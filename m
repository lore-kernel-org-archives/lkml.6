Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeCEB5K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:57:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:39574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932539AbeCEB5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:57:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,425,1515484800";
   d="scan'208";a="21986070"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v5 04/11] KVM: x86: Add Intel Processor Trace virtualization mode
Date: Sun,  4 Mar 2018 20:07:14 +0800
Message-Id: <1520165241-15819-5-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Intel PT virtualization can be work in one of 3 possible modes:
a. system-wide: trace both host/guest and output to host buffer;
b. host-only: only trace host and output to host buffer;
c. host-guest: trace host/guest simultaneous and output to their
   respective buffer.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/intel_pt.h  |  6 ++++
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/vmx.h       |  8 +++++
 arch/x86/kvm/vmx.c               | 68 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 486e11f..13e9499 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -5,6 +5,12 @@
 #define PT_CPUID_LEAVES		2
 #define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
 
+enum pt_mode {
+	PT_MODE_SYSTEM = 0,
+	PT_MODE_HOST,
+	PT_MODE_HOST_GUEST,
+};
+
 enum pt_capabilities {
 	PT_CAP_max_subleaf = 0,
 	PT_CAP_cr3_filtering,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c1fb2d2..4ad6e9d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -776,6 +776,7 @@
 #define VMX_BASIC_INOUT		0x0040000000000000LLU
 
 /* MSR_IA32_VMX_MISC bits */
+#define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
 #define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
 /* AMD-V MSRs */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 8b67807..9e828d4 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -76,7 +76,9 @@
 #define SECONDARY_EXEC_SHADOW_VMCS              0x00004000
 #define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
 #define SECONDARY_EXEC_ENABLE_PML               0x00020000
+#define SECONDARY_EXEC_PT_CONCEAL_VMX		0x00080000
 #define SECONDARY_EXEC_XSAVES			0x00100000
+#define SECONDARY_EXEC_PT_USE_GPA		0x01000000
 #define SECONDARY_EXEC_TSC_SCALING              0x02000000
 
 #define PIN_BASED_EXT_INTR_MASK                 0x00000001
@@ -97,6 +99,8 @@
 #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
 #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VM_EXIT_PT_CONCEAL_PIP			0x01000000
+#define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -108,6 +112,8 @@
 #define VM_ENTRY_LOAD_IA32_PAT			0x00004000
 #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
 #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
+#define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
@@ -234,6 +240,8 @@ enum vmcs_field {
 	GUEST_PDPTR3_HIGH               = 0x00002811,
 	GUEST_BNDCFGS                   = 0x00002812,
 	GUEST_BNDCFGS_HIGH              = 0x00002813,
+	GUEST_IA32_RTIT_CTL		= 0x00002814,
+	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
 	HOST_IA32_PAT			= 0x00002c00,
 	HOST_IA32_PAT_HIGH		= 0x00002c01,
 	HOST_IA32_EFER			= 0x00002c02,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4d1cd09..aba747b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -52,6 +52,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
+#include <asm/intel_pt.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -191,6 +192,10 @@
 static int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 module_param(ple_window_max, int, S_IRUGO);
 
+/* Default is SYSTEM mode. */
+static int __read_mostly pt_mode = PT_MODE_SYSTEM;
+module_param(pt_mode, int, S_IRUGO);
+
 extern const ulong vmx_return;
 
 #define NR_AUTOLOAD_MSRS 8
@@ -1306,6 +1311,19 @@ static inline bool cpu_has_vmx_vmfunc(void)
 		SECONDARY_EXEC_ENABLE_VMFUNC;
 }
 
+static inline bool cpu_has_vmx_intel_pt(void)
+{
+	u64 vmx_msr;
+
+	rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
+	return vmx_msr & MSR_IA32_VMX_MISC_INTEL_PT;
+}
+
+static inline bool cpu_has_vmx_pt_use_gpa(void)
+{
+	return vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_PT_USE_GPA;
+}
+
 static inline bool report_flexpriority(void)
 {
 	return flexpriority_enabled;
@@ -3751,6 +3769,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 			SECONDARY_EXEC_RDRAND_EXITING |
 			SECONDARY_EXEC_ENABLE_PML |
 			SECONDARY_EXEC_TSC_SCALING |
+			SECONDARY_EXEC_PT_USE_GPA |
+			SECONDARY_EXEC_PT_CONCEAL_VMX |
 			SECONDARY_EXEC_ENABLE_VMFUNC;
 		if (adjust_vmx_controls(min2, opt2,
 					MSR_IA32_VMX_PROCBASED_CTLS2,
@@ -3795,7 +3815,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 	min |= VM_EXIT_HOST_ADDR_SPACE_SIZE;
 #endif
 	opt = VM_EXIT_SAVE_IA32_PAT | VM_EXIT_LOAD_IA32_PAT |
-		VM_EXIT_CLEAR_BNDCFGS;
+		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_PT_CONCEAL_PIP |
+		VM_EXIT_CLEAR_IA32_RTIT_CTL;
 	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_EXIT_CTLS,
 				&_vmexit_control) < 0)
 		return -EIO;
@@ -3814,11 +3835,20 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 		_pin_based_exec_control &= ~PIN_BASED_POSTED_INTR;
 
 	min = VM_ENTRY_LOAD_DEBUG_CONTROLS;
-	opt = VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
+	opt = VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
+		VM_ENTRY_PT_CONCEAL_PIP | VM_ENTRY_LOAD_IA32_RTIT_CTL;
 	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_ENTRY_CTLS,
 				&_vmentry_control) < 0)
 		return -EIO;
 
