Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D131320700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D131320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeKFEuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:50:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387572AbeKFEuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:50:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88FF4B0F6;
        Mon,  5 Nov 2018 19:28:48 +0000 (UTC)
Message-ID: <1541446371.3441.9.camel@suse.cz>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Mon, 05 Nov 2018 20:32:51 +0100
In-Reply-To: <1556808.yKVbhZSazi@aspire.rjw.lan>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 17:31 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The venerable menu governor does some thigns that are quite
> questionable in my view.  First, it includes timer wakeups in
> the pattern detection data and mixes them up with wakeups from
> other sources which in some cases causes it to expect what
> essentially would be a timer wakeup in a time frame in which
> no timer wakeups are possible (becuase it knows the time until
> the next timer event and that is later than the expected wakeup
> time).  Second, it uses the extra exit latency limit based on
> the predicted idle duration and depending on the number of tasks
> waiting on I/O, even though those tasks may run on a different
> CPU when they are woken up.  Moreover, the time ranges used by it
> for the sleep length correction factors depend on whether or not
> there are tasks waiting on I/O, which again doesn't imply anything
> in particular, and they are not correlated to the list of available
> idle states in any way whatever.  Also,  the pattern detection code
> in menu may end up considering values that are too large to matter
> at all, in which cases running it is a waste of time.
> 
> A major rework of the menu governor would be required to address
> these issues and the performance of at least some workloads (tuned
> specifically to the current behavior of the menu governor) is likely
> to suffer from that.  It is thus better to introduce an entirely new
> governor without them and let everybody use the governor that works
> better with their actual workloads.
> 
> The new governor introduced here, the timer events oriented (TEO)
> governor, uses the same basic strategy as menu: it always tries to
> find the deepest idle state that can be used in the given conditions.
> However, it applies a different approach to that problem.  First, it
> doesn't use "correction factors" for the time till the closest timer,
> but instead it tries to correlate the measured idle duration values
> with the available idle states and use that information to pick up
> the idle state that is most likely to "match" the upcoming CPU idle
> interval.  Second, it doesn't take the number of "I/O waiters" into
> account at all and the pattern detection code in it tries to avoid
> taking timer wakeups into account.  It also only uses idle duration
> values less than the current time till the closest timer (with the
> tick excluded) for that purpose.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3:
>  * Simplify the pattern detection code and make it return a value
>         lower than the time to the closest timer if the majority of recent
>         idle intervals are below it regardless of their variance (that should
>         cause it to be slightly more aggressive).
>  * Do not count wakeups from state 0 due to the time limit in poll_idle()
>    as non-timer.
> 
> Note: I will be mostly offline tomorrow, so this goes slightly early.
> I have tested it only very lightly, but it is not so much different from
> the previous one.
> 
> It requires the same additional patches to apply as the previous one too.
> 
> ---
>  drivers/cpuidle/Kconfig            |   11 
>  drivers/cpuidle/governors/Makefile |    1 
>  drivers/cpuidle/governors/teo.c    |  491 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 503 insertions(+)
> 
> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- /dev/null
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -0,0 +1,491 @@
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
> + * wakeups from idle states.  Moreover, information about what happened in the
> + * (relatively recent) past can be used to estimate whether or not the deepest
> + * idle state with target residency within the time to the closest timer is
> + * likely to be suitable for the upcoming idle time of the CPU and, if not, then
> + * which of the shallower idle states to choose.
> + *
> + * Of course, non-timer wakeup sources are more important in some use cases and
> + * they can be covered by detecting patterns among recent idle time intervals
> + * of the CPU.  However, even in that case it is not necessary to take idle
> + * duration values greater than the time till the closest timer into account, as
> + * the patterns that they may belong to produce average values close enough to
> + * the time till the closest timer (sleep length) anyway.
> + *
> + * Thus this governor estimates whether or not the upcoming idle time of the CPU
> + * is likely to be significantly shorter than the sleep length and selects an
> + * idle state for it in accordance with that, as follows:
> + *
> + * - If there is a pattern of 5 or more recent non-timer wakeups earlier than
> + *   the closest timer event, expect one more of them to occur and use the
> + *   average of the idle duration values corresponding to them to select an
> + *   idle state for the CPU.
> + *
> + * - Otherwise, find the state on the basis of the sleep length and state
> + *   statistics collected over time:
> + *
> + *   o Find the deepest idle state whose target residency is less than or euqal
> + *     to the sleep length.
> + *
> + *   o Select it if it matched both the sleep length and the idle duration
> + *     measured after wakeup in the past more often than it matched the sleep
> + *     length, but not the idle duration (i.e. the measured idle duration was
> + *     significantly shorter than the sleep length matched by that state).
> + *
> + *   o Otherwise, select the shallower state with the greatest matched "early"
> + *     wakeups metric.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/sched/clock.h>
> +#include <linux/tick.h>
> +
> +/*
> + * The SPIKE value is added to metrics when they grow and the DECAY_SHIFT value
> + * is used for decreasing metrics on a regular basis.
> + */
> +#define SPIKE          1024
> +#define DECAY_SHIFT    3
> +
> +/*
> + * Number of the most recent idle duration values to take into consideration for
> + * the detection of wakeup patterns.
> + */
> +#define INTERVALS      8
> +
> +/*
> + * Ratio of the sample spread limit and the length of the interesting intervals
> + * range used for pattern detection, reptesented as a shift.
> + */
> +#define MAX_SPREAD_SHIFT       3
> +
> +/**
> + * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
> + * @early_hits: "Early" CPU wakeups matched by this state.
> + * @hits: "On time" CPU wakeups matched by this state.
> + * @misses: CPU wakeups "missed" by this state.
> + *
> + * A CPU wakeup is "matched" by a given idle state if the idle duration measured
> + * after the wakeup is between the target residency of that state and the target
> + * residnecy of the next one (or if this is the deepest available idle state, it
> + * "matches" a CPU wakeup when the measured idle duration is at least equal to
> + * its target residency).
> + *
> + * Also, from the TEO governor prespective, a CPU wakeup from idle is "early" if
> + * it occurs significantly earlier than the closest expected timer event (that
> + * is, early enough to match an idle state shallower than the one matching the
> + * time till the closest timer event).  Otherwise, the wakeup is "on time", or
> + * it is a "hit".
> + *
> + * A "miss" occurs when the given state doesn't match the wakeup, but it matches
> + * the time till the closest timer event used for idle state selection.
> + */
> +struct teo_idle_state {
> +       unsigned int early_hits;
> +       unsigned int hits;
> +       unsigned int misses;
> +};
> +
> +/**
> + * struct teo_cpu - CPU data used by the TEO cpuidle governor.
> + * @time_span_ns: Time between idle state selection and post-wakeup update.
> + * @sleep_length_ns: Time till the closest timer event (at the selection time).
> + * @states: Idle states data corresponding to this CPU.
> + * @last_state: Idle state entered by the CPU last time.
> + * @interval_idx: Index of the most recent saved idle interval.
> + * @intervals: Saved idle duration values.
> + */
> +struct teo_cpu {
> +       u64 time_span_ns;
> +       u64 sleep_length_ns;
> +       struct teo_idle_state states[CPUIDLE_STATE_MAX];
> +       int last_state;
> +       int interval_idx;
> +       unsigned int intervals[INTERVALS];
> +};
> +
> +static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> +
> +/**
> + * teo_update - Update CPU data after wakeup.
> + * @drv: cpuidle driver containing state data.
> + * @dev: Target CPU.
> + */
> +static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +       struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +       unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
> +       int i, idx_hit = -1, idx_timer = -1;
> +       unsigned int measured_us;
> +
> +       if (cpu_data->time_span_ns == cpu_data->sleep_length_ns) {
> +               /* One of the safety nets has triggered (most likely). */
> +               measured_us = sleep_length_us;
> +       } else {
> +               measured_us = dev->last_residency;
> +               i = cpu_data->last_state;
> +               if (measured_us >= 2 * drv->states[i].exit_latency)
> +                       measured_us -= drv->states[i].exit_latency;
> +               else
> +                       measured_us /= 2;
> +       }
> +

I haven't read this v3 yet, so just a little comment on the bit above (which
is there since v1).

When you check for measured_us >= 2 * exit_latency, is that because
dev->last_residency is composed by an "entry" latency, then the actual
residency, and finally the exit_latency? I'm asking about the 2x factor
there.

If that succeeds, you proceed to remove the exit_latency from
measured_us... just once. Given how the condition is formulated, I expected
measured_us -= 2 * exit_latency there.

More: you acknowledge, in that snippet of code, that there can be
dev->last_residency's smaller than twice the exit_latency, i.e. not even the
time to entry/exit the state. Am I reading this right? Is that because both
exit_latency and dev->last_residency are only approximations?

I actually see quite a few of those extra-short residencies in my traces, even
with dev->last_residency < exit_latency.


Giovanni
