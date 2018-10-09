Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E7C65BD7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B921479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0B921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJJFFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:05:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:15631 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeJJFFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:05:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 14:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,361,1534834800"; 
   d="scan'208";a="81248624"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2018 14:46:52 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        erik.schmauss@intel.com, viresh.kumar@linaro.org
Cc:     pprakash@codeaurora.org, george.cherian@cavium.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Add base_frequency attribute
Date:   Tue,  9 Oct 2018 14:46:33 -0700
Message-Id: <20181009214633.16390-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
References: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Present base_frequency to user space via cpufreq sysfs when HWP is in
use.

This HWP base frequency is read from HWP Capabilities MSR, if platform
doesn't have ACPI _CPC object. On most of the HWP platforms the _CPC
object will point to the HWP Capabilities MSR using address space id as
"Functional Fixed Hardware". But the address space id can be simply
ACPI_TYPE_INTEGER, where the platform firmware can modify this value
based on the system constraints.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b6a1aadaff9f..2a99e2fd9412 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -373,10 +373,28 @@ static void intel_pstate_set_itmt_prio(int cpu)
 		}
 	}
 }
+
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	struct cppc_perf_caps cppc_perf;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	return cppc_perf.guaranteed_perf;
+}
+
 #else
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
+
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
@@ -699,9 +717,29 @@ static ssize_t show_energy_performance_preference(
 
 cpufreq_freq_attr_rw(energy_performance_preference);
 
+static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
+{
+	struct cpudata *cpu;
+	u64 cap;
+	int ratio;
+
+	ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
+	if (ratio <= 0) {
+		rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
+		ratio = HWP_GUARANTEED_PERF(cap);
+	}
+
+	cpu = all_cpu_data[policy->cpu];
+
+	return sprintf(buf, "%d\n", ratio * cpu->pstate.scaling);
+}
+
+cpufreq_freq_attr_ro(base_frequency);
+
 static struct freq_attr *hwp_cpufreq_attrs[] = {
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
+	&base_frequency,
 	NULL,
 };
 
-- 
2.17.1

