require 'spec_helper'

describe Puppet::Type.type(:apt_key).provider(:apt_key) do
  describe 'instances' do
    it 'should have an instance method' do
      expect(described_class).to respond_to :instances
    end
  end
  
  describe 'prefetch' do
    it 'should have a prefetch method' do
      expect(described_class).to respond_to :prefetch
    end
  end

  context 'no key' do
    before :each do
      described_class.expects(:apt_key).with(
        ['adv', '--no-tty', '--list-keys', '--with-colons', '--fingerprint', '--fixed-list-mode']
      ).returns 'uid:-::::1284991450::07BEBE04F4AE4A8E885A761325717D8509D9C1DC::Ubuntu Extras Archive Automatic Signing Key <ftpmaster@ubuntu.com>::::::::::0:'
    end
    it 'should return no resources' do
      expect(described_class.instances.size).to eq(0)
    end
  end

  context 'multiple keys' do
    before :each do
      described_class.expects(:apt_key).with(
        ['adv', '--no-tty', '--list-keys', '--with-colons', '--fingerprint', '--fixed-list-mode']
      ).returns "Executing: gpg --ignore-time-conflict --no-options --no-default-keyring --homedir /tmp/tmp.DU0GdRxjmE --no-auto-check-trustdb --trust-model always --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyring /etc/apt/trusted.gpg.d/puppetlabs-pc1-keyring.gpg --no-tty --list-keys --with-colons --fingerprint --fixed-list-mode\ntru:t:1:1549900774:0:3:1:5\npub:-:1024:17:40976EAF437D05B5:1095016255:::-:::scESC:\nfpr:::::::::630239CC130E1A7FD81A27B140976EAF437D05B5:\nuid:-::::1095016255::B84AE656F4F5A826C273A458512EF8E282754CE1::Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>:\nsub:-:2048:16:251BEFF479164387:1095016263::::::e:\npub:-:1024:17:46181433FBB75451:1104433784:::-:::scSC:\nfpr:::::::::C5986B4F1257FFA86632CBA746181433FBB75451:\nuid:-::::1104433784::B4D41942D4B35FF44182C7F9D00C99AF27B93AD0::Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>:\npub:-:4096:1:3B4FE6ACC0B21F32:1336770936:::-:::scSC:\nfpr:::::::::790BC7277767219C42C86F933B4FE6ACC0B21F32:\nuid:-::::1336770936::B7A02867A0C1D32B594B36C00E20C8C57E397748::Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>:\npub:-:4096:1:D94AA3F0EFE21092:1336774248:::-:::scSC:\nfpr:::::::::843938DF228D22F7B3742BC0D94AA3F0EFE21092:\nuid:-::::1336774248::77355A0B96082B2694009775B6490C605BD16B6F::Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>:\npub:-:4096:1:0946FCA2C105B9DE:1309660067:1625020067::-:::scSC:\nfpr:::::::::C1DAC52D1664E8A4386DBA430946FCA2C105B9DE:\nuid:-::::1309660067::DCC16DBD7D4721B4CC9231FFEF26179CB3550E9B::CentOS-6 Key (CentOS 6 Official Signing Key) <centos-6-key@centos.org>:\npub:e:4096:1:1054B7A24BD6EC30:1278720832:1468001658::-:::sc:\nfpr:::::::::47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30:\nuid:e::::1341252858::BA4BCA138CEBDF8444241CE928DEE1AD79612E6C::Puppet Labs Release Key (Puppet Labs Release Key) <info@puppetlabs.com>:\npub:-:4096:1:7F438280EF8D349F:1471554366:1629234366::-:::scESC:\nfpr:::::::::6F6B15509CF8E59E6E469F327F438280EF8D349F:\nuid:-::::1471554366::B648B946D1E13EEA5F4081D8FE5CF4D001200BC7::Puppet, Inc. Release Key (Puppet, Inc. Release Key) <release@puppet.com>:\nsub:-:4096:1:A2D80E04656674AE:1471554366:1629234366:::::e:\npub:-:4096:1:B8F999C007BB6C57:1360109177:1549910347::-:::scESC:\nfpr:::::::::8735F5AF62A99A628EC13377B8F999C007BB6C57:\nuid:-::::1455302347::A8FC88656336852AD4301DF059CEE6134FD37C21::Puppet Labs Nightly Build Key (Puppet Labs Nightly Build Key) <delivery@puppetlabs.com>:\nuid:-::::1455302347::4EF2A82F1FF355343885012A832C628E1A4F73A8::Puppet Labs Nightly Build Key (Puppet Labs Nightly Build Key) <info@puppetlabs.com>:\nsub:-:4096:1:AE8282E5A5FC3E74:1360109177:1549910293:::::e:\n" 
    end
    it 'should return 8 resources' do
      expect(described_class.instances.size).to eq(8)
    end
  end

  context 'create key' do
    let(:resource) do
      Puppet::Type.type(:apt_key).new({
        :name   => 'gsd',
        :id     => 'C105B9DE',
        :content => 'asad',
        :ensure => 'present',
      })
    end

    let(:provider) do
      resource.provider
    end
    
    it 'should create a key' do 
       provider.expects(:apt_key).with( [''] ).returns true 
require 'pry' 
binding.pry
       provider.create
       expect(provider).to be_exist 
    end
  end
end  
