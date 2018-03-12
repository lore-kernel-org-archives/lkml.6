Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeCLKIy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:08:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51238 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeCLKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:07:36 -0400
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
Subject: [RFT][PATCH v4 2/7] sched: idle: Do not stop the tick upfront in the idle loop
Date: Mon, 12 Mar 2018 10:51:11 +0100
Message-ID: <2177770.i4UbKDJpnI@aspire.rjw.lan>
In-Reply-To: <2352117.3UUoYAu18A@aspire.rjw.lan>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
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
enough information on whether or not to stop the tick.

Link: https://marc.info/?l=linux-pm&m=150116085925208&w=2 # [1]
Link: https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c      |    8 +++++---
 kernel/time/tick-sched.c |    6 ++----
 2 files changed, 7 insertions(+), 7 deletions(-)

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
@@ -241,10 +241,12 @@ static void do_idle(void)
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		if (cpu_idle_force_poll || tick_check_broadcast_expired())
+		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
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
