Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD089C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5FD21A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5FD21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbeHFTfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:35:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:31359 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbeHFTfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:35:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 10:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="62707862"
Received: from otc-kbl-h-01.jf.intel.com ([10.54.55.131])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2018 10:25:01 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/intel: Add quirk for Goldmont Plus
Date:   Mon,  6 Aug 2018 10:23:43 -0700
Message-Id: <1533576223-11588-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A ucode patch is needed for Goldmont Plus while counter freezing feature
is enabled. Otherwise, there will be some issues, e.g. PMI flood with
some events.

Add a quirk to check microcode version. Only enable counter freezing
feature on the machine with ucode patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 03778ce..10ab9a1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3847,6 +3847,58 @@ static __init void intel_nehalem_quirk(void)
 	}
 }
 
+static bool intel_glk_counter_freezing_broken(int cpu)
+{
+	u32 rev = UINT_MAX; /* default to broken for unknown stepping */
+
+	switch (cpu_data(cpu).x86_stepping) {
+	case 1:
+		rev = 0x28;
+		break;
+	case 8:
+		rev = 0x6;
+		break;
+	}
+
+	return (cpu_data(cpu).microcode < rev);
+}
+
+static void intel_glk_check_microcode(void)
+{
+	bool counter_freezing_broken = false;
+	int cpu;
+
+	if (disable_counter_freezing)
+		return;
+
+	for_each_online_cpu(cpu) {
+		counter_freezing_broken = intel_glk_counter_freezing_broken(cpu);
+		if (counter_freezing_broken)
+			break;
+	}
+
+	if (counter_freezing_broken == !x86_pmu.counter_freezing)
+		return;
+
+	if (x86_pmu.counter_freezing) {
+		pr_info("PMU counter freezing disabled due to CPU errata, please upgrade microcode\n");
+		x86_pmu.counter_freezing = false;
+		x86_pmu.handle_irq = intel_pmu_handle_irq;
+	} else {
+		pr_info("PMU counter freezing enabled due to microcode update\n");
+		x86_pmu.counter_freezing = true;
+		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
+	}
+}
+
+static __init void intel_counter_freezing_quirk(void)
+{
+	x86_pmu.check_microcode = intel_glk_check_microcode;
+	cpus_read_lock();
+	intel_glk_check_microcode();
+	cpus_read_unlock();
+}
+
 /*
  * enable software workaround for errata:
  * SNB: BJ122
@@ -4191,6 +4243,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
@@ -4207,6 +4260,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.counter_freezing = disable_counter_freezing ?
+					   false : true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
-- 
2.7.4

