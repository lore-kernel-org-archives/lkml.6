Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeCVLOf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:14:35 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36723 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeCVLOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:14:31 -0400
X-Google-Smtp-Source: AG47ELt/tZUkhaZAorsHC6OkGhXlhbn+/WNQ2iZXcC/K4zVcw1UrBNMfRmsUBzc8Pc7o62ZZ9RrO8Yiay3hMEhcqPTQ=
MIME-Version: 1.0
In-Reply-To: <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com> <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com> <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 22 Mar 2018 19:14:30 +0800
Message-ID: <CANRm+Cx=Mo_vVy68PN+AiaxVSO=HwE5FhRm9FRVeS8nS9Vbeyw@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit mode
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MBFgKZ015759

2018-03-22 19:04 GMT+08:00 Andrew Cooper <andrew.cooper3@citrix.com>:
> On 22/03/2018 10:42, Paolo Bonzini wrote:
>> On 22/03/2018 11:19, Andrew Cooper wrote:
>>> On 22/03/2018 10:07, Paolo Bonzini wrote:
>>>> On 22/03/2018 09:34, Wanpeng Li wrote:
>>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>>
>>>>> Explicit segment overides other than %fs and %gs are documented as ignored by
>>>>> both Intel and AMD.
>>>>>
>>>>> In practice, this means that:
>>>>>
>>>>>  * Explicit uses of %ss don't actually yield #SS[0] for non-canonical
>>>>>    memory references.
>>>>>  * Explicit uses of %{e,c,d}s don't override %rbp/%rsp-based memory references
>>>>>    to yield #GP[0] for non-canonical memory references.
>>>>>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> When porting fixes from other projects, it is customary to identify so
>>> in the commit message.  In this case, the fix you've ported is
>>> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=b7dce29d9faf3597d009c853ed1fcbed9f7a7f68
>>>
>>> Here is an example of how Xen ports fixes from Linux for the drivers
>>> that we share.
>>> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=4e131596f1defec9407b6e60d584a696beaf5d7e
>> Thanks Andrew.  The code is of course completely different, but the
>> commit message is 1:1.  Wanpeng, please acknowledge Jan in v2!
>
> Thanks, but it is actually my patch, which is why I was confused at
> seeing my own commit message on LKML.

Thanks Andrew's original patch. Anyway, it is a really small stuff, I
will drop this patch to avoid the confusing.

Regards,
Wanpeng Li

>
> Also, the chances are that there are similar issues decoding the
> instruction info field in the VMCS, which is how I stumbled onto this in
> the first place.  I haven't yet fixed that side of things for Xen.
>
>>
>>>> Testcase, please...
>>> If you want to crib from one, this is the testcase I made for Xen.
>>>
>>> http://xenbits.xen.org/docs/xtf/test-memop-seg.html
>> How does it ensure that the code is executed through the emulator and
>> not by the processor?
>
> This test, and most of the tests in general, deliberately set things up
> to execute the test cases first on the main processor, and then via the
> emulator, and complain when any result is unexpected.
>
> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
> magic.  Originally, this was used for PV guests to explicitly request an
> emulated CPUID, but I extended it to HVM guests for "emulate the next
> instruction", after we had some guest user => guest kernel privilege
> escalations because of incorrect emulation.
>
> Fundamentally, any multi-vcpu guest can force an arbitrary instruction
> through the emulator, because rewriting a couple of bytes of instruction
> stream is far far far faster than a vmexit.  I chose to introduce a
> explicit way to force this to occur, for testing purposes.
>
>>
>>> With the impending KVM/PVH work which is ongoing, it will soon be easy
>>> to run Xen's HVM test suite unmodified under KVM, but we're not quite
>>> there yet.
>> What does the test suite use for console I/O?
>
> Depends on what it available as it boots, but one of the default
> consoles is port 0x12.  If things need to be tweaked to work more
> cleanly, then that is entirely fine.
>
> ~Andrew
