Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9461C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786AC2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeLZKBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:01:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:3472 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbeLZKBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:01:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 02:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="112107173"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga008.fm.intel.com with ESMTP; 26 Dec 2018 02:00:59 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com
Subject: [PATCH v4 10/10] KVM/x86/lbr: lazy save the guest lbr stack
Date:   Wed, 26 Dec 2018 17:25:38 +0800
Message-Id: <1545816338-1171-11-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
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
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/kvm_host.h |   4 ++
 arch/x86/kvm/pmu.h              |   5 ++
 arch/x86/kvm/vmx.c              | 138 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fac209b..7f91eac 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -775,6 +775,10 @@ struct kvm_vcpu_arch {
 
 	/* Flush the L1 Data cache for L1TF mitigation on VMENTER */
 	bool l1tf_flush_l1d;
+	/* Indicate if the guest is using lbr with the user callstack mode */
+	bool lbr_user_callstack;
+	/* Indicate if the lbr msrs were accessed in this vCPU time slice */
+	bool lbr_used;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index efd8f16..c1fed24 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -103,6 +103,11 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 	return NULL;
 }
 
+static inline bool intel_pmu_save_vcpu_lbr_enabled(struct kvm_vcpu *vcpu)
+{
+	return !!vcpu_to_pmu(vcpu)->vcpu_lbr_event;
+}
+
 void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel);
 void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int fixed_idx);
 void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ee02967..80ec3f4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1310,6 +1310,9 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
+static void
+__always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap, u32 msr,
+					  int type, bool value);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -4088,6 +4091,121 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 	return 0;
 }
 
+static void vmx_set_intercept_for_lbr_msrs(struct kvm_vcpu *vcpu, bool set)
+{
+	unsigned long *msr_bitmap = to_vmx(vcpu)->vmcs01.msr_bitmap;
+	struct x86_perf_lbr_stack *stack = &vcpu->kvm->arch.lbr_stack;
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
+	struct x86_perf_lbr_stack *stack = &vcpu->kvm->arch.lbr_stack;
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
+	if (!vcpu->kvm->arch.lbr_in_guest)
+		return false;
+
+	if (set)
+		ret = guest_set_lbr_msr(vcpu, msr_info);
+	else
+		ret = guest_get_lbr_msr(vcpu, msr_info);
+
+	if (ret && !vcpu->arch.lbr_used) {
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
+
 /*
  * Reads an msr value (of 'msr_index') into 'pdata'.
  * Returns 0 on success, non-0 otherwise.
@@ -4179,6 +4297,8 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = msr->data;
 			break;
 		}
+		if (guest_access_lbr_msr(vcpu, msr_info, false))
+			break;
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
 
@@ -4375,6 +4495,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			}
 			break;
 		}
+		if (guest_access_lbr_msr(vcpu, msr_info, true))
+			break;
 		ret = kvm_set_msr_common(vcpu, msr_info);
 	}
 
@@ -11515,6 +11637,7 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 
 	if (enable_pml)
 		vmx_destroy_pml_buffer(vmx);
+	intel_pmu_disable_save_guest_lbr(vcpu);
 	free_vpid(vmx->vpid);
 	leave_guest_mode(vcpu);
 	vmx_free_vcpu_nested(vcpu);
@@ -14422,6 +14545,21 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	if (!kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
+
+	if (vcpu->arch.lbr_used) {
+		vcpu->arch.lbr_used = false;
+		vmx_set_intercept_for_lbr_msrs(vcpu, true);
+	} else if (intel_pmu_save_vcpu_lbr_enabled(vcpu)) {
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

