Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932346AbeCDWaU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:30:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47248 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeCDWaS (ORCPT
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
Subject: [RFC/RFT][PATCH 7/7] time: tick-sched: Avoid running the same code twice in a row
Date: Sun, 04 Mar 2018 23:29:59 +0100
Message-ID: <80015621.dpHl3GThpV@aspire.rjw.lan>
In-Reply-To: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid running the same piece of code twice in a row, move the
tick stopping part of __tick_nohz_next_event() into a new function
called __tick_nohz_stop_tick() and invoke them both separately.

Make __tick_nohz_idle_enter() avoid calling __tick_nohz_next_event()
if it has been called already by tick_nohz_get_sleep_length() and
use the new next_idle_tick field in struct tick_sched to pass the
next event time value between tick_nohz_get_sleep_length() and
__tick_nohz_idle_enter().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-sched.c |  130 ++++++++++++++++++++++++++---------------------
 kernel/time/tick-sched.h |    1 
 2 files changed, 73 insertions(+), 58 deletions(-)

Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -655,13 +655,10 @@ static inline bool local_timer_softirq_p
 	return local_softirq_pending() & TIMER_SOFTIRQ;
 }
 
-static ktime_t __tick_nohz_next_event(struct tick_sched *ts, int cpu,
-				      bool stop_tick)
+static ktime_t __tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
 	unsigned long seq, basejiff;
-	ktime_t	tick;
 
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
@@ -714,34 +711,23 @@ static ktime_t __tick_nohz_next_event(st
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
 		 */
-		if (!ts->tick_stopped) {
-			tick = 0;
-			goto out;
-		}
+		if (!ts->tick_stopped)
+			return 0;
 	}
 
 	/*
-	 * If this CPU is the one which updates jiffies, then give up
-	 * the assignment and let it be taken by the CPU which runs
-	 * the tick timer next, which might be this CPU as well. If we
-	 * don't drop this here the jiffies might be stale and
-	 * do_timer() never invoked. Keep track of the fact that it
-	 * was the one which had the do_timer() duty last. If this CPU
-	 * is the one which had the do_timer() duty last, we limit the
-	 * sleep time to the timekeeping max_deferment value.
+	 * If this CPU is the one which had the do_timer() duty last, we limit
+	 * the sleep time to the timekeeping max_deferment value.
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu == tick_do_timer_cpu) {
-		if (stop_tick) {
-			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-			ts->do_timer_last = 1;
+	if (cpu != tick_do_timer_cpu) {
+		if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+			delta = KTIME_MAX;
+			ts->do_timer_last = 0;
+		} else if (!ts->do_timer_last) {
+			delta = KTIME_MAX;
 		}
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
-		delta = KTIME_MAX;
-		ts->do_timer_last = 0;
-	} else if (!ts->do_timer_last) {
-		delta = KTIME_MAX;
 	}
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -756,24 +742,37 @@ static ktime_t __tick_nohz_next_event(st
 	else
 		expires = KTIME_MAX;
 
-	expires = min_t(u64, expires, next_tick);
-	tick = expires;
+	ts->next_idle_tick = min_t(u64, expires, next_tick);
+	return ts->next_idle_tick;
+}
 
-	if (!stop_tick) {
-		/* Undo the effect of get_next_timer_interrupt(). */
-		timer_clear_idle();
-		goto out;
+static void __tick_nohz_stop_tick(struct tick_sched *ts, int cpu, u64 expires)
+{
+	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	ktime_t tick = expires;
+
+	/*
+	 * If this CPU is the one which updates jiffies, then give up
+	 * the assignment and let it be taken by the CPU which runs
+	 * the tick timer next, which might be this CPU as well. If we
+	 * don't drop this here the jiffies might be stale and
+	 * do_timer() never invoked. Keep track of the fact that it
+	 * was the one which had the do_timer() duty last.
+	 */
+	if (cpu == tick_do_timer_cpu) {
+		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+		ts->do_timer_last = 1;
 	}
 
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
 		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
-			goto out;
+			return;
 
 		WARN_ON_ONCE(1);
 		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
-			    basemono, ts->next_tick, dev->next_event,
+			    ts->last_jiffies_update, ts->next_tick, dev->next_event,
 			    hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_timer));
 	}
 
