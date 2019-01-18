Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AF92087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfARQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:36:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33790 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbfARQgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:36:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 943801596;
        Fri, 18 Jan 2019 08:36:03 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7F23F557;
        Fri, 18 Jan 2019 08:36:01 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:35:58 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190118163556.GB3578@e103592.cambridge.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
> Instead disabling interrupts by setting the PSR.I bit, use a priority
> higher than the one used for interrupts to mask them via PMR.
> 
> When using PMR to disable interrupts, the value of PMR will be used
> instead of PSR.[DAIF] for the irqflags.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/arm64/include/asm/efi.h      |  11 ++++
>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>  2 files changed, 106 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..134ff6e 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -44,6 +44,17 @@
>  
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>  
> +#define arch_efi_save_flags(state_flags)		\
> +	do {						\
> +		(state_flags) =	read_sysreg(daif);	\
> +	} while (0)
> +
> +#define arch_efi_restore_flags(state_flags)		\
> +	do {						\
> +		write_sysreg(state_flags, daif);	\
> +	} while (0)
> +
> +

Randomly commenting a few minor nits as I glance down my mailbox...

There's no need to protect single statements with do { } while(0).

Just protect an expression statement that could be misparsed with ( ).

->

#define arch_efi_save_flags(state_flags) ((state_flags) = read_sysreg(daif))
#define arch_efi_restore_flags(state_flags) write_sysreg(state_flags, daif)

[...]

> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..fa3b06f 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,9 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/alternative.h>
>  #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
>  
>  /*
>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> @@ -36,47 +38,96 @@

[...]

>  /*
> + * Having two ways to control interrupt status is a bit complicated. Some
> + * locations like exception entries will have PSR.I bit set by the architecture
> + * while PMR is unmasked.
> + * We need the irqflags to represent that interrupts are disabled in such cases.
> + *
> + * For this, we lower the value read from PMR when the I bit is set so it is
> + * considered as an irq masking priority. (With PMR, lower value means masking
> + * more interrupts).
> + */
> +#define _get_irqflags(daif_bits, pmr)					\
> +({									\
> +	unsigned long flags;						\
> +									\
> +	BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));	\
> +	asm volatile(ALTERNATIVE(					\
> +		"mov	%0, %1\n"					\
> +		"nop\n"							\
> +		"nop",							\
> +		"and	%0, %1, #" __stringify(PSR_I_BIT) "\n"		\
> +		"mvn	%0, %0\n"					\
> +		"and	%0, %0, %2",					\
> +		ARM64_HAS_IRQ_PRIO_MASKING)				\
> +		: "=&r" (flags)						\
> +		: "r" (daif_bits), "r" (pmr)				\
> +		: "memory");						\
> +									\
> +	flags;								\
> +})

Nit: does this need to be a macro?

({ ... }) is mildly gross and it's preferable to avoid it if the code
works just as well without...

pmr would need to be passed as a pointer, with "r" (*pmr) in the asm,
but I think it would compile down to precisely the same code.

> +
> +/*
>   * Save the current interrupt enable state.
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> -	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> +	unsigned long daif_bits;
> +	unsigned long pmr; // Only used if alternative is on
> +
> +	daif_bits = read_sysreg(daif);
> +
> +	// Get PMR
> +	asm volatile(ALTERNATIVE(
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (pmr)

Why earlyclobber?

>  		:
>  		: "memory");

[...]

> @@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)

[...]

>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
> -	return flags & PSR_I_BIT;
> +	int res;
> +
> +	asm volatile(ALTERNATIVE(
> +			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
> +			"nop",
> +			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
> +			"cset	%w0, ls",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (res)

Why earlyclobber?  %0 is not written before the reading of any input
argument so far as I can see, in either alternative.

Cheers
---Dave
