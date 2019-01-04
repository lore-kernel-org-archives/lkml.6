Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC00720874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfADLbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:31:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46543 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfADLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:31:31 -0500
Received: from 79.184.255.240.ipv4.supernova.orange.pl (79.184.255.240) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c5715c355372fb91; Fri, 4 Jan 2019 12:31:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v11] cpuidle: New timer events oriented governor for tickless systems
Date:   Fri, 04 Jan 2019 12:30:47 +0100
Message-ID: <3625809.WY5lk7ujeb@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The venerable menu governor does some things that are quite
questionable in my view.

First, it includes timer wakeups in the pattern detection data and
mixes them up with wakeups from other sources which in some cases
causes it to expect what essentially would be a timer wakeup in a
time frame in which no timer wakeups are possible (because it knows
the time until the next timer event and that is later than the
expected wakeup time).

Second, it uses the extra exit latency limit based on the predicted
idle duration and depending on the number of tasks waiting on I/O,
even though those tasks may run on a different CPU when they are
woken up.  Moreover, the time ranges used by it for the sleep length
correction factors depend on whether or not there are tasks waiting
on I/O, which again doesn't imply anything in particular, and they
are not correlated to the list of available idle states in any way
whatever.

Also, the pattern detection code in menu may end up considering
values that are too large to matter at all, in which cases running
it is a waste of time.

A major rework of the menu governor would be required to address
these issues and the performance of at least some workloads (tuned
specifically to the current behavior of the menu governor) is likely
to suffer from that.  It is thus better to introduce an entirely new
governor without them and let everybody use the governor that works
better with their actual workloads.

The new governor introduced here, the timer events oriented (TEO)
governor, uses the same basic strategy as menu: it always tries to
find the deepest idle state that can be used in the given conditions.
However, it applies a different approach to that problem.

First, it doesn't use "correction factors" for the time till the
closest timer, but instead it tries to correlate the measured idle
duration values with the available idle states and use that
information to pick up the idle state that is most likely to "match"
the upcoming CPU idle interval.

Second, it doesn't take the number of "I/O waiters" into account at
all and the pattern detection code in it avoids taking timer wakeups
into account.  It also only uses idle duration values less than the
current time till the closest timer (with the tick excluded) for that
purpose.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I decided to continue the revision numbering from RFCs to avoid duplicate
version numbers.

v10 -> v11:
  * Update one piece of documentation that was missed previously,
    no code changes.

-> v10:
  * Fixes of typos (Quentin, Doug).
  * Reorganization of comments in teo_update() (Quentin).

