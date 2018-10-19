Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E9ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7160E2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7160E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJTBMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:12:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:33478 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbeJTBMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:12:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 10:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="79349734"
Received: from otc-cfl-s-03.jf.intel.com ([10.54.55.152])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2018 10:05:32 -0700
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/uncore: Support CoffeeLake 8th CBOX
Date:   Fri, 19 Oct 2018 10:04:19 -0700
Message-Id: <20181019170419.378-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181019170419.378-1-kan.liang@linux.intel.com>
References: <20181019170419.378-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Coffee Lake has 8 core product which has 8 Cboxes. The 8th CBOX is
mapped into different MSR space.

Increase the num_boxes to 8 to handle the new products. It will not
impact the previous platforms, SkyLake, KabyLake and earlier CoffeeLake.
Because the num_boxes will be recalculated in uncore_cpu_init and
doesn't exceed the x86_max_cores.

Introduce a new box flag bit to indicate the 8th CBOX.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.h     | 33 ++++++++++++++++++++++--------
 arch/x86/events/intel/uncore_snb.c |  6 +++++-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e17ab885b1e9..cb46d602a6b8 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -129,8 +129,15 @@ struct intel_uncore_box {
 	struct intel_uncore_extra_reg shared_regs[0];
 };
 
-#define UNCORE_BOX_FLAG_INITIATED	0
-#define UNCORE_BOX_FLAG_CTL_OFFS8	1 /* event config registers are 8-byte apart */
+/* CFL uncore 8th cbox MSRs */
+#define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
+#define CFL_UNC_CBO_7_PER_CTR0			0xf76
+
+#define UNCORE_BOX_FLAG_INITIATED		0
+/* event config registers are 8-byte apart */
+#define UNCORE_BOX_FLAG_CTL_OFFS8		1
+/* CFL 8th CBOX has different MSR space */
+#define UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS	2
 
 struct uncore_event_desc {
 	struct kobj_attribute attr;
@@ -297,17 +304,27 @@ unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 static inline
 unsigned uncore_msr_event_ctl(struct intel_uncore_box *box, int idx)
 {
-	return box->pmu->type->event_ctl +
-		(box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
-		uncore_msr_box_offset(box);
+	if (test_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags)) {
+		return CFL_UNC_CBO_7_PERFEVTSEL0 +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx);
+	} else {
+		return box->pmu->type->event_ctl +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
+		       uncore_msr_box_offset(box);
+	}
 }
 
 static inline
 unsigned uncore_msr_perf_ctr(struct intel_uncore_box *box, int idx)
 {
-	return box->pmu->type->perf_ctr +
-		(box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
-		uncore_msr_box_offset(box);
+	if (test_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags)) {
+		return CFL_UNC_CBO_7_PER_CTR0 +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx);
+	} else {
+		return box->pmu->type->perf_ctr +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
+		       uncore_msr_box_offset(box);
+	}
 }
 
 static inline
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index bfa25814fe5f..2593b0d7aeee 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -221,6 +221,10 @@ static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
 		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL,
 			SNB_UNC_GLOBAL_CTL_EN | SKL_UNC_GLOBAL_CTL_CORE_ALL);
 	}
+
+	/* The 8th CBOX has different MSR space */
+	if (box->pmu->pmu_idx == 7)
+		__set_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags);
 }
 
 static void skl_uncore_msr_enable_box(struct intel_uncore_box *box)
@@ -247,7 +251,7 @@ static struct intel_uncore_ops skl_uncore_msr_ops = {
 static struct intel_uncore_type skl_uncore_cbox = {
 	.name		= "cbox",
 	.num_counters   = 4,
-	.num_boxes	= 5,
+	.num_boxes	= 8,
 	.perf_ctr_bits	= 44,
 	.fixed_ctr_bits	= 48,
 	.perf_ctr	= SNB_UNC_CBO_0_PER_CTR0,
-- 
2.17.1

