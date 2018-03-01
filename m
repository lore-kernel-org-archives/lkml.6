Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967215AbeCAJt4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:49:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37686 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967059AbeCAJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:49:52 -0500
X-Google-Smtp-Source: AG47ELvJzlBophcszVjmKx8/6qdkp19K0WKuySjDViDRm18Lzn25/taF6I6ZYKUY6ehXBb0x8nff+A==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 1/3] KVM: X86: Provides userspace with a capability to not intercept MWAIT
Date: Thu,  1 Mar 2018 17:49:40 +0800
Message-Id: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Allowing a guest to execute MWAIT without interception enables a guest
to put a (physical) CPU into a power saving state, where it takes
longer to return from than what may be desired by the host.

Don't give a guest that power over a host by default. (Especially,
since nothing prevents a guest from using MWAIT even when it is not
advertised via CPUID.)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/api.txt | 26 ++++++++++++++++----------
 arch/x86/include/asm/kvm_host.h   |  2 ++
 arch/x86/kvm/svm.c                |  2 +-
 arch/x86/kvm/vmx.c                |  9 +++++----
 arch/x86/kvm/x86.c                | 24 ++++++++++++++++++++----
 arch/x86/kvm/x86.h                | 10 +++++-----
 include/uapi/linux/kvm.h          |  2 +-
 tools/include/uapi/linux/kvm.h    |  2 +-
 8 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index da3b958..4df35c0 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1041,7 +1041,8 @@ On systems that do not support this ioctl, it always fails. On systems that
 do support it, it only works for extensions that are supported for enablement.
 
 To check if a capability can be enabled, the KVM_CHECK_EXTENSION ioctl should
