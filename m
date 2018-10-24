Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF2C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00F520833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00F520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJXQex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:34:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:28654 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbeJXQew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:34:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="273987383"
Received: from skx-d.bj.intel.com ([10.238.135.53])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 01:07:45 -0700
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
Subject: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for each vcpu
Date:   Wed, 24 Oct 2018 16:05:12 +0800
Message-Id: <1540368316-12998-9-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Load/Store Intel Processor Trace register in context switch.
MSR IA32_RTIT_CTL is loaded/stored automatically from VMCS.
In Host-Guest mode, we need load/resore PT MSRs only when PT
is enabled in guest.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/intel_pt.h |  2 +
 arch/x86/kvm/vmx.c              | 94 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 4727584..eabbdbc 100644
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
index 692154c..d8480a6 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -978,6 +978,24 @@ struct vmx_msrs {
 	struct vmx_msr_entry	val[NR_AUTOLOAD_MSRS];
 };
 
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
@@ -1071,6 +1089,8 @@ struct vcpu_vmx {
 	u64 msr_ia32_feature_control;
 	u64 msr_ia32_feature_control_valid_bits;
 	u64 ept_pointer;
+
+	struct pt_desc pt_desc;
 };
 
 enum segment_cache_field {
@@ -2899,6 +2919,69 @@ static unsigned long segment_base(u16 selector)
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
 static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6749,6 +6832,13 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 
 	if (cpu_has_vmx_encls_vmexit())
 		vmcs_write64(ENCLS_EXITING_BITMAP, -1ull);
+
+	if (pt_mode == PT_MODE_HOST_GUEST) {
+		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
+		/* Bit[6~0] are forced to 1, writes are ignored. */
+		vmx->pt_desc.guest.output_mask = 0x7F;
+		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
+	}
 }
 
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -11260,6 +11350,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	    vcpu->arch.pkru != vmx->host_pkru)
 		__write_pkru(vcpu->arch.pkru);
 
+	pt_guest_enter(vmx);
+
 	atomic_switch_perf_msrs(vmx);
 
 	vmx_update_hv_timer(vcpu);
@@ -11459,6 +11551,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 				  | (1 << VCPU_EXREG_CR3));
 	vcpu->arch.regs_dirty = 0;
 
+	pt_guest_exit(vmx);
+
 	/*
 	 * eager fpu is enabled if PKEY is supported and CR4 is switched
 	 * back on host, so it is safe to read guest PKRU from current
-- 
1.8.3.1

