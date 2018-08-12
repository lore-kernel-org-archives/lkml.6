Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09DAC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED8217BD
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPiW/7Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED8217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeHLRdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 13:33:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34548 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeHLRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 13:33:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so5521551wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOElgytuRc10wDKpe0RlyUZj+qt1LGN5Wb42nE6JFm8=;
        b=CPiW/7AvdnVyjS9bQNkM2vUIY0DmlSnDvRfh8LK5J5NO/aGY/tPQT0/7kH+CFtpBRl
         zEIuL5JFxltQb53CFJYhg+WImYt3NliQxR2lZuMl6BYCbBw+ZUr+bJLd5/ArQBfELQ+M
         0MXwDxrZP5pAeMQJXOMUj8P+Nevk080XeMDH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOElgytuRc10wDKpe0RlyUZj+qt1LGN5Wb42nE6JFm8=;
        b=HRuNBdwLn2Uf8aK0rqXDSS3WLTgm6cQFikQEvUU2uEzdEbS5qBcTsQKVLcaKVGzGe0
         t8j3rbC4qxKXjATiuguSLNqOzgMBJoveglchGmpHjxMBaO9t6/VFMu5+JHwR9VZec/Dw
         Ai1heLKap3qNBt0myzI+SSWG+K2J2QOQMoEvRnvkUSib8VRRSN6ib1gIC4Lc3g4M9JOq
         sx8/LcqzYXBXoWgdHpqt/855XcjEqM8eDFbKk5lWff9AHx7ULv2kwVVh4wkbknX3we8e
         vMdK55r+a4SYM4uwFAAAaLLYM4eifbmtDsOYRHd12VBQkaNYyaqFPJCXJ1yTnjH1IMXH
         TKuA==
X-Gm-Message-State: AOUpUlE9FiiCWFsRVol0pVljTAE39V68tO0oO5P8A/YhydSgtfYfagbM
        63Mnd5eftl3Dhn2O0J+s2UDipw==
X-Google-Smtp-Source: AA+uWPxykWlQIanNGft8wFZmylUC0on7WtxDQGOoF6bSB8BvIJFZBXBvQ1hJgP4/+3VXdC2dG+7pQg==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr5565250wmg.155.1534085730333;
        Sun, 12 Aug 2018 07:55:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id a184-v6sm10730192wmh.41.2018.08.12.07.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 07:55:29 -0700 (PDT)
