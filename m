Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9E6C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D727620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D727620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeILPf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:35:26 -0400
Received: from foss.arm.com ([217.140.101.70]:57230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeILPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:35:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5407A9;
        Wed, 12 Sep 2018 03:31:31 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCF2C3F614;
        Wed, 12 Sep 2018 03:31:28 -0700 (PDT)
Subject: Re: [PATCH v5 06/27] arm64: Delay daif masking for user return
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-7-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <59fa96d5-6bfa-c3aa-94d6-5941a7576bfa@arm.com>
Date:   Wed, 12 Sep 2018 11:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-7-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> Masking daif flags is done very early before returning to EL0.
> 
> Only toggle the interrupt masking while in the vector entry and mask daif
> once in kernel_exit.

I had an earlier version that did this, but it showed up as a performance
problem. commit 8d66772e869e ("arm64: Mask all exceptions during kernel_exit")
described it as:
|    Adding a naked 'disable_daif' to kernel_exit causes a performance problem
|    for micro-benchmarks that do no real work, (e.g. calling getpid() in a
|    loop). This is because the ret_to_user loop has already masked IRQs so
|    that the TIF_WORK_MASK thread flags can't change underneath it, adding
|    disable_daif is an additional self-synchronising operation.
|
|    In the future, the RAS APEI code may need to modify the TIF_WORK_MASK
|    flags from an SError, in which case the ret_to_user loop must mask SError
|    while it examines the flags.


We may decide that the benchmark is silly, and we don't care about this. (At the
time it was easy enough to work around).

We need regular-IRQs masked when we read the TIF flags, and to stay masked until
we return to user-space.
I assume you're changing this so that psuedo-NMI are unmasked for EL0 until
kernel_exit.

I'd like to be able to change the TIF flags from the SError handlers for RAS,
which means masking SError for do_notify_resume too. (The RAS code that does
this doesn't exist today, so you can make this my problem to work out later!)
I think we should have psuedo_NMI masked if SError is masked too.


Is there a strong reason for having psuedo-NMI unmasked during
do_notify_resume(), or is it just for having the maximum amount of code exposed?


Thanks,

James

> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 09dbea22..85ce06ac 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -259,9 +259,9 @@ alternative_else_nop_endif
>  	.endm
>  
>  	.macro	kernel_exit, el
> -	.if	\el != 0
>  	disable_daif
>  
> +	.if	\el != 0
>  	/* Restore the task's original addr_limit. */
>  	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
>  	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
> @@ -896,7 +896,7 @@ work_pending:
>   * "slow" syscall return path.
>   */
>  ret_to_user:
> -	disable_daif
> +	disable_irq				// disable interrupts
>  	ldr	x1, [tsk, #TSK_TI_FLAGS]
>  	and	x2, x1, #_TIF_WORK_MASK
>  	cbnz	x2, work_pending
> 

