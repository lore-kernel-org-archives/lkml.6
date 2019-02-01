Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEBFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2F2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfBAIq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:46:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56108 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAIq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:46:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E36A78;
        Fri,  1 Feb 2019 00:46:26 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 059613F71E;
        Fri,  1 Feb 2019 00:46:24 -0800 (PST)
Subject: Re: [RFC PATCH 1/3] arm64: entry: Remove unneeded need_resched() loop
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-2-valentin.schneider@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <d7b5db35-0906-4ac2-d51e-905790020eaf@arm.com>
Date:   Fri, 1 Feb 2019 08:46:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131182339.9835-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 31/01/2019 18:23, Valentin Schneider wrote:
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

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

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
>  /*
>   * EL0 mode handlers.
>   */
> 

-- 
Julien Thierry
