Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDCDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1099F20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2YVEIJ4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1099F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeKLB31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:29:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeKLB31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VxgewE1aQOeLLyBtfyXEevOusqyK6eRA2KSg3uriUkg=; b=2YVEIJ4wsk8UB4smXI2JdKKgk
        9MCfjYIDY5ECpq3Lgr5ic+PoLVyZ7D9KZiBW5z4SKysF2FLkz3wJdaL4CAGfvYYGCjvTasbIYFqOk
        ozsm6NpFklU6h0kSBgLuzlNIbXiiWdsBnh3YcPz9kc3Zmvq6Ace05jIFQA5SBq9eT8Bss5ZY9R+/v
        wdVmEspC0CP6neNElElLXLhOOU2gc6KShb1jJJ0YL3wfTP+Yxo0hb5fjnOjOA0uEIpAde9ayqtKSn
        QoZD8AUuS997YRIgYorvtXR0N5iSOxUU8B3YSL3f3y0+Spj2SO12uuou99ASEKvIuX1cRWV881Mbe
        gXf1dWkAw==;
Received: from [64.114.255.97] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLrqU-0008Sk-2M; Sun, 11 Nov 2018 15:40:18 +0000
Received: by worktop (Postfix, from userid 1000)
        id 51CE56E0405; Sun, 11 Nov 2018 16:40:17 +0100 (CET)
Date:   Sun, 11 Nov 2018 16:40:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor
 for tickless systems
Message-ID: <20181111154017.GD3021@worktop>
References: <102783770.7hZjAahU8c@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102783770.7hZjAahU8c@aspire.rjw.lan>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 06:25:07PM +0100, Rafael J. Wysocki wrote:
> +unsigned int teo_idle_duration(struct cpuidle_driver *drv,
> +			       struct teo_cpu *cpu_data,
> +			       unsigned int sleep_length_us)
> +{
> +	u64 range, max_spread, sum, max, min;
> +	unsigned int i, count;
> +
> +	/*
> +	 * If the sleep length is below the target residency of idle state 1,
> +	 * the only viable choice is to select the first available (enabled)
> +	 * idle state, so return immediately in that case.
> +	 */
> +	if (sleep_length_us < drv->states[1].target_residency)
> +		return sleep_length_us;
> +
> +	/*
> +	 * The purpose of this function is to check if there is a pattern of
> +	 * wakeups indicating that it would be better to select a state
> +	 * shallower than the deepest one matching the sleep length or the
> +	 * deepest one at all if the sleep lenght is long.  Larger idle duration
> +	 * values are beyond the interesting range.
> +	 */
> +	range = drv->states[drv->state_count-1].target_residency;
> +	range = min_t(u64, sleep_length_us, range + (range >> 2));
> +
> +	/*
> +	 * This is the value to compare with the distance between the average
> +	 * and the greatest sample to decide whether or not it is small enough.
> +	 * Take 10 us as the total cap of it.
> +	 */
> +	max_spread = max_t(u64, range >> MAX_SPREAD_SHIFT, 10);
> +
> +	/*
> +	 * First pass: compute the sum of interesting samples, the minimum and
> +	 * maximum of them and count them.
> +	 */
> +	count = 0;
> +	sum = 0;
> +	max = 0;
> +	min = UINT_MAX;
> +
> +	for (i = 0; i < INTERVALS; i++) {
> +		u64 val = cpu_data->intervals[i];
> +
> +		if (val >= range)
> +			continue;
> +
> +		count++;
> +		sum += val;
> +		if (max < val)
> +			max = val;
> +
> +		if (min > val)
> +			min = val;
> +	}
> +
> +	/* Give up if the number of interesting samples is too small. */
> +	if (count <= INTERVALS / 2)
> +		return sleep_length_us;
> +
> +	/*
> +	 * If the distance between the max or min and the average is too large,
> +	 * try to refine by discarding the max, as long as the count is above 3.
> +	 */
> +	while (count > 3 && max > max_spread &&
> +	       ((max - max_spread) * count > sum ||
> +	        (min + max_spread) * count < sum)) {
> +
> +		range = max;
> +
> +		/*
> +		 * Compute the sum of samples in the interesting range.  Count
> +		 * them and find the maximum of them.
> +		 */
> +		count = 0;
> +		sum = 0;
> +		max = 0;
> +
> +		for (i = 0; i < INTERVALS; i++) {
> +			u64 val = cpu_data->intervals[i];
> +
> +			if (val >= range)
> +				continue;
> +
> +			count++;
> +			sum += val;
> +			if (max < val)
> +				max = val;
> +		}
> +	}
> +
> +	return div64_u64(sum, count);
> +}

By always discarding the larger value; you're searching for the first or
shortest peak, right?

While that is always a safe value; it might not be the best value.

Also; I think you can write the whole thing shorter; maybe like:


	do {
		count = sum = max = 0;
		min = UINT_MAX;

		for (i = 0; i < INTERVALS; i++) {
			u64 val = cpu_data->intervals[i];

			if (val >= range)
				continue;

			count++;
			sum += val;
			max = max(max, val);
			min = min(min, val);
		}

		range = max;

	} while (count > 3 && max > max_spread &&
	         ((max - max_spread) * count > sum ||
		  (min + max_spread) * count < sum));

per the fact that <= INTERVALS/2 := > 3, without assuming that you need
one more condition in there for the first pass or something.


Anyway; a fair while ago I proposed a different estimator. I've not had
time to dig through the 4 prior versions so I cannot tell if you've
already tried this, but the idea was simple:

  - track the last @n wakeup distances in the @idle-states buckets;
  - sum the buckets in increasing idle state and pick the state before
    you reach 50% of @n.

That is computationally cheaper than what you have; and should allow you
to increase @n without making the computation more expensive.

