Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeCOWVa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:21:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49141 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeCOWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:20:57 -0400
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
Subject: [RFT][PATCH v5 2/7] sched: idle: Do not stop the tick upfront in the idle loop
Date: Thu, 15 Mar 2018 23:05:50 +0100
Message-ID: <2474699.rEmgzDRfis@aspire.rjw.lan>
In-Reply-To: <2142751.3U6XgWyF8u@aspire.rjw.lan>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Push the decision whether or not to stop the tick somewhat deeper
into the idle loop.

Stopping the tick upfront leads to unpleasant outcomes in case the
idle governor doesn't agree with the nohz code on the duration of the
upcoming idle period.  Specifically, if the tick has been stopped and
the idle governor predicts short idle, the situation is bad regardless
of whether or not the prediction is accurate.  If it is accurate, the
tick has been stopped unnecessarily which means excessive overhead.
If it is not accurate, the CPU is likely to spend too much time in
the (shallow, because short idle has been predicted) idle state
selected by the governor [1].

As the first step towards addressing this problem, change the code
to make the tick stopping decision inside of the loop in do_idle().
In particular, do not stop the tick in the cpu_idle_poll() code path.
Also don't do that in tick_nohz_irq_exit() which doesn't really have
enough information on whether or not to stop the tick.

Link: https://marc.info/?l=linux-pm&m=150116085925208&w=2 # [1]
Link: https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5:
  * Restart the tick before cpu_idle_poll() as suggested by Frederic.

---
 include/linux/tick.h     |    2 ++
 kernel/sched/idle.c      |    9 ++++++---
 kernel/time/tick-sched.c |   26 ++++++++++++++++++--------
 3 files changed, 26 insertions(+), 11 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -221,13 +221,13 @@ static void do_idle(void)
 
 	__current_set_polling();
 	tick_nohz_idle_enter();
-	tick_nohz_idle_stop_tick_protected();
 
 	while (!need_resched()) {
 		check_pgt_cache();
 		rmb();
 
 		if (cpu_is_offline(cpu)) {
+			tick_nohz_idle_stop_tick_protected();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
@@ -241,10 +241,13 @@ static void do_idle(void)
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		if (cpu_idle_force_poll || tick_check_broadcast_expired())
+		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
+			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
-		else
+		} else {
+			tick_nohz_idle_stop_tick();
 			cpuidle_idle_call();
+		}
 		arch_cpu_idle_exit();
 	}
 
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -984,12 +984,10 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->inidle) {
+	if (ts->inidle)
 		tick_nohz_start_idle(ts);
-		__tick_nohz_idle_stop_tick(ts);
-	} else {
+	else
 		tick_nohz_full_update_tick(ts);
-	}
 }
 
 /**
@@ -1050,6 +1048,20 @@ static void tick_nohz_account_idle_ticks
 #endif
 }
 
+static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
+{
+	tick_nohz_restart_sched_tick(ts, now);
+	tick_nohz_account_idle_ticks(ts);
+}
+
+void tick_nohz_idle_restart_tick(void)
+{
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (ts->tick_stopped)
+		__tick_nohz_idle_restart_tick(ts, ktime_get());
+}
+
 /**
  * tick_nohz_idle_exit - restart the idle tick from the idle task
  *
@@ -1074,10 +1086,8 @@ void tick_nohz_idle_exit(void)
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
 
-	if (ts->tick_stopped) {
-		tick_nohz_restart_sched_tick(ts, now);
-		tick_nohz_account_idle_ticks(ts);
-	}
+	if (ts->tick_stopped)
+		__tick_nohz_idle_restart_tick(ts, now);
 
 	local_irq_enable();
 }
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -115,6 +115,7 @@ enum tick_dep_bits {
 extern bool tick_nohz_enabled;
 extern int tick_nohz_tick_stopped(void);
 extern void tick_nohz_idle_stop_tick(void);
+extern void tick_nohz_idle_restart_tick(void);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
@@ -135,6 +136,7 @@ static inline void tick_nohz_idle_stop_t
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
 static inline void tick_nohz_idle_stop_tick(void) { }
+static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 
