Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1700EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD01B214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD01B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeKONVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:21:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57850 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKONVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:21:54 -0500
Received: from 64.114.255.114 (64.114.255.114) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 99c4a3471693d3da; Thu, 15 Nov 2018 04:15:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 15 Nov 2018 04:15:59 +0100
Message-ID: <3270197.PFh8UsvZCP@aspire.rjw.lan>
In-Reply-To: <20181111154017.GD3021@worktop>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <20181111154017.GD3021@worktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 11, 2018 4:40:17 PM CET Peter Zijlstra wrote:
> On Thu, Nov 08, 2018 at 06:25:07PM +0100, Rafael J. Wysocki wrote:
> > +unsigned int teo_idle_duration(struct cpuidle_driver *drv,
> > +			       struct teo_cpu *cpu_data,
> > +			       unsigned int sleep_length_us)
> > +{
> > +	u64 range, max_spread, sum, max, min;
> > +	unsigned int i, count;
> > +
> > +	/*
> > +	 * If the sleep length is below the target residency of idle state 1,
> > +	 * the only viable choice is to select the first available (enabled)
> > +	 * idle state, so return immediately in that case.
> > +	 */
> > +	if (sleep_length_us < drv->states[1].target_residency)
> > +		return sleep_length_us;
> > +
> > +	/*
> > +	 * The purpose of this function is to check if there is a pattern of
> > +	 * wakeups indicating that it would be better to select a state
> > +	 * shallower than the deepest one matching the sleep length or the
> > +	 * deepest one at all if the sleep lenght is long.  Larger idle duration
> > +	 * values are beyond the interesting range.
> > +	 */
> > +	range = drv->states[drv->state_count-1].target_residency;
> > +	range = min_t(u64, sleep_length_us, range + (range >> 2));
> > +
> > +	/*
> > +	 * This is the value to compare with the distance between the average
> > +	 * and the greatest sample to decide whether or not it is small enough.
> > +	 * Take 10 us as the total cap of it.
> > +	 */
> > +	max_spread = max_t(u64, range >> MAX_SPREAD_SHIFT, 10);
> > +
> > +	/*
> > +	 * First pass: compute the sum of interesting samples, the minimum and
> > +	 * maximum of them and count them.
> > +	 */
> > +	count = 0;
> > +	sum = 0;
> > +	max = 0;
> > +	min = UINT_MAX;
> > +
> > +	for (i = 0; i < INTERVALS; i++) {
> > +		u64 val = cpu_data->intervals[i];
> > +
> > +		if (val >= range)
> > +			continue;
> > +
> > +		count++;
> > +		sum += val;
> > +		if (max < val)
> > +			max = val;
> > +
> > +		if (min > val)
> > +			min = val;
> > +	}
> > +
> > +	/* Give up if the number of interesting samples is too small. */
> > +	if (count <= INTERVALS / 2)
> > +		return sleep_length_us;
> > +
> > +	/*
> > +	 * If the distance between the max or min and the average is too large,
> > +	 * try to refine by discarding the max, as long as the count is above 3.
> > +	 */
> > +	while (count > 3 && max > max_spread &&
> > +	       ((max - max_spread) * count > sum ||
> > +	        (min + max_spread) * count < sum)) {
> > +
> > +		range = max;
> > +
> > +		/*
> > +		 * Compute the sum of samples in the interesting range.  Count
> > +		 * them and find the maximum of them.
> > +		 */
> > +		count = 0;
> > +		sum = 0;
> > +		max = 0;
> > +
> > +		for (i = 0; i < INTERVALS; i++) {
> > +			u64 val = cpu_data->intervals[i];
> > +
> > +			if (val >= range)
> > +				continue;
> > +
> > +			count++;
> > +			sum += val;
> > +			if (max < val)
> > +				max = val;
> > +		}
> > +	}
> > +
> > +	return div64_u64(sum, count);
> > +}
> 
> By always discarding the larger value; you're searching for the first or
> shortest peak, right?

Yes, basically.

> While that is always a safe value; it might not be the best value.

Sure.

> Also; I think you can write the whole thing shorter; maybe like:
> 
> 
> 	do {
> 		count = sum = max = 0;
> 		min = UINT_MAX;
> 
> 		for (i = 0; i < INTERVALS; i++) {
> 			u64 val = cpu_data->intervals[i];
> 
> 			if (val >= range)
> 				continue;
> 
> 			count++;
> 			sum += val;
> 			max = max(max, val);
> 			min = min(min, val);
> 		}
> 
> 		range = max;
> 
> 	} while (count > 3 && max > max_spread &&
> 	         ((max - max_spread) * count > sum ||
> 		  (min + max_spread) * count < sum));
> 
> per the fact that <= INTERVALS/2 := > 3, without assuming that you need
> one more condition in there for the first pass or something.

The reason I wrote it this way was because I needed to compute the min
in the first pass only and then the count from the first pass was compared
with INTERVALS/2 to decide whether or not to do more passes.

> Anyway; a fair while ago I proposed a different estimator. I've not had
> time to dig through the 4 prior versions so I cannot tell if you've
> already tried this, but the idea was simple:
> 
>   - track the last @n wakeup distances in the @idle-states buckets;
>   - sum the buckets in increasing idle state and pick the state before
>     you reach 50% of @n.
> 
> That is computationally cheaper than what you have; and should allow you
> to increase @n without making the computation more expensive.

I can do something similar (actually, I have a prototype ready already),
but do it after walking the idle states once (which will give us a preliminary
idle state choice based on the time to the closest timer and the "history")
and then sum the buckets below the idle state selected so far in the decreasing
order (that will tend to select a shallower state in "tie" situations).

