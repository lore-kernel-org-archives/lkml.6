Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeCOWW4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:22:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43728 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeCOWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:20:56 -0400
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
Subject: [RFT][PATCH v5 4/7] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 15 Mar 2018 23:11:35 +0100
Message-ID: <2021405.tG9RYD54xL@aspire.rjw.lan>
In-Reply-To: <2142751.3U6XgWyF8u@aspire.rjw.lan>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
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
 (3) the expected idle period duration is within the tick period
     range.

Since the value returned through the new argument pointer is not
used yet, this change is not expected to alter the functionality of
the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5:
  * Simplify the code deciding what to return as 'nohz_ret' in
    cpuidle_select(), add comments to explain what is going on.

---
 drivers/cpuidle/cpuidle.c          |   10 ++++++++--
 drivers/cpuidle/governors/ladder.c |    3 ++-
 drivers/cpuidle/governors/menu.c   |   30 ++++++++++++++++++++++++++----
 include/linux/cpuidle.h            |    8 +++++---
 kernel/sched/idle.c                |    4 +++-
 5 files changed, 44 insertions(+), 11 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -135,7 +135,8 @@ extern bool cpuidle_not_available(struct
 				  struct cpuidle_device *dev);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
-			  struct cpuidle_device *dev);
+			  struct cpuidle_device *dev,
+			  bool *nohz_ret);
 extern int cpuidle_enter(struct cpuidle_driver *drv,
 			 struct cpuidle_device *dev, int index);
 extern void cpuidle_reflect(struct cpuidle_device *dev, int index);
@@ -167,7 +168,7 @@ static inline bool cpuidle_not_available
 					 struct cpuidle_device *dev)
 {return true; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
-				 struct cpuidle_device *dev)
+				 struct cpuidle_device *dev, bool *nohz_ret)
 {return -ENODEV; }
 static inline int cpuidle_enter(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
@@ -250,7 +251,8 @@ struct cpuidle_governor {
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
@@ -188,13 +188,15 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		bool nohz = true;
+
 		tick_nohz_idle_stop_tick();
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
@@ -272,12 +272,18 @@ int cpuidle_enter_state(struct cpuidle_d
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
@@ -275,12 +275,16 @@ again:
 	goto again;
 }
 
+#define TICK_USEC_HZ   ((USEC_PER_SEC + HZ/2) / HZ)
+
 /**
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
@@ -303,8 +307,10 @@ static int menu_select(struct cpuidle_dr
 		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0))
+	if (unlikely(latency_req == 0)) {
+		*nohz_ret = false;
 		return 0;
+	}
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
@@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
 	if (latency_req > interactivity_req)
 		latency_req = interactivity_req;
 
+	expected_interval = data->predicted_us;
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
@@ -369,15 +376,30 @@ static int menu_select(struct cpuidle_dr
 			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us)
 			break;
-		if (s->exit_latency > latency_req)
+		if (s->exit_latency > latency_req) {
+			/*
+			 * If we break out of the loop for latency reasons, use
+			 * the target residency of the selected state as the
+			 * expected idle duration so that the tick is retained
+			 * as long as that target residency is low enough.
+			 */
+			expected_interval = drv->states[idx].target_residency;
 			break;
-
+		}
 		idx = i;
 	}
 
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
+	/*
+	 * Don't stop the tick if the selected state is a polling one or if the
+	 * expected idle duration is shorter than the tick period length.
+	 */
+	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	    expected_interval < TICK_USEC_HZ)
+		*nohz_ret = false;
+
 	data->last_state_idx = idx;
 
 	return data->last_state_idx;
