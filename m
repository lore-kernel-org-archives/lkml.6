Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5266C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD652081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD652081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeLDRgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:36:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeLDRgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:36:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36368A78;
        Tue,  4 Dec 2018 09:36:15 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459533F59C;
        Tue,  4 Dec 2018 09:36:13 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:36:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        marc.zyngier@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org
Subject: Re: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20181204173610.GC19210@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:57:01AM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..e0a32e4 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,27 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/alternative.h>
> +#include <asm/cpufeature.h>
>  #include <asm/ptrace.h>
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
> +	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
> +
> +#define ARCH_FLAGS_GET_PMR(flags)				 \
> +	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
> +		| GIC_PRIO_IRQOFF)
> +
> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)

I wonder whether we could just use the PSR_I_BIT here to decide whether
to set the GIC_PRIO_IRQ{ON,OFF}. We could clear the PSR_I_BIT in
_restore_daif() with an alternative.

> +/*
> + * CPU interrupt mask handling.
> + */
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

DSB needed here as well? I guess I'd have to read the GIC spec before
asking again ;).

-- 
Catalin
