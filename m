Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50214C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216CB20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBDWYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:24:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:2736 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfBDWYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:24:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 14:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="135878811"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2019 14:24:31 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 4/5] perf/x86/intel: Clean up counter freezing quirk
Date:   Mon,  4 Feb 2019 14:23:32 -0800
Message-Id: <1549319013-4522-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
References: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Clean up counter freezing quirk to use the new facility to check for
min microcode revisions.

Rename the counter freezing quirk related functions. Because other
platforms, e.g. Goldmont, also needs to call the quirk.

Only check the boot CPU, assuming models and features are consistent
over all CPUs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V6

 arch/x86/events/intel/core.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 23672d5..f59be79 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3917,23 +3917,18 @@ static __init void intel_nehalem_quirk(void)
 	}
 }
 
-static bool intel_glp_counter_freezing_broken(int cpu)
-{
-	u32 rev = UINT_MAX; /* default to broken for unknown stepping */
-
-	switch (cpu_data(cpu).x86_stepping) {
-	case 1:
-		rev = 0x28;
-		break;
-	case 8:
-		rev = 0x6;
-		break;
-	}
+static const struct x86_cpu_desc counter_freezing_ucodes[] = {
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	8, 0x00000006),
+	{}
+};
 
-	return (cpu_data(cpu).microcode < rev);
+static bool intel_counter_freezing_broken(void)
+{
+	return !x86_cpu_has_min_microcode_rev(counter_freezing_ucodes);
 }
 
-static __init void intel_glp_counter_freezing_quirk(void)
+static __init void intel_counter_freezing_quirk(void)
 {
 	/* Check if it's already disabled */
 	if (disable_counter_freezing)
@@ -3943,7 +3938,7 @@ static __init void intel_glp_counter_freezing_quirk(void)
 	 * If the system starts with the wrong ucode, leave the
 	 * counter-freezing feature permanently disabled.
 	 */
-	if (intel_glp_counter_freezing_broken(raw_smp_processor_id())) {
+	if (intel_counter_freezing_broken()) {
 		pr_info("PMU counter freezing disabled due to CPU errata,"
 			"please upgrade microcode\n");
 		x86_pmu.counter_freezing = false;
@@ -4320,7 +4315,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-		x86_add_quirk(intel_glp_counter_freezing_quirk);
+		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
-- 
2.7.4

