Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeC2MZf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:25:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59254 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeC2MXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:05 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: [PATCH v8 06/10] time: tick-sched: Split tick_nohz_stop_sched_tick()
Date: Thu, 29 Mar 2018 14:11:18 +0200
Message-ID: <2069618.3ykeHBrnIj@aspire.rjw.lan>
In-Reply-To: <40092860.XNQZrLjKDd@aspire.rjw.lan>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to address the issue with short idle duration predictions
by the idle governor after the scheduler tick has been stopped, split
tick_nohz_stop_sched_tick() into two separate routines, one computing
the time to the next timer event and the other simply stopping the
tick when the time to the next timer event is known.

Prepare these two routines to be called separately, as one of them
will be called by the idle governor in the cpuidle_select() code
path after subsequent changes.

Update the former callers of tick_nohz_stop_sched_tick() to use
the new routines, tick_nohz_next_event() and tick_nohz_stop_tick(),
instead of it and move the updates of the sleep_length field in
struct tick_sched into __tick_nohz_idle_stop_tick() as it doesn't
need to be updated anywhere else.

There should be no intentional visible changes in functionality
resulting from this change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v7 -> v8: New patch.
  * Mostly changes previously in [v7 6/8].
  * Small fixes in tick_nohz_next_event() and tick_nohz_stop_tick().

---
 kernel/time/tick-sched.c |  128 +++++++++++++++++++++++++++++------------------
 kernel/time/tick-sched.h |    4 +
 2 files changed, 84 insertions(+), 48 deletions(-)

Index: linux-pm/kernel/time/tick-sched.h
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.h
+++ linux-pm/kernel/time/tick-sched.h
@@ -39,6 +39,8 @@ enum tick_nohz_mode {
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
  * @sleep_length:	Duration of the current idle sleep
+ * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
+ * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @do_timer_lst:	CPU was the last one doing do_timer before going idle
  */
 struct tick_sched {
@@ -60,6 +62,8 @@ struct tick_sched {
 	ktime_t				iowait_sleeptime;
 	ktime_t				sleep_length;
 	unsigned long			last_jiffies;
+	u64				timer_expires;
+	u64				timer_expires_base;
 	u64				next_timer;
 	ktime_t				idle_expires;
 	int				do_timer_last;
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -652,13 +652,10 @@ static inline bool local_timer_softirq_p
 	return local_softirq_pending() & TIMER_SOFTIRQ;
 }
 
-static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
-					 ktime_t now, int cpu)
+static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
 	unsigned long seq, basejiff;
-	ktime_t	tick;
 
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
@@ -667,6 +664,7 @@ static ktime_t tick_nohz_stop_sched_tick
 		basejiff = jiffies;
 	} while (read_seqretry(&jiffies_lock, seq));
 	ts->last_jiffies = basejiff;
+	ts->timer_expires_base = basemono;
 
 	/*
 	 * Keep the periodic tick, when RCU, architecture or irq_work
@@ -711,32 +709,20 @@ static ktime_t tick_nohz_stop_sched_tick
 		 * next period, so no point in stopping it either, bail.
 		 */
 		if (!ts->tick_stopped) {
-			tick = 0;
+			ts->timer_expires = 0;
 			goto out;
 		}
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
-		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		ts->do_timer_last = 1;
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
-		delta = KTIME_MAX;
-		ts->do_timer_last = 0;
-	} else if (!ts->do_timer_last) {
+	if (cpu != tick_do_timer_cpu &&
+	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
 		delta = KTIME_MAX;
-	}
 
 #ifdef CONFIG_NO_HZ_FULL
 	/* Limit the tick delta to the maximum scheduler deferment */
@@ -750,14 +736,42 @@ static ktime_t tick_nohz_stop_sched_tick
 	else
 		expires = KTIME_MAX;
 
-	expires = min_t(u64, expires, next_tick);
-	tick = expires;
+	ts->timer_expires = min_t(u64, expires, next_tick);
+
+out:
+	return ts->timer_expires;
+}
+
+static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
+{
+	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	u64 basemono = ts->timer_expires_base;
+	u64 expires = ts->timer_expires;
+	ktime_t tick = expires;
+
+	/* Make sure we won't be trying to stop it twice in a row. */
+	ts->timer_expires_base = 0;
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
+	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+		ts->do_timer_last = 0;
+	}
 
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
 		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
