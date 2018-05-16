Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeEPEtg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:49:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:1168 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbeEPEtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300353"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 10/10] cpufreq: intel_pstate: enable boost for SKX
Date: Tue, 15 May 2018 21:49:11 -0700
Message-Id: <20180516044911.28797-11-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HWP boost on Skylake server platform.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 65d11d2..827c003 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1863,6 +1863,11 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 	{}
 };
 
+static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst = {
+	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
+	{}
+};
+
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
@@ -1893,6 +1898,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
+
+		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
+		if (id)
+			hwp_boost = true;
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
-- 
2.9.5