---
 Documentation/admin-guide/pm/cpuidle.rst |  104 ++++++-
 drivers/cpuidle/Kconfig                  |   11 
 drivers/cpuidle/governors/Makefile       |    1 
 drivers/cpuidle/governors/teo.c          |  444 +++++++++++++++++++++++++++++++
 4 files changed, 551 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Timer events oriented CPU idle governor
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * The idea of this governor is based on the observation that on many systems
+ * timer events are two or more orders of magnitude more frequent than any
+ * other interrupts, so they are likely to be the most significant source of CPU
+ * wakeups from idle states.  Moreover, information about what happened in the
+ * (relatively recent) past can be used to estimate whether or not the deepest
+ * idle state with target residency within the time to the closest timer is
+ * likely to be suitable for the upcoming idle time of the CPU and, if not, then
+ * which of the shallower idle states to choose.
+ *
+ * Of course, non-timer wakeup sources are more important in some use cases and
+ * they can be covered by taking a few most recent idle time intervals of the
+ * CPU into account.  However, even in that case it is not necessary to consider
+ * idle duration values greater than the time till the closest timer, as the
+ * patterns that they may belong to produce average values close enough to
+ * the time till the closest timer (sleep length) anyway.
+ *
+ * Thus this governor estimates whether or not the upcoming idle time of the CPU
+ * is likely to be significantly shorter than the sleep length and selects an
+ * idle state for it in accordance with that, as follows:
+ *
+ * - Find an idle state on the basis of the sleep length and state statistics
+ *   collected over time:
+ *
+ *   o Find the deepest idle state whose target residency is less than or equal
+ *     to the sleep length.
+ *
+ *   o Select it if it matched both the sleep length and the observed idle
+ *     duration in the past more often than it matched the sleep length alone
+ *     (i.e. the observed idle duration was significantly shorter than the sleep
+ *     length matched by it).
+ *
+ *   o Otherwise, select the shallower state with the greatest matched "early"
+ *     wakeups metric.
+ *
+ * - If the majority of the most recent idle duration values are below the
+ *   target residency of the idle state selected so far, use those values to
+ *   compute the new expected idle duration and find an idle state matching it
+ *   (which has to be shallower than the one selected so far).
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/sched/clock.h>
+#include <linux/tick.h>
+
+/*
+ * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
+ * is used for decreasing metrics on a regular basis.
+ */
+#define PULSE		1024
+#define DECAY_SHIFT	3
+
+/*
+ * Number of the most recent idle duration values to take into consideration for
+ * the detection of wakeup patterns.
+ */
+#define INTERVALS	8
+
+/**
+ * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
+ * @early_hits: "Early" CPU wakeups "matching" this state.
+ * @hits: "On time" CPU wakeups "matching" this state.
+ * @misses: CPU wakeups "missing" this state.
+ *
+ * A CPU wakeup is "matched" by a given idle state if the idle duration measured
+ * after the wakeup is between the target residency of that state and the target
+ * residency of the next one (or if this is the deepest available idle state, it
+ * "matches" a CPU wakeup when the measured idle duration is at least equal to
+ * its target residency).
+ *
+ * Also, from the TEO governor perspective, a CPU wakeup from idle is "early" if
+ * it occurs significantly earlier than the closest expected timer event (that
+ * is, early enough to match an idle state shallower than the one matching the
+ * time till the closest timer event).  Otherwise, the wakeup is "on time", or
+ * it is a "hit".
+ *
+ * A "miss" occurs when the given state doesn't match the wakeup, but it matches
+ * the time till the closest timer event used for idle state selection.
+ */
+struct teo_idle_state {
+	unsigned int early_hits;
+	unsigned int hits;
+	unsigned int misses;
+};
+
+/**
+ * struct teo_cpu - CPU data used by the TEO cpuidle governor.
+ * @time_span_ns: Time between idle state selection and post-wakeup update.
+ * @sleep_length_ns: Time till the closest timer event (at the selection time).
+ * @states: Idle states data corresponding to this CPU.
+ * @last_state: Idle state entered by the CPU last time.
+ * @interval_idx: Index of the most recent saved idle interval.
+ * @intervals: Saved idle duration values.
+ */
+struct teo_cpu {
+	u64 time_span_ns;
+	u64 sleep_length_ns;
+	struct teo_idle_state states[CPUIDLE_STATE_MAX];
+	int last_state;
+	int interval_idx;
+	unsigned int intervals[INTERVALS];
+};
+
+static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
+
+/**
+ * teo_update - Update CPU data after wakeup.
+ * @drv: cpuidle driver containing state data.
+ * @dev: Target CPU.
+ */
+static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+	unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
+	int i, idx_hit = -1, idx_timer = -1;
+	unsigned int measured_us;
+
+	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
+		/*
+		 * One of the safety nets has triggered or this was a timer
+		 * wakeup (or equivalent).
+		 */
+		measured_us = sleep_length_us;
+	} else {
+		unsigned int lat = drv->states[cpu_data->last_state].exit_latency;
+
+		measured_us = ktime_to_us(cpu_data->time_span_ns);
+		/*
+		 * The delay between the wakeup and the first instruction
+		 * executed by the CPU is not likely to be worst-case every
+		 * time, so take 1/2 of the exit latency as a very rough
+		 * approximation of the average of it.
+		 */
+		if (measured_us >= lat)
+			measured_us -= lat / 2;
+		else
+			measured_us /= 2;
+	}
+
+	/*
+	 * Decay the "early hits" metric for all of the states and find the
+	 * states matching the sleep length and the measured idle duration.
+	 */
+	for (i = 0; i < drv->state_count; i++) {
+		unsigned int early_hits = cpu_data->states[i].early_hits;
+
+		cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;
+
+		if (drv->states[i].target_residency <= sleep_length_us) {
+			idx_timer = i;
+			if (drv->states[i].target_residency <= measured_us)
+				idx_hit = i;
+		}
+	}
+
+	/*
+	 * Update the "hits" and "misses" data for the state matching the sleep
+	 * length.  If it matches the measured idle duration too, this is a hit,
+	 * so increase the "hits" metric for it then.  Otherwise, this is a
+	 * miss, so increase the "misses" metric for it.  In the latter case
+	 * also increase the "early hits" metric for the state that actually
+	 * matches the measured idle duration.
+	 */
+	if (idx_timer >= 0) {
+		unsigned int hits = cpu_data->states[idx_timer].hits;
+		unsigned int misses = cpu_data->states[idx_timer].misses;
+
+		hits -= hits >> DECAY_SHIFT;
+		misses -= misses >> DECAY_SHIFT;
+
+		if (idx_timer > idx_hit) {
+			misses += PULSE;
+			if (idx_hit >= 0)
+				cpu_data->states[idx_hit].early_hits += PULSE;
+		} else {
+			hits += PULSE;
+		}
+
+		cpu_data->states[idx_timer].misses = misses;
+		cpu_data->states[idx_timer].hits = hits;
+	}
+
+	/*
+	 * If the total time span between idle state selection and the "reflect"
+	 * callback is greater than or equal to the sleep length determined at
+	 * the idle state selection time, the wakeup is likely to be due to a
+	 * timer event.
+	 */
+	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns)
+		measured_us = UINT_MAX;
+
+	/*
+	 * Save idle duration values corresponding to non-timer wakeups for
+	 * pattern detection.
+	 */
+	cpu_data->intervals[cpu_data->interval_idx++] = measured_us;
+	if (cpu_data->interval_idx > INTERVALS)
+		cpu_data->interval_idx = 0;
+}
+
+/**
+ * teo_find_shallower_state - Find shallower idle state matching given duration.
+ * @drv: cpuidle driver containing state data.
+ * @dev: Target CPU.
+ * @state_idx: Index of the capping idle state.
+ * @duration_us: Idle duration value to match.
+ */
+static int teo_find_shallower_state(struct cpuidle_driver *drv,
+				    struct cpuidle_device *dev, int state_idx,
+				    unsigned int duration_us)
+{
+	int i;
+
+	for (i = state_idx - 1; i >= 0; i--) {
+		if (drv->states[i].disabled || dev->states_usage[i].disable)
+			continue;
+
+		state_idx = i;
+		if (drv->states[i].target_residency <= duration_us)
+			break;
+	}
+	return state_idx;
+}
+
+/**
+ * teo_select - Selects the next idle state to enter.
+ * @drv: cpuidle driver containing state data.
+ * @dev: Target CPU.
+ * @stop_tick: Indication on whether or not to stop the scheduler tick.
+ */
+static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		      bool *stop_tick)
+{
+	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+	int latency_req = cpuidle_governor_latency_req(dev->cpu);
+	unsigned int duration_us, count;
+	int max_early_idx, idx, i;
+	ktime_t delta_tick;
+
+	if (cpu_data->last_state >= 0) {
+		teo_update(drv, dev);
+		cpu_data->last_state = -1;
+	}
+
+	cpu_data->time_span_ns = local_clock();
+
+	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
+	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
+
+	count = 0;
+	max_early_idx = -1;
+	idx = -1;
+
+	for (i = 0; i < drv->state_count; i++) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (s->disabled || su->disable) {
+			/*
+			 * If the "early hits" metric of a disabled state is
+			 * greater than the current maximum, it should be taken
+			 * into account, because it would be a mistake to select
+			 * a deeper state with lower "early hits" metric.  The
+			 * index cannot be changed to point to it, however, so
+			 * just increase the max count alone and let the index
+			 * still point to a shallower idle state.
+			 */
+			if (max_early_idx >= 0 &&
+			    count < cpu_data->states[i].early_hits)
+				count = cpu_data->states[i].early_hits;
+
+			continue;
+		}
+
+		if (idx < 0)
+			idx = i; /* first enabled state */
+
+		if (s->target_residency > duration_us)
+			break;
+
+		if (s->exit_latency > latency_req) {
+			/*
+			 * If we break out of the loop for latency reasons, use
+			 * the target residency of the selected state as the
+			 * expected idle duration to avoid stopping the tick
+			 * as long as that target residency is low enough.
+			 */
+			duration_us = drv->states[idx].target_residency;
+			goto refine;
+		}
+
+		idx = i;
+
+		if (count < cpu_data->states[i].early_hits &&
+		    !(tick_nohz_tick_stopped() &&
+		      drv->states[i].target_residency < TICK_USEC)) {
+			count = cpu_data->states[i].early_hits;
+			max_early_idx = i;
+		}
+	}
+
+	/*
+	 * If the "hits" metric of the idle state matching the sleep length is
+	 * greater than its "misses" metric, that is the one to use.  Otherwise,
+	 * it is more likely that one of the shallower states will match the
+	 * idle duration observed after wakeup, so take the one with the maximum
+	 * "early hits" metric, but if that cannot be determined, just use the
+	 * state selected so far.
+	 */
+	if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
+	    max_early_idx >= 0) {
+		idx = max_early_idx;
+		duration_us = drv->states[idx].target_residency;
+	}
+
+refine:
+	if (idx < 0) {
+		idx = 0; /* No states enabled. Must use 0. */
+	} else if (idx > 0) {
+		u64 sum = 0;
+
+		count = 0;
+
+		/*
+		 * Count and sum the most recent idle duration values less than
+		 * the target residency of the state selected so far, find the
+		 * max.
+		 */
+		for (i = 0; i < INTERVALS; i++) {
+			unsigned int val = cpu_data->intervals[i];
+
+			if (val >= drv->states[idx].target_residency)
+				continue;
+
+			count++;
+			sum += val;
+		}
+
+		/*
+		 * Give up unless the majority of the most recent idle duration
+		 * values are in the interesting range.
+		 */
+		if (count > INTERVALS / 2) {
+			unsigned int avg_us = div64_u64(sum, count);
+
+			/*
+			 * Avoid spending too much time in an idle state that
+			 * would be too shallow.
+			 */
+			if (!(tick_nohz_tick_stopped() && avg_us < TICK_USEC)) {
+				idx = teo_find_shallower_state(drv, dev, idx, avg_us);
+				duration_us = avg_us;
+			}
+		}
+	}
+
+	/*
+	 * Don't stop the tick if the selected state is a polling one or if the
+	 * expected idle duration is shorter than the tick period length.
+	 */
+	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	    duration_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
+		unsigned int delta_tick_us = ktime_to_us(delta_tick);
+
+		*stop_tick = false;
+
+		/*
+		 * The tick is not going to be stopped, so if the target
+		 * residency of the state to be returned is not within the time
+		 * till the closest timer including the tick, try to correct
+		 * that.
+		 */
+		if (idx > 0 && drv->states[idx].target_residency > delta_tick_us)
+			idx = teo_find_shallower_state(drv, dev, idx, delta_tick_us);
+	}
+
+	return idx;
+}
+
+/**
+ * teo_reflect - Note that governor data for the CPU need to be updated.
+ * @dev: Target CPU.
+ * @state: Entered state.
+ */
+static void teo_reflect(struct cpuidle_device *dev, int state)
+{
+	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+
+	cpu_data->last_state = state;
+	/*
+	 * If the wakeup was not "natural", but triggered by one of the safety
+	 * nets, assume that the CPU might have been idle for the entire sleep
+	 * length time.
+	 */
+	if (dev->poll_time_limit ||
+	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC)) {
+		dev->poll_time_limit = false;
+		cpu_data->time_span_ns = cpu_data->sleep_length_ns;
+	} else {
+		cpu_data->time_span_ns = local_clock() - cpu_data->time_span_ns;
+	}
+}
+
+/**
+ * teo_enable_device - Initialize the governor's data for the target CPU.
+ * @drv: cpuidle driver (not used).
+ * @dev: Target CPU.
+ */
+static int teo_enable_device(struct cpuidle_driver *drv,
+			     struct cpuidle_device *dev)
+{
+	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+	int i;
+
+	memset(cpu_data, 0, sizeof(*cpu_data));
+
+	for (i = 0; i < INTERVALS; i++)
+		cpu_data->intervals[i] = UINT_MAX;
+
+	return 0;
+}
+
+static struct cpuidle_governor teo_governor = {
+	.name =		"teo",
+	.rating =	19,
+	.enable =	teo_enable_device,
+	.select =	teo_select,
+	.reflect =	teo_reflect,
+};
+
+static int __init teo_governor_init(void)
+{
+	return cpuidle_register_governor(&teo_governor);
+}
+
+postcore_initcall(teo_governor_init);
Index: linux-pm/drivers/cpuidle/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpuidle/Kconfig
+++ linux-pm/drivers/cpuidle/Kconfig
@@ -4,7 +4,7 @@ config CPU_IDLE
 	bool "CPU idle PM support"
 	default y if ACPI || PPC_PSERIES
 	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
