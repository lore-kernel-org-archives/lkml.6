Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945E620841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945E620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbeHARvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:51:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389698AbeHARvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:51:45 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fktcj-00028t-1Z; Wed, 01 Aug 2018 18:05:17 +0200
Date:   Wed, 1 Aug 2018 18:04:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gaurav Kohli <gkohli@codeaurora.org>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] timers: Clear must_forward_clk inside base lock
In-Reply-To: <1533129016-28050-1-git-send-email-gkohli@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1808011804040.1835@nanos.tec.linutronix.de>
References: <1533129016-28050-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Gaurav Kohli wrote:
> @@ -1657,6 +1657,17 @@ static inline void __run_timers(struct timer_base *base)
>  
>  	raw_spin_lock_irq(&base->lock);
>  
> +	/*
> +	 * The must_forward_clk flag is cleared unconditionally also for
> +	 * the deferrable base. The deferrable base is not affected by idle
> +	 * tracking and never forwarded, so clearing the flag is a NOOP.
> +	 *
> +	 * The fact that the deferrable base is never forwarded can cause
> +	 * large variations in granularity for deferrable timers, but they
> +	 * can be deferred for long periods due to idle anyway.
> +	 */
> +	base->must_forward_clk = false;
> +
>  	while (time_after_eq(jiffies, base->clk)) {
>  
>  		levels = collect_expired_timers(base, heads);
> @@ -1676,19 +1687,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>  {
>  	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>  
> -	/*
> -	 * must_forward_clk must be cleared before running timers so that any
> -	 * timer functions that call mod_timer will not try to forward the
> -	 * base. idle trcking / clock forwarding logic is only used with
> -	 * BASE_STD timers.

You lost this part of the comment ....

Thanks,

	tglx
