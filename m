Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeCDWad (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:30:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56649 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeCDWaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 17:30:20 -0500
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
Subject: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration prediction from state selection
Date: Sun, 04 Mar 2018 23:26:24 +0100
Message-ID: <2332986.m9oRvTSu8E@aspire.rjw.lan>
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
by the idle governor after the tick has been stopped, prepare the
menu governor code for reordering with respect to the timekeeping
code that stops the tick.

Use the observation that menu_select() can be split into two
functions, one predicting the idle duration and one selecting the
idle state, and rework it accordingly.

Introduce menu_predict() to predict the idle duration and (for now)
call it from menu_select().  The next set of changes will use
menu_predict() as a new governor callback.

This change is not expected to alter the functionality of the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   68 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -130,6 +130,7 @@ struct menu_device {
 	unsigned int	correction_factor[BUCKETS];
 	unsigned int	intervals[INTERVALS];
 	int		interval_ptr;
+	int		latency_req;
 };
 
 
@@ -275,36 +276,30 @@ again:
 	goto again;
 }
 
-/**
- * menu_select - selects the next idle state to enter
- * @drv: cpuidle driver containing state data
- * @dev: the CPU
- */
-static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+static void menu_predict(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	struct device *device = get_cpu_device(dev->cpu);
-	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
-	int i;
-	int first_idx;
-	int idx;
+	int resume_latency = dev_pm_qos_raw_read_value(device);
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
-	int resume_latency = dev_pm_qos_raw_read_value(device);
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
 	}
 
-	if (resume_latency < latency_req &&
+	data->latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	if (resume_latency < data->latency_req &&
 	    resume_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
-		latency_req = resume_latency;
+		data->latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0))
-		return 0;
+	if (unlikely(data->latency_req == 0)) {
+		data->predicted_us = 0;
+		return;
+	}
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
@@ -324,6 +319,32 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = get_typical_interval(data);
 	expected_interval = min(expected_interval, data->next_timer_us);
 
+	/*
+	 * Use the lowest expected idle interval to pick the idle state.
+	 */
+	data->predicted_us = min(data->predicted_us, expected_interval);
+
+	/*
+	 * Use the performance multiplier and the user-configurable
+	 * latency_req to determine the maximum exit latency.
+	 */
+	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+	if (data->latency_req > interactivity_req)
+		data->latency_req = interactivity_req;
+}
+
+/**
+ * menu_select - selects the next idle state to enter
+ * @drv: cpuidle driver containing state data
+ * @dev: the CPU
+ */
+static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	struct menu_device *data = this_cpu_ptr(&menu_devices);
+	int first_idx, idx, i;
+
+	menu_predict(drv, dev);
+
 	first_idx = 0;
 	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
 		struct cpuidle_state *s = &drv->states[1];
@@ -336,25 +357,12 @@ static int menu_select(struct cpuidle_dr
 		 */
 		polling_threshold = max_t(unsigned int, 20, s->target_residency);
 		if (data->next_timer_us > polling_threshold &&
-		    latency_req > s->exit_latency && !s->disabled &&
+		    data->latency_req > s->exit_latency && !s->disabled &&
 		    !dev->states_usage[1].disable)
 			first_idx = 1;
 	}
 
 	/*
-	 * Use the lowest expected idle interval to pick the idle state.
-	 */
-	data->predicted_us = min(data->predicted_us, expected_interval);
-
-	/*
-	 * Use the performance multiplier and the user-configurable
-	 * latency_req to determine the maximum exit latency.
-	 */
-	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
-	if (latency_req > interactivity_req)
-		latency_req = interactivity_req;
-
-	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
@@ -369,7 +377,7 @@ static int menu_select(struct cpuidle_dr
 			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us)
 			break;
-		if (s->exit_latency > latency_req)
+		if (s->exit_latency > data->latency_req)
 			break;
 
 		idx = i;
