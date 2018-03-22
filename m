Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753897AbeCVLFC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:05:02 -0400
Received: from ppsw-42.csi.cam.ac.uk ([131.111.8.142]:54544 "EHLO
        ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCVLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:04:59 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
 <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
Date: Thu, 22 Mar 2018 11:04:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 10:42, Paolo Bonzini wrote:
> On 22/03/2018 11:19, Andrew Cooper wrote:
>> On 22/03/2018 10:07, Paolo Bonzini wrote:
>>> On 22/03/2018 09:34, Wanpeng Li wrote:
>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>
>>>> Explicit segment overides other than %fs and %gs are documented as ignored by
>>>> both Intel and AMD.
>>>>
>>>> In practice, this means that:
>>>>
>>>>  * Explicit uses of %ss don't actually yield #SS[0] for non-canonical
>>>>    memory references.
>>>>  * Explicit uses of %{e,c,d}s don't override %rbp/%rsp-based memory references
>>>>    to yield #GP[0] for non-canonical memory references.
>>>>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> When porting fixes from other projects, it is customary to identify so
>> in the commit message.  In this case, the fix you've ported is
>> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=b7dce29d9faf3597d009c853ed1fcbed9f7a7f68
>>
>> Here is an example of how Xen ports fixes from Linux for the drivers
>> that we share. 
>> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=4e131596f1defec9407b6e60d584a696beaf5d7e
> Thanks Andrew.  The code is of course completely different, but the
> commit message is 1:1.  Wanpeng, please acknowledge Jan in v2!

Thanks, but it is actually my patch, which is why I was confused at
seeing my own commit message on LKML.

Also, the chances are that there are similar issues decoding the
instruction info field in the VMCS, which is how I stumbled onto this in
the first place.  I haven't yet fixed that side of things for Xen.

>
>>> Testcase, please...
>> If you want to crib from one, this is the testcase I made for Xen.
>>
>> http://xenbits.xen.org/docs/xtf/test-memop-seg.html
> How does it ensure that the code is executed through the emulator and
> not by the processor?

This test, and most of the tests in general, deliberately set things up
to execute the test cases first on the main processor, and then via the
emulator, and complain when any result is unexpected.

We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
magic.  Originally, this was used for PV guests to explicitly request an
emulated CPUID, but I extended it to HVM guests for "emulate the next
instruction", after we had some guest user => guest kernel privilege
escalations because of incorrect emulation.

Fundamentally, any multi-vcpu guest can force an arbitrary instruction
through the emulator, because rewriting a couple of bytes of instruction
stream is far far far faster than a vmexit.  I chose to introduce a
explicit way to force this to occur, for testing purposes.

>
>> With the impending KVM/PVH work which is ongoing, it will soon be easy
>> to run Xen's HVM test suite unmodified under KVM, but we're not quite
>> there yet.
> What does the test suite use for console I/O?

Depends on what it available as it boots, but one of the default
consoles is port 0x12.  If things need to be tweaked to work more
cleanly, then that is entirely fine.

~Andrew
