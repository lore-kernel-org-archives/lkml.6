Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeCTQoD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:44:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54568 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeCTQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:43:47 -0400
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
Subject: [RFT][PATCH v7 1/8] time: tick-sched: Reorganize idle tick management code
Date: Tue, 20 Mar 2018 16:13:36 +0100
Message-ID: <2756593.6znKTA0Udp@aspire.rjw.lan>
In-Reply-To: <2390019.oHdSGtR3EE@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Prepare the scheduler tick code for reworking the idle loop to
avoid stopping the tick in some cases.

The idea is to split the nohz idle entry call to decouple the idle
time stats accounting and preparatory work from the actual tick stop
code, in order to later be able to delay the tick stop once we reach
more power-knowledgeable callers.

Move away the tick_nohz_start_idle() invocation from
__tick_nohz_idle_enter(), rename the latter to
__tick_nohz_idle_stop_tick() and define tick_nohz_idle_stop_tick()
as a wrapper around it for calling it from the outside.

Make tick_nohz_idle_enter() only call tick_nohz_start_idle() instead
of calling the entire __tick_nohz_idle_enter(), add another wrapper
disabling and enabling interrupts around tick_nohz_idle_stop_tick()
and make the current callers of tick_nohz_idle_enter() call it too
to retain their current functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/xen/smp_pv.c    |    1 +
 include/linux/tick.h     |   12 ++++++++++++
 kernel/sched/idle.c      |    1 +
 kernel/time/tick-sched.c |   46 +++++++++++++++++++++++++---------------------
 4 files changed, 39 insertions(+), 21 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -114,6 +114,7 @@ enum tick_dep_bits {
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
 extern int tick_nohz_tick_stopped(void);
+extern void tick_nohz_idle_stop_tick(void);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
@@ -122,9 +123,18 @@ extern unsigned long tick_nohz_get_idle_
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
+
+static inline void tick_nohz_idle_stop_tick_protected(void)
+{
+	local_irq_disable();
+	tick_nohz_idle_stop_tick();
+	local_irq_enable();
+}
+
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
+static inline void tick_nohz_idle_stop_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 
@@ -134,6 +144,8 @@ static inline ktime_t tick_nohz_get_slee
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
+
+static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -539,14 +539,11 @@ static void tick_nohz_stop_idle(struct t
 	sched_clock_idle_wakeup_event();
 }
 
-static ktime_t tick_nohz_start_idle(struct tick_sched *ts)
+static void tick_nohz_start_idle(struct tick_sched *ts)
 {
-	ktime_t now = ktime_get();
-
-	ts->idle_entrytime = now;
+	ts->idle_entrytime = ktime_get();
 	ts->idle_active = 1;
 	sched_clock_idle_sleep_event();
-	return now;
 }
 
 /**
@@ -911,19 +908,21 @@ static bool can_stop_idle_tick(int cpu,
 	return true;
 }
 
-static void __tick_nohz_idle_enter(struct tick_sched *ts)
+static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 {
-	ktime_t now, expires;
+	ktime_t expires;
 	int cpu = smp_processor_id();
 
-	now = tick_nohz_start_idle(ts);
-
 	if (can_stop_idle_tick(cpu, ts)) {
 		int was_stopped = ts->tick_stopped;
 
 		ts->idle_calls++;
 
-		expires = tick_nohz_stop_sched_tick(ts, now, cpu);
+		/*
+		 * The idle entry time should be a sufficient approximation of
+		 * the current time at this point.
+		 */
+		expires = tick_nohz_stop_sched_tick(ts, ts->idle_entrytime, cpu);
 		if (expires > 0LL) {
 			ts->idle_sleeps++;
 			ts->idle_expires = expires;
@@ -937,16 +936,19 @@ static void __tick_nohz_idle_enter(struc
 }
 
 /**
- * tick_nohz_idle_enter - stop the idle tick from the idle task
+ * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
  *
  * When the next event is more than a tick into the future, stop the idle tick
- * Called when we start the idle loop.
- *
- * The arch is responsible of calling:
+ */
+void tick_nohz_idle_stop_tick(void)
+{
+	__tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched));
+}
+
+/**
+ * tick_nohz_idle_enter - prepare for entering idle on the current CPU
  *
- * - rcu_idle_enter() after its last use of RCU before the CPU is put
- *  to sleep.
- * - rcu_idle_exit() before the first use of RCU after the CPU is woken up.
+ * Called when we start the idle loop.
  */
 void tick_nohz_idle_enter(void)
 {
@@ -965,7 +967,7 @@ void tick_nohz_idle_enter(void)
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 	ts->inidle = 1;
-	__tick_nohz_idle_enter(ts);
+	tick_nohz_start_idle(ts);
 
 	local_irq_enable();
 }
@@ -982,10 +984,12 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->inidle)
-		__tick_nohz_idle_enter(ts);
-	else
+	if (ts->inidle) {
+		tick_nohz_start_idle(ts);
+		__tick_nohz_idle_stop_tick(ts);
+	} else {
 		tick_nohz_full_update_tick(ts);
+	}
 }
 
 /**
Index: linux-pm/arch/x86/xen/smp_pv.c
===================================================================
--- linux-pm.orig/arch/x86/xen/smp_pv.c
+++ linux-pm/arch/x86/xen/smp_pv.c
@@ -425,6 +425,7 @@ static void xen_pv_play_dead(void) /* us
 	 * data back is to call:
 	 */
 	tick_nohz_idle_enter();
+	tick_nohz_idle_stop_tick_protected();
 
 	cpuhp_online_idle(CPUHP_AP_ONLINE_IDLE);
 }
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -221,6 +221,7 @@ static void do_idle(void)
 
 	__current_set_polling();
 	tick_nohz_idle_enter();
+	tick_nohz_idle_stop_tick_protected();
 
 	while (!need_resched()) {
 		check_pgt_cache();
