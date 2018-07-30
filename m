Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B111EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C8520890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeG3Xhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:37:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:11464 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbeG3Xhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:37:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 15:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,424,1526367600"; 
   d="scan'208";a="61989951"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2018 15:00:31 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eero.t.tamminen@intel.com, ggherdovich@suse.cz,
        mgorman@techsingularity.net, currojerez@riseup.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Limit the scope of HWP dynamic boost platforms
Date:   Mon, 30 Jul 2018 15:00:29 -0700
Message-Id: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic boosting of HWP performance on IO wake showed significant
improvement to IO workloads. This series was intended for Skylake Xeon
platforms only and feature was enabled by default based on CPU model
number.

But some Xeon platforms reused the Skylake desktop CPU model number. This
caused some undesirable side effects to some graphics workloads. Since
they are heavily IO bound, the increase in CPU performance decreased the
power available for GPU to do its computing and hence decrease in graphics
benchmark performance.

For example on a Skylake desktop, GpuTest benchmark showed average FPS
reduction from 529 to 506.

This change makes sure that HWP boost feature is only enabled for Skylake
server platforms by using ACPI FADT preferred PM Profile. If some desktop
users wants to get benefit of boost, they can still enable boost from
intel_pstate sysfs attribute "hwp_dynamic_boost".

Fixes: 41ab43c9c89e (cpufreq: intel_pstate: enable boost for Skylake Xeon)
Link: https://bugs.freedesktop.org/show_bug.cgi?id=107410
Reported-by: Eero Tamminen <eero.t.tamminen@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3c3971256130..d4ed0022b0dd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -311,12 +311,20 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
 
 #ifdef CONFIG_ACPI
 
-static bool intel_pstate_get_ppc_enable_status(void)
+static bool intel_pstate_acpi_pm_profile_server(void)
 {
 	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
 	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
 		return true;
 
+	return false;
+}
+
+static bool intel_pstate_get_ppc_enable_status(void)
+{
+	if (intel_pstate_acpi_pm_profile_server())
+		return true;
+
 	return acpi_ppc;
 }
 
@@ -459,6 +467,11 @@ static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *pol
 static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
 }
+
+static inline bool intel_pstate_acpi_pm_profile_server(void)
+{
+	return false;
+}
 #endif
 
 static inline void update_turbo_state(void)
@@ -1841,7 +1854,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		intel_pstate_hwp_enable(cpu);
 
 		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
-		if (id)
+		if (id && intel_pstate_acpi_pm_profile_server())
 			hwp_boost = true;
 	}
 
-- 
2.17.1

