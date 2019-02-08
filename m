Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CEEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B4421916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBHJg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:36:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46896 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbfBHJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:36:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8FFA78;
        Fri,  8 Feb 2019 01:36:54 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34823F557;
        Fri,  8 Feb 2019 01:36:50 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
 <20190208043543.GA5040@archlinux-ryzen>
Message-ID: <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
Date:   Fri, 8 Feb 2019 09:36:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208043543.GA5040@archlinux-ryzen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 08/02/2019 04:35, Nathan Chancellor wrote:
> On Thu, Jan 31, 2019 at 02:58:50PM +0000, Julien Thierry wrote:

[...]

> 
> Hi Julien,
> 
> This patch introduced a slew of Clang warnings:
> 
> In file included from arch/arm64/kernel/signal.c:21:
> In file included from include/linux/compat.h:10:
> In file included from include/linux/time.h:6:
> In file included from include/linux/seqlock.h:36:
> In file included from include/linux/spinlock.h:54:
> In file included from include/linux/irqflags.h:16:
> arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQON)
>                        ^
> arch/arm64/include/asm/ptrace.h:39:25: note: expanded from macro 'GIC_PRIO_IRQON'
> #define GIC_PRIO_IRQON          0xf0
>                                 ^
> arch/arm64/include/asm/irqflags.h:46:44: note: use constraint modifier "w"
>                 "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>                                                          ^~
>                                                          %w0

I'm not sure I get the relevance of this kind of warnings from Clang.
Had it been an output operand I could understand the concern of having a
variable too small to store the register value. But here it's an input
operand being place in a wider register...

> arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
>         _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
>                                    ^
> arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
>         __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
>                                     ^
> arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
>         newinstr "\n"                                                   \
>         ^
> In file included from arch/arm64/kernel/signal.c:21:
> In file included from include/linux/compat.h:10:
> In file included from include/linux/time.h:6:
> In file included from include/linux/seqlock.h:36:
> In file included from include/linux/spinlock.h:54:
> In file included from include/linux/irqflags.h:16:
> arch/arm64/include/asm/irqflags.h:61:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQOFF)
>                        ^
> arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
> #define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
>                                 ^
> arch/arm64/include/asm/irqflags.h:58:45: note: use constraint modifier "w"
>                 "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
>                                                           ^
> arch/arm64/include/asm/irqflags.h:94:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQOFF)
>                        ^
> arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
> #define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
>                                 ^
> arch/arm64/include/asm/irqflags.h:91:18: note: use constraint modifier "w"
>                         "csel   %0, %0, %2, eq",
>                                         ^~
>                                         %w2
> arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
>         _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
>                                    ^
> arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
>         __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
>                                     ^
> arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
>         newinstr "\n"                                                   \
>         ^
> 3 warnings generated.
> 
> 
> I am not sure if they should be fixed with Clang's suggestion of a
> constraint modifier or a cast like commit 1b57ec8c7527 ("arm64: io:
> Ensure value passed to __iormb() is held in a 64-bit register"), hence
> this message.
> 

Clang's suggestion would not work as MSR instructions do not operate on
32-bit general purpose registers. Seeing that PMR is a 32-bit register,
I'd avoid adding UL for the GIC_PRIO_IRQ* constants.

So I'd recommend just casting the the asm inline operands to unsigned
long. This should only affect the 3 locations
arch/arm64/include/asm/irqflags.h.

Does the following patch work for you?

Thanks,

-- 
Julien Thierry


-->

From e839dec632bbf440efe8314751138ba46324078c Mon Sep 17 00:00:00 2001
From: Julien Thierry <julien.thierry@arm.com>
Date: Fri, 8 Feb 2019 09:21:58 +0000
Subject: [PATCH] arm64: irqflags: Fix clang build warnings

Clang complains when passing asm operands that are smaller than the
registers they are mapped to:

arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not
	match register size specified by the constraint and modifier
	[-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQON)

Fix it by casting the affected input operands to a type of the correct
size.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/include/asm/irqflags.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index d4597b2..43d8366 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -47,7 +47,7 @@ static inline void arch_local_irq_enable(void)
 		"dsb	sy",
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
-		: "r" (GIC_PRIO_IRQON)
+		: "r" ((unsigned long) GIC_PRIO_IRQON)
 		: "memory");
 }
 
@@ -58,7 +58,7 @@ static inline void arch_local_irq_disable(void)
 		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
-		: "r" (GIC_PRIO_IRQOFF)
+		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
 		: "memory");
 }
 
@@ -91,7 +91,7 @@ static inline unsigned long arch_local_save_flags(void)
 			"csel	%0, %0, %2, eq",
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (flags), "+r" (daif_bits)
-		: "r" (GIC_PRIO_IRQOFF)
+		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
 		: "memory");
 
 	return flags;
-- 
1.9.1


