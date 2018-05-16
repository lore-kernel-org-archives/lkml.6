Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeEPEvR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:51:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:1168 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbeEPEtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300342"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional frequency invariant accounting
Date: Tue, 15 May 2018 21:49:03 -0700
Message-Id: <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pstate has two operating modes: active and passive. In "active"
mode, the in-built scaling governor is used and in "passive" mode,
the driver can be used with any governor like "schedutil". In "active"
mode the utilization values from schedutil is not used and there is
a requirement from high performance computing use cases, not to read
any APERF/MPERF MSRs. In this case no need to use CPU cycles for
frequency invariant accounting by reading APERF/MPERF MSRs.
With this change frequency invariant account is only enabled in
"passive" mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
[Note: The tick will be enabled later in the series when hwp dynamic
boost is enabled]

 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17e566af..f686bbe 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2040,6 +2040,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
 	int ret;
 
+	x86_arch_scale_freq_tick_disable();
+
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
 
@@ -2052,6 +2054,9 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	global.min_perf_pct = min_perf_pct_min();
 
+	if (driver == &intel_cpufreq)
+		x86_arch_scale_freq_tick_enable();
+
 	return 0;
 }
 
-- 
2.9.5
