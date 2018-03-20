Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeCTQnv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:43:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58597 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeCTQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:43:44 -0400
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
Subject: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Tue, 20 Mar 2018 16:45:34 +0100
Message-ID: <1635957.yuHkCe9oyz@aspire.rjw.lan>
In-Reply-To: <2390019.oHdSGtR3EE@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new pointer argument to cpuidle_select() and to the ->select
cpuidle governor callback to allow a boolean value indicating
whether or not the tick should be stopped before entering the
selected state to be returned from there.

Make the ladder governor ignore that pointer (to preserve its
current behavior) and make the menu governor return 'false" through
it if:
 (1) the idle exit latency is constrained at 0, or
 (2) the selected state is a polling one, or
 (3) the expected idle period duration is within the tick period
     range.

In addition to that, the correction factor computations in the menu
governor need to take the possibility that the tick may not be
stopped into account to avoid artificially small correction factor
values.  To that end, add a mechanism to record tick wakeups, as
suggested by Peter Zijlstra, and use it to modify the menu_update()
behavior when tick wakeup occurs.  Namely, make it add a (sufficiently
large) constant value to the correction factor in these cases (instead
of increasing the correction factor by a value based on the
measured idle time).

Since the value returned through the new argument pointer of
cpuidle_select() is not used by its caller yet, this change by
itself is not expected to alter the functionality of the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v5 -> v7:
 * Rename the new cpuidle_select() arg (and some related things) from
   "nohz" to "stop_tick" (as requested by Peter).
 * Use TICK_USEC from the previous patch.
 * Record tick wakeups (as suggested by Peter) and use them to take the
   tick into account in menu_update().

---
 drivers/cpuidle/cpuidle.c          |   10 +++-
 drivers/cpuidle/governors/ladder.c |    3 -
 drivers/cpuidle/governors/menu.c   |   81 ++++++++++++++++++++++++++-----------
 include/linux/cpuidle.h            |    8 ++-
 include/linux/tick.h               |    2 
 kernel/sched/idle.c                |    4 +
 kernel/time/tick-sched.c           |   20 +++++++++
 7 files changed, 98 insertions(+), 30 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -135,7 +135,8 @@ extern bool cpuidle_not_available(struct
 				  struct cpuidle_device *dev);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
-			  struct cpuidle_device *dev);
+			  struct cpuidle_device *dev,
+			  bool *stop_tick);
 extern int cpuidle_enter(struct cpuidle_driver *drv,
 			 struct cpuidle_device *dev, int index);
 extern void cpuidle_reflect(struct cpuidle_device *dev, int index);
@@ -167,7 +168,7 @@ static inline bool cpuidle_not_available
 					 struct cpuidle_device *dev)
 {return true; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
-				 struct cpuidle_device *dev)
+				 struct cpuidle_device *dev, bool *stop_tick)
 {return -ENODEV; }
 static inline int cpuidle_enter(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
@@ -250,7 +251,8 @@ struct cpuidle_governor {
 					struct cpuidle_device *dev);
 
 	int  (*select)		(struct cpuidle_driver *drv,
-					struct cpuidle_device *dev);
+					struct cpuidle_device *dev,
+					bool *stop_tick);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
 
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -188,13 +188,15 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		bool stop_tick = true;
+
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-		next_state = cpuidle_select(drv, dev);
+		next_state = cpuidle_select(drv, dev, &stop_tick);
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -272,12 +272,18 @@ int cpuidle_enter_state(struct cpuidle_d
  *
  * @drv: the cpuidle driver
  * @dev: the cpuidle device
+ * @stop_tick: indication on whether or not to stop the tick
  *
  * Returns the index of the idle state.  The return value must not be negative.
+ *
+ * The memory location pointed to by @stop_tick is expected to be written the
+ * 'false' boolean value if the scheduler tick should not be stopped before
+ * entering the returned state.
  */
-int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		   bool *stop_tick)
 {
-	return cpuidle_curr_governor->select(drv, dev);
+	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -63,9 +63,10 @@ static inline void ladder_do_selection(s
  * ladder_select_state - selects the next state to enter
  * @drv: cpuidle driver
  * @dev: the CPU
+ * @dummy: not used
  */
 static int ladder_select_state(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev)
+			       struct cpuidle_device *dev, bool *dummy)
 {
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct device *device = get_cpu_device(dev->cpu);
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -123,6 +123,7 @@
 struct menu_device {
 	int		last_state_idx;
 	int             needs_update;
+	int             tick_wakeup;
 
 	unsigned int	next_timer_us;
 	unsigned int	predicted_us;
@@ -279,8 +280,10 @@ again:
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
  * @dev: the CPU
+ * @stop_tick: indication on whether or not to stop the tick
  */
-static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       bool *stop_tick)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	struct device *device = get_cpu_device(dev->cpu);
@@ -303,8 +306,10 @@ static int menu_select(struct cpuidle_dr
 		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0))
+	if (unlikely(latency_req == 0)) {
+		*stop_tick = false;
 		return 0;
+	}
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
@@ -354,6 +359,7 @@ static int menu_select(struct cpuidle_dr
 	if (latency_req > interactivity_req)
 		latency_req = interactivity_req;
 
+	expected_interval = data->predicted_us;
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
@@ -369,15 +375,30 @@ static int menu_select(struct cpuidle_dr
 			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us)
 			break;
-		if (s->exit_latency > latency_req)
+		if (s->exit_latency > latency_req) {
+			/*
+			 * If we break out of the loop for latency reasons, use
+			 * the target residency of the selected state as the
+			 * expected idle duration so that the tick is retained
+			 * as long as that target residency is low enough.
+			 */
+			expected_interval = drv->states[idx].target_residency;
 			break;
-
+		}
 		idx = i;
 	}
 
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
+	/*
+	 * Don't stop the tick if the selected state is a polling one or if the
+	 * expected idle duration is shorter than the tick period length.
+	 */
+	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	    expected_interval < TICK_USEC)
+		*stop_tick = false;
+
 	data->last_state_idx = idx;
 
 	return data->last_state_idx;
