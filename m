Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D3CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B117C2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VwviLJCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B117C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbeKGCbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:31:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389389AbeKGCbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J+AQHXDaRXe5s5Tal8bIIneMc3X482IV7r7MRuAHypk=; b=VwviLJCrqrKrK9wWgeTnIndCi
        6Knc9NQXCxj7sCKNBpbXLHpSM27iHUT/hmL25k4PSy/TRV7EJtQ/iWLJa5SC4m13HAngo+e8V2qRZ
        9/6DL6WLoVF8+bQyhyvGWXXvNNYnF97PgbVTUIsyhAS5pQ2/EyCWjraU6CMneI4WF/Zd4gTjflmEM
        kZtXLu0Kf/6QKJLCB0vPqLbSpNGA+XCOmsyJobibKyBdKVgNvakplsyKpRI+ISxVAXK35FeipkdDs
        AW119Nd5yax78WgNuRbcHALXhIX/T1cnxBlx4F340+oPYhBJzxhgd7U7eb5WLcmoKXnC67BfM3XXE
        QfFGnYfyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK4mT-00020L-KN; Tue, 06 Nov 2018 17:04:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4FA320284C62; Tue,  6 Nov 2018 18:04:42 +0100 (CET)
Date:   Tue, 6 Nov 2018 18:04:42 +0100
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
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Message-ID: <20181106170442.GC9781@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556808.yKVbhZSazi@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 05:31:20PM +0100, Rafael J. Wysocki wrote:
> + * - If there is a pattern of 5 or more recent non-timer wakeups earlier than
> + *   the closest timer event, expect one more of them to occur and use the
> + *   average of the idle duration values corresponding to them to select an
> + *   idle state for the CPU.


> +/**
> + * teo_idle_duration - Estimate the duration of the upcoming CPU idle time.
> + * @drv: cpuidle driver containing state data.
> + * @cpu_data: Governor data for the target CPU.
> + * @sleep_length_us: Time till the closest timer event in microseconds.
> + */
> +unsigned int teo_idle_duration(struct cpuidle_driver *drv,
> +			       struct teo_cpu *cpu_data,
> +			       unsigned int sleep_length_us)
> +{
> +	u64 range, max_spread, max, sum;
> +	unsigned int count;
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
> +	 *
> +	 * Narrowing the range of interesting values down upfront also helps to
> +	 * avoid overflows during the computation below.
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
> +	max = range;
> +
> +	do {
> +		u64 cap = max;
> +		int i;
> +
> +		/*
> +		 * Compute the sum of the saved intervals below the cap and the
> +		 * sum of of their squares.  Count them and find the maximum
> +		 * interval below the cap.
> +		 */
> +		count = 0;
> +		sum = 0;
> +		max = 0;
> +
> +		for (i = 0; i < INTERVALS; i++) {
> +			u64 val = cpu_data->intervals[i];
> +
> +			if (val >= cap)
> +				continue;
> +
> +			count++;
> +			sum += val;
> +			if (max < val)
> +				max = val;
> +		}
> +
> +		/*
> +		 * Give up if the total number of interesting samples is too
> +		 * small.
> +		 */
> +		if (cap == range && count <= INTERVALS / 2)
> +			return sleep_length_us;
> +
> +		/*
> +		 * If the distance between the max and the average is too large,
> +		 * discard the max an repeat.
> +		 */
> +	} while (count > 3 && max > max_spread && (max - max_spread) * count > sum);
> +
> +	return div64_u64(sum, count);
> +}

Instead of this detector; why haven't you used the code from
kernel/irq/timings.c ?
