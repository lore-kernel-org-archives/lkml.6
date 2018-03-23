Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCWOnr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:43:47 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:3678 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeCWOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:43:45 -0400
X-IronPort-AV: E=Sophos;i="5.48,350,1517875200";
   d="scan'208";a="70469679"
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Wanpeng Li <kernellwp@gmail.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
 <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com>
 <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
 <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com>
 <CANRm+CwmJQCFZ7oe1_YatqoOXzzEU+SP9Z5qR6zU_ybd_DoGQQ@mail.gmail.com>
 <94bbfac5-2022-ab92-0b9a-1c3cd2275054@citrix.com>
 <CANRm+CwsFX7rVkPvENRM20D84zotonxFFJMSq98icS4BQm7o2Q@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <3cff8fb1-bfa7-0e63-4642-4d779454965a@citrix.com>
Date: Fri, 23 Mar 2018 14:43:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwsFX7rVkPvENRM20D84zotonxFFJMSq98icS4BQm7o2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/18 14:27, Wanpeng Li wrote:
> 2018-03-22 21:53 GMT+08:00 Andrew Cooper <andrew.cooper3@citrix.com>:
>> On 22/03/18 13:39, Wanpeng Li wrote:
>>> 2018-03-22 20:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>> On 22/03/2018 12:04, Andrew Cooper wrote:
>>>>> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
>>>>> magic.  Originally, this was used for PV guests to explicitly request an
>>>>> emulated CPUID, but I extended it to HVM guests for "emulate the next
>>>>> instruction", after we had some guest user => guest kernel privilege
>>>>> escalations because of incorrect emulation.
>>>> Wanpeng, why don't you add it behind a new kvm module parameter? :)
>>> Great point! I will have a try. Thanks Paolo and Andrew. :)
>> Using the force emulation prefix requires intercepting #UD, which is in
>> general a BadThing(tm) for security.  Therefore, we have a build time
> Yeah, however kvm intercepts and emulates #UD by default, should we
> add a new kvm module parameter to enable it and disable by default?
> Paolo.
>
>> configuration option to compile in support, and require that test
>> systems explicitly opt into using it via a command line parameter.
>>
>> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/x86/hvm/hvm.c;h=db52312882205e65b32e587106ca795f4bfab2eb;hb=refs/heads/staging#l3741
>> is the general #UD intercept handler if you want a reference.  (You can
> Thanks Andrew, it is useful. :) In addition, I didn't see the
> test-memop-seg testcase has "Forced Emulation Prefix", when the prefix
> is added to each instruction in the testcase?

It has ended up substantially more ugly than I first intended, due to
several assembler bugs in older GCC and Clang toolchains.

http://xenbits.xen.org/gitweb/?p=xtf.git;a=blob;f=tests/memop-seg/asm.S;h=698661425bcdc9c181b235e323c2460e06c6e986;hb=HEAD#l35

I previously has FEP passed as a second parameter, but that becomes
prohibitively complicated to extract when testing %ss or %esp.  FEP is
now encoded in the bottom bit of the address passed in.

This was the cleanest way I could find of testing every combination, but
I'm open to improvements if anyone can spot any.

~Andrew
