Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EDD21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EDD21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbeIUXaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:30:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389545AbeIUXaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:30:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CBB7A9;
        Fri, 21 Sep 2018 10:40:07 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.emea.arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9BC03F557;
        Fri, 21 Sep 2018 10:40:05 -0700 (PDT)
Subject: Re: [PATCH v5 15/27] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-16-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <1675f220-e4c3-b1e2-7842-901bec8eee19@arm.com>
Date:   Fri, 21 Sep 2018 18:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-16-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/18 16:51, Julien Thierry wrote:
> Instead disabling interrupts by setting the PSR.I bit, use a priority
> higher than the one used for interrupts to mask them via PMR.
> 
> The value chosen for PMR to enable/disable interrupts encodes the status
> of interrupts on a single bit. This information is stored in the irqflags
> values used when saving/restoring IRQ status.
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>   arch/arm64/include/asm/assembler.h | 17 ++++++-
>   arch/arm64/include/asm/efi.h       |  3 +-
>   arch/arm64/include/asm/irqflags.h  | 97 ++++++++++++++++++++++++++++++--------
>   arch/arm64/include/asm/ptrace.h    | 10 ++--
>   arch/arm64/kernel/entry.S          |  2 +-
>   5 files changed, 102 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 0bcc98d..0b2dcfd 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -23,6 +23,7 @@
>   #ifndef __ASM_ASSEMBLER_H
>   #define __ASM_ASSEMBLER_H
> 
> +#include <asm/alternative.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/cpufeature.h>
>   #include <asm/debug-monitors.h>
> @@ -62,12 +63,24 @@
>   /*
>    * Enable and disable interrupts.
>    */
> -	.macro	disable_irq
> +	.macro	disable_irq, tmp
> +	mov	\tmp, #ICC_PMR_EL1_MASKED
> +alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
>   	msr	daifset, #2
> +alternative_else
> +	msr_s	SYS_ICC_PMR_EL1, \tmp
> +alternative_endif
>   	.endm
> 
> -	.macro	enable_irq
> +	.macro	enable_irq, tmp
> +	mov     \tmp, #ICC_PMR_EL1_UNMASKED
> +alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
>   	msr	daifclr, #2
> +	nop
> +alternative_else
> +	msr_s	SYS_ICC_PMR_EL1, \tmp
> +	dsb	sy
> +alternative_endif
>   	.endm
> 
>   	.macro	save_and_disable_irq, flags
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..3e06891 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -42,7 +42,8 @@
> 
>   efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
> 
> -#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> +#define ARCH_EFI_IRQ_FLAGS_MASK \
> +	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | ARCH_FLAG_PMR_EN)
> 
>   /* arch specific definitions used by the stub code */
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..193cfd0 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,27 @@
> 
>   #ifdef __KERNEL__
> 
> +#include <asm/alternative.h>
> +#include <asm/cpufeature.h>
>   #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
> +
> +
> +/*
> + * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
> + * whether the normal interrupts are masked is kept along with the daif
> + * flags.
> + */
> +#define ARCH_FLAG_PMR_EN 0x1
> +
> +#define MAKE_ARCH_FLAGS(daif, pmr)					\
> +	((daif) | (((pmr) >> ICC_PMR_EL1_EN_SHIFT) & ARCH_FLAG_PMR_EN))
> +
> +#define ARCH_FLAGS_GET_PMR(flags)				\
> +	((((flags) & ARCH_FLAG_PMR_EN) << ICC_PMR_EL1_EN_SHIFT) \
> +		| ICC_PMR_EL1_MASKED)
> +
> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
> 
>   /*
>    * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> @@ -38,31 +58,50 @@
>    */
>   static inline unsigned long arch_local_irq_save(void)
>   {
> -	unsigned long flags;
> -	asm volatile(
> +	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
> +	unsigned long pmr = 0;
> +
> +	asm volatile(ALTERNATIVE(
>   		"mrs	%0, daif		// arch_local_irq_save\n"
> -		"msr	daifset, #2"
> -		: "=r" (flags)
> -		:
> +		"msr	daifset, #2\n"
> +		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
> +		/* --- */
> +		"mrs	%0, daif\n"
> +		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +		"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %2",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (flags), "=&r" (pmr)
> +		: "r" (masked)
>   		: "memory");
> -	return flags;
> +
> +	return MAKE_ARCH_FLAGS(flags, pmr);
>   }
> 
>   static inline void arch_local_irq_enable(void)
>   {
> -	asm volatile(
> -		"msr	daifclr, #2		// arch_local_irq_enable"
> -		:
> +	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
> +		"nop",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		"dsb	sy",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>   		:
> +		: "r" (unmasked)
>   		: "memory");
>   }
> 
>   static inline void arch_local_irq_disable(void)
>   {
> -	asm volatile(
> -		"msr	daifset, #2		// arch_local_irq_disable"
> -		:
> +	unsigned long masked = ICC_PMR_EL1_MASKED;
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifset, #2		// arch_local_irq_disable",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>   		:
> +		: "r" (masked)
>   		: "memory");
>   }
> 
> @@ -72,12 +111,19 @@ static inline void arch_local_irq_disable(void)
>   static inline unsigned long arch_local_save_flags(void)
>   {
>   	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> +	unsigned long pmr = 0;
> +
> +	asm volatile(ALTERNATIVE(
> +		"mrs	%0, daif		// arch_local_save_flags\n"
> +		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
> +		"mrs	%0, daif\n"
> +		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1),
> +		ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=r" (flags), "=r" (pmr)
>   		:
>   		: "memory");
> -	return flags;
> +
> +	return MAKE_ARCH_FLAGS(flags, pmr);
>   }
> 
>   /*
> @@ -85,16 +131,27 @@ static inline unsigned long arch_local_save_flags(void)
>    */
>   static inline void arch_local_irq_restore(unsigned long flags)
>   {
> -	asm volatile(
> -		"msr	daif, %0		// arch_local_irq_restore"
> +	unsigned long pmr = ARCH_FLAGS_GET_PMR(flags);
> +
> +	flags = ARCH_FLAGS_GET_DAIF(flags);
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daif, %0		// arch_local_irq_restore\n"
> +		"nop\n"
> +		"nop",
> +		"msr	daif, %0\n"
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%1\n"
> +		"dsb	sy",

I've come to realize there is an issue with that sequence. If the CPU 
has { PSR.I = 1, PMR = unmasked }, attempting attempting to restore 
flags { PSR.I = 0, PMR = masked }, there will be that ever so small 
window between the two instructions where interrupts get re-enabled 
while both contexts (the current one and the one being restored) have 
interrupts disabled...

Does that ever happen? Yes, when coming from a kernel entry or coming 
back from a VHE guest and doing "local_daif_retore(DAIF_PROCCTX_NOIRQ)".

An obvious, always working solution would be to do:
	msr daifset, #2
	msr ICC_PMR_EL1, %1
	msr daif, %0
	dsb sy

This however has some heavy performance hit on hackbench (~4-5%).

So I'd suggest:
	msr ICC_PMR_EL1, %1
	msr daif, %0
	dsb sy

So, this only reverses the issue to the case where we restore { PSR.I = 
1, PMR = unmasked } while CPU has { PSR.I = 0, PMR = masked }?
Yes, *but* there is no reason this should happen:

- There is no pre-defined flags values that provide { PSR.I = 1, PMR = 
unmasked } (and there is no reason to be one once we start using priorities)

- If flags { PMR = unmasked, PSR.I = 1 } where obtained through 
local_irq_save() or local_irq_save_flags(), from that point one would 
need to mask PMR *and* explicitly modify PSR.I since local_enable_irq() 
no longer touches PSR.
The only code that has a reason to do this explicit change is PMR setup 
code at CPU startup and when coming from exception entry. And code doing 
such action has no reason to be between local_irq_save/restore() calls 
since that would simply undo its action...

So my take is that restoring the PMR register first is fine without 
masking PSR.I with the following comment:

/*
  * Code switching from PSR.I interrupt disabling to PMR masking
  * should not lie between consecutive calls to local_irq_save()
  * and local_irq_restore() in the same context.
  */

Does this approach seem sound? (If my explanation was not to confusing)
Am I missing some corner case?
Any suggestions for better approach? Or better wording?

Thanks,

> +		ARM64_HAS_IRQ_PRIO_MASKING)
>   	:
> -	: "r" (flags)
> +	: "r" (flags), "r" (pmr)
>   	: "memory");
>   }
> 
>   static inline int arch_irqs_disabled_flags(unsigned long flags)
>   {
> -	return flags & PSR_I_BIT;
> +	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
> +		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
>   }
>   #endif
>   #endif
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 29ec217..67df46e 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -25,8 +25,11 @@
>   #define CurrentEL_EL1		(1 << 2)
>   #define CurrentEL_EL2		(2 << 2)
> 
> -/* PMR value use to unmask interrupts */
> +/* PMR values used to mask/unmask interrupts */
>   #define ICC_PMR_EL1_UNMASKED    0xf0
> +#define ICC_PMR_EL1_EN_SHIFT	6
> +#define ICC_PMR_EL1_EN_BIT	(1 << ICC_PMR_EL1_EN_SHIFT) // PMR IRQ enable
> +#define ICC_PMR_EL1_MASKED      (ICC_PMR_EL1_UNMASKED ^ ICC_PMR_EL1_EN_BIT)
> 
>   /* AArch32-specific ptrace requests */
>   #define COMPAT_PTRACE_GETREGS		12
> @@ -201,8 +204,9 @@ static inline void forget_syscall(struct pt_regs *regs)
>   #define processor_mode(regs) \
>   	((regs)->pstate & PSR_MODE_MASK)
> 
> -#define interrupts_enabled(regs) \
> -	(!((regs)->pstate & PSR_I_BIT))
> +#define interrupts_enabled(regs)			\
> +	((!((regs)->pstate & PSR_I_BIT)) &&		\
> +	 ((regs)->pmr_save & ICC_PMR_EL1_EN_BIT))
> 
>   #define fast_interrupts_enabled(regs) \
>   	(!((regs)->pstate & PSR_F_BIT))
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 79b06af..91e1e3d 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -912,7 +912,7 @@ work_pending:
>    * "slow" syscall return path.
>    */
>   ret_to_user:
> -	disable_irq				// disable interrupts
> +	disable_irq x21				// disable interrupts
>   	ldr	x1, [tsk, #TSK_TI_FLAGS]
>   	and	x2, x1, #_TIF_WORK_MASK
>   	cbnz	x2, work_pending
> --
> 1.9.1
> 

-- 
Julien Thierry
