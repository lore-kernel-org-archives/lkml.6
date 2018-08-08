Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DF921A18
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DF921A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeHHRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:42:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:19265 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHRmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:42:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 08:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="222982676"
Received: from otc-kbl-h-01.jf.intel.com ([10.54.55.131])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2018 08:21:54 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/3] perf/x86/intel: Add quirk for Goldmont Plus
Date:   Wed,  8 Aug 2018 00:12:08 -0700
Message-Id: <1533712328-2834-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
References: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A ucode patch is needed for Goldmont Plus while counter freezing feature
is enabled. Otherwise, there will be some issues, e.g. PMI flood with
some events.

Add a quirk to check microcode version. If the system starts with the
wrong ucode, leave the counter-freezing feature permanently disabled.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
 - Only check the microcode version on CPU 0 at initialization.

 arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fdd2f99..928a393 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3839,6 +3839,42 @@ static __init void intel_nehalem_quirk(void)
 	}
 }
 
+static bool intel_glp_counter_freezing_broken(int cpu)
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
+static __init void intel_glp_counter_freezing_quirk(void)
+{
+	/* Check if it's already disabled */
+	if (disable_counter_freezing)
+		return;
+
+	/*
+	 * If the system starts with the wrong ucode, leave the
+	 * counter-freezing feature permanently disabled.
+	 * Only checking one CPU is enough. When perf first initializes,
+	 * only CPU 0 is online.
+	 */
+	if (intel_glp_counter_freezing_broken(0)) {
+		pr_info("PMU counter freezing disabled due to CPU errata,"
+			"please upgrade microcode\n");
+		x86_pmu.counter_freezing = false;
+		x86_pmu.handle_irq = intel_pmu_handle_irq;
+	}
+}
+
 /*
  * enable software workaround for errata:
  * SNB: BJ122
@@ -4183,6 +4219,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+		x86_add_quirk(intel_glp_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
@@ -4199,6 +4236,8 @@ __init int intel_pmu_init(void)
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

