Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00673C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3582082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3582082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeK3FTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:19:18 -0500
Received: from foss.arm.com ([217.140.101.70]:42580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeK3FTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:19:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B2E80D;
        Thu, 29 Nov 2018 10:13:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814393F575;
        Thu, 29 Nov 2018 10:13:01 -0800 (PST)
Date:   Thu, 29 Nov 2018 18:12:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        Jason Cooper <jason@lakedaemon.net>, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, joel@joelfernandes.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 05/24] irqchip/gic-v3: Switch to PMR masking before
 calling IRQ handler
Message-ID: <20181129181258.jo6s4e7s3zwkp4sk@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-6-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542023835-21446-6-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:56:56AM +0000, Julien Thierry wrote:
> Mask the IRQ priority through PMR and re-enable IRQs at CPU level,
> allowing only higher priority interrupts to be received during interrupt
> handling.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/arch_gicv3.h   | 17 +++++++++++++++++
>  arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c        | 10 ++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
> index bef0b5d..f6f485f 100644
> --- a/arch/arm/include/asm/arch_gicv3.h
> +++ b/arch/arm/include/asm/arch_gicv3.h
> @@ -363,5 +363,22 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
>  
>  #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
>  
> +static inline bool gic_prio_masking_enabled(void)
> +{
> +	return false;
> +}
> +
> +static inline void gic_pmr_mask_irqs(void)
> +{
> +	/* Should not get called. */
> +	WARN_ON_ONCE(true);
> +}
> +
> +static inline void gic_arch_enable_irqs(void)
> +{
> +	/* Should not get called. */
> +	WARN_ON_ONCE(true);
> +}
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* !__ASM_ARCH_GICV3_H */
> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> index 37193e2..3f8d5f4 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -155,5 +155,22 @@ static inline u32 gic_read_rpr(void)
>  #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
>  #define gits_read_vpendbaser(c)		readq_relaxed(c)
>  
> +static inline bool gic_prio_masking_enabled(void)
> +{
> +	return system_supports_irq_prio_masking();
> +}
> +
> +static inline void gic_pmr_mask_irqs(void)
> +{
> +	/* Should not get called yet. */
> +	WARN_ON_ONCE(true);
> +}
> +
> +static inline void gic_arch_enable_irqs(void)
> +{
> +	/* Should not get called yet. */
> +	WARN_ON_ONCE(true);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_ARCH_GICV3_H */
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 8f87f40..e5d8c14 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -353,6 +353,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
>  		int err;
>  
> +		if (gic_prio_masking_enabled()) {
> +			gic_pmr_mask_irqs();
> +			gic_arch_enable_irqs();
> +		}

IIUC, if we have two pNMIs, this will allow one to preempt another, e.g.

	< pNMI#1 asserted >

	< CPU takes IRQ exception for pNMI #1>

	irqnr = gic_read_iar(); // pNMI #1

	< pNMI#2 asserted >

	// masks IRQs at GIC, leaves other pNMIs unmasked
	gic_pmr_mask_irqs()
	gic_arch_enable_irqs();

	...

	< CPU takes IRQ exception for pNMI #2 >

... or is that not a problem? Is the NMI code re-entrant?

> +
>  		if (static_branch_likely(&supports_deactivate_key))
>  			gic_write_eoir(irqnr);
>  		else
> @@ -371,6 +376,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  		return;
>  	}
>  	if (irqnr < 16) {
> +		if (gic_prio_masking_enabled()) {
> +			gic_pmr_mask_irqs();
> +			gic_arch_enable_irqs();
> +		}

Can we pull this above the two cases, or is there a problem with doing
this for spurious IRQs?

Where is the corresponding unmask of the PMR, and disable of IRQs? It's
difficult to follow the logic if that's in another patch.

Thanks,
Mark.
