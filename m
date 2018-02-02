Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeBBHMl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:12:41 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32874 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBBHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:12:08 -0500
X-Google-Smtp-Source: AH8x226lKj+5K+6Ul4GH0OzLhOxlCwbPJSOcwHfN3LEuRStDFqKI7hoBYveTQP/TIkdXfB4mnG3KuQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/2] KVM: X86: Add per-VM no-HLT-exiting capability
Date: Thu,  1 Feb 2018 23:11:13 -0800
Message-Id: <1517555473-8313-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
References: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
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
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/api.txt | 11 +++++++++++
 arch/x86/include/asm/kvm_host.h   |  2 ++
 arch/x86/kvm/vmx.c                | 21 +++++++++++++++++++++
 arch/x86/kvm/x86.c                |  5 +++++
 arch/x86/kvm/x86.h                |  5 +++++
 include/uapi/linux/kvm.h          |  1 +
 6 files changed, 45 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index e5f1743..573a3e5 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4222,6 +4222,17 @@ enables QEMU to build error log and branch to guest kernel registered
 machine check handling routine. Without this capability KVM will
 branch to guests' 0x200 interrupt vector.
 
+7.13 KVM_CAP_X86_GUEST_HLT
+
+Architectures: x86
+Parameters: none
+Returns: 0 on success
+
+This capability indicates that a guest using HLT to stop a virtual CPU
+will not cause a VM exit. As such, time spent while a virtual CPU is
+halted in this way will then be accounted for as guest running time on
+the host, KVM_FEATURE_PV_UNHALT should be disabled.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dd6f57a..c566ea0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -804,6 +804,8 @@ struct kvm_arch {
 
 	gpa_t wall_clock;
 
+	bool hlt_in_guest;
+
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b1e554a..6cfd8d3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2478,6 +2478,19 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
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
@@ -2508,6 +2521,8 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static bool vmx_rdtscp_supported(void)
@@ -5301,6 +5316,8 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 		exec_control |= CPU_BASED_CR3_STORE_EXITING |
 				CPU_BASED_CR3_LOAD_EXITING  |
 				CPU_BASED_INVLPG_EXITING;
+	if (kvm_hlt_in_guest(vmx->vcpu.kvm))
+		exec_control &= ~CPU_BASED_HLT_EXITING;
 	return exec_control;
 }
 
@@ -5729,6 +5746,8 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu)
 	} else
 		intr |= INTR_TYPE_EXT_INTR;
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
@@ -5759,6 +5778,8 @@ static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			INTR_TYPE_NMI_INTR | INTR_INFO_VALID_MASK | NMI_VECTOR);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c13cd14..a508247 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2740,6 +2740,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_BOOT_CPU_ID:
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_X86_GUEST_HLT:
 		r = 1;
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
@@ -4061,6 +4062,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 
 		r = 0;
 		break;
+	case KVM_CAP_X86_GUEST_HLT:
+		kvm->arch.hlt_in_guest = cap->args[0];
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b91215d..96fe84e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -270,4 +270,9 @@ static inline bool kvm_mwait_in_guest(void)
 		!boot_cpu_has_bug(X86_BUG_MONITOR);
 }
 
+static inline bool kvm_hlt_in_guest(struct kvm *kvm)
+{
+	return kvm->arch.hlt_in_guest;
+}
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 62c564d..6cbf080 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -932,6 +932,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
 #define KVM_CAP_S390_AIS_MIGRATION 150
+#define KVM_CAP_X86_GUEST_HLT 151
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