-	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE)
+	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
@@ -23,6 +23,15 @@ config CPU_IDLE_GOV_LADDER
 config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 
+config CPU_IDLE_GOV_TEO
+	bool "Timer events oriented (TEO) governor (for tickless systems)"
+	help
+	  This governor implements a simplified idle state selection method
+	  focused on timer events and does not do any interactivity boosting.
+
+	  Some workloads benefit from using it and it generally should be safe
+	  to use.  Say Y here if you are not happy with the alternatives.
+
 config DT_IDLE_STATES
 	bool
 
Index: linux-pm/drivers/cpuidle/governors/Makefile
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/Makefile
+++ linux-pm/drivers/cpuidle/governors/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
 obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
+obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -155,14 +155,14 @@ governor uses that information depends o
 and that is the primary reason for having more than one governor in the
 ``CPUIdle`` subsystem.
 
-There are two ``CPUIdle`` governors available, ``menu`` and ``ladder``.  Which
-of them is used depends on the configuration of the kernel and in particular on
-whether or not the scheduler tick can be `stopped by the idle
-loop <idle-cpus-and-tick_>`_.  It is possible to change the governor at run time
-if the ``cpuidle_sysfs_switch`` command line parameter has been passed to the
-kernel, but that is not safe in general, so it should not be done on production
-systems (that may change in the future, though).  The name of the ``CPUIdle``
-governor currently used by the kernel can be read from the
+There are three ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_
+and ``ladder``.  Which of them is used by default depends on the configuration
+of the kernel and in particular on whether or not the scheduler tick can be
+`stopped by the idle loop <idle-cpus-and-tick_>`_.  It is possible to change the
+governor at run time if the ``cpuidle_sysfs_switch`` command line parameter has
+been passed to the kernel, but that is not safe in general, so it should not be
+done on production systems (that may change in the future, though).  The name of
+the ``CPUIdle`` governor currently used by the kernel can be read from the
 :file:`current_governor_ro` (or :file:`current_governor` if
 ``cpuidle_sysfs_switch`` is present in the kernel command line) file under
 :file:`/sys/devices/system/cpu/cpuidle/` in ``sysfs``.
