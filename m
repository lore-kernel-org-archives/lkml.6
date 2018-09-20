Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A08ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAEA21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAEA21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbeITQUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:20:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:59584 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387615AbeITQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:19:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 03:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74796183"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 03:36:43 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: [PATCH v3 5/5] KVM/x86/lbr: lazy save the guest lbr stack
Date:   Thu, 20 Sep 2018 18:05:59 +0800
Message-Id: <1537437959-8751-6-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the vCPU is scheduled in:
- if the lbr feature was used in the last vCPU time slice, set the lbr
  stack to be interceptible, so that the host can capture whether the
  lbr feature will be used in this time slice;
- if the lbr feature wasn't used in the last vCPU time slice, disable
  the vCPU support of the guest lbr switching.

Upon the first access to one of the lbr related MSRs (since the vCPU was
scheduled in):
- record that the guest has used the lbr;
- create a host perf event to help save/restore the guest lbr stack if
  the guest uses the user callstack mode lbr stack;
- pass the stack through to the guest.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c       |  16 +++++
 arch/x86/include/asm/kvm_host.h   |   4 ++
 arch/x86/include/asm/perf_event.h |   6 ++
 arch/x86/kvm/pmu.h                |   5 ++
 arch/x86/kvm/vmx.c                | 137 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 915fcc3..a260015 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -64,6 +64,7 @@ static const enum {
 #define LBR_NO_INFO	(1ULL << LBR_NO_INFO_BIT)
 
 #define LBR_PLM (LBR_KERNEL | LBR_USER)
+#define LBR_USER_CALLSTACK (LBR_CALL_STACK | LBR_USER)
 
 #define LBR_SEL_MASK	0x3ff	/* valid bits in LBR_SELECT */
 #define LBR_NOT_SUPP	-1	/* LBR filter not supported */
@@ -1283,6 +1284,21 @@ void intel_pmu_lbr_init_knl(void)
 }
 
 /**
+ * lbr_select_user_callstack - check if the user callstack mode is set
+ *
+ * @lbr_select: the lbr select msr
+ *
+ * Returns: true if the msr is configured to the user callstack mode.
+ * Otherwise, false.
+ *
+ */
+bool lbr_select_user_callstack(u64 lbr_select)
+{
+	return !!(lbr_select & LBR_USER_CALLSTACK);
+}
+EXPORT_SYMBOL_GPL(lbr_select_user_callstack);
+
+/**
  * perf_get_lbr_stack - get the lbr stack related MSRs
  *
  * @stack: the caller's memory to get the lbr stack
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fdcac01..41b4d29 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -730,6 +730,10 @@ struct kvm_vcpu_arch {
 
 	/* Flush the L1 Data cache for L1TF mitigation on VMENTER */
 	bool l1tf_flush_l1d;
+	/* Indicate if the guest is using lbr with the user callstack mode */
+	bool lbr_user_callstack;
+	/* Indicate if the lbr msrs were accessed in this vCPU time slice */
+	bool lbr_used;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index e893a69..2d7ae55 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -277,6 +277,7 @@ struct perf_lbr_stack {
 	unsigned long	info;
 };
 
+extern bool lbr_select_user_callstack(u64 msr_lbr_select);
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern int perf_get_lbr_stack(struct perf_lbr_stack *stack);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
@@ -288,6 +289,11 @@ static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 	return NULL;
 }
 
+static bool lbr_select_user_callstack(u64 msr_lbr_select)
+{
+	return false;
+}
+
 static inline int perf_get_lbr_stack(struct perf_lbr_stack *stack)
 {
 	return -1;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e872aed..94f0624 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -102,6 +102,11 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 	return NULL;
 }
 
+static inline bool intel_pmu_save_guest_lbr_enabled(struct kvm_vcpu *vcpu)
+{
+	return !!vcpu_to_pmu(vcpu)->guest_lbr_event;
+}
+
 void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel);
 void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int fixed_idx);
 void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 92705b5..ae20563 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1282,6 +1282,9 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
+static void
+__always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap, u32 msr,
+					  int type, bool value);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -4056,6 +4059,120 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 	return 0;
 }
 
