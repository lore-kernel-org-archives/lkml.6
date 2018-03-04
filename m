Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbeCDWbx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:31:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48145 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeCDWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 17:30:19 -0500
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
Subject: [RFC/RFT][PATCH 5/7] cpuidle: New governor callback for predicting idle duration
Date: Sun, 04 Mar 2018 23:27:32 +0100
Message-ID: <24524352.zYArR4Buth@aspire.rjw.lan>
In-Reply-To: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to address the issue with short idle duration predictions
by the idle governor after the tick has been stopped, introduce a
new cpuidle governor callback for predicting idle duration and make
cpuidle_select() use it to obtain an idle duration estimate.  Also
make cpuidle_select() return the expected idle duration to its caller
through an additional argument pointer.

For the menu governor, make the new callback pointer point to the
menu_predict() routine introduced previously and stop calling it
directly from menu_select().

This change is not expected to alter the functionality of the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c        |   37 +++++++++++++++++++++++++++++++++++--
 drivers/cpuidle/governors/menu.c |   10 ++++++----
 include/linux/cpuidle.h          |    5 ++++-
 kernel/sched/idle.c              |    4 +++-
 4 files changed, 48 insertions(+), 8 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -131,7 +131,8 @@ extern bool cpuidle_not_available(struct
 				  struct cpuidle_device *dev);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
-			  struct cpuidle_device *dev);
+			  struct cpuidle_device *dev,
+			  unsigned int *duration_us_ptr);
 extern int cpuidle_enter(struct cpuidle_driver *drv,
 			 struct cpuidle_device *dev, int index);
 extern void cpuidle_reflect(struct cpuidle_device *dev, int index);
@@ -245,6 +246,8 @@ struct cpuidle_governor {
 	void (*disable)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev);
 
+	unsigned int (*predict) (struct cpuidle_driver *drv,
+					struct cpuidle_device *dev);
 	int  (*select)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -276,7 +276,8 @@ again:
 	goto again;
 }
 
-static void menu_predict(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+static unsigned int menu_predict(struct cpuidle_driver *drv,
+				 struct cpuidle_device *dev)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	struct device *device = get_cpu_device(dev->cpu);
@@ -298,7 +299,7 @@ static void menu_predict(struct cpuidle_
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(data->latency_req == 0)) {
 		data->predicted_us = 0;
-		return;
+		return 0;
 	}
 
 	/* determine the expected residency time, round up */
@@ -331,6 +332,8 @@ static void menu_predict(struct cpuidle_
 	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
 	if (data->latency_req > interactivity_req)
 		data->latency_req = interactivity_req;
+
+	return data->predicted_us;
 }
 
 /**
@@ -343,8 +346,6 @@ static int menu_select(struct cpuidle_dr
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int first_idx, idx, i;
 
-	menu_predict(drv, dev);
-
 	first_idx = 0;
 	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
 		struct cpuidle_state *s = &drv->states[1];
@@ -505,6 +506,7 @@ static struct cpuidle_governor menu_gove
 	.name =		"menu",
 	.rating =	20,
 	.enable =	menu_enable_device,
+	.predict =	menu_predict,
 	.select =	menu_select,
 	.reflect =	menu_reflect,
 };
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -263,12 +263,45 @@ int cpuidle_enter_state(struct cpuidle_d
  *
  * @drv: the cpuidle driver
  * @dev: the cpuidle device
+ * @duration_us_ptr: pointer to return the expected duration of idle period
  *
  * Returns the index of the idle state.  The return value must not be negative.
+ *
+ * The memory location pointed to by @duration_us_ptr is written the expected
+ * duration of the upcoming idle period, in microseconds.
  */
-int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		   unsigned int *duration_us_ptr)
 {
-	return cpuidle_curr_governor->select(drv, dev);
+	unsigned int duration_us;
+	int ret, i;
+
+	if (!cpuidle_curr_governor->predict) {
+		ret = cpuidle_curr_governor->select(drv, dev);
+		*duration_us_ptr = drv->states[ret].target_residency;
+		return ret;
+	}
+
+	duration_us = cpuidle_curr_governor->predict(drv, dev);
+
+	ret = cpuidle_curr_governor->select(drv, dev);
+
+	/*
+	 * Return the target residency of the selected state as the expected
+	 * idle period duration if there are any states available with target
+	 * residencies greater than the predicted idle period duration (to
+	 * avoid staying in a shallow state for too long).
+	 */
+	for (i = ret + 1; i < drv->state_count; i++)
+		if (!drv->states[i].disabled &&
+		    !dev->states_usage[i].disable &&
+		    drv->states[i].target_residency > duration_us) {
+			duration_us = drv->states[ret].target_residency;
+			break;
+		}
+
+	*duration_us_ptr = duration_us;
+	return ret;
 }
 
 /**
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -186,13 +186,15 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		unsigned int duration_us;
+
 		tick_nohz_idle_go_idle(true);
 		rcu_idle_enter();
 
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-		next_state = cpuidle_select(drv, dev);
+		next_state = cpuidle_select(drv, dev, &duration_us);
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
