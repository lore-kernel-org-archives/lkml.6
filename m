Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185DDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23572083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23572083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbeGKK7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:59:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33202 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732376AbeGKK7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:59:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40DB80D;
        Wed, 11 Jul 2018 03:55:27 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 482303F589;
        Wed, 11 Jul 2018 03:55:26 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:55:23 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Yandong.Zhao" <yandong77520@gmail.com>
Cc:     zhaoxb@thundersoft.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, zhaoyd@thundersoft.com,
        linux-arm-kernel@lists.infradead.org, fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180711105523.GL9486@e103592.cambridge.arm.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:09:59AM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> It does not matter if the caller of may_use_simd() migrates to
> another cpu after the call, but it is still important that the
> kernel_neon_busy percpu instance that is read matches the cpu the
> task is running on at the time of the read.
> 
> This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> may appear true if the caller migrates during the execution of
> raw_cpu_read() and the next task to be scheduled in on the initial
> cpu calls kernel_neon_begin().
> 
> This patch replaces raw_cpu_read() with this_cpu_read() to protect
> against this race.
> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>

Looks ok to me.  You can add the following tags:

Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
Reviewed-by: Dave Martin <Dave.Martin@arm.com>


Cheers
---Dave


> ---
>  arch/arm64/include/asm/simd.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..784a8c2 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,7 +29,8 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * The raw_cpu_read() is racy if called with preemption enabled.
> +	 * The this_cpu_read() is racy if called with preemption enabled,
> +	 * since the task may subsequently migrate to another CPU.
>  	 * This is not a bug: kernel_neon_busy is only set when
>  	 * preemption is disabled, so we cannot migrate to another CPU
>  	 * while it is set, nor can we migrate to a CPU where it is set.
> @@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
>  	 * false.
>  	 */
>  	return !in_irq() && !irqs_disabled() && !in_nmi() &&
> -		!raw_cpu_read(kernel_neon_busy);
> +		!this_cpu_read(kernel_neon_busy);
>  }
>  
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
