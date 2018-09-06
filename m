Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E8F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeIFQgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:36:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:62812 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:36:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 05:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="71046882"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2018 05:01:00 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com
Subject: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for lbr stack save/restore
Date:   Thu,  6 Sep 2018 19:30:54 +0800
Message-Id: <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an interface to enable a guest to request KVM to save
and restore the lbr stack on vCPU context switching.

KVM couldn't capture the info about whether the guest is actively using
the lbr feature via the lbr enable bit in the debugctl MSR, because that
control bit is frequently enabled and disabled by the guest, and in some
csaes, it is disabled even when the guest is actively using the lbr
feature. For example, perf_pmu_sched_task in the guest disables the bit
before reading out the lbr stack. In this case, the bit is disabled though
the guest is still using the lbr feature.

So, a KVM-specific MSR, MSR_KVM_PV_LBR_CTRL, is used by the guest at a
proper place to tell KVM if the LBR is actively in use or not. Basically,
the lbr user callstack mode needs the lbr stack to be saved/restored on a
context switching, so we set the ACTIVE bit of MSR_KVM_PV_LBR_CTRL only
when the user callstack mode is used. The KVM hypervisor will add the lbr
stack save/restore support on vCPU switching after the ACTIVE bit is set.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c          | 21 +++++++++++++++++++++
 arch/x86/include/asm/perf_event.h    |  3 +++
 arch/x86/include/uapi/asm/kvm_para.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7c3958e..50921d3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <linux/kvm_para.h>
 
 #include <asm/perf_event.h>
 #include <asm/msr.h>
@@ -454,6 +455,24 @@ static inline bool branch_user_callstack(unsigned br_sel)
 	return (br_sel & X86_BR_USER) && (br_sel & X86_BR_CALL_STACK);
 }
 
+static inline void set_pv_lbr_ctrl_active(bool active)
+{
+	u64 lbr_ctrl_old, lbr_ctrl_new;
+
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
+	    !kvm_para_has_feature(KVM_FEATURE_PV_LBR_CTRL))
+		return;
+
+	rdmsrl(MSR_KVM_PV_LBR_CTRL, lbr_ctrl_old);
+	if (active)
+		lbr_ctrl_new = lbr_ctrl_old | KVM_PV_LBR_CTRL_ACTIVE;
+	else
+		lbr_ctrl_new = lbr_ctrl_old & ~KVM_PV_LBR_CTRL_ACTIVE;
+
+	if (lbr_ctrl_new != lbr_ctrl_old)
+		wrmsrl(MSR_KVM_PV_LBR_CTRL, lbr_ctrl_new);
+}
+
 void intel_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -467,6 +486,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
 		task_ctx = event->ctx->task_ctx_data;
 		task_ctx->lbr_callstack_users++;
+		set_pv_lbr_ctrl_active(true);
 	}
 
 	/*
@@ -505,6 +525,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	    event->ctx->task_ctx_data) {
 		task_ctx = event->ctx->task_ctx_data;
 		task_ctx->lbr_callstack_users--;
+		set_pv_lbr_ctrl_active(false);
 	}
 
 	cpuc->lbr_users--;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 161165f..9fb0f7e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -162,6 +162,9 @@ struct x86_pmu_capability {
  */
 #define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
 
+/* Indicate to the hypervisor that the guest LBR is active */
+#define KVM_PV_LBR_CTRL_ACTIVE		(1UL << 0)
+
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
 #define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 19980ec..87764dd 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -29,6 +29,7 @@
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 #define KVM_FEATURE_PV_SEND_IPI	11
+#define KVM_FEATURE_PV_LBR_CTRL	12
 
 #define KVM_HINTS_REALTIME      0
 
@@ -47,6 +48,7 @@
 #define MSR_KVM_ASYNC_PF_EN 0x4b564d02
 #define MSR_KVM_STEAL_TIME  0x4b564d03
 #define MSR_KVM_PV_EOI_EN      0x4b564d04
+#define MSR_KVM_PV_LBR_CTRL    0x4b564d05
 
 struct kvm_steal_time {
 	__u64 steal;
-- 
2.7.4

