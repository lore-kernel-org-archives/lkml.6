Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeFEVmy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:42:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:37416 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbeFEVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:42:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="47023741"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, ggherdovich@suse.cz,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] cpufreq: intel_pstate: HWP boost performance on IO wakeup
Date: Tue,  5 Jun 2018 14:42:40 -0700
Message-Id: <20180605214242.62156-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses SCHED_CPUFREQ_IOWAIT flag to boost HWP performance.
Since SCHED_CPUFREQ_IOWAIT flag is set frequently, we don't start
boosting steps unless we see two consecutive flags in two ticks. This
avoids boosting due to IO because of regular system activities.

To avoid synchronization issues, the actual processing of the flag is
done on the local CPU callback.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3949e3861f55..5b2b6b6d1ff4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -223,6 +223,8 @@ struct global_params {
  *			operation
  * @hwp_req_cached:	Cached value of the last HWP Request MSR
  * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
+ * @last_io_update:	Last time when IO wake flag was set
+ * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  *
  * This structure stores per CPU instance data for all CPUs.
@@ -258,6 +260,8 @@ struct cpudata {
 	s16 epp_saved;
 	u64 hwp_req_cached;
 	u64 hwp_cap_cached;
+	u64 last_io_update;
+	unsigned int sched_flags;
 	u32 hwp_boost_min;
 };
 
@@ -1460,9 +1464,44 @@ static inline void intel_pstate_hwp_boost_down(struct cpudata *cpu)
 	cpu->last_update = cpu->sample.time;
 }
 
+static inline void intel_pstate_update_util_hwp_local(struct cpudata *cpu,
+						      u64 time)
+{
+	cpu->sample.time = time;
+
+	if (cpu->sched_flags & SCHED_CPUFREQ_IOWAIT) {
+		bool do_io = false;
+
+		cpu->sched_flags = 0;
+		/*
+		 * Set iowait_boost flag and update time. Since IO WAIT flag
+		 * is set all the time, we can't just conclude that there is
+		 * some IO bound activity is scheduled on this CPU with just
+		 * one occurrence. If we receive at least two in two
+		 * consecutive ticks, then we treat as boost candidate.
+		 */
+		if (time_before64(time, cpu->last_io_update + 2 * TICK_NSEC))
+			do_io = true;
+
+		cpu->last_io_update = time;
+
+		if (do_io)
+			intel_pstate_hwp_boost_up(cpu);
+
+	} else {
+		intel_pstate_hwp_boost_down(cpu);
+	}
+}
+
 static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
 						u64 time, unsigned int flags)
 {
+	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+
+	cpu->sched_flags |= flags;
+
+	if (smp_processor_id() == cpu->cpu)
+		intel_pstate_update_util_hwp_local(cpu, time);
 }
 
 static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
-- 
2.13.6