@@ -803,7 +802,7 @@ static ktime_t __tick_nohz_next_event(st
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
-		goto out;
+		return;
 	}
 
 	hrtimer_set_expires(&ts->sched_timer, tick);
@@ -812,14 +811,18 @@ static ktime_t __tick_nohz_next_event(st
 		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
 	else
 		tick_program_event(tick, 1);
-out:
-	return tick;
 }
 
-static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+#ifdef CONFIG_NO_HZ_FULL
+static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
 {
-	return __tick_nohz_next_event(ts, cpu, true);
+	u64 next_tick;
+
+	next_tick = __tick_nohz_next_event(ts, cpu);
+	if (next_tick)
+		__tick_nohz_stop_tick(ts, cpu, next_tick);
 }
+#endif /* CONFIG_NO_HZ_FULL */
 
 static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 {
@@ -921,32 +924,43 @@ static bool can_stop_idle_tick(int cpu,
 static void __tick_nohz_idle_enter(struct tick_sched *ts, bool stop_tick)
 {
 	int cpu = smp_processor_id();
+	ktime_t expires;
+	int was_stopped;
 
-	if (!ts->last_jiffies_update) {
-		/* tick_nohz_get_sleep_length() has not run. */
+	if (ts->last_jiffies_update) {
+		if (!stop_tick)
+			goto out;
+
+		/*
+		 * tick_nohz_get_sleep_length() has run, so the tick timer
+		 * expiration time has been computed already.
+		 */
+		expires = ts->next_idle_tick;
+	} else {
 		tick_nohz_start_idle(ts);
-		if (!can_stop_idle_tick(cpu, ts))
+		if (!can_stop_idle_tick(cpu, ts) || !stop_tick)
 			return;
+
+		expires = __tick_nohz_next_event(ts, cpu);
 	}
 
-	if (stop_tick) {
-		int was_stopped = ts->tick_stopped;
-		ktime_t expires;
-
-		ts->idle_calls++;
-
-		expires = tick_nohz_stop_sched_tick(ts, cpu);
-		if (expires > 0LL) {
-			ts->idle_sleeps++;
-			ts->idle_expires = expires;
-		}
+	ts->idle_calls++;
 
-		if (!was_stopped && ts->tick_stopped) {
-			ts->idle_jiffies = ts->last_jiffies;
-			nohz_balance_enter_idle(cpu);
-		}
+	was_stopped = ts->tick_stopped;
+
+	if (expires > 0LL) {
+		__tick_nohz_stop_tick(ts, cpu, expires);
+
+		ts->idle_sleeps++;
+		ts->idle_expires = expires;
 	}
 
+	if (!was_stopped && ts->tick_stopped) {
+		ts->idle_jiffies = ts->last_jiffies;
+		nohz_balance_enter_idle(cpu);
+	}
+
+out:
 	ts->last_jiffies_update = 0;
 }
 
@@ -957,7 +971,7 @@ void __tick_nohz_idle_prepare(void)
 	lockdep_assert_irqs_enabled();
 	/*
 	 * Update the idle state in the scheduler domain hierarchy
-	 * when tick_nohz_stop_sched_tick() is called from the idle loop.
+	 * when __tick_nohz_stop_tick() is called from the idle loop.
 	 * State will be updated to busy during the first busy tick after
 	 * exiting idle.
 	 */
@@ -1033,7 +1047,7 @@ ktime_t tick_nohz_get_sleep_length(void)
 	now = tick_nohz_start_idle(ts);
 
 	if (can_stop_idle_tick(cpu, ts)) {
-		next_event = __tick_nohz_next_event(ts, cpu, false);
+		next_event = __tick_nohz_next_event(ts, cpu);
 	} else {
 		struct clock_event_device *dev;
 
Index: linux-pm/kernel/time/tick-sched.h
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.h
+++ linux-pm/kernel/time/tick-sched.h
@@ -59,6 +59,7 @@ struct tick_sched {
 	ktime_t				iowait_sleeptime;
 	unsigned long			last_jiffies;
 	u64				last_jiffies_update;
+	u64				next_idle_tick;
 	u64				next_timer;
 	ktime_t				idle_expires;
 	int				do_timer_last;
