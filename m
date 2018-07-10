Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B44220883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B44220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGJNLZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:11:25 -0400
Received: from foss.arm.com ([217.140.101.70]:46188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754201AbeGJNLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:11:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A62ED1;
        Tue, 10 Jul 2018 06:11:24 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E01F3F5A0;
        Tue, 10 Jul 2018 06:11:22 -0700 (PDT)
Date:   Tue, 10 Jul 2018 14:11:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Yandong.Zhao" <yandong77520@gmail.com>
Cc:     zhaoxb@thundersoft.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, zhaoyd@thundersoft.com,
        linux-arm-kernel@lists.infradead.org, fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180710131119.GI9486@e103592.cambridge.arm.com>
References: <1531189300-26216-1-git-send-email-yandong77520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531189300-26216-1-git-send-email-yandong77520@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:21:40AM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> Operations for contexts where we do not want to do any checks for
> preemptions.  Unless strictly necessary, always use this_cpu_read()
> instead.  Because of the kernel_neon_busy here we have to make sure
> that it is the current cpu.

I find this wording a bit confusing.

Does the following make look OK to you?

--8<--

It does not matter if the caller of may_use_simd() migrates to
another cpu after the call, but it is still important that the
kernel_neon_busy percpu instance that is read matches the cpu the
task is running on at the time of the read.

This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
may appear true if the caller migrates during the execution of
raw_cpu_read() and the next task to be scheduled in on the initial
cpu calls kernel_neon_begin().

This patch replaces raw_cpu_read() with this_cpu_read() to protect
against this race.

-->8--

> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> ---
>  arch/arm64/include/asm/simd.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..8b97f8b 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,7 +29,8 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * The raw_cpu_read() is racy if called with preemption enabled.
> +	 * The this_cpu_read() is racy if called with preemption enabled,
> +	 * since the task my subsequently migrate to another CPU.

"my" -> "may"

(apologies if I was responsible for that typo)


[...]

Cheers
---Dave
