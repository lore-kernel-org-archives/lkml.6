Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeEVC6l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:58:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:56138 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeEVC6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:58:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="201335998"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        chao.p.peng@linux.intel.com, thomas.lendacky@amd.com, bp@suse.de,
        Kan.liang@intel.com, Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v9 08/12] KVM: x86: Add Intel Processor Trace context switch for each vcpu
Date: Tue, 22 May 2018 12:52:11 +0800
Message-Id: <1526964735-16566-9-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Load/Store Intel processor trace register in context switch.
MSR IA32_RTIT_CTL is loaded/stored automatically from VMCS.
In HOST_GUEST mode, we need load/resore PT MSRs only when PT
is enabled in guest.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/intel_pt.h |  2 +
 arch/x86/kvm/vmx.c              | 94 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 5748205..70f4139 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -8,6 +8,8 @@
 #define PT_MODE_SYSTEM		0
 #define PT_MODE_HOST_GUEST	1
 
+#define RTIT_ADDR_RANGE		4
+
 enum pt_capabilities {
 	PT_CAP_max_subleaf = 0,
 	PT_CAP_cr3_filtering,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 24aded4..11fb90a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -597,6 +597,24 @@ static inline int pi_test_sn(struct pi_desc *pi_desc)
 			(unsigned long *)&pi_desc->control);
 }
 
+struct pt_ctx {
+	u64 ctl;
+	u64 status;
+	u64 output_base;
+	u64 output_mask;
+	u64 cr3_match;
+	u64 addr_a[RTIT_ADDR_RANGE];
+	u64 addr_b[RTIT_ADDR_RANGE];
+};
+
+struct pt_desc {
+	u64 ctl_bitmask;
+	u32 addr_range;
+	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
+	struct pt_ctx host;
+	struct pt_ctx guest;
+};
+
 struct vcpu_vmx {
 	struct kvm_vcpu       vcpu;
 	unsigned long         host_rsp;
@@ -693,6 +711,8 @@ struct vcpu_vmx {
 	 */
 	u64 msr_ia32_feature_control;
 	u64 msr_ia32_feature_control_valid_bits;
+
+	struct pt_desc pt_desc;
 };
 
 enum segment_cache_field {
@@ -2391,6 +2411,69 @@ static unsigned long segment_base(u16 selector)
 }
 #endif
 
+static inline void pt_load_msr(struct pt_ctx *ctx, u32 addr_range)
+{
+	u32 i;
+
+	wrmsrl(MSR_IA32_RTIT_STATUS, ctx->status);
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
+	wrmsrl(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
+	for (i = 0; i < addr_range; i++) {
+		wrmsrl(MSR_IA32_RTIT_ADDR0_A + i * 2, ctx->addr_a[i]);
+		wrmsrl(MSR_IA32_RTIT_ADDR0_B + i * 2, ctx->addr_b[i]);
+	}
+}
+
+static inline void pt_save_msr(struct pt_ctx *ctx, u32 addr_range)
+{
+	u32 i;
+
+	rdmsrl(MSR_IA32_RTIT_STATUS, ctx->status);
+	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
+	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
+	rdmsrl(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
+	for (i = 0; i < addr_range; i++) {
+		rdmsrl(MSR_IA32_RTIT_ADDR0_A + i * 2, ctx->addr_a[i]);
+		rdmsrl(MSR_IA32_RTIT_ADDR0_B + i * 2, ctx->addr_b[i]);
+	}
+}
+
+static void pt_guest_enter(struct vcpu_vmx *vmx)
+{
+	if (pt_mode == PT_MODE_SYSTEM)
+		return;
+
+	/* Save host state before VM entry */
+	rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+
+	/*
+	 * Set guest state of MSR_IA32_RTIT_CTL MSR (PT will be disabled
+	 * on VM entry when it has been disabled in guest before).
+	 */
+	vmcs_write64(GUEST_IA32_RTIT_CTL, vmx->pt_desc.guest.ctl);
+
+	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
+		wrmsrl(MSR_IA32_RTIT_CTL, 0);
+		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.addr_range);
+		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.addr_range);
+	}
+}
+
+static void pt_guest_exit(struct vcpu_vmx *vmx)
+{
+	if (pt_mode == PT_MODE_SYSTEM)
+		return;
+
+	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
+		pt_save_msr(&vmx->pt_desc.guest, vmx->pt_desc.addr_range);
+		pt_load_msr(&vmx->pt_desc.host, vmx->pt_desc.addr_range);
+	}
+
+	/* Reload host state (IA32_RTIT_CTL will be cleared on VM exit). */
+	wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+}
+
 static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6135,6 +6218,13 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
 		vmcs_write16(GUEST_PML_INDEX, PML_ENTITY_NUM - 1);
 	}
+
+	if (pt_mode == PT_MODE_HOST_GUEST) {
+		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
+		/* Bit[6~0] are forced to 1, writes are ignored. */
+		vmx->pt_desc.guest.output_mask = 0x7F;
+		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
+	}
 }
 
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -9800,6 +9890,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	    vcpu->arch.pkru != vmx->host_pkru)
 		__write_pkru(vcpu->arch.pkru);
 
+	pt_guest_enter(vmx);
+
 	atomic_switch_perf_msrs(vmx);
 
 	vmx_arm_hv_timer(vcpu);
@@ -9994,6 +10086,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 				  | (1 << VCPU_EXREG_CR3));
 	vcpu->arch.regs_dirty = 0;
 
+	pt_guest_exit(vmx);
+
 	/*
 	 * eager fpu is enabled if PKEY is supported and CR4 is switched
 	 * back on host, so it is safe to read guest PKRU from current
-- 
1.8.3.1
