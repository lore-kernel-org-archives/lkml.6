Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3F7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7A62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeGRWcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:32:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:45013 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeGRWcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:32:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 14:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="57952200"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2018 14:52:22 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Show different max frequency with turbo 3 and HWP
Date:   Wed, 18 Jul 2018 14:51:59 -0700
Message-Id: <20180718215159.28698-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HWP platforms with Turbo 3.0, the HWP capability max ratio shows the
maximum ratio of that core, which can be different than other cores. If
we show the correct maximum frequency in cpufreq sysfs via
cpuinfo_max_freq and scaling_max_freq then, user can know which cores
can run faster for pinning some high priority tasks.

Currently the max turbo frequency is shown as max frequency, which is
the max of all cores, even if some cores can't reach that frequency
even for single threaded workload.

But it is possible that max ratio in HWP capabilities is set as 0xFF or
some high invalid value (E.g. One KBL NUC). Since the actual performance
can never exceed 1 core turbo frequency from MSR TURBO_RATIO_LIMIT, we
use this as a bound check.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ece120da3353..97096127d015 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2072,6 +2072,15 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
 
+	if (hwp_active) {
+		unsigned int max_freq;
+
+		max_freq = global.turbo_disabled ?
+			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+		if (max_freq < policy->cpuinfo.max_freq)
+			policy->cpuinfo.max_freq = max_freq;
+	}
+
 	intel_pstate_init_acpi_perf_limits(policy);
 
 	policy->fast_switch_possible = true;
-- 
2.17.0

