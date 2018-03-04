Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeCDWab (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:30:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42177 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeCDWaV (ORCPT
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
Subject: [RFC/RFT][PATCH 2/7] sched: idle: Do not stop the tick upfront in the idle loop
Date: Sun, 04 Mar 2018 23:24:14 +0100
Message-ID: <4940679.SXdkBYNTAE@aspire.rjw.lan>
In-Reply-To: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
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
idle governor doesn't agree with the timekeeping code on the duration
of the upcoming idle period.  Specifically, if the tick has been
stopped and the idle governor predicts short idle, the situation is
bad regardless of whether or not the prediction is accurate.  If it
is accurate, the tick has been stopped unnecessarily which means
excessive overhead.  If it is not accurate, the CPU is likely to
spend too much time in the (shallow, because short idle has been
predicted) idle state selected by the governor [1].

As the first step towards addressing this problem, change the code
to make the tick stopping decision inside of the loop in do_idle().
In particular, do not stop the tick in the cpu_idle_poll() code path.
Also don't do that in tick_nohz_irq_exit() which doesn't really have
information to whether or not to stop the tick.

Link: https://marc.info/?l=linux-pm&m=150116085925208&w=2 # [1]
Link: https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c      |   13 ++++++++++---
 kernel/time/tick-sched.c |    2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -220,13 +220,17 @@ static void do_idle(void)
 	 */
 
 	__current_set_polling();
-	tick_nohz_idle_enter();
+	tick_nohz_idle_prepare();
 
 	while (!need_resched()) {
 		check_pgt_cache();
 		rmb();
 
 		if (cpu_is_offline(cpu)) {
+			local_irq_disable();
+			tick_nohz_idle_go_idle(true);
+			local_irq_enable();
+
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
@@ -240,10 +244,13 @@ static void do_idle(void)
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		if (cpu_idle_force_poll || tick_check_broadcast_expired())
+		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
+			tick_nohz_idle_go_idle(false);
 			cpu_idle_poll();
-		else
+		} else {
+			tick_nohz_idle_go_idle(true);
 			cpuidle_idle_call();
+		}
 		arch_cpu_idle_exit();
 	}
 
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -1000,7 +1000,7 @@ void tick_nohz_irq_exit(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->inidle)
-		__tick_nohz_idle_enter(ts, true);
+		__tick_nohz_idle_enter(ts, false);
 	else
 		tick_nohz_full_update_tick(ts);
 }
