Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3136C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33475223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahhx3Apu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33475223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeHJLtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:49:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53484 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeHJLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:49:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1155425wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbHgAo019b1xAGMp98Qgt9hfmo1jht8q9PYK+xJ4UTo=;
        b=ahhx3ApuD6J3GRwQnPWP4wd2NjQgDx4t0HC5zhlUPplKrnp7JzTtPu3fHRav3epv3w
         oVnGcOGogcQV0hxaky7X6ZcItCDumvLWGKBBi8PYl4+2WDMEItsE08pNcqkjFOXN7wp9
         I6ildjhMXqA1ZYQ853FR5Tzh+gExzGKcttyJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbHgAo019b1xAGMp98Qgt9hfmo1jht8q9PYK+xJ4UTo=;
        b=LqcxpmZzSjVTmQ+r4bdtOReZv9u6K7LwOTrpehDQuf7kovSARfMLXWOvztbfyG1cZr
         I6gF6TUQpujIfWYCwxtPEL2z3Q0ejKuolY4QvAxikZ3bS81p4launYHoqOq/oQeVWUK/
         9GKK7arKYrY1eTyffX9muk5JHktNgJPtkqzNEUQxIhG9OVNY/o2YPSTJ1eKMiM5b29cZ
         X8fTR+kfwv1brGB2y7saRiP3gWECDDIEbqVa/yhiQ6/kWpeNO08/vvR6+TpIpGL9Fz+j
         0H0orMBoEcfQSNrijC4nCwVtoP+eHZ+IlGKw4qSL4kNzeaYU01a9yJulrUgg//0b6CaR
         hoVw==
X-Gm-Message-State: AOUpUlHunGCEPxsZw8r9IKJOVfkw1FBEHZIJUYPNskSMHWkvLCzWho8L
        NYU6Hz0wjchX+Vzuc/3N4+/cKA==
X-Google-Smtp-Source: AA+uWPyEB9AvRwj6EnQC8RkNIe8k7loVk+jUSk+Oq5Jv4QA25l7ZwWVWOGv0v/4wsZ+h8BEe7giKdA==
X-Received: by 2002:a1c:e304:: with SMTP id a4-v6mr981570wmh.0.1533892842085;
        Fri, 10 Aug 2018 02:20:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1419268wma.32.2018.08.10.02.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:20:41 -0700 (PDT)
Date:   Fri, 10 Aug 2018 17:20:34 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180810092034.GF11817@leoy-ThinkPad-X240s>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174357.2tBMdxG3bF@aspire.rjw.lan>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:57:18AM +0200, Rafael J . Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpuidle: menu: Handle stopped tick more aggressively
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
> @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
>  	/* determine the expected residency time, round up */
>  	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
>  
> +	/*
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
> +

This introduce two potential issues:

- This will totally ignore the typical pattern in idle loop; I
  observed on the mmc driver can trigger multiple times (> 10 times)
  with consistent interval;  but I have no strong opinion to not
  use next timer event for this case.

- Will this break correction factors when the CPU exit from idle?
  data->bucket is stale value ....

>  	get_iowait_load(&nr_iowaiters, &cpu_load);
>  	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
>  
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

I am not sure this logic is right... Why not use below checking, so
for POLLING state we will never ask to stop the tick?

        if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING ||
            (expected_interval < TICK_USEC && !tick_nohz_tick_stopped())) {

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
