Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D7C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE92150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDE92150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbeHNUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388923AbeHNUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:34 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C11BC9A;
        Tue, 14 Aug 2018 17:42:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 061/107] x86/KVM/VMX: Add L1D flush logic
Date:   Tue, 14 Aug 2018 19:17:24 +0200
Message-Id: <20180814171524.738766841@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit c595ceee45707f00f64f61c54fb64ef0cc0b4e85 upstream

Add the logic for flushing L1D on VMENTER. The flush depends on the static
key being enabled and the new l1tf_flush_l1d flag being set.

The flags is set:
 - Always, if the flush module parameter is 'always'

 - Conditionally at:
   - Entry to vcpu_run(), i.e. after executing user space

   - From the sched_in notifier, i.e. when switching to a vCPU thread.

   - From vmexit handlers which are considered unsafe, i.e. where
     sensitive data can be brought into L1D:

     - The emulator, which could be a good target for other speculative
       execution-based threats,

     - The MMU, which can bring host page tables in the L1 cache.

     - External interrupts

     - Nested operations that require the MMU (see above). That is
       vmptrld, vmptrst, vmclear,vmwrite,vmread.

     - When handling invept,invvpid

[ tglx: Split out from combo patch and reduced to a single flag ]
[ dwmw2: Backported to 4.9, set l1tf_flush_l1d in svm/vmx code ]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    4 ++++
 arch/x86/kvm/svm.c              |    2 ++
 arch/x86/kvm/vmx.c              |   23 ++++++++++++++++++++++-
 arch/x86/kvm/x86.c              |    8 ++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -659,6 +659,9 @@ struct kvm_vcpu_arch {
 
 	int pending_ioapic_eoi;
 	int pending_external_vector;
+
+	/* Flush the L1 Data cache for L1TF mitigation on VMENTER */
+	bool l1tf_flush_l1d;
 };
 
 struct kvm_lpage_info {
@@ -819,6 +822,7 @@ struct kvm_vcpu_stat {
 	u64 signal_exits;
 	u64 irq_window_exits;
 	u64 nmi_window_exits;
+	u64 l1d_flush;
 	u64 halt_exits;
 	u64 halt_successful_poll;
 	u64 halt_attempted_poll;
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2124,6 +2124,8 @@ static int pf_interception(struct vcpu_s
 	u32 error_code;
 	int r = 1;
 
+	svm->vcpu.arch.l1tf_flush_l1d = true;
+
 	switch (svm->apf_reason) {
 	default:
 		error_code = svm->vmcb->control.exit_info_1;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5773,6 +5773,7 @@ static int handle_exception(struct kvm_v
 		BUG_ON(enable_ept);
 		cr2 = vmcs_readl(EXIT_QUALIFICATION);
 		trace_kvm_page_fault(cr2, error_code);
+		vcpu->arch.l1tf_flush_l1d = true;
 
 		if (kvm_event_needs_reinjection(vcpu))
 			kvm_mmu_unprotect_page_virt(vcpu, cr2);
@@ -8549,9 +8550,20 @@ static int vmx_handle_exit(struct kvm_vc
 #define L1D_CACHE_ORDER 4
 static void *vmx_l1d_flush_pages;
 
-static void __maybe_unused vmx_l1d_flush(void)
+static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+	bool always;
+
+	/*
+	 * If the mitigation mode is 'flush always', keep the flush bit
+	 * set, otherwise clear it. It gets set again either from
+	 * vcpu_run() or from one of the unsafe VMEXIT handlers.
+	 */
+	always = vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
+	vcpu->arch.l1tf_flush_l1d = always;
+
+	vcpu->stat.l1d_flush++;
 
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
@@ -8792,6 +8804,7 @@ static void vmx_handle_external_intr(str
 			[ss]"i"(__KERNEL_DS),
 			[cs]"i"(__KERNEL_CS)
 			);
+		vcpu->arch.l1tf_flush_l1d = true;
 	}
 }
 STACK_FRAME_NON_STANDARD(vmx_handle_external_intr);
@@ -9037,6 +9050,11 @@ static void __noclone vmx_vcpu_run(struc
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 
+	if (static_branch_unlikely(&vmx_l1d_should_flush)) {
+		if (vcpu->arch.l1tf_flush_l1d)
+			vmx_l1d_flush(vcpu);
+	}
+
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -10552,6 +10570,9 @@ static int nested_vmx_run(struct kvm_vcp
 
 	vmcs12->launch_state = 1;
 
+	/* Hide L1D cache contents from the nested guest.  */
+	vmx->vcpu.arch.l1tf_flush_l1d = true;
+
 	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
 		return kvm_vcpu_halt(vcpu);
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -180,6 +180,7 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "insn_emulation_fail", VCPU_STAT(insn_emulation_fail) },
 	{ "irq_injections", VCPU_STAT(irq_injections) },
 	{ "nmi_injections", VCPU_STAT(nmi_injections) },
+	{ "l1d_flush", VCPU_STAT(l1d_flush) },
 	{ "mmu_shadow_zapped", VM_STAT(mmu_shadow_zapped) },
 	{ "mmu_pte_write", VM_STAT(mmu_pte_write) },
 	{ "mmu_pte_updated", VM_STAT(mmu_pte_updated) },
@@ -4476,6 +4477,9 @@ static int emulator_write_std(struct x86
 int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
 				unsigned int bytes, struct x86_exception *exception)
 {
+	/* kvm_write_guest_virt_system can pull in tons of pages. */
+	vcpu->arch.l1tf_flush_l1d = true;
+
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
 					   PFERR_WRITE_MASK, exception);
 }
@@ -5574,6 +5578,8 @@ int x86_emulate_instruction(struct kvm_v
 	bool writeback = true;
 	bool write_fault_to_spt = vcpu->arch.write_fault_to_shadow_pgtable;
 
+	vcpu->arch.l1tf_flush_l1d = true;
+
 	/*
 	 * Clear write_fault_to_shadow_pgtable here to ensure it is
 	 * never reused.
@@ -6929,6 +6935,7 @@ static int vcpu_run(struct kvm_vcpu *vcp
 	struct kvm *kvm = vcpu->kvm;
 
 	vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
+	vcpu->arch.l1tf_flush_l1d = true;
 
 	for (;;) {
 		if (kvm_vcpu_running(vcpu)) {
@@ -7899,6 +7906,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcp
 
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
+	vcpu->arch.l1tf_flush_l1d = true;
 	kvm_x86_ops->sched_in(vcpu, cpu);
 }
 


