Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36043222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438024AbfBNJoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:44:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:32197 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395245AbfBNJm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:42:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 01:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="124411732"
Received: from devel-ww.sh.intel.com ([10.239.48.128])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2019 01:42:53 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com, jmattson@google.com
Subject: [PATCH v5 04/12] KVM/x86: intel_pmu_lbr_enable
Date:   Thu, 14 Feb 2019 17:06:06 +0800
Message-Id: <1550135174-5423-5-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lbr stack is architecturally specific, for example, SKX has 32 lbr
stack entries while HSW has 16 entries, so a HSW guest running on a SKX
machine may not get accurate perf results. Currently, we forbid the
guest lbr enabling when the guest and host see different lbr stack
entries or the host and guest see different lbr stack msr indices.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kvm/cpuid.h         |   8 +++
 arch/x86/kvm/pmu.c           |   8 +++
 arch/x86/kvm/pmu.h           |   2 +
 arch/x86/kvm/vmx/pmu_intel.c | 136 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c           |   3 +-
 5 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 9a327d5..92bdc7d 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -123,6 +123,14 @@ static inline bool guest_cpuid_is_amd(struct kvm_vcpu *vcpu)
 	return best && best->ebx == X86EMUL_CPUID_VENDOR_AuthenticAMD_ebx;
 }
 
+static inline bool guest_cpuid_is_intel(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 0, 0);
+	return best && best->ebx == X86EMUL_CPUID_VENDOR_GenuineIntel_ebx;
+}
+
 static inline int guest_cpuid_family(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 58ead7d..b438ffa 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -299,6 +299,14 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	return 0;
 }
 
+bool kvm_pmu_lbr_enable(struct kvm_vcpu *vcpu)
+{
+	if (guest_cpuid_is_intel(vcpu))
+		return kvm_x86_ops->pmu_ops->lbr_enable(vcpu);
+
+	return false;
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu))
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ba8898e..5f3c7a4 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -28,6 +28,7 @@ struct kvm_pmu_ops {
 	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, unsigned idx);
 	int (*is_valid_msr_idx)(struct kvm_vcpu *vcpu, unsigned idx);
 	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
+	bool (*lbr_enable)(struct kvm_vcpu *vcpu);
 	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 	void (*refresh)(struct kvm_vcpu *vcpu);
@@ -106,6 +107,7 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel);
 void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int fixed_idx);
 void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx);
 
+bool kvm_pmu_lbr_enable(struct kvm_vcpu *vcpu);
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 5ab4a36..6728701 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -15,6 +15,7 @@
 #include <linux/kvm_host.h>
 #include <linux/perf_event.h>
 #include <asm/perf_event.h>
+#include <asm/intel-family.h>
 #include "x86.h"
 #include "cpuid.h"
 #include "lapic.h"
@@ -164,6 +165,140 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	return ret;
 }
 
