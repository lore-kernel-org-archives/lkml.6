Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030367AbeCAMbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:31:19 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:37553 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030321AbeCAMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:31:17 -0500
X-Google-Smtp-Source: AG47ELvGacHm7XQdu4RDcAXsk78MOCihmvpO90FPnm1w4hol7Fzbtgz5kCMtMBB89T++x6AyJVEq4A6/pXylgMtHOpg=
MIME-Version: 1.0
In-Reply-To: <be30b204-5752-9667-b599-b394cbfbc663@arm.com>
References: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
 <be30b204-5752-9667-b599-b394cbfbc663@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 1 Mar 2018 13:31:16 +0100
Message-ID: <CAAeHK+ywWwsU0LO2-CK5rUsqk0VUkoU044jJTLu_q6SLfed37g@mail.gmail.com>
Subject: Re: Clang build of arm64 kernel fails
To: Marc Zyngier <marc.zyngier@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, ard.biesheuvel@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 11:47 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Andrey,
>
> On 28/02/18 19:32, Andrey Konovalov wrote:
>> Hi Marc!
>>
>> I've tried to pull in new upstream commits and the kernel build
>> started failing for me with the following errors (see below).
>>
>> It seems that the reason is your commit "arm64: Add
>> ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
>> doesn't like 32 bits registers being used in 64 bits build.
>
> These are not AArch32 registers. They are AArch64 registers that the
> compiler specialises to an x (64bit wide) or w (32bit wide) register
> depending on the type that is used to define the corresponding variable.
> The fact that they are named just as AArch32 is an added compatibility
> bonus.
>
> For example:
>
> void foo(void)
> {
>         register unsigned long reg0 asm("r0") = 0;
>         register unsigned int  reg1 asm("r1") = 1;
>
>         asm volatile("hvc #0" : : "r" (reg0), "r" (reg1));
> }
>
> results in:
>
> Disassembly of section .text:
>
> 0000000000000000 <foo>:
>    0:   d2800000        mov     x0, #0x0                        // #0
>    4:   52800021        mov     w1, #0x1                        // #1
>    8:   d4000002        hvc     #0x0
>    c:   d65f03c0        ret

OK, I see, thanks for the explanation! I assumed there was something
wrong with the patch, since before it was applied everything was
compiling fine.

>
>> Would you mind sending a fix?
>
> I can look into it. Is there an equivalent Clang construct that wouldn't
> result in a sea of #ifdefs?

I'm having trouble to find any LLVM documentation related to this.

Kostya and Evgeniy, whom from the LLVM side we can ask about this?

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
