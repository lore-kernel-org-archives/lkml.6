Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEPEtX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:49:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:1168 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeEPEtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300344"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 04/10] cpufreq: intel_pstate: Add update_util_hook for HWP
Date: Tue, 15 May 2018 21:49:05 -0700
Message-Id: <20180516044911.28797-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HWP dynamic boost is active then set the HWP specific update util
hook. Also start and stop processing in frequency invariant accounting
based on the HWP dyanmic boost setting

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dc7dfa9..e200887 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -290,6 +290,7 @@ static struct pstate_funcs pstate_funcs __read_mostly;
 
 static int hwp_active __read_mostly;
 static bool per_cpu_limits __read_mostly;
+static bool hwp_boost __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
@@ -1420,6 +1421,12 @@ static void csd_init(struct cpudata *cpu)
 	cpu->csd.info = cpu;
 }
 
+static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
+						u64 time, unsigned int flags)
+{
+
+}
+
 static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
@@ -1723,7 +1730,7 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
-	if (hwp_active)
+	if (hwp_active && !hwp_boost)
 		return;
 
 	if (cpu->update_util_set)
@@ -1731,8 +1738,12 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
-	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
-				     intel_pstate_update_util);
+	if (hwp_active)
+		cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
+					     intel_pstate_update_util_hwp);
+	else
+		cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
+					     intel_pstate_update_util);
 	cpu->update_util_set = true;
 }
 
@@ -1844,8 +1855,15 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		intel_pstate_set_update_util_hook(policy->cpu);
 	}
 
-	if (hwp_active)
+	if (hwp_active) {
+		if (hwp_boost) {
+			x86_arch_scale_freq_tick_enable();
+		} else {
+			intel_pstate_clear_update_util_hook(policy->cpu);
+			x86_arch_scale_freq_tick_disable();
+		}
 		intel_pstate_hwp_set(policy->cpu);
+	}
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-- 
2.9.5
