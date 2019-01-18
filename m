Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5799FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313F32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfARQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:09:26 -0500
Received: from foss.arm.com ([217.140.101.70]:60536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfARQJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:09:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42744EBD;
        Fri, 18 Jan 2019 08:09:25 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FB133F557;
        Fri, 18 Jan 2019 08:09:23 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:09:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190118160920.GF118707@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
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

Can you write the last two instructions as a single:

		bic	%0, %2, %0

> +		: "=&r" (flags)						\
> +		: "r" (daif_bits), "r" (pmr)				\
> +		: "memory");						\
> +									\
> +	flags;								\
> +})
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

Nitpick: don't use C++ (or arm asm) comment style in C code.

> +	asm volatile(ALTERNATIVE(
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (pmr)
>  		:
>  		: "memory");
> +
> +	return _get_irqflags(daif_bits, pmr);
> +}

I find this confusing spread over two inline asm statements. IIUC, you
want something like below (it could be written as inline asm but I need
to understand it first):

	daif_bits = read_sysreg(daif);

	if (system_uses_irq_prio_masking()) {
		pmr = read_gicreg(ICC_PMR_EL1);
		flags = pmr & ~(daif_bits & PSR_I_BIT);
	} else {
		flags = daif_bits;
	}

	return flags;

In the case where the interrupts are disabled at the PSR level, is the
PMR value still relevant? Could we just return the GIC_PRIO_IRQOFF?
Something like:

	flags = read_sysreg(daif);

	if (system_uses_irq_prio_masking())
		flags = flags & PSR_I_BIT ?
			GIC_PRIO_IRQOFF : read_gicreg(ICC_PMR_EL1);

-- 
Catalin
