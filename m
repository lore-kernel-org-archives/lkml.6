Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967252AbeCAJt6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:49:58 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45262 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967087AbeCAJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:49:54 -0500
X-Google-Smtp-Source: AG47ELs0HgM2EHfberb1HxMIjlw1G8AN1ub5mXYDDY7EZ2zRnqA2YO+D7Y5/EhWyX3PzOyEusNK5Wg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/3] KVM: X86: Provides userspace with a capability to not intercept HLT
Date: Thu,  1 Mar 2018 17:49:41 +0800
Message-Id: <1519897782-8124-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
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
 Documentation/virtual/kvm/api.txt |  1 +
 arch/x86/include/asm/kvm_host.h   |  1 +
 arch/x86/kvm/svm.c                |  3 +++
 arch/x86/kvm/vmx.c                | 23 +++++++++++++++++++++++
 arch/x86/kvm/x86.c                |  3 +++
 arch/x86/kvm/x86.h                |  9 ++++++++-
 6 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 4df35c0..c07e775 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4368,6 +4368,7 @@ Returns: 0 on success, -EINVAL when args[0] contains invalid exits
 Valid exits in args[0] are
 
 #define KVM_X86_DISABLE_EXITS_MWAIT            (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HLT              (1 << 1)
 
 Enabling this capability on a VM provides userspace with a way to no
 longer intercepts some instructions for improved latency in some
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6bd754f..ee739ad 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -808,6 +808,7 @@ struct kvm_arch {
 	gpa_t wall_clock;
 
 	bool mwait_in_guest;
+	bool hlt_in_guest;
 
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index dff3a5d..fcf8339 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1394,6 +1394,9 @@ static void init_vmcb(struct vcpu_svm *svm)
 		set_intercept(svm, INTERCEPT_MWAIT);
 	}
 
+	if (!kvm_hlt_in_guest(svm->vcpu.kvm))
+		set_intercept(svm, INTERCEPT_HLT);
+
 	control->iopm_base_pa = __sme_set(iopm_base);
 	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
 	control->int_ctl = V_INTR_MASKING_MASK;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b551067..f9f887a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2525,6 +2525,19 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
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
@@ -2555,6 +2568,8 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static bool vmx_rdtscp_supported(void)
@@ -5504,6 +5519,8 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 	if (kvm_mwait_in_guest(vmx->vcpu.kvm))
 		exec_control &= ~(CPU_BASED_MWAIT_EXITING |
 				CPU_BASED_MONITOR_EXITING);
+	if (kvm_hlt_in_guest(vmx->vcpu.kvm))
+		exec_control &= ~CPU_BASED_HLT_EXITING;
 	return exec_control;
 }
 
@@ -5865,6 +5882,8 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	update_exception_bitmap(vcpu);
 
 	vpid_sync_context(vmx->vpid);
+	if (init_event)
+		vmx_clear_hlt(vcpu);
 }
 
 /*
@@ -5936,6 +5955,8 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu)
 	} else
 		intr |= INTR_TYPE_EXT_INTR;
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
@@ -5966,6 +5987,8 @@ static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			INTR_TYPE_NMI_INTR | INTR_INFO_VALID_MASK | NMI_VECTOR);
+
+	vmx_clear_hlt(vcpu);
 }
 
 static bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c1d9bbb..13f01d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2845,6 +2845,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
+		r |=  KVM_X86_DISABLE_EXITS_HTL;
 		if(kvm_mwait_can_in_guest())
 			r |= KVM_X86_DISABLE_EXITS_MWAIT;
 		break;
@@ -4199,6 +4200,8 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
 			kvm_mwait_can_in_guest())
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
