Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeEPEtk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:49:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:1169 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeEPEtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300350"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 08/10] cpufreq: intel_pstate: Dyanmically update busy pct
Date: Tue, 15 May 2018 21:49:09 -0700
Message-Id: <20180516044911.28797-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate hwp_boost_threshold_busy_pct (task busy percent, which is
worth boosting) and hwp_boost_pstate_threshold (Don't boost if
CPU already has some performance) based on platform, min, max and
turbo frequencies.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec455af..c43edce 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1463,6 +1463,42 @@ static inline int intel_pstate_get_sched_util(struct cpudata *cpu)
 	return util * 100 / max;
 }
 
+
+static inline void intel_pstate_update_busy_threshold(struct cpudata *cpu)
+{
+	if (!hwp_boost_threshold_busy_pct) {
+		int min_freq, max_freq;
+
+		min_freq  = cpu->pstate.min_pstate * cpu->pstate.scaling;
+		update_turbo_state();
+		max_freq =  global.turbo_disabled || global.no_turbo ?
+				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+
+		/*
+		 * We are guranteed to get atleast min P-state. If we assume
+		 * P-state is proportional to load (such that 10% load
+		 * increase will result in 10% P-state increase), we will
+		 * get at least min P-state till we have atleast
+		 * (min * 100/max) percent cpu load. So any load less than
+		 * than this this we shouldn't do any boost. Then boosting
+		 * is not free, we will add atleast 20% offset.
+		 */
+		hwp_boost_threshold_busy_pct = min_freq * 100 / max_freq;
+		hwp_boost_threshold_busy_pct += 20;
+		pr_debug("hwp_boost_threshold_busy_pct = %d\n",
+			 hwp_boost_threshold_busy_pct);
+	}
+
+	/* P1 percent out of total range of P-states */
+	if (cpu->pstate.max_freq != cpu->pstate.turbo_freq) {
+		hwp_boost_pstate_threshold =
+			cpu->pstate.max_freq * SCHED_CAPACITY_SCALE / cpu->pstate.turbo_freq;
+		pr_debug("hwp_boost_pstate_threshold = %d\n",
+			 hwp_boost_pstate_threshold);
+	}
+
+}
+
 static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
 						u64 time, unsigned int flags)
 {
@@ -2061,8 +2097,10 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->fast_switch_possible = true;
 
-	if (hwp_active)
+	if (hwp_active) {
 		csd_init(cpu);
+		intel_pstate_update_busy_threshold(cpu);
+	}
 
 	return 0;
 }
-- 
2.9.5