+static void vmx_set_intercept_for_lbr_msrs(struct kvm_vcpu *vcpu, bool set)
+{
+	unsigned long *msr_bitmap = to_vmx(vcpu)->vmcs01.msr_bitmap;
+	struct perf_lbr_stack *stack = &vcpu->kvm->arch.lbr_stack;
+	int nr = stack->nr;
+	int i;
+
+	vmx_set_intercept_for_msr(msr_bitmap, stack->tos, MSR_TYPE_RW, set);
+	for (i = 0; i < nr; i++) {
+		vmx_set_intercept_for_msr(msr_bitmap, stack->from + i,
+					  MSR_TYPE_RW, set);
+		vmx_set_intercept_for_msr(msr_bitmap, stack->to + i,
+					  MSR_TYPE_RW, set);
+		if (stack->info)
+			vmx_set_intercept_for_msr(msr_bitmap, stack->info + i,
+						  MSR_TYPE_RW, set);
+	}
+}
+
+static inline bool msr_is_lbr_stack(struct kvm_vcpu *vcpu, u32 index)
+{
+	struct perf_lbr_stack *stack = &vcpu->kvm->arch.lbr_stack;
+	int nr = stack->nr;
+
+	return !!(index == stack->tos ||
+		 (index >= stack->from && index < stack->from + nr) ||
+		 (index >= stack->to && index < stack->to + nr) ||
+		 (index >= stack->info && index < stack->info));
+}
+
+static bool guest_get_lbr_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	u32 index = msr_info->index;
+	bool ret = false;
+
+	switch (index) {
+	case MSR_IA32_DEBUGCTLMSR:
+		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		ret = true;
+		break;
+	case MSR_LBR_SELECT:
+		ret = true;
+		rdmsrl(index, msr_info->data);
+		break;
+	default:
+		if (msr_is_lbr_stack(vcpu, index)) {
+			ret = true;
+			rdmsrl(index, msr_info->data);
+		}
+	}
+
+	return ret;
+}
+
+static bool guest_set_lbr_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	u32 index = msr_info->index;
+	u64 data = msr_info->data;
+	bool ret = false;
+
+	switch (index) {
+	case MSR_IA32_DEBUGCTLMSR:
+		ret = true;
+		/*
+		 * Currently, only FREEZE_LBRS_ON_PMI and DEBUGCTLMSR_LBR are
+		 * supported.
+		 */
+		data &= (DEBUGCTLMSR_FREEZE_LBRS_ON_PMI | DEBUGCTLMSR_LBR);
+		vmcs_write64(GUEST_IA32_DEBUGCTL, msr_info->data);
+		break;
+	case MSR_LBR_SELECT:
+		ret = true;
+		if (lbr_select_user_callstack(data))
+			vcpu->arch.lbr_user_callstack = true;
+		else
+			vcpu->arch.lbr_user_callstack = false;
+		wrmsrl(index, msr_info->data);
+		break;
+	default:
+		if (msr_is_lbr_stack(vcpu, index)) {
+			ret = true;
+			wrmsrl(index, msr_info->data);
+		}
+	}
+
+	return ret;
+}
+
+static bool guest_access_lbr_msr(struct kvm_vcpu *vcpu,
+				 struct msr_data *msr_info,
+				 bool set)
+{
+	bool ret = false;
+
+	if (!vcpu->kvm->arch.guest_lbr_enabled)
+		return false;
+
+	if (set)
+		ret = guest_set_lbr_msr(vcpu, msr_info);
+	else
+		ret = guest_get_lbr_msr(vcpu, msr_info);
+
+	if (ret) {
+		vcpu->arch.lbr_used = true;
+		vmx_set_intercept_for_lbr_msrs(vcpu, false);
+		if (vcpu->arch.lbr_user_callstack)
+			intel_pmu_enable_save_guest_lbr(vcpu);
+		else
+			intel_pmu_disable_save_guest_lbr(vcpu);
+	}
+
+	return ret;
+}
+
 /*
  * Reads an msr value (of 'msr_index') into 'pdata'.
  * Returns 0 on success, non-0 otherwise.
@@ -4147,6 +4264,8 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = msr->data;
 			break;
 		}
+		if (guest_access_lbr_msr(vcpu, msr_info, false))
+			break;
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
 
@@ -4341,6 +4460,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			}
 			break;
 		}
+		if (guest_access_lbr_msr(vcpu, msr_info, true))
+			break;
 		ret = kvm_set_msr_common(vcpu, msr_info);
 	}
 
@@ -10946,6 +11067,7 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 
 	if (enable_pml)
 		vmx_destroy_pml_buffer(vmx);
+	intel_pmu_disable_save_guest_lbr(vcpu);
 	free_vpid(vmx->vpid);
 	leave_guest_mode(vcpu);
 	vmx_free_vcpu_nested(vcpu);
@@ -13488,6 +13610,21 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	if (!kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
+
+	if (vcpu->arch.lbr_used) {
+		vcpu->arch.lbr_used = false;
+		vmx_set_intercept_for_lbr_msrs(vcpu, true);
+	} else if (intel_pmu_save_guest_lbr_enabled(vcpu)) {
+		u64 guest_debugctl;
+
+		/*
+		 * The lbr feature wasn't used during that last vCPU time
+		 * slice, so it's time to disable the vCPU side save/restore.
+		 */
+		guest_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		if (!(guest_debugctl & DEBUGCTLMSR_LBR))
+			intel_pmu_disable_save_guest_lbr(vcpu);
+	}
 }
 
 static void vmx_slot_enable_log_dirty(struct kvm *kvm,
-- 
2.7.4

