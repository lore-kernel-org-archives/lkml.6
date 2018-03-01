Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967469AbeCAKrm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:47:42 -0500
Received: from foss.arm.com ([217.140.101.70]:35882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965992AbeCAKrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:47:40 -0500
Subject: Re: Clang build of arm64 kernel fails
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        ard.biesheuvel@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <be30b204-5752-9667-b599-b394cbfbc663@arm.com>
Date: Thu, 1 Mar 2018 10:47:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 28/02/18 19:32, Andrey Konovalov wrote:
> Hi Marc!
> 
> I've tried to pull in new upstream commits and the kernel build
> started failing for me with the following errors (see below).
> 
> It seems that the reason is your commit "arm64: Add
> ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
> doesn't like 32 bits registers being used in 64 bits build.

These are not AArch32 registers. They are AArch64 registers that the
compiler specialises to an x (64bit wide) or w (32bit wide) register
depending on the type that is used to define the corresponding variable.
The fact that they are named just as AArch32 is an added compatibility
bonus.

For example:

void foo(void)
{
	register unsigned long reg0 asm("r0") = 0;
	register unsigned int  reg1 asm("r1") = 1;

	asm volatile("hvc #0" : : "r" (reg0), "r" (reg1));
}

results in:

Disassembly of section .text:

0000000000000000 <foo>:
   0:	d2800000 	mov	x0, #0x0                   	// #0
   4:	52800021 	mov	w1, #0x1                   	// #1
   8:	d4000002 	hvc	#0x0
   c:	d65f03c0 	ret

> Would you mind sending a fix?

I can look into it. Is there an equivalent Clang construct that wouldn't
result in a sea of #ifdefs?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
