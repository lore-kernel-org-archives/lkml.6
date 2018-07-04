Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA56BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3622414
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B3622414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGDNG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:06:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:10905 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeGDNG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:06:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 06:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="52592619"
Received: from dst.sh.intel.com ([10.239.48.156])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2018 06:06:55 -0700
From:   Jingqi Liu <jingqi.liu@intel.com>
To:     pbonzini@redhat.com
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, wei.w.wang@intel.com,
        Jingqi Liu <jingqi.liu@intel.com>
Subject: [PATCH v2] KVM: Expose the split lock detection feature to guest VM
Date:   Wed,  4 Jul 2018 21:06:33 +0800
Message-Id: <1530709593-87702-1-git-send-email-jingqi.liu@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new control bit(bit 29) in the TEST_CTRL MSR will be introduced
to enable detection of split locks.

When bit 29 of the TEST_CTRL(33H) MSR is set, the processor
causes an #AC exception to be issued instead of suppressing LOCK on
bus(during split lock access). A previous control bit (bit 31)
in this MSR causes the processor to disable LOCK# assertion for
split locked accesses when set. When bits 29 and 31 are both set,
bit 29 takes precedence.

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf
This patch has a dependency on https://lkml.org/lkml/2018/5/27/78.

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx.c              | 77 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              | 10 ++++++
 arch/x86/kvm/x86.h              |  5 +++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 94 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28..adf4c8e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -809,6 +809,7 @@ struct kvm_arch {
 	bool mwait_in_guest;
 	bool hlt_in_guest;
 	bool pause_in_guest;
+	bool split_lock_ac_in_guest;
 
 	unsigned long irq_sources_bitmap;
 	s64 kvmclock_offset;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 1689f43..d380764 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -58,6 +58,9 @@
 #include "pmu.h"
 #include "vmx_evmcs.h"
 
+static u64 x86_split_lock_ctrl_base;
+static u64 x86_split_lock_ctrl_mask;
+
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 #define __ex_clear(x, reg) \
 	____kvm_handle_fault_on_reboot(x, "xor " reg " , " reg)
@@ -776,6 +779,7 @@ struct vcpu_vmx {
 
 	u64 		      arch_capabilities;
 	u64 		      spec_ctrl;
+	u64		      split_lock_ctrl;
 
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
@@ -3750,6 +3754,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 #endif
 	case MSR_EFER:
 		return kvm_get_msr_common(vcpu, msr_info);
+	case MSR_TEST_CTL:
+		if (!msr_info->host_initiated &&
+		    !kvm_split_lock_ac_in_guest(vcpu->kvm))
+			return 1;
+		msr_info->data = to_vmx(vcpu)->split_lock_ctrl;
+		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
@@ -3868,6 +3878,19 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vmcs_write64(GUEST_BNDCFGS, data);
 		break;
+	case MSR_TEST_CTL:
+		if (!msr_info->host_initiated &&
+		    !kvm_split_lock_ac_in_guest(vcpu->kvm))
+			return 1;
+
+		vmx->split_lock_ctrl = data;
+
+		if (!data)
+			break;
+		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap,
+					      MSR_TEST_CTL,
+					      MSR_TYPE_RW);
+		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
@@ -6293,6 +6316,8 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
 		vmcs_write16(GUEST_PML_INDEX, PML_ENTITY_NUM - 1);
 	}
+
+	vmx->split_lock_ctrl = 0;
 }
 
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -6303,6 +6328,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vmx->rmode.vm86_active = 0;
 	vmx->spec_ctrl = 0;
+	vmx->split_lock_ctrl = 0;
 
 	vcpu->arch.microcode_version = 0x100000000ULL;
 	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
@@ -9947,6 +9973,38 @@ static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)
 	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 }
 
+static void x86_split_lock_ctrl_init(void)
+{
+	/*
+	 * Read the MSR_TEST_CTL MSR to account for reserved bits which may
+	 * have unknown values.
+	 */
+	if (boot_cpu_has(X86_FEATURE_AC_SPLIT_LOCK)) {
+		rdmsrl(MSR_TEST_CTL, x86_split_lock_ctrl_base);
+		x86_split_lock_ctrl_mask = MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	}
+}
+
+static void x86_set_split_lock_ctrl(struct kvm_vcpu *vcpu,
+				    u64 guest_split_lock_ctrl, bool setguest)
+{
+	/*
+	 * Check if the feature of #AC exception
+	 * for split locked access is supported.
+	 */
+	if (boot_cpu_has(X86_FEATURE_AC_SPLIT_LOCK)) {
+		u64 msrval, guestval;
+		u64 hostval = x86_split_lock_ctrl_base;
+
+		guestval = hostval & ~x86_split_lock_ctrl_mask;
+		guestval |= guest_split_lock_ctrl & x86_split_lock_ctrl_mask;
+		if (hostval != guestval) {
+			msrval = setguest ? guestval : hostval;
+			wrmsrl(MSR_TEST_CTL, msrval);
+		}
+	}
+}
+
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -10014,6 +10072,12 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
+	/*
+	 * Restore the guest's value of TEST_CTL MSR
+	 * if it's different with the host's value.
+	 */
+	x86_set_split_lock_ctrl(vcpu, vmx->split_lock_ctrl, true);
+
 	vmx->__launched = vmx->loaded_vmcs->launched;
 
 	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
@@ -10162,6 +10226,17 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 	x86_spec_ctrl_restore_host(vmx->spec_ctrl, 0);
 
+	if (kvm_split_lock_ac_in_guest(vcpu->kvm) &&
+	    !msr_write_intercepted(vcpu, MSR_TEST_CTL)) {
+		vmx->split_lock_ctrl = native_read_msr(MSR_TEST_CTL);
+	}
+
+	/*
+	 * Restore the host's value of TEST_CTL MSR
+	 * if it's different with the guest's value.
+	 */
+	x86_set_split_lock_ctrl(vcpu, vmx->split_lock_ctrl, false);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
@@ -13120,6 +13195,8 @@ static int __init vmx_init(void)
 {
 	int r;
 
+	x86_split_lock_ctrl_init();
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Enlightened VMCS usage should be recommended and the host needs
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa7..2611022 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2942,6 +2942,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_X2APIC_API:
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
+	case KVM_CAP_X86_SPLIT_LOCK_AC:
+		if (boot_cpu_has(X86_FEATURE_AC_SPLIT_LOCK))
+			r = 1;
+		else
+			r = 0;
+		break;
 	default:
 		break;
 	}
@@ -4260,6 +4266,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.pause_in_guest = true;
 		r = 0;
 		break;
+	case KVM_CAP_X86_SPLIT_LOCK_AC:
+		kvm->arch.split_lock_ac_in_guest = true;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 257f276..aa4daeb 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -326,6 +326,11 @@ static inline bool kvm_pause_in_guest(struct kvm *kvm)
 	return kvm->arch.pause_in_guest;
 }
 
+static inline bool kvm_split_lock_ac_in_guest(struct kvm *kvm)
+{
+	return kvm->arch.split_lock_ac_in_guest;
+}
+
 DECLARE_PER_CPU(struct kvm_vcpu *, current_vcpu);
 
 static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3..219f5fd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_X86_SPLIT_LOCK_AC 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.1