+static bool intel_pmu_lbr_enable(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	u8 vcpu_model = guest_cpuid_model(vcpu);
+	unsigned int vcpu_lbr_from, vcpu_lbr_nr;
+
+	if (x86_perf_get_lbr_stack(&kvm->arch.lbr_stack))
+		return false;
+
+	if (guest_cpuid_family(vcpu) != boot_cpu_data.x86)
+		return false;
+
+	/*
+	 * It could be possible that people have vcpus of old model run on
+	 * physcal cpus of newer model, for example a BDW guest on a SKX
+	 * machine (but not possible to be the other way around).
+	 * The BDW guest may not get accurate results on a SKX machine as it
+	 * only reads 16 entries of the lbr stack while there are 32 entries
+	 * of recordings. We currently forbid the lbr enabling when the vcpu
+	 * and physical cpu see different lbr stack entries or the guest lbr
+	 * msr indices are not compatible with the host.
+	 */
+	switch (vcpu_model) {
+	case INTEL_FAM6_CORE2_MEROM:
+	case INTEL_FAM6_CORE2_MEROM_L:
+	case INTEL_FAM6_CORE2_PENRYN:
+	case INTEL_FAM6_CORE2_DUNNINGTON:
+		/* intel_pmu_lbr_init_core() */
+		vcpu_lbr_nr = 4;
+		vcpu_lbr_from = MSR_LBR_CORE_FROM;
+		break;
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_NEHALEM_EP:
+	case INTEL_FAM6_NEHALEM_EX:
+		/* intel_pmu_lbr_init_nhm() */
+		vcpu_lbr_nr = 16;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_ATOM_BONNELL:
+	case INTEL_FAM6_ATOM_BONNELL_MID:
+	case INTEL_FAM6_ATOM_SALTWELL:
+	case INTEL_FAM6_ATOM_SALTWELL_MID:
+	case INTEL_FAM6_ATOM_SALTWELL_TABLET:
+		/* intel_pmu_lbr_init_atom() */
+		vcpu_lbr_nr = 8;
+		vcpu_lbr_from = MSR_LBR_CORE_FROM;
+		break;
+	case INTEL_FAM6_ATOM_SILVERMONT:
+	case INTEL_FAM6_ATOM_SILVERMONT_X:
+	case INTEL_FAM6_ATOM_SILVERMONT_MID:
+	case INTEL_FAM6_ATOM_AIRMONT:
+	case INTEL_FAM6_ATOM_AIRMONT_MID:
+		/* intel_pmu_lbr_init_slm() */
+		vcpu_lbr_nr = 8;
+		vcpu_lbr_from = MSR_LBR_CORE_FROM;
+		break;
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:
+		/* intel_pmu_lbr_init_skl(); */
+		vcpu_lbr_nr = 32;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+		/* intel_pmu_lbr_init_skl()*/
+		vcpu_lbr_nr = 32;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_WESTMERE_EP:
+	case INTEL_FAM6_WESTMERE_EX:
+		/* intel_pmu_lbr_init_nhm() */
+		vcpu_lbr_nr = 16;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_SANDYBRIDGE_X:
+		/* intel_pmu_lbr_init_snb() */
+		vcpu_lbr_nr = 16;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_IVYBRIDGE:
+	case INTEL_FAM6_IVYBRIDGE_X:
+		/* intel_pmu_lbr_init_snb() */
+		vcpu_lbr_nr = 16;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_X:
+	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_GT3E:
+		/* intel_pmu_lbr_init_hsw() */
+		vcpu_lbr_nr = 16;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL_XEON_D:
+	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_X:
+		/* intel_pmu_lbr_init_hsw() */
+		vcpu_lbr_nr = 16;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_XEON_PHI_KNL:
+	case INTEL_FAM6_XEON_PHI_KNM:
+		/* intel_pmu_lbr_init_knl() */
+		vcpu_lbr_nr = 8;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_DESKTOP:
+		/* intel_pmu_lbr_init_skl() */
+		vcpu_lbr_nr = 32;
+		vcpu_lbr_from = MSR_LBR_NHM_FROM;
+		break;
+	default:
+		vcpu_lbr_nr = 0;
+		vcpu_lbr_from = 0;
+		pr_warn("%s: vcpu model not supported %d\n", __func__,
+			vcpu_model);
+	}
+
+	if (vcpu_lbr_nr != kvm->arch.lbr_stack.nr ||
+	    vcpu_lbr_from != kvm->arch.lbr_stack.from) {
+		pr_warn("%s: vcpu model %x incompatible to pcpu %x\n",
+			__func__, vcpu_model, boot_cpu_data.x86_model);
+		return false;
+	}
+
+	return true;
+}
+
 static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -350,6 +485,7 @@ struct kvm_pmu_ops intel_pmu_ops = {
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_msr_idx = intel_is_valid_msr_idx,
 	.is_valid_msr = intel_is_valid_msr,
+	.lbr_enable = intel_pmu_lbr_enable,
 	.get_msr = intel_pmu_get_msr,
 	.set_msr = intel_pmu_set_msr,
 	.refresh = intel_pmu_refresh,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2cdebe7..2a41aab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4565,8 +4565,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		break;
 	case KVM_CAP_X86_GUEST_LBR:
 		r = -EINVAL;
-		if (cap->args[0] &&
-		    x86_perf_get_lbr_stack(&kvm->arch.lbr_stack)) {
+		if (cap->args[0] && !kvm_pmu_lbr_enable(kvm->vcpus[0])) {
 			pr_err("Failed to enable the guest lbr feature\n");
 			break;
 		}
-- 
2.7.4

