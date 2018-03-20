Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCTQqA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:46:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47074 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCTQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:43:43 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH v7 7/8] cpuidle: menu: Refine idle state selection for running tick
Date: Tue, 20 Mar 2018 16:46:56 +0100
Message-ID: <1581877.Tdb107SmOT@aspire.rjw.lan>
In-Reply-To: <2390019.oHdSGtR3EE@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpuidle: menu: Refine idle state selection for running tick

If the tick isn't stopped, the target residency of the state selected
by the menu governor may be greater than the actual time to the next
tick and that means lost energy.

To avoid that, make tick_nohz_get_sleep_length() return the current
time to the next event (before stopping the tick) in addition to the
estimated one via an extra pointer argument and make menu_select()
use that value to refine the state selection when necessary.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v5 -> v7:
  * Rebase on top of the new [5-6/8].
  * Rename the new argument of tick_nohz_get_sleep_length() to
    "delta_next" (as requested by Peter).

---
 drivers/cpuidle/governors/menu.c |   22 ++++++++++++++++++++--
 include/linux/tick.h             |    7 ++++---
 kernel/time/tick-sched.c         |    7 +++++--
 3 files changed, 29 insertions(+), 7 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -121,7 +121,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
-extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
@@ -144,9 +144,10 @@ static inline void tick_nohz_idle_enter(
 static inline void tick_nohz_idle_exit(void) { }
 static inline bool tick_nohz_idle_got_tick(void) { return false; }
 
-static inline ktime_t tick_nohz_get_sleep_length(void)
+static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
-	return NSEC_PER_SEC / HZ;
+	*delta_next = NSEC_PER_SEC / HZ;
+	return *delta_next;
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -1045,10 +1045,11 @@ bool tick_nohz_idle_got_tick(void)
 
 /**
  * tick_nohz_get_sleep_length - return the expected length of the current sleep
+ * @delta_next: duration until the next event if the tick cannot be stopped
  *
  * Called from power state control code with interrupts disabled
  */
-ktime_t tick_nohz_get_sleep_length(void)
+ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
@@ -1061,6 +1062,8 @@ ktime_t tick_nohz_get_sleep_length(void)
 
 	WARN_ON_ONCE(!ts->inidle);
 
+	*delta_next = ktime_sub(dev->next_event, now);
+
 	if (can_stop_idle_tick(cpu, ts)) {
 		ktime_t next_event = tick_nohz_next_event(ts, cpu);
 
@@ -1068,7 +1071,7 @@ ktime_t tick_nohz_get_sleep_length(void)
 			return ktime_sub(next_event, now);
 	}
 
-	return ktime_sub(dev->next_event, now);
+	return *delta_next;
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -295,6 +295,7 @@ static int menu_select(struct cpuidle_dr
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
 	int resume_latency = dev_pm_qos_raw_read_value(device);
+	ktime_t delta_next;
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -312,7 +313,7 @@ static int menu_select(struct cpuidle_dr
 	}
 
 	/* determine the expected residency time, round up */
-	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
+	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
@@ -396,9 +397,26 @@ static int menu_select(struct cpuidle_dr
 	 * expected idle duration is shorter than the tick period length.
 	 */
 	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC)
+	    expected_interval < TICK_USEC) {
 		*stop_tick = false;
 
+		if (!tick_nohz_tick_stopped()) {
+			unsigned int delta_next_us = ktime_to_us(delta_next);
+
+			/*
+			 * Because the tick is not going to be stopped, make
+			 * sure that the target residency of the state to be
+			 * returned is within the time to the next timer event
+			 * including the tick.
+			 */
+			while (idx > 0 &&
+			    (drv->states[idx].target_residency > delta_next_us ||
+			     drv->states[idx].disabled ||
+			     dev->states_usage[idx].disable))
+				idx--;
+		}
+	}
+
 	data->last_state_idx = idx;
 
 	return data->last_state_idx;