-be used.
+be used. Blindly passing the KVM_CHECK_EXTENSION result to KVM_ENABLE_CAP is
+a valid thing to do when vCPUs are associated to dedicated physical CPUs.
 
 struct kvm_enable_cap {
        /* in */
@@ -4358,6 +4359,20 @@ enables QEMU to build error log and branch to guest kernel registered
 machine check handling routine. Without this capability KVM will
 branch to guests' 0x200 interrupt vector.
 
+7.13 KVM_CAP_X86_DISABLE_EXITS
+
+Architectures: x86
+Parameters: args[0] defines which exits are disabled
+Returns: 0 on success, -EINVAL when args[0] contains invalid exits
+
+Valid exits in args[0] are
+
+#define KVM_X86_DISABLE_EXITS_MWAIT            (1 << 0)
+
+Enabling this capability on a VM provides userspace with a way to no
+longer intercepts some instructions for improved latency in some
+workloads. Not enable KVM_FEATURE_PV_UNHALT if you block HLT.
+
 8. Other capabilities.
 ----------------------
 
@@ -4470,15 +4485,6 @@ reserved.
     Both registers and addresses are 64-bits wide.
     It will be possible to run 64-bit or 32-bit guest code.
 
-8.8 KVM_CAP_X86_GUEST_MWAIT
-
-Architectures: x86
-
-This capability indicates that guest using memory monotoring instructions
-(MWAIT/MWAITX) to stop the virtual CPU will not cause a VM exit.  As such time
-spent while virtual CPU is halted in this way will then be accounted for as
-guest running time on the host (as opposed to e.g. HLT).
-
 8.9 KVM_CAP_ARM_USER_IRQ
 
 Architectures: arm, arm64
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index df6720f..6bd754f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -807,6 +807,8 @@ struct kvm_arch {
 
 	gpa_t wall_clock;
 
+	bool mwait_in_guest;
+
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 312f33f..dff3a5d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1389,7 +1389,7 @@ static void init_vmcb(struct vcpu_svm *svm)
 	set_intercept(svm, INTERCEPT_XSETBV);
 	set_intercept(svm, INTERCEPT_RSM);
 
-	if (!kvm_mwait_in_guest()) {
+	if (!kvm_mwait_in_guest(svm->vcpu.kvm)) {
 		set_intercept(svm, INTERCEPT_MONITOR);
 		set_intercept(svm, INTERCEPT_MWAIT);
 	}
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2cdbea7..b551067 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3713,13 +3713,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 	      CPU_BASED_UNCOND_IO_EXITING |
 	      CPU_BASED_MOV_DR_EXITING |
 	      CPU_BASED_USE_TSC_OFFSETING |
+	      CPU_BASED_MWAIT_EXITING |
+	      CPU_BASED_MONITOR_EXITING |
 	      CPU_BASED_INVLPG_EXITING |
 	      CPU_BASED_RDPMC_EXITING;
 
-	if (!kvm_mwait_in_guest())
-		min |= CPU_BASED_MWAIT_EXITING |
-			CPU_BASED_MONITOR_EXITING;
-
 	opt = CPU_BASED_TPR_SHADOW |
 	      CPU_BASED_USE_MSR_BITMAPS |
 	      CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
@@ -5503,6 +5501,9 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 		exec_control |= CPU_BASED_CR3_STORE_EXITING |
 				CPU_BASED_CR3_LOAD_EXITING  |
 				CPU_BASED_INVLPG_EXITING;
+	if (kvm_mwait_in_guest(vmx->vcpu.kvm))
+		exec_control &= ~(CPU_BASED_MWAIT_EXITING |
+				CPU_BASED_MONITOR_EXITING);
 	return exec_control;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5c93cbc..c1d9bbb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2780,9 +2780,15 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
 	return r;
 }
 
+static inline bool kvm_mwait_can_in_guest(void)
+{
+	return boot_cpu_has(X86_FEATURE_MWAIT) &&
+		!boot_cpu_has_bug(X86_BUG_MONITOR);
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
-	int r;
+	int r = 0;
 
 	switch (ext) {
 	case KVM_CAP_IRQCHIP:
@@ -2838,8 +2844,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ADJUST_CLOCK:
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
-	case KVM_CAP_X86_GUEST_MWAIT:
-		r = kvm_mwait_in_guest();
+	case KVM_CAP_X86_DISABLE_EXITS:
+		if(kvm_mwait_can_in_guest())
+			r |= KVM_X86_DISABLE_EXITS_MWAIT;
 		break;
 	case KVM_CAP_X86_SMM:
 		/* SMBASE is usually relocated above 1M on modern chipsets,
@@ -2880,7 +2887,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
 	default:
-		r = 0;
 		break;
 	}
 	return r;
@@ -4185,6 +4191,16 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 
 		r = 0;
 		break;
+	case KVM_CAP_X86_DISABLE_EXITS:
+		r = -EINVAL;
+		if (cap->args[0] & ~KVM_X86_DISABLE_VALID_EXITS)
+			break;
+
+		if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
+			kvm_mwait_can_in_guest())
+			kvm->arch.mwait_in_guest = true;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b91215d..cd1215e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -2,8 +2,6 @@
 #ifndef ARCH_X86_KVM_X86_H
 #define ARCH_X86_KVM_X86_H
 
-#include <asm/processor.h>
-#include <asm/mwait.h>
 #include <linux/kvm_host.h>
 #include <asm/pvclock.h>
 #include "kvm_cache_regs.h"
@@ -264,10 +262,12 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 	    __rem;						\
 	 })
 
-static inline bool kvm_mwait_in_guest(void)
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT)
+
+static inline bool kvm_mwait_in_guest(struct kvm *kvm)
 {
-	return boot_cpu_has(X86_FEATURE_MWAIT) &&
-		!boot_cpu_has_bug(X86_BUG_MONITOR);
+	return kvm->arch.mwait_in_guest;
 }
 
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 088c2c9..1065006 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -929,7 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_GS 140
 #define KVM_CAP_S390_AIS 141
 #define KVM_CAP_SPAPR_TCE_VFIO 142
-#define KVM_CAP_X86_GUEST_MWAIT 143
+#define KVM_CAP_X86_DISABLE_EXITS 143
 #define KVM_CAP_ARM_USER_IRQ 144
 #define KVM_CAP_S390_CMMA_MIGRATION 145
 #define KVM_CAP_PPC_FWNMI 146
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 8fb90a0..a81df22 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -924,7 +924,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_GS 140
 #define KVM_CAP_S390_AIS 141
 #define KVM_CAP_SPAPR_TCE_VFIO 142
-#define KVM_CAP_X86_GUEST_MWAIT 143
+#define KVM_CAP_X86_DISABLE_EXITS 143
 #define KVM_CAP_ARM_USER_IRQ 144
 #define KVM_CAP_S390_CMMA_MIGRATION 145
 #define KVM_CAP_PPC_FWNMI 146
-- 
2.7.4
