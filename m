Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeE3LoL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:44:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45639 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeE3LoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:44:02 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>
Subject: [PATCH 2/2] cpuidle: governors: Consolidate PM QoS handling
Date: Wed, 30 May 2018 13:43:01 +0200
Message-ID: <10468614.qBmGIGE6jp@aspire.rjw.lan>
In-Reply-To: <2261593.SGWtJkXgY3@aspire.rjw.lan>
References: <2261593.SGWtJkXgY3@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is some code duplication related to the PM QoS handling between
the existing cpuidle governors, so move that code to a common helper
function and call that from the governors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governor.c         |   17 ++++++++++++++++-
 drivers/cpuidle/governors/ladder.c |    9 +--------
 drivers/cpuidle/governors/menu.c   |    9 +--------
 include/linux/cpuidle.h            |    1 +
 4 files changed, 19 insertions(+), 17 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -268,6 +268,7 @@ struct cpuidle_governor {
 
 #ifdef CONFIG_CPU_IDLE
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern int cpuidle_governor_latency_req(unsigned int cpu);
 #else
 static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 {return 0;}
Index: linux-pm/drivers/cpuidle/governor.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governor.c
+++ linux-pm/drivers/cpuidle/governor.c
@@ -8,8 +8,10 @@
  * This code is licenced under the GPL.
  */
 
-#include <linux/mutex.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
+#include <linux/mutex.h>
+#include <linux/pm_qos.h>
 
 #include "cpuidle.h"
 
@@ -93,3 +95,16 @@ int cpuidle_register_governor(struct cpu
 
 	return ret;
 }
+
+/**
+ * cpuidle_governor_latency_req - Compute a latency constraint for CPU
+ * @cpu: Target CPU
+ */
+int cpuidle_governor_latency_req(unsigned int cpu)
+{
+	int global_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	struct device *device = get_cpu_device(cpu);
+	int device_req = dev_pm_qos_raw_read_value(device);
+
+	return device_req < global_req ? device_req : global_req;
+}
Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -14,10 +14,8 @@
 
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
-#include <linux/pm_qos.h>
 #include <linux/jiffies.h>
 #include <linux/tick.h>
-#include <linux/cpu.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -69,15 +67,10 @@ static int ladder_select_state(struct cp
 			       struct cpuidle_device *dev, bool *dummy)
 {
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
-	struct device *device = get_cpu_device(dev->cpu);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx = ldev->last_state_idx;
 	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
-	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
-	int resume_latency = dev_pm_qos_raw_read_value(device);
-
-	if (resume_latency < latency_req)
-		latency_req = resume_latency;
+	int latency_req = cpuidle_governor_latency_req(dev->cpu);
 
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0)) {
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
-#include <linux/pm_qos.h>
 #include <linux/time.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
@@ -21,7 +20,6 @@
 #include <linux/sched/loadavg.h>
 #include <linux/sched/stat.h>
 #include <linux/math64.h>
-#include <linux/cpu.h>
 
 /*
  * Please note when changing the tuning values:
@@ -286,15 +284,13 @@ static int menu_select(struct cpuidle_dr
 		       bool *stop_tick)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
-	struct device *device = get_cpu_device(dev->cpu);
-	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	int latency_req = cpuidle_governor_latency_req(dev->cpu);
 	int i;
 	int first_idx;
 	int idx;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
-	int resume_latency = dev_pm_qos_raw_read_value(device);
 	ktime_t delta_next;
 	bool prediction_override = false;
 	bool prediction_override_tick = false;
@@ -304,9 +300,6 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	if (resume_latency < latency_req)
-		latency_req = resume_latency;
-
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0)) {
 		*stop_tick = false;
