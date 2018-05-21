Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeEUO0S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:26:18 -0400
Received: from foss.arm.com ([217.140.101.70]:51136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbeEUO0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:26:06 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Date: Mon, 21 May 2018 15:25:05 +0100
Message-Id: <20180521142505.6522-11-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Energy Aware Scheduling starts when the scheduling domains are built if the
Energy Model is present and all conditions are met. However, in the typical
case of Arm/Arm64 systems, the Energy Model is provided after the scheduling
domains are first built at boot time, which results in EAS staying
disabled.

This commit fixes this issue by re-building the scheduling domain from the
arch topology driver, once CPUfreq is up and running and when the capacity
of the CPUs have been updated to their final value.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/base/arch_topology.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..7f9fa10ef940 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched/topology.h>
+#include <linux/energy_model.h>
+#include <linux/cpuset.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -173,6 +175,9 @@ static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
 static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
+static void start_eas_workfn(struct work_struct *work);
+static DECLARE_WORK(start_eas_work, start_eas_workfn);
+
 static int
 init_cpu_capacity_callback(struct notifier_block *nb,
 			   unsigned long val,
@@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
+		schedule_work(&start_eas_work);
 	}
 
 	return 0;
@@ -249,6 +255,19 @@ static void parsing_done_workfn(struct work_struct *work)
 	free_cpumask_var(cpus_to_visit);
 }
 
+static void start_eas_workfn(struct work_struct *work)
+{
+	/* Make sure the EM knows about the updated CPU capacities. */
+	rcu_read_lock();
+	em_rescale_cpu_capacity();
+	rcu_read_unlock();
+
+	/* Inform the scheduler about the EM availability. */
+	cpus_read_lock();
+	rebuild_sched_domains();
+	cpus_read_unlock();
+}
+
 #else
 core_initcall(free_raw_capacity);
 #endif
-- 
2.17.0
