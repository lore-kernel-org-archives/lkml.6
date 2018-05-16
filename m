Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeEPEuS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:50:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:1168 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbeEPEtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300349"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 07/10] cpufreq: intel_pstate: HWP boost performance on busy task migrate
Date: Tue, 15 May 2018 21:49:08 -0700
Message-Id: <20180516044911.28797-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a busy task migrates to a new CPU boost HWP prformance to max. This
helps workloads on servers with per core P-states, which saturates all
CPUs and then they migrate frequently. But changing limits has extra over
head of issuing new HWP Request MSR, which takes 1000+
cycles. So this change limits setting HWP Request MSR.
Rate control in setting HWP Requests:
- If the current performance is around P1, simply ignore.
- Once set wait till hold time, till remove boost. While the boost
 is on, another flags is notified, it will prolong boost.
- The task migrates needs to have some utilzation which is more
than threshold utilization, which will trigger P-state above minimum.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d418265..ec455af 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -227,6 +227,7 @@ struct global_params {
  *			defines callback and arguments
  * @hwp_boost_active:	HWP performance is boosted on this CPU
  * @last_io_update:	Last time when IO wake flag was set
+ * @migrate_hint:	Set when scheduler indicates thread migration
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -263,6 +264,7 @@ struct cpudata {
 	call_single_data_t csd;
 	bool hwp_boost_active;
 	u64 last_io_update;
+	bool migrate_hint;
 };
 
 static struct cpudata **all_cpu_data;
@@ -1438,6 +1440,8 @@ static int hwp_boost_hold_time_ms = 3;
 #define BOOST_PSTATE_THRESHOLD	(SCHED_CAPACITY_SCALE / 2)
 static int hwp_boost_pstate_threshold = BOOST_PSTATE_THRESHOLD;
 
+static int hwp_boost_threshold_busy_pct;
+
 static inline bool intel_pstate_check_boost_threhold(struct cpudata *cpu)
 {
 	/*
@@ -1450,12 +1454,32 @@ static inline bool intel_pstate_check_boost_threhold(struct cpudata *cpu)
 	return true;
 }
 
+static inline int intel_pstate_get_sched_util(struct cpudata *cpu)
+{
+	unsigned long util_cfs, util_dl, max, util;
+
+	cpufreq_get_sched_util(cpu->cpu, &util_cfs, &util_dl, &max);
+	util = min(util_cfs + util_dl, max);
+	return util * 100 / max;
+}
+
 static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
 						u64 time, unsigned int flags)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 
-	if (flags & SCHED_CPUFREQ_IOWAIT) {
+	if (flags & SCHED_CPUFREQ_MIGRATION) {
+		if (intel_pstate_check_boost_threhold(cpu))
+			cpu->migrate_hint = true;
+
+		cpu->last_update = time;
+		/*
+		 * The rq utilization data is not migrated yet to the new CPU
+		 * rq, so wait for call on local CPU to boost.
+		 */
+		if (smp_processor_id() != cpu->cpu)
+			return;
+	} else if (flags & SCHED_CPUFREQ_IOWAIT) {
 		/*
 		 * Set iowait_boost flag and update time. Since IO WAIT flag
 		 * is set all the time, we can't just conclude that there is
@@ -1499,6 +1523,17 @@ static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
 			intel_pstate_hwp_boost_up(cpu);
 		else
 			smp_call_function_single_async(cpu->cpu, &cpu->csd);
+		return;
+	}
+
+	/* Ignore if the migrated thread has low utilization */
+	if (cpu->migrate_hint && smp_processor_id() == cpu->cpu) {
+		int util = intel_pstate_get_sched_util(cpu);
+
+		if (util >= hwp_boost_threshold_busy_pct) {
+			cpu->hwp_boost_active = true;
+			intel_pstate_hwp_boost_up(cpu);
+		}
 	}
 }
 
-- 
2.9.5
