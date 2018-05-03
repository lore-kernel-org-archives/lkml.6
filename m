Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeECQFd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:05:33 -0400
Received: from sonic304-28.consmr.mail.gq1.yahoo.com ([98.137.68.209]:37340
        "EHLO sonic304-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751612AbeECQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:05:30 -0400
X-YMail-OSG: f74tyFsVM1k9AVvM9.MdAH.b62pBPaVoIGzEWK_q1B2pz6eahue7ZO6APupdeN4
 otByih1jZthQLmJ8q9S.keoHnk71atWSL8DKCJMwkIqPq.J87JV_AWnikYF9.gR72pbiwc0Z4VNR
 pjmIuuu.qQeSO51Vsz_BAc_NptgYcZTcMSKnhihLDG5upTaUMl1Qca_8Cr.QTkiI.1XWyFVNZ2SS
 ZXsnAPc5_zPadJm8kjq85sfapa3iZ1HZAmZfSEAesqzMWA0CJ3cPx.9AjmMr8_VHKxvDAaosaZON
 lfdL_.QqBUgz6Xaiak8VcCTqusommDbpdWNHBEPegnyDYxZDfOSX.8l_JAZm2x51xsJlJbbv0N7F
 VElhOu3bl2RjcLwFumQG6mxvlZ16DpAxQrEHcSTy7wrO9nONnGn.4dnbAa_zvrSv.7bvNGEn5OGR
 IHXdX4y7o9AdZOvseHi7kTte_A1HsoHvBSXYBFic2Cq3IKFPcRtLG5kDx25HwtilXHHRyaiCnjrZ
 oDP2zmTP46oiunmt9.fbxeHgdXDNk6JgsBIkBf7im4Tz3jBccz2A5BSaJVTFKpQl5iyCUoNQhKuZ
 TEuDQWKeQ_g1LqKrb7I4QDfv0A7bHvw9zgkO4eRnJAg6J5QeThERIsCaNrWb4LBfgaXmzIeDHtCe
 YcMcBCP3bCZiMpGbz_aT4f2iN.uJOYXzRgxg5
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
 <87h8nqglpx.fsf@xmission.com> <1525275904.5669.308.camel@linux.vnet.ibm.com>
 <87h8nospo5.fsf@xmission.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com>
Date: Thu, 3 May 2018 09:05:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87h8nospo5.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2018 8:51 AM, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>
>> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>>
>>>> Allow LSMs and IMA to differentiate between the kexec_load and
>>>> kexec_file_load syscalls by adding an "unnecessary" call to
>>>> security_kernel_read_file() in kexec_load.  This would be similar to the
>>>> existing init_module syscall calling security_kernel_read_file().
>>> Given the reasonable desire to load a policy that ensures everything
>>> has a signature I don't have fundamental objections.
>>>
>>> security_kernel_read_file as a hook seems an odd choice.  At the very
>>> least it has a bad name because there is no file reading going on here.
>>>
>>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
>>> anywhere.  Which means I could have a kernel compiled without that and I
>>> would be allowed to use kexec_file_load without signature checking.
>>> While kexec_load would be denied.
>>>
>>> Am I missing something here?
>> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
>> calls security_kernel_read_file().  So kexec_file_load and kexec_load
>> syscall would be using the same method for enforcing signature
>> verification.
> Having looked at your patches and the kernel a little more I think
> this should be a separate security hook that does not take a file
> parameter.
>
> Right now every other security module assumes !file is init_module.
> So I think this change has the potential to confuse other security
> modules, with the result of unintended policy being applied.
>
> So just for good security module hygeine I think this needs a dedicated
> kexec_load security hook.

I would rather see the existing modules updated than a new
hook added. Too many hooks spoil the broth. Two hooks with
trivial differences just add to the clutter and make it harder
for non-lsm developers to figure out what to use in their
code. 
