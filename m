Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5BE2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeLZKBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:01:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:3456 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbeLZKA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:00:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 02:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="112107157"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga008.fm.intel.com with ESMTP; 26 Dec 2018 02:00:55 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com
Subject: [PATCH v4 08/10] perf/x86: save/restore LBR_SELECT on vCPU switching
Date:   Wed, 26 Dec 2018 17:25:36 +0800
Message-Id: <1545816338-1171-9-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vCPU lbr event relies on the host to save/restore all the lbr
related MSRs. So add the LBR_SELECT save/restore to the related
functions for the vCPU case.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 7 +++++++
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1d20051..0225ac9 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -383,6 +383,9 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
 	task_ctx->lbr_stack_state = LBR_NONE;
+
+	if (cpuc->vcpu_lbr)
+		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
@@ -409,6 +412,10 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
 			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
 	}
+
+	if (cpuc->vcpu_lbr)
+		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
+
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
 	task_ctx->lbr_stack_state = LBR_VALID;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bbea559..ccd0215 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -653,6 +653,7 @@ struct x86_perf_task_context {
 	u64 lbr_from[MAX_LBR_ENTRIES];
 	u64 lbr_to[MAX_LBR_ENTRIES];
 	u64 lbr_info[MAX_LBR_ENTRIES];
+	u64 lbr_sel;
 	int tos;
 	int valid_lbrs;
 	int lbr_callstack_users;
-- 
2.7.4

