Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeC2MZy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:25:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49099 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeC2MXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:04 -0400
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
Subject: [PATCH v8 08/10] sched: idle: Select idle state before stopping the tick
Date: Thu, 29 Mar 2018 14:16:24 +0200
Message-ID: <1717553.uJRtP9dZYi@aspire.rjw.lan>
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
by the idle governor after the scheduler tick has been stopped,
reorder the code in cpuidle_idle_call() so that the governor idle
state selection runs before tick_nohz_idle_go_idle() and use the
"nohz" hint returned by cpuidle_select() to decide whether or not
to stop the tick.

This isn't straightforward, because menu_select() invokes
tick_nohz_get_sleep_length() to get the time to the next timer
event and the number returned by the latter comes from
__tick_nohz_idle_stop_tick().  Fortunately, however, it is possible
to compute that number without actually stopping the tick and with
the help of the existing code.

Namely, tick_nohz_get_sleep_length() can be made call
tick_nohz_next_event(), introduced earlier, to get the time to the
next non-highres timer event.  If that happens, tick_nohz_next_event()
need not be called by __tick_nohz_idle_stop_tick() again.

If it turns out that the scheduler tick cannot be stopped going
forward or the next timer event is too close for the tick to be
stopped, tick_nohz_get_sleep_length() can simply return the time to
the next event currently programmed into the corresponding clock
event device.

In addition to knowing the return value of tick_nohz_next_event(),
however, tick_nohz_get_sleep_length() needs to know the time to the
next highres timer event, but with the scheduler tick timer excluded,
which can be computed with the help of hrtimer_get_next_event().

That minimum of that number and the tick_nohz_next_event() return
value is the total time to the next timer event with the assumption
that the tick will be stopped.  It can be returned to the idle
governor which can use it for predicting idle duration (under the
assumption that the tick will be stopped) and deciding whether or
not it makes sense to stop the tick before putting the CPU into the
selected idle state.

With the above, the sleep_length field in struct tick_sched is not
necessary any more, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v7 -> v8:
  * Some changes moved to patch [06/10].
  * Use hrtimer_get_next_event() in tick_nohz_get_sleep_length().
  * Add timer_clear_idle() to tick_nohz_idle_retain_tick().

---
 include/linux/hrtimer.h  |    2 -
 include/linux/tick.h     |    2 +
 kernel/sched/idle.c      |   11 ++++++--
 kernel/time/hrtimer.c    |   56 +++++++++++++++++++++++++++++++++----------
 kernel/time/tick-sched.c |   61 +++++++++++++++++++++++++++++++++++++----------
 kernel/time/tick-sched.h |    2 -
 kernel/time/timer.c      |    4 +--
 7 files changed, 105 insertions(+), 33 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -115,6 +115,7 @@ enum tick_dep_bits {
 extern bool tick_nohz_enabled;
 extern int tick_nohz_tick_stopped(void);
 extern void tick_nohz_idle_stop_tick(void);
+extern void tick_nohz_idle_retain_tick(void);
 extern void tick_nohz_idle_restart_tick(void);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
@@ -137,6 +138,7 @@ static inline void tick_nohz_idle_stop_t
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
 static inline void tick_nohz_idle_stop_tick(void) { }
+static inline void tick_nohz_idle_retain_tick(void) { }
 static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -190,13 +190,18 @@ static void cpuidle_idle_call(void)
 	} else {
 		bool stop_tick = true;
 
-		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
-
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
+
+		if (stop_tick)
+			tick_nohz_idle_stop_tick();
+		else
+			tick_nohz_idle_retain_tick();
+
+		rcu_idle_enter();
+
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -930,16 +930,19 @@ static bool can_stop_idle_tick(int cpu,
 
 static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 {
-	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	ktime_t expires;
 	int cpu = smp_processor_id();
 
-	WARN_ON_ONCE(ts->timer_expires_base);
-
-	if (!can_stop_idle_tick(cpu, ts))
-		goto out;
-
-	expires = tick_nohz_next_event(ts, cpu);
+	/*
+	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
+	 * tick timer expiration time is known already.
+	 */
+	if (ts->timer_expires_base)
+		expires = ts->timer_expires;
+	else if (can_stop_idle_tick(cpu, ts))
+		expires = tick_nohz_next_event(ts, cpu);
+	else
+		return;
 
 	ts->idle_calls++;
 
@@ -958,9 +961,6 @@ static void __tick_nohz_idle_stop_tick(s
 	} else {
 		tick_nohz_retain_tick(ts);
 	}
-
-out:
-	ts->sleep_length = ktime_sub(dev->next_event, ts->idle_entrytime);
 }
 
 /**
@@ -973,6 +973,16 @@ void tick_nohz_idle_stop_tick(void)
 	__tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched));
 }
 
+void tick_nohz_idle_retain_tick(void)
+{
+	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
+	/*
+	 * Undo the effect of get_next_timer_interrupt() called from
+	 * tick_nohz_next_event().
+	 */
+	timer_clear_idle();
+}
+
 /**
  * tick_nohz_idle_enter - prepare for entering idle on the current CPU
  *
@@ -1036,15 +1046,42 @@ bool tick_nohz_idle_got_tick(void)
 }
 
 /**
- * tick_nohz_get_sleep_length - return the length of the current sleep
+ * tick_nohz_get_sleep_length - return the expected length of the current sleep
  *
  * Called from power state control code with interrupts disabled
  */
 ktime_t tick_nohz_get_sleep_length(void)
 {
+	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	int cpu = smp_processor_id();
+	/*
+	 * The idle entry time is expected to be a sufficient approximation of
+	 * the current time at this point.
+	 */
+	ktime_t now = ts->idle_entrytime;
+	ktime_t next_event;
+
+	WARN_ON_ONCE(!ts->inidle);
+
+	if (!can_stop_idle_tick(cpu, ts))
+		goto out_dev;
+
+	next_event = tick_nohz_next_event(ts, cpu);
+	if (!next_event)
+		goto out_dev;
+
+	/*
+	 * If the next highres timer to expire is earlier than next_event, the
+	 * idle governor needs to know that.
+	 */
+	next_event = min_t(u64, next_event,
+			   hrtimer_get_next_event(&ts->sched_timer));
+
+	return ktime_sub(next_event, now);
 
-	return ts->sleep_length;
+out_dev:
+	return ktime_sub(dev->next_event, now);
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
  * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @do_timer_lst:	CPU was the last one doing do_timer before going idle
@@ -60,7 +59,6 @@ struct tick_sched {
 	ktime_t				idle_exittime;
 	ktime_t				idle_sleeptime;
 	ktime_t				iowait_sleeptime;
-	ktime_t				sleep_length;
 	unsigned long			last_jiffies;
 	u64				timer_expires;
 	u64				timer_expires_base;
