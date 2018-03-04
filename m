Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeCDWaf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:30:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62722 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbeCDWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 17:30:21 -0500
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
Subject: [RFC/RFT][PATCH 1/7] time: tick-sched: Reorganize idle tick management code
Date: Sun, 04 Mar 2018 23:24:00 +0100
Message-ID: <46071692.o1R0bjyNQV@aspire.rjw.lan>
In-Reply-To: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Prepare two pieces of code in tick_nohz_idle_enter() for being
called separately from each other.

First, make it possible to call the initial preparatory part of
tick_nohz_idle_enter() without the tick-stopping part following
it and introduce the tick_nohz_idle_prepare() wrapper for that
(that will be used in the next set of changes).

Second, add a new stop_tick argument to __tick_nohz_idle_enter()
tell it whether or not to stop the tick (that is always set for
now) and add a wrapper allowing this function to be called from
the outside of tick-sched.c.

Just the code reorganization and two new wrapper functions, no
intended functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/tick.h     |    2 +
 kernel/time/tick-sched.c |   51 +++++++++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 17 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -114,6 +114,8 @@ enum tick_dep_bits {
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
 extern int tick_nohz_tick_stopped(void);
+extern void tick_nohz_idle_prepare(void);
+extern void tick_nohz_idle_go_idle(bool stop_tick);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -911,14 +911,14 @@ static bool can_stop_idle_tick(int cpu,
 	return true;
 }
 
-static void __tick_nohz_idle_enter(struct tick_sched *ts)
+static void __tick_nohz_idle_enter(struct tick_sched *ts, bool stop_tick)
 {
 	ktime_t now, expires;
 	int cpu = smp_processor_id();
 
 	now = tick_nohz_start_idle(ts);
 
-	if (can_stop_idle_tick(cpu, ts)) {
+	if (can_stop_idle_tick(cpu, ts) && stop_tick) {
 		int was_stopped = ts->tick_stopped;
 
 		ts->idle_calls++;
@@ -936,19 +936,7 @@ static void __tick_nohz_idle_enter(struc
 	}
 }
 
-/**
- * tick_nohz_idle_enter - stop the idle tick from the idle task
- *
- * When the next event is more than a tick into the future, stop the idle tick
- * Called when we start the idle loop.
- *
- * The arch is responsible of calling:
- *
- * - rcu_idle_enter() after its last use of RCU before the CPU is put
- *  to sleep.
- * - rcu_idle_exit() before the first use of RCU after the CPU is woken up.
- */
-void tick_nohz_idle_enter(void)
+void __tick_nohz_idle_prepare(void)
 {
 	struct tick_sched *ts;
 
@@ -965,7 +953,36 @@ void tick_nohz_idle_enter(void)
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 	ts->inidle = 1;
-	__tick_nohz_idle_enter(ts);
+}
+
+/**
+ * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
+ *
+ * Called when we start the idle loop.
+ */
+void tick_nohz_idle_prepare(void)
+{
+	__tick_nohz_idle_prepare();
+
+	local_irq_enable();
+}
+
+/**
+ * tick_nohz_idle_go_idle - start idle period on the current CPU.
+ * @stop_tick: Whether or not to stop the idle tick.
+ *
+ * When @stop_tick is set and the next event is more than a tick into the
+ * future, stop the idle tick.
+ */
+void tick_nohz_idle_go_idle(bool stop_tick)
+{
+	__tick_nohz_idle_enter(this_cpu_ptr(&tick_cpu_sched), stop_tick);
+}
+
+void tick_nohz_idle_enter(void)
+{
+	__tick_nohz_idle_prepare();
+	tick_nohz_idle_go_idle(true);
 
 	local_irq_enable();
 }
@@ -983,7 +1000,7 @@ void tick_nohz_irq_exit(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->inidle)
-		__tick_nohz_idle_enter(ts);
+		__tick_nohz_idle_enter(ts, true);
 	else
 		tick_nohz_full_update_tick(ts);
 }