Date:   Sun, 12 Aug 2018 22:55:15 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180812145515.GB28966@leoy-ThinkPad-X240s>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754612.IcCR94pSYR@aspire.rjw.lan>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 01:15:58PM +0200, Rafael J . Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> with stopped tick) missed the case when the target residencies of
> deep idle states of CPUs are above the tick boundary which may cause
> the CPU to get stuck in a shallow idle state for a long time.
> 
> Say there are two CPU idle states available: one shallow, with the
> target residency much below the tick boundary and one deep, with
> the target residency significantly above the tick boundary.  In
> that case, if the tick has been stopped already and the expected
> next timer event is relatively far in the future, the governor will
> assume the idle duration to be equal to TICK_USEC and it will select
> the idle state for the CPU accordingly.  However, that will cause the
> shallow state to be selected even though it would have been more
> energy-efficient to select the deep one.
> 
> To address this issue, modify the governor to always assume idle
> duration to be equal to the time till the closest timer event if
> the tick is not running which will cause the selected idle states
> to always match the known CPU wakeup time.
> 
> Also make it always indicate that the tick should be stopped in
> that case for consistency.
> 
> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Initialize first_idx properly in the stopped tick case.
> 
> -> v3: Compute data->bucket before checking whether or not the tick has been
>        stopped already to prevent it from becoming stale.
> 
> ---
>  drivers/cpuidle/governors/menu.c |   55 +++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
>  {
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	int latency_req = cpuidle_governor_latency_req(dev->cpu);
> -	int i;
> -	int first_idx;
> -	int idx;
> +	int first_idx = 0;
> +	int idx, i;
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
>  	unsigned long nr_iowaiters, cpu_load;
> @@ -311,6 +310,18 @@ static int menu_select(struct cpuidle_dr
>  	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
>  
>  	/*
> +	 * If the tick is already stopped, the cost of possible short idle
> +	 * duration misprediction is much higher, because the CPU may be stuck
> +	 * in a shallow idle state for a long time as a result of it.  In that
> +	 * case say we might mispredict and use the known time till the closest
> +	 * timer event for the idle state selection.
> +	 */
> +	if (tick_nohz_tick_stopped()) {
> +		data->predicted_us = ktime_to_us(delta_next);
> +		goto select;
> +	}

I tried this patch at my side, firstly just clarify this patch is okay
for me, but there have other underlying issues I observed the CPU
staying shallow idle state with tick stopped, so just note at here.

From my understanding, the rational for this patch is we
only use the timer event as the reliable wake up source; if there have
one short timer event then we can select shallow state, otherwise we
also can select deepest idle state for long expired timer.

This means the idle governor needs to know the reliable info for the
timer event, so far I observe there at least have two issues for timer
event delta value cannot be trusted.

The first one issue is caused by timer cancel, I wrote one case for
CPU_0 starting a hrtimer with pinned mode with short expire time and
when the CPU_0 goes to sleep this short timeout timer can let idle
governor selects a shallow state; at the meantime another CPU_1 will
be used to try to cancel the timer, my purpose is to cheat CPU_0 so can
see the CPU_0 staying in shallow state for long time;  it has low
percentage to cancel the timer successfully, but I do see seldomly the
timer can be canceled successfully so CPU_0 will stay in idle for long
time (I cannot explain why the timer cannot be canceled successfully
for every time, this might be another issue?).  This case is tricky,
but it's possible happen in drivers with timer cancel.

Another issue is caused by spurious interrupts; if we review the
function tick_nohz_get_sleep_length(), it uses 'ts->idle_entrytime' to
calculate tick or timer delta, so every time when exit from interrupt
and before enter idle governor, it needs to update
'ts->idle_entrytime'; but for spurious interrupts, it will not call
irq_enter() and irq_exit() pairs, so it doesn't invoke below flows:

  irq_exit()
    `->tick_irq_exit()
         `->tick_nohz_irq_exit()
              `->tick_nohz_start_idle()

As result, after spurious interrupts handling, the idle loop doesn't
update for ts->idle_entrytime so the governor might read back a stale
value.  I don't really locate this issue, but I can see the CPU is
waken up without any interrupt handling and then directly go to
sleep again, the menu governor selects one shallow state so the cpu
stay in shallow state for long time.

> +
> +	/*
>  	 * Force the result of multiplication to be 64 bits even if both
>  	 * operands are 32 bits.
>  	 * Make sure to round up for half microseconds.
> @@ -322,7 +333,6 @@ static int menu_select(struct cpuidle_dr
>  	expected_interval = get_typical_interval(data);
>  	expected_interval = min(expected_interval, data->next_timer_us);
>  
> -	first_idx = 0;
>  	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
>  		struct cpuidle_state *s = &drv->states[1];
>  		unsigned int polling_threshold;
> @@ -344,29 +354,15 @@ static int menu_select(struct cpuidle_dr
>  	 */
>  	data->predicted_us = min(data->predicted_us, expected_interval);
>  
> -	if (tick_nohz_tick_stopped()) {
> -		/*
> -		 * If the tick is already stopped, the cost of possible short
> -		 * idle duration misprediction is much higher, because the CPU
> -		 * may be stuck in a shallow idle state for a long time as a
> -		 * result of it.  In that case say we might mispredict and try
> -		 * to force the CPU into a state for which we would have stopped
> -		 * the tick, unless a timer is going to expire really soon
> -		 * anyway.
> -		 */
> -		if (data->predicted_us < TICK_USEC)
> -			data->predicted_us = min_t(unsigned int, TICK_USEC,
> -						   ktime_to_us(delta_next));
> -	} else {
> -		/*
> -		 * Use the performance multiplier and the user-configurable
> -		 * latency_req to determine the maximum exit latency.
> -		 */
> -		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> -		if (latency_req > interactivity_req)
> -			latency_req = interactivity_req;
> -	}
> +	/*
> +	 * Use the performance multiplier and the user-configurable latency_req
> +	 * to determine the maximum exit latency.
> +	 */
> +	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> +	if (latency_req > interactivity_req)
> +		latency_req = interactivity_req;
>  
> +select:
>  	expected_interval = data->predicted_us;
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
> @@ -403,14 +399,13 @@ static int menu_select(struct cpuidle_dr
>  	 * Don't stop the tick if the selected state is a polling one or if the
>  	 * expected idle duration is shorter than the tick period length.
>  	 */
> -	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -	    expected_interval < TICK_USEC) {
> +	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> +	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
>  		unsigned int delta_next_us = ktime_to_us(delta_next);
>  
>  		*stop_tick = false;
>  
> -		if (!tick_nohz_tick_stopped() && idx > 0 &&
> -		    drv->states[idx].target_residency > delta_next_us) {
> +		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
>  			/*
>  			 * The tick is not going to be stopped and the target
>  			 * residency of the state to be returned is not within
> 
