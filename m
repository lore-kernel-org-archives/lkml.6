Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeECKQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:16:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:44408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752123AbeECKPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:15:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38109849"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 09/13] KVM: x86: Implement Intel Processor Trace context switch
Date: Thu,  3 May 2018 20:08:39 +0800
Message-Id: <1525349323-9938-10-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Load/Store Intel processor trace register in context switch.
MSR IA32_RTIT_CTL is loaded/stored automatically from VMCS.
In HOST mode, we just need to restore the status of IA32_RTIT_CTL.
In HOST_GUEST mode, we need load/resore PT MSRs only when PT is
enabled in guest.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9a5c26d..a08c61b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2385,6 +2385,55 @@ static unsigned long segment_base(u16 selector)
 }
 #endif
 
+static inline void pt_load_msr(struct pt_ctx *ctx, u32 range_cnt)
+{
+	u32 i;
+
+	wrmsrl(MSR_IA32_RTIT_STATUS, ctx->status);
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
+	wrmsrl(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
+	for (i = 0; i < range_cnt; i++)
+		wrmsrl(MSR_IA32_RTIT_ADDR0_A + i, ctx->addrs[i]);
+}
+
+static inline void pt_save_msr(struct pt_ctx *ctx, u32 range_cnt)
+{
+	u32 i;
+
+	rdmsrl(MSR_IA32_RTIT_STATUS, ctx->status);
+	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
+	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
+	rdmsrl(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
+	for (i = 0; i < range_cnt; i++)
+		rdmsrl(MSR_IA32_RTIT_ADDR0_A + i, ctx->addrs[i]);
+}
+
+static void pt_guest_enter(struct vcpu_vmx *vmx)
+{
+	if (pt_mode == PT_MODE_HOST || pt_mode == PT_MODE_HOST_GUEST)
+		rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+
+	if (pt_mode == PT_MODE_HOST_GUEST &&
+		vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
+		wrmsrl(MSR_IA32_RTIT_CTL, 0);
+		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.range_cnt);
+		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.range_cnt);
+	}
+}
+
+static void pt_guest_exit(struct vcpu_vmx *vmx)
+{
+	if (pt_mode == PT_MODE_HOST_GUEST &&
+		vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
+		pt_save_msr(&vmx->pt_desc.guest, vmx->pt_desc.range_cnt);
+		pt_load_msr(&vmx->pt_desc.host, vmx->pt_desc.range_cnt);
+	}
+
+	if (pt_mode == PT_MODE_HOST || pt_mode == PT_MODE_HOST_GUEST)
+		wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+}
+
 static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6119,6 +6168,13 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
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
@@ -9794,6 +9850,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	    vcpu->arch.pkru != vmx->host_pkru)
 		__write_pkru(vcpu->arch.pkru);
 
+	pt_guest_enter(vmx);
+
 	atomic_switch_perf_msrs(vmx);
 
 	vmx_arm_hv_timer(vcpu);
@@ -9988,6 +10046,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 				  | (1 << VCPU_EXREG_CR3));
 	vcpu->arch.regs_dirty = 0;
 
+	pt_guest_exit(vmx);
+
 	/*
 	 * eager fpu is enabled if PKEY is supported and CR4 is switched
 	 * back on host, so it is safe to read guest PKRU from current
-- 
1.8.3.1
