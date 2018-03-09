Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeCIJsw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:48:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46969 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCIJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:48:49 -0500
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
Subject: [RFC/RFT][PATCH v3 6/6] cpuidle: menu: Refine idle state selection for running tick
Date: Fri, 09 Mar 2018 10:49:11 +0100
Message-ID: <2427176.MrJbnUnnmj@aspire.rjw.lan>
In-Reply-To: <2450532.XN8DODrtDf@aspire.rjw.lan>
References: <2450532.XN8DODrtDf@aspire.rjw.lan>
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
time the the next event (before stopping the tick) in addition to
the estimated one via an extra pointer argument and make
menu_select() use that value to refine the state selection
when necessary.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   21 ++++++++++++++++++---
 include/linux/tick.h             |    2 +-
 kernel/time/tick-sched.c         |    7 +++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -119,7 +119,7 @@ extern void tick_nohz_idle_retain_tick(v
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
@@ -1024,10 +1024,11 @@ void tick_nohz_irq_exit(void)
 
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
@@ -1038,6 +1039,8 @@ ktime_t tick_nohz_get_sleep_length(void)
 	 */
 	ktime_t now = ts->idle_entrytime;
 
+	*cur_ret = ktime_sub(dev->next_event, now);
+
 	if (can_stop_idle_tick(cpu, ts)) {
 		ktime_t next_event = __tick_nohz_next_event(ts, cpu);
 
@@ -1045,7 +1048,7 @@ ktime_t tick_nohz_get_sleep_length(void)
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
@@ -400,8 +401,22 @@ static int menu_select(struct cpuidle_dr
 		 * within the tick period range that could be used if longer
 		 * idle duration was predicted.
 		 */
-		*nohz_ret = !(first_idx > idx &&
-			      drv->states[first_idx].target_residency < TICK_USEC_HZ);
+		if (first_idx > idx &&
+		    drv->states[first_idx].target_residency < TICK_USEC_HZ) {
+			unsigned int tick_us = ktime_to_us(tick_time);
+
+			/*
+			 * Find a state with target residency less than the
+			 * time to the next timer event including the tick.
+			 */
+			while (idx > 0 &&
+			    (drv->states[idx].target_residency > tick_us ||
+			     drv->states[idx].disabled ||
+			     dev->states_usage[idx].disable))
+				idx--;
+
+			*nohz_ret = false;
+		}
 	}
 
 	data->last_state_idx = idx;
