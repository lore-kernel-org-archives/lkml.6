Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1477BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1554217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfAVPV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:21:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55696 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfAVPVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:21:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3C3A78;
        Tue, 22 Jan 2019 07:21:53 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA39D3F589;
        Tue, 22 Jan 2019 07:21:51 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:21:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190122152149.GD187049@arrakis.emea.arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:33:31PM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..7e82a92 100644
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
> @@ -36,33 +38,31 @@
>  /*
>   * CPU interrupt mask handling.
>   */
> -static inline unsigned long arch_local_irq_save(void)
> -{
> -	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_irq_save\n"
> -		"msr	daifset, #2"
> -		: "=r" (flags)
> -		:
> -		: "memory");
> -	return flags;
> -}
> -
>  static inline void arch_local_irq_enable(void)
>  {
> -	asm volatile(
> -		"msr	daifclr, #2		// arch_local_irq_enable"
> -		:
> +	unsigned long unmasked = GIC_PRIO_IRQON;
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
> +		"nop",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		"dsb	sy",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (unmasked)
>  		: "memory");
>  }
>  
>  static inline void arch_local_irq_disable(void)
>  {
> -	asm volatile(
> -		"msr	daifset, #2		// arch_local_irq_disable"
> -		:
> +	unsigned long masked = GIC_PRIO_IRQOFF;
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifset, #2		// arch_local_irq_disable",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (masked)
>  		: "memory");
>  }

Nitpicks: you could drop masked/unmasked variables here (it's up to you,
it wouldn't make any difference on the generated asm).

> @@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> +	unsigned long daif_bits;
>  	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> -		:
> +
> +	daif_bits = read_sysreg(daif);
> +
> +	/*
> +	 * The asm is logically equivalent to:
> +	 *
> +	 * if (system_uses_irq_prio_masking())
> +	 *	flags = (daif_bits & PSR_I_BIT) ?
> +	 *			GIC_PRIO_IRQOFF :
> +	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
> +	 * else
> +	 *	flags = daif_bits;
> +	 */
> +	asm volatile(ALTERNATIVE(
> +			"mov	%0, %1\n"
> +			"nop\n"
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
> +			"csel	%0, %0, %2, eq",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (flags), "+r" (daif_bits)
> +		: "r" (GIC_PRIO_IRQOFF)
>  		: "memory");
> +
> +	return flags;
> +}

BTW, how's the code generated from the C version? It will have a branch
but may not be too bad. Either way is fine by me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