@@ -256,6 +256,8 @@ the ``menu`` governor by default and if
 ``CPUIdle`` governor on it will be ``ladder``.
 
 
+.. _menu-gov:
+
 The ``menu`` Governor
 =====================
 
@@ -333,6 +335,92 @@ that time, the governor may need to sele
 target residency.
 
 
+.. _teo-gov:
+
+The Timer Events Oriented (TEO) Governor
+========================================
+
+The timer events oriented (TEO) governor is an alternative ``CPUIdle`` governor
+for tickless systems.  It follows the same basic strategy as the ``menu`` `one
+<menu-gov_>`_: it always tries to find the deepest idle state suitable for the
+given conditions.  However, it applies a different approach to that problem.
+
+First, it does not use sleep length correction factors, but instead it attempts
+to correlate the observed idle duration values with the available idle states
+and use that information to pick up the idle state that is most likely to
+"match" the upcoming CPU idle interval.   Second, it does not take the tasks
+that were running on the given CPU in the past and are waiting on some I/O
+operations to complete now at all (there is no guarantee that they will run on
+the same CPU when they become runnable again) and the pattern detection code in
+it avoids taking timer wakeups into account.  It also only uses idle duration
+values less than the current time till the closest timer (with the scheduler
+tick excluded) for that purpose.
+
+Like in the ``menu`` governor `case <menu-gov_>`_, the first step is to obtain
+the *sleep length*, which is the time until the closest timer event with the
+assumption that the scheduler tick will be stopped (that also is the upper bound
+on the time until the next CPU wakeup).  That value is then used to preselect an
+idle state on the basis of three metrics maintained for each idle state provided
+by the ``CPUIdle`` driver: ``hits``, ``misses`` and ``early_hits``.
+
+The ``hits`` and ``misses`` metrics measure the likelihood that a given idle
+state will "match" the observed (post-wakeup) idle duration if it "matches" the
+sleep length.  They both are subject to decay (after a CPU wakeup) every time
+the target residency of the idle state corresponding to them is less than or
+equal to the sleep length and the target residency of the next idle state is
+greater than the sleep length (that is, when the idle state corresponding to
+them "matches" the sleep length).  The ``hits`` metric is increased if the
+former condition is satisfied and the target residency of the given idle state
+is less than or equal to the observed idle duration and the target residency of
+the next idle state is greater than the observed idle duration at the same time
+(that is, it is increased when the given idle state "matches" both the sleep
+length and the observed idle duration).  In turn, the ``misses`` metric is
+increased when the given idle state "matches" the sleep length only and the
+observed idle duration is too short for its target residency.
+
+The ``early_hits`` metric measures the likelihood that a given idle state will
+"match" the observed (post-wakeup) idle duration if it does not "match" the
+sleep length.  It is subject to decay on every CPU wakeup and it is increased
+when the idle state corresponding to it "matches" the observed (post-wakeup)
+idle duration and the target residency of the next idle state is less than or
+equal to the sleep length (i.e. the idle state "matching" the sleep length is
+deeper than the given one).
+
+The governor walks the list of idle states provided by the ``CPUIdle`` driver
+and finds the last (deepest) one with the target residency less than or equal
+to the sleep length.  Then, the ``hits`` and ``misses`` metrics of that idle
+state are compared with each other and it is preselected if the ``hits`` one is
+greater (which means that that idle state is likely to "match" the observed idle
+duration after CPU wakeup).  If the ``misses`` one is greater, the governor
+preselects the shallower idle state with the maximum ``early_hits`` metric
+(or if there are multiple shallower idle states with equal ``early_hits``
+metric which also is the maximum, the shallowest of them will be preselected).
+[If there is a wakeup latency constraint coming from the `PM QoS framework
+<cpu-pm-qos_>`_ which is hit before reaching the deepest idle state with the
+target residency within the sleep length, the deepest idle state with the exit
+latency within the constraint is preselected without consulting the ``hits``,
+``misses`` and ``early_hits`` metrics.]
+
+Next, the governor takes several idle duration values observed most recently
+into consideration and if at least a half of them are greater than or equal to
+the target residency of the preselected idle state, that idle state becomes the
+final candidate to ask for.  Otherwise, the average of the most recent idle
+duration values below the target residency of the preselected idle state is
+computed and the governor walks the idle states shallower than the preselected
+one and finds the deepest of them with the target residency within that average.
+That idle state is then taken as the final candidate to ask for.
+
+Still, at this point the governor may need to refine the idle state selection if
+it has not decided to `stop the scheduler tick <idle-cpus-and-tick_>`_.  That
+generally happens if the target residency of the idle state selected so far is
+less than the tick period and the tick has not been stopped already (in a
+previous iteration of the idle loop).  Then, like in the ``menu`` governor
+`case <menu-gov_>`_, the sleep length used in the previous computations may not
+reflect the real time until the closest timer event and if it really is greater
+than that time, a shallower state with a suitable target residency may need to
+be selected.
+
+
 .. _idle-states-representation:
 
 Representation of Idle States

