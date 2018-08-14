Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576B5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031B521731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGULUp/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031B521731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeHNSce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:32:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37701 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNSce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:32:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so9274367pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWy6we3YYPKN6W3SpT9M+MZ5av+tkqjEZEp52kLHpGg=;
        b=DGULUp/ILP0qsXvBMEiN0xCZII6e1jfPM9HekhinwOYlSfqTmv6nAQKx9J2T/MECwb
         uGN0KfKbyLqgjnBLySGiuyYLcNT7nA8x3Jnv4MnzlTZp3I5bpptlPV/fKq0nol6LOkYD
         0dB2dxsmJmjdOdF8ldj2WGQwYJhq42+MNxmfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWy6we3YYPKN6W3SpT9M+MZ5av+tkqjEZEp52kLHpGg=;
        b=E+Dnkb4F5AZzMdL06VRvKCYvwhqn4tP68jweW9O+tXaQih30xgIbqmH35XGwp8Dmgf
         6vlwgl/zJHZOE2gdghV6bjpLYRRrWCL+ap9dAMEGo/i+Iz3cyXHTBE9LA9pGewWn4RN1
         QxSiv3pw9RgXqM9OA56kygt/otJwMRGShaMsVndRo8iJ6BYBv9naVLRKyvxXmE28Jvmn
         IFdFvUd58wg2Bg6UvOLstXL+mI7Il5BY319MTC6x3zlDfxS+8Jag3kVB618qJgr/G7KX
         XrGm2oC/I6caB1QhcOrqEcZUMHwj+kcFK1jb7NiT85H5KGKacqhpcXPxr4mAdWXbIvF0
         EmPg==
X-Gm-Message-State: AOUpUlEI7+gbeVVS5Z4seC/unr34M94jGWqPkEbjE/ef5TamH9NhVaYn
        fTxDm0P/fDSuO0g2PASgGqV/0nGC3M+fvQrk
X-Google-Smtp-Source: AA+uWPxPoE5UgaO45dxkp1ih7h+DzKww00Gg6BTs2IFXnGMCmWVpAL1x/qyEJhC8qNpXdLEn2BFCCw==
X-Received: by 2002:a62:d8c:: with SMTP id 12-v6mr24101454pfn.202.1534261492806;
        Tue, 14 Aug 2018 08:44:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1431-29.members.linode.com. [45.33.104.29])
        by smtp.gmail.com with ESMTPSA id t76-v6sm31860307pfe.109.2018.08.14.08.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 08:44:51 -0700 (PDT)
Date:   Tue, 14 Aug 2018 23:44:41 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180814154441.GA13920@leoy-ThinkPad-X240s>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
 <1582055.9b67urWYFa@aspire.rjw.lan>
 <1572343.jWaXB8XNF1@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572343.jWaXB8XNF1@aspire.rjw.lan>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:34:40PM +0200, Rafael J . Wysocki wrote:
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
> To address this issue, modify the governor to always use the time
> till the closest timer event instead of the predicted idle duration
> if the latter is less than the tick period length and the tick has
> been stopped already.  Also make it extend the search for a matching
> idle state if the tick is stopped to avoid settling on a shallow
> state if deep states with target residencies above the tick period
> length are available.
> 
> In addition, make it always indicate that the tick should be stopped
> if it has been stopped already for consistency.
> 
> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> -> v2: Initialize first_idx properly in the stopped tick case.
>  
> v2 -> v3: Compute data->bucket before checking whether or not the tick has been
>           stopped already to prevent it from becoming stale.
> 
> v3 -> v4: Allow the usual state selection to be carried out if the tick has been
>           stopped in case the predicted idle duration is greater than the tick
>           period length and a matching state can be found without overriding
>           the prediction result.
> 
> v4 -> v5: Rework code to be more straightforward.  Functionally, it should
>           behave like the v4.
> ---
>  drivers/cpuidle/governors/menu.c |   36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -349,14 +349,12 @@ static int menu_select(struct cpuidle_dr
>  		 * If the tick is already stopped, the cost of possible short
>  		 * idle duration misprediction is much higher, because the CPU
>  		 * may be stuck in a shallow idle state for a long time as a
> -		 * result of it.  In that case say we might mispredict and try
> -		 * to force the CPU into a state for which we would have stopped
> -		 * the tick, unless a timer is going to expire really soon
> -		 * anyway.
> +		 * result of it.  In that case say we might mispredict and use
> +		 * the known time till the closest timer event for the idle
> +		 * state selection.
>  		 */
>  		if (data->predicted_us < TICK_USEC)
> -			data->predicted_us = min_t(unsigned int, TICK_USEC,
> -						   ktime_to_us(delta_next));
> +			data->predicted_us = ktime_to_us(delta_next);
>  	} else {
>  		/*
>  		 * Use the performance multiplier and the user-configurable
> @@ -381,8 +379,22 @@ static int menu_select(struct cpuidle_dr
>  			continue;
>  		if (idx == -1)
>  			idx = i; /* first enabled state */
> -		if (s->target_residency > data->predicted_us)
> -			break;
> +		if (s->target_residency > data->predicted_us) {
> +			if (!tick_nohz_tick_stopped())
> +				break;
> +
> +			/*
> +			 * If the state selected so far is shallow and this
> +			 * state's target residency matches the time till the
> +			 * closest timer event, select this one to avoid getting
> +			 * stuck in the shallow one for too long.
> +			 */
> +			if (drv->states[idx].target_residency < TICK_USEC &&
> +			    s->target_residency <= ktime_to_us(delta_next))
> +				idx = i;

I took some time to understand v4 and v5; now I understand you want to
prompt to deeper idle state if the prediction falls in the range
between [TICK_USEC..max_target_residency).  This seems to me is a
huristics method but not general enough and IMHO this is more difficult
for code readable.

I agree this patch can resolve the issue you mentioned in the commit
log, but this patch will be fragile for below case, so it will select
state1 but not state2, how about you think for this case?

Idle_state0::
target_residency   TICK_USEC   Prediction
    |                 |       /
    V                 V      /
-----------------------------------------------------> Time length
                                ^                 ^
                                |                 |
                            Idle_state1:       Idle_state2:
                            target_residency   target_residency

> +			goto out;
> +		}
>  		if (s->exit_latency > latency_req) {
>  			/*
>  			 * If we break out of the loop for latency reasons, use
> @@ -403,14 +415,13 @@ static int menu_select(struct cpuidle_dr
>  	 * Don't stop the tick if the selected state is a polling one or if the
>  	 * expected idle duration is shorter than the tick period length.
>  	 */
> -	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -	    expected_interval < TICK_USEC) {
> +	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> +	     expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
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
> @@ -429,6 +440,7 @@ static int menu_select(struct cpuidle_dr
>  		}
>  	}
>  
> +out:
>  	data->last_state_idx = idx;
>  
>  	return data->last_state_idx;
> 
