Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeCLLzC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:55:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44308 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbeCLLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:54:26 -0400
X-Google-Smtp-Source: AG47ELtWPCM1j+0lnLRYHgPjysrGxNtI1DTj9bEPYvLOXjACHUxvuphJNIpLk7hbKiWBu7zzkdUmvA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Subject: [PATCH v2 3/3] KVM: X86: Provides userspace with a capability to not intercept PAUSE
Date: Mon, 12 Mar 2018 04:53:04 -0700
Message-Id: <1520855584-10079-4-git-send-email-wanpengli@tencent.com>
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

Allow to disable pause loop exit/pause filtering on a per VM basis.

If some VMs have dedicated host CPUs, they won't be negatively affected
due to needlessly intercepted PAUSE instructions.

Thanks to Jan H. Schönherr's initial patch.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm.c              |  3 ++-
 arch/x86/kvm/vmx.c              | 17 +++++++++++++----
 arch/x86/kvm/x86.c              |  4 +++-
 arch/x86/kvm/x86.h              |  9 ++++++++-
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1a79065..d73ca26 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -813,6 +813,7 @@ struct kvm_arch {
 
 	bool mwait_in_guest;
 	bool hlt_in_guest;
+	bool pause_in_guest;
 
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 0b2e7af..ddc705c 100644
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
index fa0c5e1..400f9d1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5582,7 +5582,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 	}
 	if (!enable_unrestricted_guest)
 		exec_control &= ~SECONDARY_EXEC_UNRESTRICTED_GUEST;
-	if (!ple_gap)
+	if (kvm_pause_in_guest(vmx->vcpu.kvm))
 		exec_control &= ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
 	if (!kvm_vcpu_apicv_active(vcpu))
 		exec_control &= ~(SECONDARY_EXEC_APIC_REGISTER_VIRT |
@@ -5745,7 +5745,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->pi_desc)));
 	}
 
-	if (ple_gap) {
+	if (!kvm_pause_in_guest(vmx->vcpu.kvm)) {
 		vmcs_write32(PLE_GAP, ple_gap);
 		vmx->ple_window = ple_window;
 		vmx->ple_window_dirty = true;
@@ -7182,7 +7182,7 @@ static __exit void hardware_unsetup(void)
  */
 static int handle_pause(struct kvm_vcpu *vcpu)
 {
-	if (ple_gap)
+	if (!kvm_pause_in_guest(vcpu->kvm))
 		grow_ple_window(vcpu);
 
 	/*
@@ -9878,6 +9878,13 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
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
@@ -12019,7 +12026,7 @@ static void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
 
 static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
-	if (ple_gap)
+	if (!kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 }
 
@@ -12379,6 +12386,8 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_accelerated_tpr = report_flexpriority,
 	.cpu_has_high_real_mode_segbase = vmx_has_high_real_mode_segbase,
 
+	.vm_init = vmx_vm_init,
+
 	.vcpu_create = vmx_create_vcpu,
 	.vcpu_free = vmx_free_vcpu,
 	.vcpu_reset = vmx_vcpu_reset,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 73255e6..8060f27 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2874,7 +2874,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
-		r |=  KVM_X86_DISABLE_EXITS_HTL;
+		r |=  KVM_X86_DISABLE_EXITS_HTL | KVM_X86_DISABLE_EXITS_PAUSE;
 		if(kvm_can_mwait_in_guest())
 			r |= KVM_X86_DISABLE_EXITS_MWAIT;
 		break;
@@ -4231,6 +4231,8 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
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
