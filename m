Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF70BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C844920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfAHPkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:40:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54502 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfAHPkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:40:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF9780D;
        Tue,  8 Jan 2019 07:40:21 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1007D3F5AF;
        Tue,  8 Jan 2019 07:40:18 -0800 (PST)
Date:   Tue, 8 Jan 2019 15:40:13 +0000
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
Message-ID: <20190108153957.GA5840@e103592.cambridge.arm.com>
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

[...]

> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..fa3b06f 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,9 @@

[...]

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

I'm still not convinced these dsbs are needed.

Without the dsb, we are probably not guaranteed to take a pending
interrupt _immediately_ on unmasking, but I'm not sure that's a
problem.

What goes wrong if we omit them?

(My attempts to answer these questions using the GIC architecture spec
have met with limited success so far...)

[...]

Cheers
---Dave
