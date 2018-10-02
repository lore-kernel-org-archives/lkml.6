Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79EAC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A03620652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A03620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJCEQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:16:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:9943 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeJCEQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:16:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 14:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,333,1534834800"; 
   d="scan'208";a="262326682"
Received: from otc-kbl-h-01.jf.intel.com ([10.54.55.131])
  by orsmga005.jf.intel.com with ESMTP; 02 Oct 2018 14:30:50 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Add counter freezing quirk for Goldmont
Date:   Tue,  2 Oct 2018 14:30:12 -0700
Message-Id: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A ucode patch is also needed for Goldmont while counter freezing feature
is enabled. Otherwise, there will be some issues, e.g. PMI lost.

Add a quirk to check microcode version. If the system starts with the
wrong ucode, leave the counter-freezing feature permanently disabled.

The quirk function for Goldmont is similar as Goldmont Plus. Reuse the
quirk function and rename it to atom_v4.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ab01ef9..56401bc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3839,23 +3839,48 @@ static __init void intel_nehalem_quirk(void)
 	}
 }
 
-static bool intel_glp_counter_freezing_broken(int cpu)
+static bool intel_atom_v4_counter_freezing_broken(int cpu)
 {
 	u32 rev = UINT_MAX; /* default to broken for unknown stepping */
 
-	switch (cpu_data(cpu).x86_stepping) {
-	case 1:
-		rev = 0x28;
+	switch (cpu_data(cpu).x86_model) {
+	case INTEL_FAM6_ATOM_GOLDMONT:
+		switch (cpu_data(cpu).x86_stepping) {
+		case 2:
+			rev = 0xe;
+			break;
+		case 9:
+			rev = 0x2e;
+			break;
+		case 10:
+			rev = 0x8;
+			break;
+		}
 		break;
-	case 8:
-		rev = 0x6;
+
+	case INTEL_FAM6_ATOM_GOLDMONT_X:
+		switch (cpu_data(cpu).x86_stepping) {
+		case 1:
+			rev = 0x1a;
+			break;
+		}
 		break;
+
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+		switch (cpu_data(cpu).x86_stepping) {
+		case 1:
+			rev = 0x28;
+			break;
+		case 8:
+			rev = 0x6;
+			break;
+		}
 	}
 
 	return (cpu_data(cpu).microcode < rev);
 }
 
-static __init void intel_glp_counter_freezing_quirk(void)
+static __init void intel_atom_v4_counter_freezing_quirk(void)
 {
 	/* Check if it's already disabled */
 	if (disable_counter_freezing)
@@ -3865,7 +3890,7 @@ static __init void intel_glp_counter_freezing_quirk(void)
 	 * If the system starts with the wrong ucode, leave the
 	 * counter-freezing feature permanently disabled.
 	 */
-	if (intel_glp_counter_freezing_broken(raw_smp_processor_id())) {
+	if (intel_atom_v4_counter_freezing_broken(raw_smp_processor_id())) {
 		pr_info("PMU counter freezing disabled due to CPU errata,"
 			"please upgrade microcode\n");
 		x86_pmu.counter_freezing = false;
@@ -4196,6 +4221,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_X:
+		x86_add_quirk(intel_atom_v4_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
@@ -4222,7 +4248,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-		x86_add_quirk(intel_glp_counter_freezing_quirk);
+		x86_add_quirk(intel_atom_v4_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
-- 
2.7.4

