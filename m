Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA0C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD102082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD102082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJXQek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:34:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:50007 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbeJXQej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:34:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="273987325"
Received: from skx-d.bj.intel.com ([10.238.135.53])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 01:07:32 -0700
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, joro@8bytes.org,
        songliubraving@fb.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work mode
Date:   Wed, 24 Oct 2018 16:05:10 +0800
Message-Id: <1540368316-12998-7-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Intel Processor Trace virtualization can be work in one
of 2 possible modes:

a. System-Wide mode (default):
   When the host configures Intel PT to collect trace packets
   of the entire system, it can leave the relevant VMX controls
   clear to allow VMX-specific packets to provide information
   across VMX transitions.
   KVM guest will not aware this feature in this mode and both
   host and KVM guest trace will output to host buffer.

b. Host-Guest mode:
   Host can configure trace-packet generation while in
   VMX non-root operation for guests and root operation
   for native executing normally.
   Intel PT will be exposed to KVM guest in this mode, and
   the trace output to respective buffer of host and guest.
   In this mode, tht status of PT will be saved and disabled
   before VM-entry and restored after VM-exit if trace
   a virtual machine.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/intel_pt.h  |  3 ++
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/vmx.h       |  8 +++++
 arch/x86/kvm/vmx.c               | 68 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 634f99b..4727584 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -5,6 +5,9 @@
 #define PT_CPUID_LEAVES		2
 #define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
 
+#define PT_MODE_SYSTEM		0
+#define PT_MODE_HOST_GUEST	1
+
 enum pt_capabilities {
 	PT_CAP_max_subleaf = 0,
 	PT_CAP_cr3_filtering,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 107818e3..f51579d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -805,6 +805,7 @@
 #define VMX_BASIC_INOUT		0x0040000000000000LLU
 
 /* MSR_IA32_VMX_MISC bits */
+#define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
 #define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
 /* AMD-V MSRs */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index ade0f15..b99710c 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -77,7 +77,9 @@
 #define SECONDARY_EXEC_ENCLS_EXITING		0x00008000
 #define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
 #define SECONDARY_EXEC_ENABLE_PML               0x00020000
+#define SECONDARY_EXEC_PT_CONCEAL_VMX		0x00080000
 #define SECONDARY_EXEC_XSAVES			0x00100000
+#define SECONDARY_EXEC_PT_USE_GPA		0x01000000
 #define SECONDARY_EXEC_TSC_SCALING              0x02000000
 
 #define PIN_BASED_EXT_INTR_MASK                 0x00000001
@@ -98,6 +100,8 @@
 #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
 #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VM_EXIT_PT_CONCEAL_PIP			0x01000000
+#define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -109,6 +113,8 @@
 #define VM_ENTRY_LOAD_IA32_PAT			0x00004000
 #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
 #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
+#define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
@@ -240,6 +246,8 @@ enum vmcs_field {
 	GUEST_PDPTR3_HIGH               = 0x00002811,
 	GUEST_BNDCFGS                   = 0x00002812,
 	GUEST_BNDCFGS_HIGH              = 0x00002813,
+	GUEST_IA32_RTIT_CTL		= 0x00002814,
+	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
 	HOST_IA32_PAT			= 0x00002c00,
 	HOST_IA32_PAT_HIGH		= 0x00002c01,
 	HOST_IA32_EFER			= 0x00002c02,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 641a65b..c4c4b76 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -55,6 +55,7 @@
 #include <asm/mmu_context.h>
 #include <asm/spec-ctrl.h>
 #include <asm/mshyperv.h>
+#include <asm/intel_pt.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -190,6 +191,10 @@
 static unsigned int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 module_param(ple_window_max, uint, 0444);
 
+/* Default is SYSTEM mode. */
+static int __read_mostly pt_mode = PT_MODE_SYSTEM;
+module_param(pt_mode, int, S_IRUGO);
+
 extern const ulong vmx_return;
 extern const ulong vmx_early_consistency_check_return;
 
@@ -1955,6 +1960,20 @@ static bool vmx_umip_emulated(void)
 		SECONDARY_EXEC_DESC;
 }
 
+static inline bool cpu_has_vmx_intel_pt(void)
+{
+	u64 vmx_msr;
+
+	rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
+	return !!(vmx_msr & MSR_IA32_VMX_MISC_INTEL_PT);
+}
+
+static inline bool cpu_has_vmx_pt_use_gpa(void)
+{
+	return !!(vmcs_config.cpu_based_2nd_exec_ctrl &
+				SECONDARY_EXEC_PT_USE_GPA);
+}
+
 static inline bool report_flexpriority(void)
 {
 	return flexpriority_enabled;
@@ -4580,6 +4599,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 			SECONDARY_EXEC_RDRAND_EXITING |
 			SECONDARY_EXEC_ENABLE_PML |
 			SECONDARY_EXEC_TSC_SCALING |
+			SECONDARY_EXEC_PT_USE_GPA |
+			SECONDARY_EXEC_PT_CONCEAL_VMX |
 			SECONDARY_EXEC_ENABLE_VMFUNC |
 			SECONDARY_EXEC_ENCLS_EXITING;
 		if (adjust_vmx_controls(min2, opt2,
@@ -4625,7 +4646,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 	min |= VM_EXIT_HOST_ADDR_SPACE_SIZE;
 #endif
 	opt = VM_EXIT_SAVE_IA32_PAT | VM_EXIT_LOAD_IA32_PAT |
-		VM_EXIT_CLEAR_BNDCFGS;
+		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_PT_CONCEAL_PIP |
+		VM_EXIT_CLEAR_IA32_RTIT_CTL;
 	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_EXIT_CTLS,
 				&_vmexit_control) < 0)
 		return -EIO;
@@ -4644,11 +4666,20 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
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
@@ -6433,6 +6464,28 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
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
@@ -6567,6 +6620,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 		}
 	}
 
+	if (pt_mode == PT_MODE_SYSTEM)
+		exec_control &= ~(SECONDARY_EXEC_PT_USE_GPA |
+				  SECONDARY_EXEC_PT_CONCEAL_VMX);
+
 	vmx->secondary_exec_control = exec_control;
 }
 
@@ -6672,10 +6729,10 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 
 	vmx->arch_capabilities = kvm_get_arch_capabilities();
 
-	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
+	vm_exit_controls_init(vmx, vmx_vmexit_control(vmx));
 
 	/* 22.2.1, 20.8.1 */
-	vm_entry_controls_init(vmx, vmcs_config.vmentry_ctrl);
+	vm_entry_controls_init(vmx, vmx_vmentry_control(vmx));
 
 	vmx->vcpu.arch.cr0_guest_owned_bits = X86_CR0_TS;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~X86_CR0_TS);
@@ -8018,6 +8075,9 @@ static __init int hardware_setup(void)
 
 	kvm_mce_cap_supported |= MCG_LMCE_P;
 
+	if (!enable_ept || !cpu_has_vmx_intel_pt() || !cpu_has_vmx_pt_use_gpa())
+		pt_mode = PT_MODE_SYSTEM;
+
 	return alloc_kvm_area();
 
 out:
-- 
1.8.3.1