-			goto out;
+			return;
 
 		WARN_ON_ONCE(1);
 		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
@@ -791,7 +805,7 @@ static ktime_t tick_nohz_stop_sched_tick
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
-		goto out;
+		return;
 	}
 
 	hrtimer_set_expires(&ts->sched_timer, tick);
@@ -800,15 +814,23 @@ static ktime_t tick_nohz_stop_sched_tick
 		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
 	else
 		tick_program_event(tick, 1);
-out:
-	/*
-	 * Update the estimated sleep length until the next timer
-	 * (not only the tick).
-	 */
-	ts->sleep_length = ktime_sub(dev->next_event, now);
-	return tick;
 }
 
+static void tick_nohz_retain_tick(struct tick_sched *ts)
+{
+	ts->timer_expires_base = 0;
+}
+
+#ifdef CONFIG_NO_HZ_FULL
+static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+{
+	if (tick_nohz_next_event(ts, cpu))
+		tick_nohz_stop_tick(ts, cpu);
+	else
+		tick_nohz_retain_tick(ts);
+}
+#endif /* CONFIG_NO_HZ_FULL */
+
 static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 {
 	/* Update jiffies first */
@@ -844,7 +866,7 @@ static void tick_nohz_full_update_tick(s
 		return;
 
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, ktime_get(), cpu);
+		tick_nohz_stop_sched_tick(ts, cpu);
 	else if (ts->tick_stopped)
 		tick_nohz_restart_sched_tick(ts, ktime_get());
 #endif
@@ -870,10 +892,8 @@ static bool can_stop_idle_tick(int cpu,
 		return false;
 	}
 
-	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE)) {
-		ts->sleep_length = NSEC_PER_SEC / HZ;
+	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE))
 		return false;
-	}
 
 	if (need_resched())
 		return false;
@@ -910,29 +930,37 @@ static bool can_stop_idle_tick(int cpu,
 
 static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 {
+	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	ktime_t expires;
 	int cpu = smp_processor_id();
 
-	if (can_stop_idle_tick(cpu, ts)) {
+	WARN_ON_ONCE(ts->timer_expires_base);
+
+	if (!can_stop_idle_tick(cpu, ts))
+		goto out;
+
+	expires = tick_nohz_next_event(ts, cpu);
+
+	ts->idle_calls++;
+
+	if (expires > 0LL) {
 		int was_stopped = ts->tick_stopped;
 
-		ts->idle_calls++;
+		tick_nohz_stop_tick(ts, cpu);
 
-		/*
-		 * The idle entry time should be a sufficient approximation of
-		 * the current time at this point.
-		 */
-		expires = tick_nohz_stop_sched_tick(ts, ts->idle_entrytime, cpu);
-		if (expires > 0LL) {
-			ts->idle_sleeps++;
-			ts->idle_expires = expires;
-		}
+		ts->idle_sleeps++;
+		ts->idle_expires = expires;
 
 		if (!was_stopped && ts->tick_stopped) {
 			ts->idle_jiffies = ts->last_jiffies;
 			nohz_balance_enter_idle(cpu);
 		}
+	} else {
+		tick_nohz_retain_tick(ts);
 	}
+
+out:
+	ts->sleep_length = ktime_sub(dev->next_event, ts->idle_entrytime);
 }
 
 /**
@@ -957,7 +985,7 @@ void tick_nohz_idle_enter(void)
 	lockdep_assert_irqs_enabled();
 	/*
 	 * Update the idle state in the scheduler domain hierarchy
-	 * when tick_nohz_stop_sched_tick() is called from the idle loop.
+	 * when tick_nohz_stop_tick() is called from the idle loop.
 	 * State will be updated to busy during the first busy tick after
 	 * exiting idle.
 	 */
@@ -966,6 +994,9 @@ void tick_nohz_idle_enter(void)
 	local_irq_disable();
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
+
+	WARN_ON_ONCE(ts->timer_expires_base);
+
 	ts->inidle = 1;
 	tick_nohz_start_idle(ts);
 
@@ -1091,6 +1122,7 @@ void tick_nohz_idle_exit(void)
 	local_irq_disable();
 
 	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(ts->timer_expires_base);
 
 	ts->inidle = 0;
 
