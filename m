Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C606C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D06620866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xNUzPBiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D06620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeINMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:54:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nBCw95MZoaOSgS/VhGCBvaJiYoXuFm90CmUzQ+d6IWg=; b=xNUzPBiNphBZt0250jPEnlcbI
        R25fMt1SykTWAKTqMzS0uIRybyUsoSWWzChWJywjkGFhBkDR8xeP46xeamXSqp6ost+KBBl6PHI9n
        7+TgNr43iSGMongQGH0YrgXP0HoZsUNvVJHwXqBxlf+UvYvjejnYh05Qc494HLsndtRUgKS2X6d0u
        NrGIPkJInkxdNvhu+VgwITqKl3XHJJXAEw9sp2xvOB+sBcvy51QAs7xcWuNjYVSKT9T1yxYip14lz
        T3PALycmw6Xekn/VSvJKUBHzPvaEFyv1wDERsN/A4Oexoz95amLqeHh0rr87g6ga0/kwcYttbyM9t
        Ve1WAgmLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0iil-0000Ak-I7; Fri, 14 Sep 2018 07:40:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76F83202C1A2E; Fri, 14 Sep 2018 09:40:52 +0200 (CEST)
Date:   Fri, 14 Sep 2018 09:40:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Message-ID: <20180914074052.GF24124@hirez.programming.kicks-ass.net>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9611469.2z7W9akjOQ@aspire.rjw.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 08:59:03AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a difference in behavior between suspend-to-idle and
> suspend-to-RAM in the timekeeping handling that leads to functional
> issues.  Namely, every iteration of the loop in s2idle_loop()
> increases the monotinic clock somewhat, even if timekeeping_suspend()
> and timekeeping_resume() are invoked from s2idle_enter(), and if
> many of them are carried out in a row, the monotonic clock can grow
> significantly while the system is regarded as suspended, which
> doesn't happen during suspend-to-RAM and so it is unexpected and
> leads to confusion and misbehavior in user space (similar to what
> ensued when we tried to combine the boottime and monotonic clocks).
> 
> To avoid that, count all iterations of the loop in s2idle_loop()
> as "sleep time" and adjust the clock for that on exit from
> suspend-to-idle.
> 
> [That also covers systems on which timekeeping is not suspended
>  by by s2idle_enter().]
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do we want a 'warning' of sorts when the delta becomes significant (for
whatever that is) ? That might be an indication that there are frequent
wakeups which we might not be expecting. Of keep the number of spurious
wakeups in a stat counter somewhere -- something to look at if the
battery drains faster than expected.

Otherwise:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

One minor nit below:

> ---
>  kernel/power/suspend.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -109,8 +109,12 @@ static void s2idle_enter(void)
>  
>  static void s2idle_loop(void)
>  {
> +	ktime_t start, delta;
> +
>  	pm_pr_dbg("suspend-to-idle\n");
>  
> +	start = ktime_get();
> +
>  	for (;;) {
>  		int error;
>  
> @@ -150,6 +154,20 @@ static void s2idle_loop(void)
>  		pm_wakeup_clear(false);
>  	}
>  
> +	/*
> +	 * If the monotonic clock difference between the start of the loop and
> +	 * this point is too large, user space may get confused about whether or
> +	 * not the system has been suspended and tasks may get killed by
> +	 * watchdogs etc., so count the loop as "sleep time" to compensate for
> +	 * that.
> +	 */
> +	delta = ktime_sub(ktime_get(), start);
> +	if (ktime_to_ns(delta) > 0) {
> +		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
> +
> +		timekeeping_inject_sleeptime64(&timespec64_delta);
> +	}
> +
>  	pm_pr_dbg("resume from suspend-to-idle\n");
>  }

Like I mentioned yesterday; I myself prefer the form:


	u64 stamp = ktimer_get_ns();

	for (;;) {
		/* ... */
	}

	stamp = ktime_get_ns() - stamp;
	if (stamp)
		timekeeping_inject_sleeptime64(ns_to_timespec64(ns));


Esp. since ktime_t _is_ s64 these days, there is no point in keep using
all the weird ktime helpers that make the code harder to read.
