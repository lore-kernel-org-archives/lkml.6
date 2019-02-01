Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65831C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB0218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfBAItp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:49:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbfBAItm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:49:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B45A78;
        Fri,  1 Feb 2019 00:49:42 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE583F71E;
        Fri,  1 Feb 2019 00:49:40 -0800 (PST)
Subject: Re: [RFC PATCH 2/3] ARM: entry: Remove unneeded need_resched() loop
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-3-valentin.schneider@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <fa090a80-5579-5dac-da19-56c9a6c5c423@arm.com>
Date:   Fri, 1 Feb 2019 08:49:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131182339.9835-3-valentin.schneider@arm.com>
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
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

> ---
>  arch/arm/kernel/entry-armv.S | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index e85a3af9ddeb..a7ac22e09bb2 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -220,7 +220,7 @@ __irq_svc:
>  	teq	r8, #0				@ if preempt count != 0
>  	movne	r0, #0				@ force flags to 0
>  	tst	r0, #_TIF_NEED_RESCHED
> -	blne	svc_preempt
> +	blne	preempt_schedule_irq            @ irq en/disable is done inside
>  #endif
>  
>  	svc_exit r5, irq = 1			@ return from exception
> @@ -229,16 +229,6 @@ ENDPROC(__irq_svc)
>  
>  	.ltorg
>  
> -#ifdef CONFIG_PREEMPT
> -svc_preempt:
> -	mov	r8, lr
> -1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
> -	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
> -	tst	r0, #_TIF_NEED_RESCHED
> -	reteq	r8				@ go again
> -	b	1b
> -#endif
> -
>  __und_fault:
>  	@ Correct the PC such that it is pointing at the instruction
>  	@ which caused the fault.  If the faulting instruction was ARM
> 

-- 
Julien Thierry
