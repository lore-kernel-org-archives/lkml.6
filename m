Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C10C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0DA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfBAKV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:21:59 -0500
Received: from foss.arm.com ([217.140.101.70]:57472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfBAKV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:21:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D47715BE;
        Fri,  1 Feb 2019 02:21:58 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82F5F3F71E;
        Fri,  1 Feb 2019 02:21:56 -0800 (PST)
Date:   Fri, 1 Feb 2019 10:21:54 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] arm64: entry: Remove unneeded need_resched() loop
Message-ID: <20190201102154.GB26637@fuggles.cambridge.arm.com>
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131182339.9835-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:23:37PM +0000, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Reported-by: Julien Thierry <julien.thierry@arm.com>
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/kernel/entry.S | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 0ec0c46b2c0c..4d0c81f29a60 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -611,7 +611,7 @@ el1_irq:
>  #ifdef CONFIG_PREEMPT
>  	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
>  	cbnz	x24, 1f				// preempt count != 0
> -	bl	el1_preempt
> +	bl	preempt_schedule_irq		// irq en/disable is done inside
>  1:
>  #endif
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -620,15 +620,6 @@ el1_irq:
>  	kernel_exit 1
>  ENDPROC(el1_irq)
>  
> -#ifdef CONFIG_PREEMPT
> -el1_preempt:
> -	mov	x24, lr
> -1:	bl	preempt_schedule_irq		// irq en/disable is done inside
> -	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
> -	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
> -	ret	x24
> -#endif
> -

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up for 5.1.

Will
