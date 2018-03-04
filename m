Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeCDWaY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:30:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47935 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeCDWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 17:30:18 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before stopping the tick
Date: Sun, 04 Mar 2018 23:28:56 +0100
Message-ID: <2048240.1dZKXsSxFh@aspire.rjw.lan>
In-Reply-To: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to address the issue with short idle duration predictions
by the idle governor after the tick has been stopped, reorder the
code in cpuidle_idle_call() so that the governor idle state selection
runs before tick_nohz_idle_go_idle() and use the expected idle period
duration returned by cpuidle_select() to tell tick_nohz_idle_go_idle()
whether or not to stop the tick.

This isn't straightforward, because menu_predict() invokes
tick_nohz_get_sleep_length() to get the time to the next timer
event and the number returned by the latter comes from
__tick_nohz_idle_enter().  Fortunately, however, it is possible
to compute that number without actually stopping the tick and with
the help of the existing code.

Namely, notice that tick_nohz_stop_sched_tick() already computes the
next timer event time to reprogram the scheduler tick hrtimer and
that time can be used as a proxy for the actual next timer event
time in the idle duration predicition.

Accordingly, rename the original tick_nohz_stop_sched_tick() to
__tick_nohz_next_event() and add the stop_tick argument indicating
whether or not to stop the tick to it.  If that argument is 'true',
the function will work like the original tick_nohz_stop_sched_tick(),
but otherwise it will just compute the next event time without
stopping the tick.  Next, redefine tick_nohz_stop_sched_tick() as
a wrapper around the new function.

Following that, make tick_nohz_get_sleep_length() call
__tick_nohz_next_event() to compute the next timer event time
and make it use the new last_jiffies_update field in struct
tick_sched to tell __tick_nohz_idle_enter() to skip some code
that has run already.

[After this change the __tick_nohz_next_event() code computing the
 next event time will run twice in a row if the expected idle period
 duration coming from cpuidle_select() is large enough which is sort
 of ugly, but the next set of changes deals with that separately.
 To do that, it uses the value of the last_jiffies_update field in
 struct tick_sched introduced here, among other things.]

Finally, drop the now redundant sleep_length field from struct
tick_sched.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c      |    7 ++---
 kernel/time/tick-sched.c |   64 +++++++++++++++++++++++++++++++++--------------
 kernel/time/tick-sched.h |    3 --
 3 files changed, 50 insertions(+), 24 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
 	} else {
 		unsigned int duration_us;
 
-		tick_nohz_idle_go_idle(true);
-		rcu_idle_enter();
-
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state = cpuidle_select(drv, dev, &duration_us);
+
+		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC / HZ);
+		rcu_idle_enter();
+
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -655,8 +655,8 @@ static inline bool local_timer_softirq_p
 	return local_softirq_pending() & TIMER_SOFTIRQ;
 }
 
-static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
-					 ktime_t now, int cpu)
+static ktime_t __tick_nohz_next_event(struct tick_sched *ts, int cpu,
+				      bool stop_tick)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
@@ -670,6 +670,7 @@ static ktime_t tick_nohz_stop_sched_tick
 		basejiff = jiffies;
 	} while (read_seqretry(&jiffies_lock, seq));
 	ts->last_jiffies = basejiff;
+	ts->last_jiffies_update = basemono;
 
 	/*
 	 * Keep the periodic tick, when RCU, architecture or irq_work
@@ -732,8 +733,10 @@ static ktime_t tick_nohz_stop_sched_tick
 	 */
 	delta = timekeeping_max_deferment();
 	if (cpu == tick_do_timer_cpu) {
-		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		ts->do_timer_last = 1;
+		if (stop_tick) {
+			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+			ts->do_timer_last = 1;
+		}
 	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
 		delta = KTIME_MAX;
 		ts->do_timer_last = 0;
@@ -756,6 +759,12 @@ static ktime_t tick_nohz_stop_sched_tick
 	expires = min_t(u64, expires, next_tick);
 	tick = expires;
 
+	if (!stop_tick) {
+		/* Undo the effect of get_next_timer_interrupt(). */
+		timer_clear_idle();
+		goto out;
+	}
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -804,14 +813,14 @@ static ktime_t tick_nohz_stop_sched_tick
 	else
 		tick_program_event(tick, 1);
 out:
-	/*
-	 * Update the estimated sleep length until the next timer
-	 * (not only the tick).
-	 */
-	ts->sleep_length = ktime_sub(dev->next_event, now);
 	return tick;
 }
 
