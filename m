Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24997C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB582075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB582075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIFQgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:36:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:62802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeIFQgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:36:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 05:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="71046721"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2018 05:00:49 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com
Subject: [PATCH v2 1/8] perf/x86: add a function to get the lbr stack
Date:   Thu,  6 Sep 2018 19:30:49 +0800
Message-Id: <1536233456-12173-2-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LBR stack MSRs are architecturally specific. The perf subsystem has
already assigned the abstracted MSR values based on the CPU architecture.

This patch enables a caller outside the perf subsystem to get the LBR
stack info. This is useful for hyperviosrs to prepare the lbr feature
for the guest.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c       | 23 +++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h | 14 ++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f3e006b..7c3958e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1273,3 +1273,26 @@ void intel_pmu_lbr_init_knl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
 }
+
+/**
+ * perf_get_lbr_stack - get the lbr stack related MSRs
+ *
+ * @stack: the caller's memory to get the lbr stack
+ *
+ * Returns: 0 indicates that the lbr stack has been successfully obtained.
+ */
+int perf_get_lbr_stack(struct perf_lbr_stack *stack)
+{
+	stack->lbr_nr = x86_pmu.lbr_nr;
+	stack->lbr_tos = x86_pmu.lbr_tos;
+	stack->lbr_from = x86_pmu.lbr_from;
+	stack->lbr_to = x86_pmu.lbr_to;
+
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+		stack->lbr_info = MSR_LBR_INFO_0;
+	else
+		stack->lbr_info = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(perf_get_lbr_stack);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f5408..f40e80a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -267,7 +267,16 @@ struct perf_guest_switch_msr {
 	u64 host, guest;
 };
 
+struct perf_lbr_stack {
+	int		lbr_nr;
+	unsigned long	lbr_tos;
+	unsigned long	lbr_from;
+	unsigned long	lbr_to;
+	unsigned long	lbr_info;
+};
+
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
+extern int perf_get_lbr_stack(struct perf_lbr_stack *stack);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
 #else
@@ -277,6 +286,11 @@ static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 	return NULL;
 }
 
+static inline int perf_get_lbr_stack(struct perf_lbr_stack *stack)
+{
+	return -1;
+}
+
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	memset(cap, 0, sizeof(*cap));
-- 
2.7.4

