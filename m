Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69DC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF70205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF70205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeJVRIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbeJVRIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:08:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB003AE10;
        Mon, 22 Oct 2018 08:50:57 +0000 (UTC)
Message-ID: <1540198496.3333.4.camel@suse.cz>
Subject: Re: [RFC/RFT/[PATCH] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Mon, 22 Oct 2018 10:54:56 +0200
In-Reply-To: <6595711.BNhtJ5yyLe@aspire.rjw.lan>
References: <6595711.BNhtJ5yyLe@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael,

I ran some benchmarks and will send you a detailed report later; for now I
have some questions to make sure I understand the code.

First off, I like your algorithm and you make an excellent job at
documenting it with comments. Since it's a heuristic, it's not "obvious"
code and comments help a lot.

On Thu, 2018-10-11 at 23:01 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The venerable menu governor does some thigns that are quite
> questionable in my view.  First, it includes timer wakeups in
> the pattern detection data and mixes them up with wakeups from
> other sources which in some cases causes it to expect what
> essentially would be a timer wakeup in a time frame in which
> no timer wakeups are possible (becuase it knows the time until
> the next timer event and that is later than the expected wakeup
> time).  Second, it uses the estra exit latency limit based on
> the predicted idle duration and depending on the number of tasks
> waiting on I/O, even though those tasks may run on a different
> CPU when they are woken up.  Moreover, the time ranges used by it
> for the sleep length correction factors are not correlated to the
> list of available idle states in any way whatever and different
> correction factors are used depending on whether or not there are
> tasks waiting on I/O, which again doesn't imply anything in
> particular.
> 
> A major rework of the menu governor would be required to address
> these issues and it is likely that the performance of some
> workloads would suffer from that.  It is thus better to introduce
> an entirely new governor without them and let everybody use the
> governor that works better with their actual workloads.
> 
> The new governor introduced here, the timer events oriented (TEO)
> governor, uses the same basic strategy as menu: it always tries to
> find the deepest idle state that can be used in the given conditions.
> However, it uses a different approach to that problem.  Namely,
> instead of attempting to predict the idle duration itself which is
> likely to be inaccurate no matter what, it selects the idle state
> that was the best "match" for the time range given by the sleep
> length value in the past (see the code comments for details).
> 
> It has been tested on a few different systems with a number of
> different workloads and compared with the menu governor.  In the
> majority of cases the workloads performed similarly regardless of
> the cpuidle governor in use, but in one case the TEO governor
> allowed the workload to perform 75% better, which is a clear
> indication that some workloads may benefit from using it quite
> a bit depending on the hardware they run on.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> I'm running this governor on all of my systems now without any
> visible adverse effects.
> 
> It is likely to select the "polling" state less often than menu
> due to the lack of the extra latency limit derived from the
> predicted idle duration, so the workloads depending on that
> behavior may be worse off (but less energy should be used
> while running them at the same time).
> 
> Overall, it selects deeper idle states than menu more often, but
> that doesn't seem to make a significant difference in the majority
> of cases.
> 
> In this preliminary revision it overtakes menu as the default governor
> for tickless systems (due to the higher rating), but that is likely
> to change going forward.  At this point I'm mostly asking for feedback
> and possibly testing with whatever workloads you can throw at it.
> 
> The patch should apply on top of 4.19-rc7, although I'm running it on
> top of my linux-next branch.
> 
> ---
>  drivers/cpuidle/Kconfig            |   11 +
>  drivers/cpuidle/governors/Makefile |    1 
>  drivers/cpuidle/governors/teo.c    |  397 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 409 insertions(+)
> 
> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- /dev/null
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Timer events oriented CPU idle governor
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> + *
> + * The idea of this governor is based on the observation that on many systems
> + * timer events are two or more orders of magnitude more frequent than any
> + * other interrupts, so they are likely to be the most significant source of CPU
> + * wakeups from idle states.  Moreover, it only is necessary to estimate which
> + * idle state is the most likely one to match the idle duration measured after
> + * wakeup and it may not be necessary to predict the idle duration itself
> + * accurately.  [For example, if only two idle states are available, it is
> + * sufficient to estimate whether or not the first state is more likely to match
> + * the measured idle duration than the second one and the precise length of the
> + * idle interval itself need not be predicted for this purpose.]
> + *
> + * Also, if the time till the closest timer event (sleep length) is used to
> + * select and idle state for a CPU and that state turns out to match the idle
> + * duration measured after wakeup, it doesn't matter if the CPU really has been
> + * woken up by the timer.  What matters is that it has been woken up in the time
> + * frame matching the selected state and not what mechanism in particular has
> + * been the real cause of the wakeup.
> + *
> + * The sleep length is the maximum duration of the upcoming idle time of the
> + * CPU and it is always known to the kernel.  Using it alone for selecting an
> + * idle state for the CPU every time is a viable option in principle, but that
> + * might lead to suboptimal results if the other wakeup sources are more active
> + * for some reason.  Thus this governor estimates whether or not the CPU idle
> + * time is likely to be significantly shorter than the sleep length and selects
> + * an idle state for it in accordance with that, as follows:
> + *
> + * - If there is a series of 3 or more consecutive wakeups each significantly
> + *   earlier than the closest timer event, expect one more of them to occur and
> + *   use the average time between them to select an idle state for the CPU.
> + *
> + * - Otherwise, find the state on the basis of the sleep length and state
> + *   statistics collected over time:
> + *
> + *   o Find the deepest idle state whose target residency is less than or euqal
> + *     to the sleep length.
> + *
> + *   o Select it if the number of times it matched both the sleep length and the
> + *     idle duration measured after wakeup in the past is not less than the total
> + *     number of "early" CPU wakeups matched by all of the shallower states.
> + *
> + *   o Otherwise, select the shallower state with the greatest number of matched
> + *     "early" wakeups.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/cpuidle.h>
> +#include <linux/jiffies.h>
> +#include <linux/tick.h>
> +
> +/*
> + * Assuming an idle interval every second tick, take the maximum number of CPU
> + * wakeups regarded as recent to rougly correspond to 10 minutes.
> + *
> + * When the total number of CPU wakeups goes above this value, all of the
> + * counters corresponding to the given CPU undergo a "decay" and the counting
> + * of recent events stars over.
> + */
> +#define TEO_MAX_RECENT_WAKEUPS	(300 * HZ)
> +
> +/**
> + * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
> + * @early_wakeups: Number of "early" CPU wakeups matched by this state.
> + * @early_wakeups_old: Past "early" CPU wakeups matched by this state (decayed).
> + * @hits: Number of "on time" CPU wakeups matched by this state.
> + * @hits_old: Past "on time" CPU wakeups matched by this state (decayed).
> + *
> + * A CPU wakeup is "matched" by a given idle state if the idle duration measured
> + * after the wakeup is between the target residency of that state and the target
> + * residnecy of the next one (or if this is the deepest state provided, it
> + * "matches" a CPU wakeup when the measured idle duration is at least equal to
> + * its target residency).
> + *
> + * Also, from the TEO governor prespective, a CPU wakeup from idle is "early" if
> + * it occurs significantly earlier than the closest expected timer event (that
> + * is, early enough to match an idle state shallower than the one matching the
> + * time till the closest timer event).  Otherwise, the wakeup is "on time", or
> + * it is a "hit".
> + */
> +struct teo_idle_state {
> +	u64 early_wakeups;
> +	u64 early_wakeups_old;
> +	u64 hits;
> +	u64 hits_old;
> +};
> +
> +/**
> + * struct teo_cpu - CPU data used by the TEO cpuidle governor.
> + * @states: Idle states data corresponding to this CPU.
> + * @early_series_count: Number of recent "early" wakeups in a row (series).
> + * @early_series_time_us: Total idle time corresponding to the "early" series.
> + * @recent_wakeups: Number of wakeups since the counters were decayed last time.
> + * @sleep_length_us: Time till the closest timer event.
> + * @last_state: Idle state entered by the CPU last time.
> + */
> +struct teo_cpu {
> +	struct teo_idle_state states[CPUIDLE_STATE_MAX];
> +	u64 early_series_count;
> +	u64 early_series_time_us;
> +	unsigned int recent_wakeups;
> +	unsigned int sleep_length_us;
> +	int last_state;
> +};
> +
> +static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> +
> +/**
> + * teo_update - Update CPU data after wakeup.
> + * @drv: cpuidle driver containing state data.
> + * @dev: Target CPU.
> + */
> +static void teo_update(struct cpuidle_driver *drv,
> +			   struct cpuidle_device *dev)
> +{
> +	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +	unsigned int measured_us = dev->last_residency;

question: how reliable is the value "dev->last_residency"? does it come
"from the hardware" somehow? I'm asking because I'm more familiar with
CPUfreq than CPUidle, and there you have a bit of a disconnect between what
the OS think and what the hardware actually does. So I wonder if there is a
similar situation with the last_residency value, and ask if it comes from
some sort of feedback from the processor itself (if that makes any
sense). I see it's written to in the cpuidle_enter_state() function in
cpuidle.c, but I couldn't clearly understand that function either.

> +	int i = cpu_data->last_state;
> +
> +	if (measured_us >= 2 * drv->states[i].exit_latency)
> +		measured_us -= drv->states[i].exit_latency;
> +	else
> +		measured_us /= 2;
> +
> +	/* Find the state matching the measured idle duration. */
> +	for (i = drv->state_count - 1; i > 0; i--) {
> +		if (drv->states[i].target_residency <= measured_us)
> +			break;
> +	}

Wait, I'm lost here. You just initialized "int i = cpu_data->last_state;"
ten lines above, and here you're computing "given how much we idled, what
would have been the best state to enter?". Was the initialization of i a
mistake? what's the intention?

> +
> +	cpu_data->recent_wakeups++;
> +
> +	/*
> +	 * If the state matches the time till the closest timer event used
> +	 * during the most recent state selection too, it would be sufficient
> +	 * to use that time alone for the idle state selection, so increment
> +	 * the "hits" number for the matching state and clear the "early series"
> +	 * data.
> +	 *
> +	 * Note that sleep_length_us cannot be less than measured_us (or it
> +	 * would mean a late timer event), so it is sufficient to check the
> +	 * lower boundary here.
> +	 */
> +	if (i == drv->state_count - 1 ||
> +	    drv->states[i+1].target_residency > cpu_data->sleep_length_us)
> {

Correct me if I'm wrong: we know that states[i+1].target_residency > measured_us,
because that's just how we've chosen i. We know that sleep_length_us >= measured_us,
because that's how timers work.

Now, the naive way if we're in a "hit" situation would be to check is
measured_us is equal (or, well, "close") to sleep_length_us. If, on the
other side, measured_us is a lot smaller than sleep_length_us, it's an
"early". But you don't check it that way, what you do is to see if
target_residency[i+1] is in between measured_us and sleep_length_us or
not. Like this (sorry for the sloppy notation:

target_residency[i] < measured_us <= sleep_length_us < target_residency[i+1]

and that would be a hit. Otherwise:

target_residency[i] < measured_us < target_residency[i+1] <= sleep_length_us

and that's an "early". Right?

Again, no guarantee that i is actually the state we idle-ed in, it's just
one we make up for this bookkeeping.


> +		cpu_data->states[i].hits++;
> +
> +		cpu_data->early_series_count = 0;
> +		cpu_data->early_series_time_us = 0;
> +	} else {
> +		/*
> +		 * The wakeup was significantly earlier than the closest timer
> +		 * event used for idle state selection, so update the CPU data
> +		 * to reflect that.
> +		 */
> +		cpu_data->states[i].early_wakeups++;
> +
> +		cpu_data->early_series_count++;
> +		cpu_data->early_series_time_us += measured_us;
> +	}
> +
> +	if (cpu_data->recent_wakeups <= TEO_MAX_RECENT_WAKEUPS)
> +		return;
> +
> +	cpu_data->recent_wakeups = 0;
> +
> +	/* Decay past events information. */
> +	for (i = 0; i < drv->state_count; i++) {
> +		cpu_data->states[i].early_wakeups_old += cpu_data->states[i].early_wakeups;
> +		cpu_data->states[i].early_wakeups_old /= 2;
> +		cpu_data->states[i].early_wakeups = 0;
> +
> +		cpu_data->states[i].hits_old += cpu_data->states[i].hits;
> +		cpu_data->states[i].hits_old /= 2;
> +		cpu_data->states[i].hits = 0;
> +	}
> +}
> +
> +/**
> + * teo_select - Selects the next idle state to enter.
> + * @drv: cpuidle driver containing state data.
> + * @dev: Target CPU.
> + * @stop_tick: Indication on whether or not to stop the scheduler tick.
> + */
> +static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> +		      bool *stop_tick)
> +{
> +	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +	int latency_req = cpuidle_governor_latency_req(dev->cpu);
> +	unsigned int duration_us;
> +	ktime_t delta_next;
> +	int idx, i;
> +	u64 early_count, max_count, prev_count;
> +	int max_count_idx, prev_idx;
> +
> +	if (cpu_data->last_state >= 0) {
> +		teo_update(drv, dev);
> +		cpu_data->last_state = -1;
> +	}
> +
> +	cpu_data->sleep_length_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> +
> +	duration_us = cpu_data->sleep_length_us;
> +
> +	if (cpu_data->early_series_count > 2) {
> +		unsigned int avg_us;
> +
> +		/*
> +		 * There is a series of consecutive wakeups each significantly
> +		 * earlier than the closest timer event, so expect one more of
> +		 * them to occur and use the average time between them for idle
> +		 * state selection, as long as it is within the tick boundary
> +		 * and the tick has not been stopped.
> +		 */
> +		avg_us = div64_u64(cpu_data->early_series_time_us,
> +				   cpu_data->early_series_count);
> +
> +		if (avg_us < TICK_USEC && avg_us < duration_us &&
> +		    !tick_nohz_tick_stopped())
> +			duration_us = avg_us;
> +	}
> +
> +	early_count = 0;
> +	max_count = 0;
> +	max_count_idx = -1;
> +	prev_count = 0;
> +	prev_idx = -1;
> +	idx = -1;
> +
> +	for (i = 0; i < drv->state_count; i++) {
> +		struct cpuidle_state *s = &drv->states[i];
> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
> +		u64 count = cpu_data->states[i].early_wakeups +
> +				cpu_data->states[i].early_wakeups_old;
> +
> +		if (s->disabled || su->disable) {
> +			/*
> +			 * This state is disabled, so add its count of matched
> +			 * "early" wakeups to the last enabled state's count.
> +			 */
> +			if (prev_idx >= 0) {
> +				prev_count += count;
> +				if (prev_count > max_count) {
> +					max_count = prev_count;
> +					max_count_idx = prev_idx;
> +				}
> +			}
> +			continue;

I'm not sure I get this part: I have the impression you introduced the
prev_idx variable exactly for its use in this check (skip disabled states),
but it looks to me you had to use idx instead. At every iteration, idx is
the last enabled state. Why prev_idx?

> +		}
> +
> +		if (idx < 0)
> +			idx = i; /* first enabled state */
> +
> +		if (s->target_residency > duration_us) {
> +			/*
> +			 * If the next wakeup is expected to be "early", the
> +			 * time frame of it is known already.
> +			 */
> +			if (duration_us < cpu_data->sleep_length_us) {
> +				/*
> +				 * Use a physical idle state, not busy polling,
> +				 * unless a timer will trigger really soon.
> +				 */
> +				if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> +				    s->exit_latency <= latency_req &&
> +				    s->target_residency <= cpu_data->sleep_length_us) {

Just to be clear: 0 is a polling idle state; can there be any other? You
seem to keep it generic here, but seems to me you're actually checking if
idx so far is zero and try to see if there is another option.

Also: you put this check "may I convince you not to poll?" inside the
branch that handle the 3-or-more case (where duration_us has been changed
to avg_us). My question is: don't you need the check also outside of the
branch? (where, if I understand correctly, duration_us is equal to
sleep_length_us).

> +					duration_us = s->target_residency;
> +					idx = i;
> +				}
> +				break;
> +			}
> +
> +			/*
> +			 * If the number of "hits" for the state matching the
> +			 * sleep length is greater than the total number of
> +			 * "early" wakeups for all of the shallower states, the
> +			 * state selected so far is the one to use.
> +			 */
> +			if (early_count <= cpu_data->states[idx].hits +
> +					   cpu_data->states[idx].hits_old)
> +				break;
> +
> +			/*
> +			 * It is more likely that one of the shallower states
> +			 * will match the idle duration measured after wakeup,
> +			 * so take the one with the maximum count of matched
> +			 * "early" wakeups.
> +			 */
> +			idx = max_count_idx;
> +			duration_us = drv->states[idx].target_residency;
> +			break;
> +		}
> +		if (s->exit_latency > latency_req) {
> +			/*
> +			 * If we break out of the loop for latency reasons, use
> +			 * the target residency of the selected state as the
> +			 * expected idle duration to avoid stopping the tick
> +			 * as long as that target residency is low enough.
> +			 */
> +			duration_us = drv->states[idx].target_residency;
> +			break;
> +		}
> +
> +		early_count += prev_count;

I have the slight feeling that here you wanted "early_count += count;"
instead. As I understand early_count is meant to be "one iteration behind"
in the loop (meaning it accumulates up to i-1). If you update it with
prev_count instead of count, that would make it two iterations
behind. Wrong?

> +
> +		idx = i;
> +
> +		if (count > max_count) {
> +			max_count = count;
> +			max_count_idx = idx;
> +		}
> +
> +		prev_count = count;
> +		prev_idx = idx;
> +	}
> +
> +	if (idx < 0)
> +		idx = 0; /* No states enabled. Must use 0. */
> +
> +	/*
> +	 * Don't stop the tick if the selected state is a polling one or if the
> +	 * expected idle duration is shorter than the tick period length.
> +	 */
> +	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> +	    duration_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
> +		unsigned int delta_next_us = ktime_to_us(delta_next);
> +
> +		cpu_data->sleep_length_us = delta_next_us;
> +		*stop_tick = false;
> +
> +		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
> +			/*
> +			 * The tick is not going to be stopped and the target
> +			 * residency of the state to be returned is not within
> +			 * the time until the closest timer event including the
> +			 * tick, so try to correct that.
> +			 */
> +			for (i = idx - 1; i > 0; i--) {
> +				if (drv->states[i].disabled ||
> +				    dev->states_usage[i].disable)
> +					continue;
> +
> +				if (drv->states[i].target_residency <= delta_next_us)
> +					break;
> +			}
> +			idx = i;
> +		}
> +	}
> +
> +	return idx;
> +}
> +
> +/**
> + * teo_reflect - Note that governor data for the CPU need to be updated.
> + * @dev: Target CPU.
> + * @state: Entered state.
> + */
> +static void teo_reflect(struct cpuidle_device *dev, int state)
> +{
> +	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +
> +	cpu_data->last_state = state;
> +}
> +
> +/**
> + * teo_enable_device - Initialize the governor's data for the target CPU.
> + * @drv: cpuidle driver (not used).
> + * @dev: Target CPU.
> + */
> +static int teo_enable_device(struct cpuidle_driver *drv,
> +			     struct cpuidle_device *dev)
> +{
> +	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +
> +	memset(cpu_data, 0, sizeof(*cpu_data));
> +	return 0;
> +}
> +
> +static struct cpuidle_governor teo_governor = {
> +	.name =		"teo",
> +	.rating =	22,
> +	.enable =	teo_enable_device,
> +	.select =	teo_select,
> +	.reflect =	teo_reflect,
> +};