+	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_PT_USE_GPA) ||
+		!(_vmexit_control & VM_EXIT_CLEAR_IA32_RTIT_CTL) ||
+		!(_vmentry_control & VM_ENTRY_LOAD_IA32_RTIT_CTL)) {
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_PT_USE_GPA;
+		_vmexit_control &= ~VM_EXIT_CLEAR_IA32_RTIT_CTL;
+		_vmentry_control &= ~VM_ENTRY_LOAD_IA32_RTIT_CTL;
+	}
+
 	rdmsr(MSR_IA32_VMX_BASIC, vmx_msr_low, vmx_msr_high);
 
 	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
@@ -5506,6 +5536,28 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 	return exec_control;
 }
 
+static u32 vmx_vmexit_control(struct vcpu_vmx *vmx)
+{
+	u32 vmexit_control = vmcs_config.vmexit_ctrl;
+
+	if (pt_mode == PT_MODE_SYSTEM)
+		vmexit_control &= ~(VM_EXIT_CLEAR_IA32_RTIT_CTL |
+				    VM_EXIT_PT_CONCEAL_PIP);
+
+	return vmexit_control;
+}
+
+static u32 vmx_vmentry_control(struct vcpu_vmx *vmx)
+{
+	u32 vmentry_control = vmcs_config.vmentry_ctrl;
+
+	if (pt_mode == PT_MODE_SYSTEM)
+		vmentry_control &= ~(VM_ENTRY_PT_CONCEAL_PIP |
+				     VM_ENTRY_LOAD_IA32_RTIT_CTL);
+
+	return vmentry_control;
+}
+
 static bool vmx_rdrand_supported(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
@@ -5642,6 +5694,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 		}
 	}
 
+	if (pt_mode == PT_MODE_SYSTEM)
+		exec_control &= ~(SECONDARY_EXEC_PT_USE_GPA |
+				  SECONDARY_EXEC_PT_CONCEAL_VMX);
+
 	vmx->secondary_exec_control = exec_control;
 }
 
@@ -5752,10 +5808,10 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
-	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
+	vm_exit_controls_init(vmx, vmx_vmexit_control(vmx));
 
 	/* 22.2.1, 20.8.1 */
-	vm_entry_controls_init(vmx, vmcs_config.vmentry_ctrl);
+	vm_entry_controls_init(vmx, vmx_vmentry_control(vmx));
 
 	vmx->vcpu.arch.cr0_guest_owned_bits = X86_CR0_TS;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~X86_CR0_TS);
@@ -7100,6 +7156,10 @@ static __init int hardware_setup(void)
 
 	kvm_mce_cap_supported |= MCG_LMCE_P;
 
+	if (!enable_ept || !pt_cap_get(PT_CAP_topa_output) ||
+		!cpu_has_vmx_intel_pt() || !cpu_has_vmx_pt_use_gpa())
+		pt_mode = PT_MODE_SYSTEM;
+
 	return alloc_kvm_area();
 
 out:
-- 
1.8.3.1
