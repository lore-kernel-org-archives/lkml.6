Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeEPEuc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:50:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:1167 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbeEPEtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300347"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 06/10] cpufreq / sched: Add interface to get utilization values
Date: Tue, 15 May 2018 21:49:07 -0700
Message-Id: <20180516044911.28797-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added cpufreq_get_sched_util() to get the CFS, DL and max utilization
values for a CPU. This is required for getting utilization values
for cpufreq drivers outside of kernel/sched folder.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/sched/cpufreq.h |  2 ++
 kernel/sched/cpufreq.c        | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 5966744..a366600 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -20,6 +20,8 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
                        void (*func)(struct update_util_data *data, u64 time,
 				    unsigned int flags));
 void cpufreq_remove_update_util_hook(int cpu);
+void cpufreq_get_sched_util(int cpu, unsigned long *util_cfs,
+			    unsigned long *util_dl, unsigned long *max);
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 5e54cbc..36e2839 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -60,3 +60,26 @@ void cpufreq_remove_update_util_hook(int cpu)
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
 }
 EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
+
+/**
+ * cpufreq_get_sched_util - Get utilization values.
+ * @cpu: The targeted CPU.
+ *
+ * Get the CFS, DL and max utilization.
+ * This function allows cpufreq driver outside the kernel/sched to access
+ * utilization value for a CPUs run queue.
+ */
+void cpufreq_get_sched_util(int cpu, unsigned long *util_cfs,
+			    unsigned long *util_dl, unsigned long *max)
+{
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+	struct rq *rq = cpu_rq(cpu);
+
+	*max = arch_scale_cpu_capacity(NULL, cpu);
+	*util_cfs = cpu_util_cfs(rq);
+	*util_dl  = cpu_util_dl(rq);
+#else
+	*util_cfs = *util_dl = 1;
+#endif
+}
+EXPORT_SYMBOL_GPL(cpufreq_get_sched_util);
-- 
2.9.5