+static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+{
+	return __tick_nohz_next_event(ts, cpu, true);
+}
+
 static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 {
 	/* Update jiffies first */
@@ -847,7 +856,7 @@ static void tick_nohz_full_update_tick(s
 		return;
 
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, ktime_get(), cpu);
+		tick_nohz_stop_sched_tick(ts, cpu);
 	else if (ts->tick_stopped)
 		tick_nohz_restart_sched_tick(ts, ktime_get());
 #endif
@@ -873,10 +882,8 @@ static bool can_stop_idle_tick(int cpu,
 		return false;
 	}
 
-	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE)) {
-		ts->sleep_length = NSEC_PER_SEC / HZ;
+	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE))
 		return false;
-	}
 
 	if (need_resched())
 		return false;
@@ -913,17 +920,22 @@ static bool can_stop_idle_tick(int cpu,
 
 static void __tick_nohz_idle_enter(struct tick_sched *ts, bool stop_tick)
 {
-	ktime_t now, expires;
 	int cpu = smp_processor_id();
 
-	now = tick_nohz_start_idle(ts);
+	if (!ts->last_jiffies_update) {
+		/* tick_nohz_get_sleep_length() has not run. */
+		tick_nohz_start_idle(ts);
+		if (!can_stop_idle_tick(cpu, ts))
+			return;
+	}
 
-	if (can_stop_idle_tick(cpu, ts) && stop_tick) {
+	if (stop_tick) {
 		int was_stopped = ts->tick_stopped;
+		ktime_t expires;
 
 		ts->idle_calls++;
 
-		expires = tick_nohz_stop_sched_tick(ts, now, cpu);
+		expires = tick_nohz_stop_sched_tick(ts, cpu);
 		if (expires > 0LL) {
 			ts->idle_sleeps++;
 			ts->idle_expires = expires;
@@ -934,6 +946,8 @@ static void __tick_nohz_idle_enter(struc
 			nohz_balance_enter_idle(cpu);
 		}
 	}
+
+	ts->last_jiffies_update = 0;
 }
 
 void __tick_nohz_idle_prepare(void)
@@ -1006,15 +1020,27 @@ void tick_nohz_irq_exit(void)
 }
 
 /**
- * tick_nohz_get_sleep_length - return the length of the current sleep
+ * tick_nohz_get_sleep_length - return the expected length of the current sleep
  *
  * Called from power state control code with interrupts disabled
  */
 ktime_t tick_nohz_get_sleep_length(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	int cpu = smp_processor_id();
+	ktime_t now, next_event;
 
-	return ts->sleep_length;
+	now = tick_nohz_start_idle(ts);
+
+	if (can_stop_idle_tick(cpu, ts)) {
+		next_event = __tick_nohz_next_event(ts, cpu, false);
+	} else {
+		struct clock_event_device *dev;
+
+		dev = __this_cpu_read(tick_cpu_device.evtdev);
+		next_event = dev->next_event;
+	}
+	return ktime_sub(next_event, now);;
 }
 
 /**
Index: linux-pm/kernel/time/tick-sched.h
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.h
+++ linux-pm/kernel/time/tick-sched.h
@@ -38,7 +38,6 @@ enum tick_nohz_mode {
  * @idle_exittime:	Time when the idle state was left
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
- * @sleep_length:	Duration of the current idle sleep
  * @do_timer_lst:	CPU was the last one doing do_timer before going idle
  */
 struct tick_sched {
@@ -58,8 +57,8 @@ struct tick_sched {
 	ktime_t				idle_exittime;
 	ktime_t				idle_sleeptime;
 	ktime_t				iowait_sleeptime;
-	ktime_t				sleep_length;
 	unsigned long			last_jiffies;
+	u64				last_jiffies_update;
 	u64				next_timer;
 	ktime_t				idle_expires;
 	int				do_timer_last;
