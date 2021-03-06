require 'spec_helper'

# Make sure a password is set IMAGE-459
describe command("cat /etc/master.passwd | grep Charlie | awk -F':' '{print $2;}'") do
  its(:stdout) { should_not eq "" }
end

# Make sure ssh login is via ssh key only. This is required since we are enabling
# a password for root per IMAGE-459
describe file('/etc/ssh/sshd_config') do
  it { should be_file }
  it { should contain "PasswordAuthentication no" }
end

describe file('/etc/ssh/sshd_config') do
  it { should be_file }
  it { should contain "PermitRootLogin without-password" }
end
