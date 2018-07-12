Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC31C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8A520BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8A520BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeGLKE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:04:59 -0400
Received: from foss.arm.com ([217.140.101.70]:48924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeGLKE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:04:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C9A380D;
        Thu, 12 Jul 2018 02:56:09 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 721603F589;
        Thu, 12 Jul 2018 02:56:07 -0700 (PDT)
Date:   Thu, 12 Jul 2018 10:56:05 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Yandong.Zhao" <yandong77520@gmail.com>
Cc:     zhaoxb@thundersoft.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, zhaoyd@thundersoft.com,
        linux-arm-kernel@lists.infradead.org, fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180712095602.GN9486@e103592.cambridge.arm.com>
References: <1531366178-17630-1-git-send-email-yandong77520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531366178-17630-1-git-send-email-yandong77520@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:29:38AM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> It does not matter if the caller of may_use_simd() migrates to
> another cpu after the call, but it is still important that the
> kernel_neon_busy percpu instance that is read matches the cpu the
> task is running on at the time of the read.
> 
> This means that raw_cpu_read() is not sufficient. kernel_neon_busy
> may appear true if the caller migrates during the execution of
> raw_cpu_read() and the next task to be scheduled in on the initial
> cpu calls kernel_neon_begin().
> 
> This patch replaces raw_cpu_read() with this_cpu_read() to protect
> against this race.
> 
> Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm..com>
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> ---
>  arch/arm64/include/asm/simd.h | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..6495cc5 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,20 +29,15 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * The raw_cpu_read() is racy if called with preemption enabled.
> -	 * This is not a bug: kernel_neon_busy is only set when
> -	 * preemption is disabled, so we cannot migrate to another CPU
> -	 * while it is set, nor can we migrate to a CPU where it is set.
> -	 * So, if we find it clear on some CPU then we're guaranteed to
> -	 * find it clear on any CPU we could migrate to.
> -	 *
> -	 * If we are in between kernel_neon_begin()...kernel_neon_end(),
> -	 * the flag will be set, but preemption is also disabled, so we
> -	 * can't migrate to another CPU and spuriously see it become
> -	 * false.
> +	 * kernel_neon_busy is only set while preemption is disabled,
> +	 * and is clear whenever preemption is enabled. Since
> +	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
> +	 * cannot change under our feet -- if it's set we cannot be
> +	 * migrated, and if it's clear we cannot be migrated to a CPU
> +	 * where it is set.
>  	 */

This new explanation looks fine to me.

[...]

Cheers
---Dave
