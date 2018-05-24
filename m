Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935554AbeEXBtP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:49:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:42101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935218AbeEXBsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:48:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="41747915"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        mgorman@techsingularity.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, viresh.kumar@linaro.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH v2 1/6] cpufreq: intel_pstate: Cache last HWP capability/request value
Date: Wed, 23 May 2018 18:47:33 -0700
Message-Id: <20180524014738.52924-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the HWP request value last set using MSR_HWP_REQUEST. This will
allow us to save cycles used for reading last HWP request value for
dynamic update of MSR_HWP_REQUEST.
Also store HWP capability MSR value in local memory, to avoid reading
MSR later for calculating limits for dynamic update of MSR_HWP_REQUEST.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17e566afbb41..baed29c768e7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -221,6 +221,8 @@ struct global_params {
  *			preference/bias
  * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
  *			operation
+ * @hwp_req_cached:	Cached value of the last HWP Request MSR
+ * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -253,6 +255,8 @@ struct cpudata {
 	s16 epp_policy;
 	s16 epp_default;
 	s16 epp_saved;
+	u64 hwp_req_cached;
+	u64 hwp_cap_cached;
 };
 
 static struct cpudata **all_cpu_data;
@@ -689,6 +693,7 @@ static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
 	u64 cap;
 
 	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
+	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
 	if (global.no_turbo)
 		*current_max = HWP_GUARANTEED_PERF(cap);
 	else
@@ -763,6 +768,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 		intel_pstate_set_epb(cpu, epp);
 	}
 skip_epp:
+	WRITE_ONCE(cpu_data->hwp_req_cached, value);
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
-- 
2.13.6
