Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38018C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0779120874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRLuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:50:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeLRLuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:50:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F92E80D;
        Tue, 18 Dec 2018 03:49:59 -0800 (PST)
Received: from queper01-ThinkPad-T460s (queper01-ThinkPad-T460s.cambridge.arm.com [10.1.30.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2B2F3F5C0;
        Tue, 18 Dec 2018 03:49:56 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:49:49 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH] cpuidle: New timer events oriented governor for tickless
 systems
Message-ID: <20181218114949.c6npu357fj65l5iv@queper01-ThinkPad-T460s>
References: <128769314.7imKxugEn6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <128769314.7imKxugEn6@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

I skimmed through the previous versions, but apologies if some of these
things have been discussed already :-)

On Tuesday 18 Dec 2018 at 12:09:05 (+0100), Rafael J. Wysocki wrote:
<...>
> + * - Find an idle state on the basis of the sleep length and state statistics
> + *   collected over time:
> + *
> + *   o Find the deepest idle state whose target residency is less than or euqal

s/euqal/equal


<...>
> +/**
> + * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
> + * @early_hits: "Early" CPU wakeups "matching" this state.
> + * @hits: "On time" CPU wakeups "matching" this state.
> + * @misses: CPU wakeups "missing" this state.
> + *
> + * A CPU wakeup is "matched" by a given idle state if the idle duration measured
> + * after the wakeup is between the target residency of that state and the target
> + * residnecy of the next one (or if this is the deepest available idle state, it

s/residnecy/residency

> + * "matches" a CPU wakeup when the measured idle duration is at least equal to
> + * its target residency).
> + *
> + * Also, from the TEO governor prespective, a CPU wakeup from idle is "early" if

s/prespective/perspective

> + * it occurs significantly earlier than the closest expected timer event (that
> + * is, early enough to match an idle state shallower than the one matching the
> + * time till the closest timer event).  Otherwise, the wakeup is "on time", or
> + * it is a "hit".
> + *
> + * A "miss" occurs when the given state doesn't match the wakeup, but it matches
> + * the time till the closest timer event used for idle state selection.
> + */


<...>
> +static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +	unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
> +	int i, idx_hit = -1, idx_timer = -1;
> +	unsigned int measured_us;
> +
> +	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
> +		/*
> +		 * One of the safety nets has triggered or this was a timer
> +		 * wakeup (or equivalent).
> +		 */
> +		measured_us = sleep_length_us;
> +	} else {
> +		unsigned int lat = drv->states[cpu_data->last_state].exit_latency;
> +
> +		measured_us = ktime_to_us(cpu_data->time_span_ns);
> +		/*
> +		 * The delay between the wakeup and the first instruction
> +		 * executed by the CPU is not likely to be worst-case every
> +		 * time, so take 1/2 of the exit latency as a very rough
> +		 * approximation of the average of it.
> +		 */
> +		if (measured_us >= lat)
> +			measured_us -= lat / 2;
> +		else
> +			measured_us /= 2;

I'm not sure to understand this; why not removing lat/2 in all cases and
cap at 0 ?

> +	}


<...>
> +	/*
> +	 * Save idle duration values corresponding to non-timer wakeups for
> +	 * pattern detection.
> +	 *
> +	 * If the total time span between idle state selection and the "reflect"
> +	 * callback is greater than or equal to the sleep length determined at
> +	 * the idle state selection time, the wakeup is likely to be due to a
> +	 * timer event.

Should this paragraph go above the first 'if' of this function ? It
checks the same thing and it took me some time to understand what you
were doing while the explanation I needed was down here all along :-)

> +	 */
> +	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns)
> +		measured_us = UINT_MAX;
> +
> +	cpu_data->intervals[cpu_data->interval_idx++] = measured_us;
> +	if (cpu_data->interval_idx > INTERVALS)
> +		cpu_data->interval_idx = 0;
> +}


<...>
> +		/*
> +		 * Count and sum the most recent idle duration values less than
> +		 * the target residency of the state selected so far, find the
> +		 * max.
> +		 */
> +		for (i = 0; i < INTERVALS; i++) {
> +			unsigned int val = cpu_data->intervals[i];
> +
> +			if (val >= drv->states[idx].target_residency)
> +				continue;
> +
> +			count++;
> +			sum += val;
> +		}
> +
> +		/*
> +		 * Give up unless the majority of the most recent idle duration
> +		 * values are in the interesting range.
> +		 */
> +		if (count > INTERVALS / 2) {

I understand this probably works well enough in practice, but how 'robust'
is supposed to be this filtering here ? If you have, say, 2 tasks with
prime periods, then the hyper-period (which is when the pattern repeats)
can get high really quickly, and you'll never see the full extent of
that pattern with this mechanism.

Yes, it's hard to do much better without introducing tons of complexity
in here, but how did you define INTERVALS=8 and so ? Is this something
you'd like to make configurable at some point ? I guess this could
always be done later if need be.

> +			unsigned int avg_us = div64_u64(sum, count);
> +
> +			/*
> +			 * Avoid spending too much time in an idle state that
> +			 * would be too shallow.
> +			 */
> +			if (!(tick_nohz_tick_stopped() && avg_us < TICK_USEC)) {

IIUC, this is saying we shouldn't trust the predicted sleep time if it
is shorter than the tick and the tick is stopped. What is the use case
you have in mind for this ?

In other words, in which scenario do you expect to see a lot of high
frequency non-timer-related wake-ups and have the tick disabled ?

> +				idx = teo_find_shallower_state(drv, dev, idx, avg_us);
> +				duration_us = avg_us;
> +			}
> +		}
> +	}

Thanks,
Quentin
