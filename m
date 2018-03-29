Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeC2MXJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:23:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44062 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeC2MXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:06 -0400
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
Subject: [PATCH v8 03/10] sched: idle: Do not stop the tick before cpuidle_idle_call()
Date: Thu, 29 Mar 2018 14:02:24 +0200
Message-ID: <2094470.21BdEFonBT@aspire.rjw.lan>
In-Reply-To: <40092860.XNQZrLjKDd@aspire.rjw.lan>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make cpuidle_idle_call() decide whether or not to stop the tick.

First, the cpuidle_enter_s2idle() path deals with the tick (and with
the entire timekeeping for that matter) by itself and it doesn't need
the tick to be stopped beforehand.

Second, to address the issue with short idle duration predictions
by the idle governor after the tick has been stopped, it will be
necessary to change the ordering of cpuidle_select() with respect
to tick_nohz_idle_stop_tick().  To prepare for that, put a
tick_nohz_idle_stop_tick() call in the same branch in which
cpuidle_select() is called.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v7 -> v8: No changes.

---
 kernel/sched/idle.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -146,13 +146,15 @@ static void cpuidle_idle_call(void)
 	}
 
 	/*
-	 * Tell the RCU framework we are entering an idle section,
-	 * so no more rcu read side critical sections and one more
+	 * The RCU framework needs to be told that we are entering an idle
+	 * section, so no more rcu read side critical sections and one more
 	 * step to the grace period
 	 */
-	rcu_idle_enter();
 
 	if (cpuidle_not_available(drv, dev)) {
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
+
 		default_idle_call();
 		goto exit_idle;
 	}
@@ -169,16 +171,26 @@ static void cpuidle_idle_call(void)
 
 	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
 		if (idle_should_enter_s2idle()) {
+			rcu_idle_enter();
+
 			entered_state = cpuidle_enter_s2idle(drv, dev);
 			if (entered_state > 0) {
 				local_irq_enable();
 				goto exit_idle;
 			}
+
+			rcu_idle_exit();
 		}
 
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
+
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
+
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
@@ -245,7 +257,6 @@ static void do_idle(void)
 			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
 		} else {
-			tick_nohz_idle_stop_tick();
 			cpuidle_idle_call();
 		}
 		arch_cpu_idle_exit();
