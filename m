Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeCFJNC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:13:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65443 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeCFJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:12:33 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC/RFT][PATCH v2 4/6] cpuidle: Return nohz hint from cpuidle_select()
Date: Tue, 06 Mar 2018 10:05:13 +0100
Message-ID: <1756432.KnKEJ20PhI@aspire.rjw.lan>
In-Reply-To: <2067762.1uWBf5RSRc@aspire.rjw.lan>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new pointer argument to cpuidle_select() and to the ->select
cpuidle governor callback to allow a boolean value indicating
whether or not the tick should be stopped before entering the
selected state to be returned from there.

Make the ladder governor ignore that pointer (to preserve its
current behavior) and make the menu governor return 'false" through
it if:
 (1) the idle exit latency is constrained at 0,
 (2) the selected state is a polling one, or
 (3) the target residency of the selected state is less than the
     length of the tick period and there is at least one deeper
     idle state available within the tick period range.

Since the value returned through the new argument pointer is not
used yet, this change is not expected to alter the functionality of
the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: New patch.

---
 drivers/cpuidle/cpuidle.c          |   10 ++++++++--
 drivers/cpuidle/governors/ladder.c |    3 ++-
 drivers/cpuidle/governors/menu.c   |   26 ++++++++++++++++++++++----
 include/linux/cpuidle.h            |    6 ++++--
 kernel/sched/idle.c                |    4 +++-
 5 files changed, 39 insertions(+), 10 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -131,7 +131,8 @@ extern bool cpuidle_not_available(struct
 				  struct cpuidle_device *dev);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
-			  struct cpuidle_device *dev);
+			  struct cpuidle_device *dev,
+			  bool *nohz_ret);
 extern int cpuidle_enter(struct cpuidle_driver *drv,
 			 struct cpuidle_device *dev, int index);
 extern void cpuidle_reflect(struct cpuidle_device *dev, int index);
@@ -246,7 +247,8 @@ struct cpuidle_governor {
 					struct cpuidle_device *dev);
 
 	int  (*select)		(struct cpuidle_driver *drv,
-					struct cpuidle_device *dev);
+					struct cpuidle_device *dev,
+					bool *nohz_ret);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
 
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -186,13 +186,15 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		bool nohz = true;
+
 		tick_nohz_idle_go_idle(true);
 		rcu_idle_enter();
 
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-		next_state = cpuidle_select(drv, dev);
+		next_state = cpuidle_select(drv, dev, &nohz);
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -263,12 +263,18 @@ int cpuidle_enter_state(struct cpuidle_d
  *
  * @drv: the cpuidle driver
  * @dev: the cpuidle device
+ * @nohz_ret: indication on whether or not to stop the tick
  *
  * Returns the index of the idle state.  The return value must not be negative.
+ *
+ * The memory location pointed to by @nohz_ret is expected to be written the
+ * 'false' boolean value if the scheduler tick should not be stopped before
+ * entering the returned state.
  */
-int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		   bool *nohz_ret)
 {
-	return cpuidle_curr_governor->select(drv, dev);
+	return cpuidle_curr_governor->select(drv, dev, nohz_ret);
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -63,9 +63,10 @@ static inline void ladder_do_selection(s
  * ladder_select_state - selects the next state to enter
  * @drv: cpuidle driver
  * @dev: the CPU
+ * @dummy: not used
  */
 static int ladder_select_state(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev)
+			       struct cpuidle_device *dev, bool *dummy)
 {
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct device *device = get_cpu_device(dev->cpu);
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -279,8 +279,10 @@ again:
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
  * @dev: the CPU
+ * @nohz_ret: indication on whether or not to stop the tick
  */
-static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       bool *nohz_ret)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	struct device *device = get_cpu_device(dev->cpu);
@@ -303,8 +305,10 @@ static int menu_select(struct cpuidle_dr
 		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0))
+	if (unlikely(latency_req == 0)) {
+		*nohz_ret = false;
 		return 0;
+	}
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
@@ -367,10 +371,12 @@ static int menu_select(struct cpuidle_dr
 			continue;
 		if (idx == -1)
 			idx = i; /* first enabled state */
-		if (s->target_residency > data->predicted_us)
-			break;
 		if (s->exit_latency > latency_req)
 			break;
+		if (s->target_residency > data->predicted_us) {
+			first_idx = i;
+			break;
+		}
 
 		idx = i;
 	}
@@ -378,6 +384,18 @@ static int menu_select(struct cpuidle_dr
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
+	if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
+		*nohz_ret = false;
+	} else if (drv->states[idx].target_residency < TICK_USEC) {
+		/*
+		 * Do not stop the tick if there is at least one more state
+		 * within the tick period range that could be used if longer
+		 * idle duration was predicted.
+		 */
+		*nohz_ret = first_idx > idx &&
+			    drv->states[first_idx].target_residency < TICK_USEC;
+	}
+
 	data->last_state_idx = idx;
 
 	return data->last_state_idx;