Just a curiosity: why isn't the disable() function from the
cpuidle_governor interface implemented? I see it isn't in "menu" as well,
so I wonder what disable() is supposed to do.


Thanks,
Giovanni


> +
> +static int __init teo_governor_init(void)
> +{
> +	return cpuidle_register_governor(&teo_governor);
> +}
> +
> +postcore_initcall(teo_governor_init);
> Index: linux-pm/drivers/cpuidle/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/Kconfig
> +++ linux-pm/drivers/cpuidle/Kconfig
> @@ -23,6 +23,17 @@ config CPU_IDLE_GOV_LADDER
>  config CPU_IDLE_GOV_MENU
>  	bool "Menu governor (for tickless system)"
>  
> +config CPU_IDLE_GOV_TEO
> +	bool "Timer events oriented governor (for tickless systems)"
> +	help
> +	  Menu governor derivative that uses a simplified idle state
> +	  selection method focused on timer events and does not do any
> +	  interactivity boosting.
> +
> +	  Some workloads benefit from using this governor and it generally
> +	  should be safe to use.  Say Y here if you are not happy with the
> +	  alternatives.
> +
>  config DT_IDLE_STATES
>  	bool
>  
> Index: linux-pm/drivers/cpuidle/governors/Makefile
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/Makefile
> +++ linux-pm/drivers/cpuidle/governors/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
>  obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
> +obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
> 
