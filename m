Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47484C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C5D218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBILyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 06:54:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:48859 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfBILyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 06:54:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 03:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,351,1544515200"; 
   d="scan'208";a="121162440"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2019 03:54:09 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to broadcast  _PPC to all online CPUs
Date:   Sat,  9 Feb 2019 20:02:32 +0800
Message-Id: <20190209120232.21582-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dell Inc. XPS13 9333, the BIOS changes the value of
MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
the power source changes), the maximum frequency of the
CPU is not updated accordingly. This is due to the policy's
cpuinfo.max is not updated when _PPC notifier fires.

Fix this problem by updating the policy's cpuinfo.max
and broadcast the _PPC notifier to all online CPUs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
 drivers/cpufreq/cpufreq.c        |  2 ++
 drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index a303fd0e108c..737dbf5aa7f7 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
 MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
 		 "limited by BIOS, this should help");
 
+static int broadcast_ppc;
+module_param(broadcast_ppc, int, 0644);
+MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
+
 #define PPC_REGISTERED   1
 #define PPC_IN_USE       2
 
@@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
 		else
 			acpi_processor_ppc_ost(pr->handle, 0);
 	}
-	if (ret >= 0)
-		cpufreq_update_policy(pr->id);
+	if (ret >= 0) {
+		if (broadcast_ppc) {
+			int cpu;
+
+			for_each_possible_cpu(cpu)
+				cpufreq_update_policy(cpu);
+		} else {
+			cpufreq_update_policy(pr->id);
+		}
+	}
 }
 
 int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..95e08816b512 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
+	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
+	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
 	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..e1881313c396 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
 
 static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
+	int max_freq;
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
+	max_freq = intel_pstate_get_max_freq(cpu);
+
+	if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
+	    max_freq != policy->cpuinfo.max_freq) {
+		/*
+		 * System was not running under any constraints, but the
+		 * current max possible frequency is changed. So reset
+		 * policy limits.
+		 */
+		policy->cpuinfo.max_freq = policy->max = max_freq;
+	}
+
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     intel_pstate_get_max_freq(cpu));
+				     max_freq);
 
 	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
-- 
2.17.1

