Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541D820896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541D820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756455AbeFOVMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:12:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:29629 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756127AbeFOVMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:12:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 14:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="49356225"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2018 14:12:21 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0
Date:   Fri, 15 Jun 2018 14:12:09 -0700
Message-Id: <20180615211209.58478-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scaling max/min settings are changed, internally they are converted
to a ratio using the max turbo 1 core turbo frequency. This works fine
when 1 core max is same irrespective of the core. But under Turbo 3.0,
this will not be the case. For example:
Core 0: max turbo pstate: 43 (4.3GHz)
Core 1: max turbo pstate: 45 (4.5GHz)
In this case 1 core turbo ratio will be maximum of all, so it will be
45 (4.5GHz). Suppose scaling max is set to 4GHz (ratio 40) for all cores
,then on core one it will be
 = max_state * policy->max / max_freq;
 = 43 * (4000000/4500000) = 38 (3.8GHz)
 = 38
which is 200MHz less than the desired.
On core2, it will be correctly set to ratio 40 (4GHz). Same holds true
for scaling min frequency limit. So this requires usage of correct turbo
max frequency for core one, which in this case is 4.3GHz. So we need to
adjust per CPU cpu->pstate.turbo_freq using the maximum HWP ratio of that
core.

This change uses the HWP capability of a core to adjust max turbo
frequency. But since Broadwell HWP doesn't use ratios in the HWP
capabilities, we have use legacy max 1 core turbo ratio. This is not a
problem as the HWP capabilities don't differ among cores in Broadwell.
So we need to check for non Broadwell CPU model for applying this change.

While doing this change also optimize usage of x86_match_cpu(). Currently
using, different x86_cpu_id structure values for each feature. We can
consolidate, so that we don't have to introduce one more here. Added HWP
feature flag to each CPU model, instead of a new definition.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 43 ++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1de5ec8..26d1fc7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -308,6 +308,12 @@ static struct global_params global;
 static DEFINE_MUTEX(intel_pstate_driver_lock);
 static DEFINE_MUTEX(intel_pstate_limits_lock);
 
+#define INTEL_PSTATE_HWP_FEATURE_DISABLE_EE	0x01
+#define INTEL_PSTATE_HWP_PERF_BOOST		0x02
+#define INTEL_PSTATE_HWP_BROADWELL		0x04
+
+static u32 intel_pstate_hwp_features;
+
 #ifdef CONFIG_ACPI
 
 static bool intel_pstate_get_ppc_enable_status(void)
@@ -1413,7 +1419,16 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
-	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+
+	if (hwp_active &&
+	    !(intel_pstate_hwp_features & INTEL_PSTATE_HWP_BROADWELL)) {
+		unsigned int phy_max, current_max;
+
+		intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
+		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
+	} else {
+		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	}
 
 	if (pstate_funcs.get_aperf_mperf_shift)
 		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
@@ -1789,14 +1804,16 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	{}
 };
 
-static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, core_funcs),
-	{}
-};
-
-static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
+#define ICPU1(model, feature) \
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
+	 feature}
+
+static const struct x86_cpu_id intel_pstate_hwp_feature_ids[] = {
+	ICPU1(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU1(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU1(INTEL_FAM6_KABYLAKE_DESKTOP, INTEL_PSTATE_HWP_FEATURE_DISABLE_EE),
+	ICPU1(INTEL_FAM6_SKYLAKE_DESKTOP, INTEL_PSTATE_HWP_PERF_BOOST),
+	ICPU1(INTEL_FAM6_SKYLAKE_X, INTEL_PSTATE_HWP_PERF_BOOST),
 	{}
 };
 
@@ -1825,14 +1842,16 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 	if (hwp_active) {
 		const struct x86_cpu_id *id;
 
-		id = x86_match_cpu(intel_pstate_cpu_ee_disable_ids);
+		id = x86_match_cpu(intel_pstate_hwp_feature_ids);
 		if (id)
+			intel_pstate_hwp_features = id->driver_data;
+
+		if (intel_pstate_hwp_features & INTEL_PSTATE_HWP_FEATURE_DISABLE_EE)
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
 
-		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
-		if (id)
+		if (intel_pstate_hwp_features & INTEL_PSTATE_HWP_PERF_BOOST)
 			hwp_boost = true;
 	}
 
-- 
2.7.5

