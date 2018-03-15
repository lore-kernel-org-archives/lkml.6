Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeCOWU7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:20:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49675 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeCOWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:20:55 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH v5 6/7] cpuidle: menu: Refine idle state selection for running tick
Date: Thu, 15 Mar 2018 23:16:41 +0100
Message-ID: <4980385.RayypyZ8dA@aspire.rjw.lan>
In-Reply-To: <2142751.3U6XgWyF8u@aspire.rjw.lan>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the tick isn't stopped, the target residency of the state selected
by the menu governor may be greater than the actual time to the next
tick and that means lost energy.

To avoid that, make tick_nohz_get_sleep_length() return the current
time to the next event (before stopping the tick) in addition to the
estimated one via an extra pointer argument and make menu_select()
use that value to refine the state selection when necessary.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5:
  * Rebase on top of the new [4/7].
  * Look for a new state only if the tick isn't stopped already.

---
 drivers/cpuidle/governors/menu.c |   25 ++++++++++++++++++++++---
 include/linux/tick.h             |    2 +-
 kernel/time/tick-sched.c         |    7 +++++--
 3 files changed, 28 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -120,7 +120,7 @@ extern void tick_nohz_idle_restart_tick(
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
-extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_sleep_length(ktime_t *cur_ret);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -1031,10 +1031,11 @@ void tick_nohz_irq_exit(void)
 
 /**
  * tick_nohz_get_sleep_length - return the expected length of the current sleep
+ * @cur_ret: pointer for returning the current time to the next event
  *
  * Called from power state control code with interrupts disabled
  */
-ktime_t tick_nohz_get_sleep_length(void)
+ktime_t tick_nohz_get_sleep_length(ktime_t *cur_ret)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
@@ -1047,6 +1048,8 @@ ktime_t tick_nohz_get_sleep_length(void)
 
 	WARN_ON_ONCE(!ts->inidle);
 
+	*cur_ret = ktime_sub(dev->next_event, now);
+
 	if (can_stop_idle_tick(cpu, ts)) {
 		ktime_t next_event = tick_nohz_next_event(ts, cpu);
 
@@ -1054,7 +1057,7 @@ ktime_t tick_nohz_get_sleep_length(void)
 			return ktime_sub(next_event, now);
 	}
 
-	return ktime_sub(dev->next_event, now);
+	return *cur_ret;
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -296,6 +296,7 @@ static int menu_select(struct cpuidle_dr
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
 	int resume_latency = dev_pm_qos_raw_read_value(device);
+	ktime_t tick_time;
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -313,7 +314,7 @@ static int menu_select(struct cpuidle_dr
 	}
 
 	/* determine the expected residency time, round up */
-	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
+	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&tick_time));
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
@@ -396,9 +397,27 @@ static int menu_select(struct cpuidle_dr
 	 * Don't stop the tick if the selected state is a polling one or if the
 	 * expected idle duration is shorter than the tick period length.
 	 */
-	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC_HZ)
+	if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
 		*nohz_ret = false;
+	} else if (expected_interval < TICK_USEC_HZ) {
+		*nohz_ret = false;
+
+		if (!tick_nohz_tick_stopped()) {
+			unsigned int tick_us = ktime_to_us(tick_time);
+
+			/*
+			 * Because the tick is not going to be stopped, make
+			 * sure that the target residency of the state to be
+			 * returned is within the time to the next timer event
+			 * including the tick.
+			 */
+			while (idx > 0 &&
+			    (drv->states[idx].target_residency > tick_us ||
+			     drv->states[idx].disabled ||
+			     dev->states_usage[idx].disable))
+				idx--;
+		}
+	}
 
 	data->last_state_idx = idx;
 
