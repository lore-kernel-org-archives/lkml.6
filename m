Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967276AbeCAJuZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:50:25 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37189 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967189AbeCAJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:49:56 -0500
X-Google-Smtp-Source: AG47ELvAmFoAetuL6QvUi6DIoH4QZRrGdDTgkiFKHWM/wAtNYMbpJjWB9dbnV9twNch9D4ivQpVPxQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 3/3] KVM: X86: Provides userspace with a capability to not intercept PAUSE
Date: Thu,  1 Mar 2018 17:49:42 +0800
Message-Id: <1519897782-8124-3-git-send-email-wanpengli@tencent.com>
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

Allow to disable pause loop exit/pause filtering on a per VM basis.

If some VMs have dedicated host CPUs, they won't be negatively affected
due to needlessly intercepted PAUSE instructions.

Thanks to Jan H. Schönherr's initial patch.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm.c              |  3 ++-
 arch/x86/kvm/vmx.c              | 17 +++++++++++++----
 arch/x86/kvm/x86.c              |  4 +++-
 arch/x86/kvm/x86.h              |  9 ++++++++-
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ee739ad..555f6d4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -809,6 +809,7 @@ struct kvm_arch {
 
 	bool mwait_in_guest;
 	bool hlt_in_guest;
+	bool pause_in_guest;
 
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index fcf8339..53cb3ff 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1452,7 +1452,8 @@ static void init_vmcb(struct vcpu_svm *svm)
 	svm->nested.vmcb = 0;
 	svm->vcpu.arch.hflags = 0;
 
-	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
+	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER) &&
+	    !kvm_pause_in_guest(svm->vcpu.kvm)) {
 		control->pause_filter_count = 3000;
 		set_intercept(svm, INTERCEPT_PAUSE);
 	}
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f9f887a..b2cffcd 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5554,7 +5554,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 	}
 	if (!enable_unrestricted_guest)
 		exec_control &= ~SECONDARY_EXEC_UNRESTRICTED_GUEST;
-	if (!ple_gap)
+	if (kvm_pause_in_guest(vmx->vcpu.kvm))
 		exec_control &= ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
 	if (!kvm_vcpu_apicv_active(vcpu))
 		exec_control &= ~(SECONDARY_EXEC_APIC_REGISTER_VIRT |
@@ -5717,7 +5717,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->pi_desc)));
 	}
 
-	if (ple_gap) {
+	if (!kvm_pause_in_guest(vmx->vcpu.kvm)) {
 		vmcs_write32(PLE_GAP, ple_gap);
 		vmx->ple_window = ple_window;
 		vmx->ple_window_dirty = true;
@@ -7149,7 +7149,7 @@ static __exit void hardware_unsetup(void)
  */
 static int handle_pause(struct kvm_vcpu *vcpu)
 {
-	if (ple_gap)
+	if (!kvm_pause_in_guest(vcpu->kvm))
 		grow_ple_window(vcpu);
 
 	/*
@@ -9844,6 +9844,13 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	return ERR_PTR(err);
 }
 
+static int vmx_vm_init(struct kvm *kvm)
+{
+	if (!ple_gap)
+		kvm->arch.pause_in_guest = true;
+	return 0;
+}
+
 static void __init vmx_check_processor_compat(void *rtn)
 {
 	struct vmcs_config vmcs_conf;
@@ -11965,7 +11972,7 @@ static void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
 
 static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
-	if (ple_gap)
+	if (!kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 }
 
@@ -12324,6 +12331,8 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_accelerated_tpr = report_flexpriority,
 	.cpu_has_high_real_mode_segbase = vmx_has_high_real_mode_segbase,
 
+	.vm_init = vmx_vm_init,
+
 	.vcpu_create = vmx_create_vcpu,
 	.vcpu_free = vmx_free_vcpu,
 	.vcpu_reset = vmx_vcpu_reset,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 13f01d7..eafa0cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2845,7 +2845,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
-		r |=  KVM_X86_DISABLE_EXITS_HTL;
+		r |=  KVM_X86_DISABLE_EXITS_HTL | KVM_X86_DISABLE_EXITS_PAUSE;
 		if(kvm_mwait_can_in_guest())
 			r |= KVM_X86_DISABLE_EXITS_MWAIT;
 		break;
@@ -4202,6 +4202,8 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.mwait_in_guest = true;
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_HTL)
 			kvm->arch.hlt_in_guest = true;
+		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
+			kvm->arch.pause_in_guest = true;
 		r = 0;
 		break;
 	default:
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d4ddb00..658ea9a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -264,8 +264,10 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
 #define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HTL)
+                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_PAUSE)
 
 static inline bool kvm_mwait_in_guest(struct kvm *kvm)
 {
@@ -277,4 +279,9 @@ static inline bool kvm_hlt_in_guest(struct kvm *kvm)
 	return kvm->arch.hlt_in_guest;
 }
 
+static inline bool kvm_pause_in_guest(struct kvm *kvm)
+{
+	return kvm->arch.pause_in_guest;
+}
+
 #endif
-- 
2.7.4
