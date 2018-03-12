Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeCLLyc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:54:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33531 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:54:24 -0400
X-Google-Smtp-Source: AG47ELsNlmW2Lq6eE7lMBohOMQiOUA/cgFTQUM3nzCKxtQye032gO44z61A+IGzi6o6NvZ2gNWET9Q==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Subject: [PATCH v2 2/3] KVM: X86: Provides userspace with a capability to not intercept HLT
Date: Mon, 12 Mar 2018 04:53:03 -0700
Message-Id: <1520855584-10079-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520855584-10079-1-git-send-email-wanpengli@tencent.com>
References: <1520855584-10079-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
This patch adds the per-VM non-HLT-exiting capability.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/api.txt |  3 ++-
 arch/x86/include/asm/kvm_host.h   |  1 +
 arch/x86/kvm/cpuid.c              |  5 +++++
 arch/x86/kvm/svm.c                |  4 +++-
 arch/x86/kvm/vmx.c                | 24 ++++++++++++++++++++++++
 arch/x86/kvm/x86.c                |  3 +++
 arch/x86/kvm/x86.h                |  9 ++++++++-
 7 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 76e5a15..b46494d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4367,10 +4367,11 @@ Returns: 0 on success, -EINVAL when args[0] contains invalid exits
 Valid exits in args[0] are
 
 #define KVM_X86_DISABLE_EXITS_MWAIT            (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HLT              (1 << 1)
 
 Enabling this capability on a VM provides userspace with a way to no
 longer intercepts some instructions for improved latency in some
-workloads.
+workloads. Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
 
 8. Other capabilities.
 ----------------------
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e107171..1a79065 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -812,6 +812,7 @@ struct kvm_arch {
 	gpa_t wall_clock;
 
 	bool mwait_in_guest;
+	bool hlt_in_guest;
 
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e2d3050..82055b9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -135,6 +135,11 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
 			return -EINVAL;
 	}
 
+	best = kvm_find_cpuid_entry(vcpu, KVM_CPUID_FEATURES, 0);
+	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
+		(best->eax & (1 << KVM_FEATURE_PV_UNHALT)))
+		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
+
 	/* Update physical-address width */
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
 	kvm_mmu_reset_context(vcpu);
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 321b3fd..0b2e7af 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1372,7 +1372,6 @@ static void init_vmcb(struct vcpu_svm *svm)
 	set_intercept(svm, INTERCEPT_RDPMC);
 	set_intercept(svm, INTERCEPT_CPUID);
 	set_intercept(svm, INTERCEPT_INVD);
-	set_intercept(svm, INTERCEPT_HLT);
 	set_intercept(svm, INTERCEPT_INVLPG);
 	set_intercept(svm, INTERCEPT_INVLPGA);
 	set_intercept(svm, INTERCEPT_IOIO_PROT);
@@ -1395,6 +1394,9 @@ static void init_vmcb(struct vcpu_svm *svm)
 		set_intercept(svm, INTERCEPT_MWAIT);
 	}
 
+	if (!kvm_hlt_in_guest(svm->vcpu.kvm))
+		set_intercept(svm, INTERCEPT_HLT);
+
 	control->iopm_base_pa = __sme_set(iopm_base);
 	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
 	control->int_ctl = V_INTR_MASKING_MASK;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2302ae2..fa0c5e1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2543,6 +2543,19 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
 	return 0;
 }
 
+static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Ensure that we clear the HLT state in the VMCS.  We don't need to
+	 * explicitly skip the instruction because if the HLT state is set,
+	 * then the instruction is already executing and RIP has already been
+	 * advanced.
+	 */
+	if (kvm_hlt_in_guest(vcpu->kvm) &&
+			vmcs_read32(GUEST_ACTIVITY_STATE) == GUEST_ACTIVITY_HLT)
+		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
+}
+
 static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -2573,6 +2586,8 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static bool vmx_rdtscp_supported(void)
@@ -5532,6 +5547,8 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 	if (kvm_mwait_in_guest(vmx->vcpu.kvm))
 		exec_control &= ~(CPU_BASED_MWAIT_EXITING |
 				CPU_BASED_MONITOR_EXITING);
+	if (kvm_hlt_in_guest(vmx->vcpu.kvm))
+		exec_control &= ~CPU_BASED_HLT_EXITING;
 	return exec_control;
 }
 
@@ -5893,6 +5910,8 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	update_exception_bitmap(vcpu);
 
 	vpid_sync_context(vmx->vpid);
+	if (init_event)
+		vmx_clear_hlt(vcpu);
 }
 
 /*
@@ -5963,6 +5982,8 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu)
 	} else
 		intr |= INTR_TYPE_EXT_INTR;
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
@@ -5993,6 +6014,8 @@ static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			INTR_TYPE_NMI_INTR | INTR_INFO_VALID_MASK | NMI_VECTOR);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
@@ -12314,6 +12337,7 @@ static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 
 	vmx->nested.smm.vmxon = vmx->nested.vmxon;
 	vmx->nested.vmxon = false;
+	vmx_clear_hlt(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5fae476..73255e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2874,6 +2874,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
+		r |=  KVM_X86_DISABLE_EXITS_HTL;
 		if(kvm_can_mwait_in_guest())
 			r |= KVM_X86_DISABLE_EXITS_MWAIT;
 		break;
@@ -4228,6 +4229,8 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
 			kvm_can_mwait_in_guest())
 			kvm->arch.mwait_in_guest = true;
+		if (cap->args[0] & KVM_X86_DISABLE_EXITS_HTL)
+			kvm->arch.hlt_in_guest = true;
 		r = 0;
 		break;
 	default:
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cd1215e..d4ddb00 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -263,11 +263,18 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 	 })
 
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
-#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT)
+#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
+                                              KVM_X86_DISABLE_EXITS_HTL)
 
 static inline bool kvm_mwait_in_guest(struct kvm *kvm)
 {
 	return kvm->arch.mwait_in_guest;
 }
 
+static inline bool kvm_hlt_in_guest(struct kvm *kvm)
+{
+	return kvm->arch.hlt_in_guest;
+}
+
 #endif
-- 
2.7.4