@@ -397,6 +418,7 @@ static void menu_reflect(struct cpuidle_
 
 	data->last_state_idx = index;
 	data->needs_update = 1;
+	data->tick_wakeup = tick_nohz_idle_got_tick();
 }
 
 /**
@@ -427,31 +449,44 @@ static void menu_update(struct cpuidle_d
 	 * assume the state was never reached and the exit latency is 0.
 	 */
 
-	/* measured value */
-	measured_us = cpuidle_get_last_residency(dev);
-
-	/* Deduct exit latency */
-	if (measured_us > 2 * target->exit_latency)
-		measured_us -= target->exit_latency;
-	else
-		measured_us /= 2;
-
-	/* Make sure our coefficients do not exceed unity */
-	if (measured_us > data->next_timer_us)
-		measured_us = data->next_timer_us;
-
 	/* Update our correction ratio */
 	new_factor = data->correction_factor[data->bucket];
 	new_factor -= new_factor / DECAY;
 
-	if (data->next_timer_us > 0 && measured_us < MAX_INTERESTING)
-		new_factor += RESOLUTION * measured_us / data->next_timer_us;
-	else
+	if (data->tick_wakeup) {
 		/*
-		 * we were idle so long that we count it as a perfect
-		 * prediction
+		 * If the CPU was woken up by the tick, it might have been idle
+		 * for a much longer time if the tick had been stopped.  That
+		 * time cannot be determined, so asssume that it would have been
+		 * long, but not as long as the original return value of
+		 * tick_nohz_get_sleep_length().  Use a number between 0.5 and
+		 * 1, something like 0.75 (which is easy enough to get), that
+		 * should work on the average.
 		 */
-		new_factor += RESOLUTION;
+		new_factor += RESOLUTION / 2 + RESOLUTION / 4;
+	} else {
+		/* measured value */
+		measured_us = cpuidle_get_last_residency(dev);
+
+		/* Deduct exit latency */
+		if (measured_us > 2 * target->exit_latency)
+			measured_us -= target->exit_latency;
+		else
+			measured_us /= 2;
+
+		/* Make sure our coefficients do not exceed unity */
+		if (measured_us > data->next_timer_us)
+			measured_us = data->next_timer_us;
+
+		if (data->next_timer_us > 0 && measured_us < MAX_INTERESTING)
+			new_factor += RESOLUTION * measured_us / data->next_timer_us;
+		else
+			/*
+			 * we were idle so long that we count it as a perfect
+			 * prediction
+			 */
+			new_factor += RESOLUTION;
+	}
 
 	/*
 	 * We don't want 0 as factor; we always want at least
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -991,6 +991,20 @@ void tick_nohz_irq_exit(void)
 }
 
 /**
+ * tick_nohz_idle_got_tick - Check whether or not the tick handler has run
+ */
+bool tick_nohz_idle_got_tick(void)
+{
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (ts->inidle > 1) {
+		ts->inidle = 1;
+		return true;
+	}
+	return false;
+}
+
+/**
  * tick_nohz_get_sleep_length - return the length of the current sleep
  *
  * Called from power state control code with interrupts disabled
@@ -1101,6 +1115,9 @@ static void tick_nohz_handler(struct clo
 	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
+	if (ts->inidle)
+		ts->inidle = 2;
+
 	dev->next_event = KTIME_MAX;
 
 	tick_sched_do_timer(now);
@@ -1198,6 +1215,9 @@ static enum hrtimer_restart tick_sched_t
 	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
+	if (ts->inidle)
+		ts->inidle = 2;
+
 	tick_sched_do_timer(now);
 
 	/*
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -119,6 +119,7 @@ extern void tick_nohz_idle_restart_tick(
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
+extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
@@ -139,6 +140,7 @@ static inline void tick_nohz_idle_stop_t
 static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
+static inline bool tick_nohz_idle_got_tick(void) { return false; }
 
 static inline ktime_t tick_nohz_get_sleep_length(void)
 {
