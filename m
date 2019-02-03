Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB32C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E020815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfBCOC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:02:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53146 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbfBCNts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:48 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-0003te-AG; Sun, 03 Feb 2019 13:49:46 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006x4-SK; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "David Matlack" <dmatlack@google.com>,
        "Bandan Das" <bsd@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.380539205@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 093/305] KVM: x86: remove code for lazy FPU handling
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit bd7e5b0899a429445cc6e3037c13f8b5ae3be903 upstream.

The FPU is always active now when running KVM.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Bandan Das <bsd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16:
 - eagerfpu is still optional (but enabled by default) so disable KVM if
   eagerfpu is disabled
 - Remove one additional use of KVM_REQ_DEACTIVATE_FPU which was
   removed earlier upstream in commit c592b5734706
   "x86/fpu: Remove use_eager_fpu()"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -711,8 +711,6 @@ struct kvm_x86_ops {
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
-	void (*fpu_activate)(struct kvm_vcpu *vcpu);
-	void (*fpu_deactivate)(struct kvm_vcpu *vcpu);
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu);
 
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1119,7 +1119,6 @@ static void init_vmcb(struct vcpu_svm *s
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	struct vmcb_save_area *save = &svm->vmcb->save;
 
-	svm->vcpu.fpu_active = 1;
 	svm->vcpu.arch.hflags = 0;
 
 	set_cr_intercept(svm, INTERCEPT_CR0_READ);
@@ -1574,15 +1573,12 @@ static void update_cr0_intercept(struct
 	ulong gcr0 = svm->vcpu.arch.cr0;
 	u64 *hcr0 = &svm->vmcb->save.cr0;
 
-	if (!svm->vcpu.fpu_active)
-		*hcr0 |= SVM_CR0_SELECTIVE_MASK;
-	else
-		*hcr0 = (*hcr0 & ~SVM_CR0_SELECTIVE_MASK)
-			| (gcr0 & SVM_CR0_SELECTIVE_MASK);
+	*hcr0 = (*hcr0 & ~SVM_CR0_SELECTIVE_MASK)
+		| (gcr0 & SVM_CR0_SELECTIVE_MASK);
 
 	mark_dirty(svm->vmcb, VMCB_CR);
 
-	if (gcr0 == *hcr0 && svm->vcpu.fpu_active) {
+	if (gcr0 == *hcr0) {
 		clr_cr_intercept(svm, INTERCEPT_CR0_READ);
 		clr_cr_intercept(svm, INTERCEPT_CR0_WRITE);
 	} else {
@@ -1613,8 +1609,6 @@ static void svm_set_cr0(struct kvm_vcpu
 	if (!npt_enabled)
 		cr0 |= X86_CR0_PG | X86_CR0_WP;
 
-	if (!vcpu->fpu_active)
-		cr0 |= X86_CR0_TS;
 	/*
 	 * re-enable caching here because the QEMU bios
 	 * does not do it - this results in some delay at
@@ -1834,22 +1828,6 @@ static int ac_interception(struct vcpu_s
 	return 1;
 }
 
-static void svm_fpu_activate(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-
-	clr_exception_intercept(svm, NM_VECTOR);
-
-	svm->vcpu.fpu_active = 1;
-	update_cr0_intercept(svm);
-}
-
-static int nm_interception(struct vcpu_svm *svm)
-{
-	svm_fpu_activate(&svm->vcpu);
-	return 1;
-}
-
 static bool is_erratum_383(void)
 {
 	int err, i;
@@ -2227,9 +2205,6 @@ static int nested_svm_exit_special(struc
 		if (!npt_enabled && svm->apf_reason == 0)
 			return NESTED_EXIT_HOST;
 		break;
-	case SVM_EXIT_EXCP_BASE + NM_VECTOR:
-		nm_interception(svm);
-		break;
 	default:
 		break;
 	}
@@ -3448,7 +3423,6 @@ static int (*const svm_exit_handlers[])(
 	[SVM_EXIT_EXCP_BASE + BP_VECTOR]	= bp_interception,
 	[SVM_EXIT_EXCP_BASE + UD_VECTOR]	= ud_interception,
 	[SVM_EXIT_EXCP_BASE + PF_VECTOR]	= pf_interception,
-	[SVM_EXIT_EXCP_BASE + NM_VECTOR]	= nm_interception,
 	[SVM_EXIT_EXCP_BASE + MC_VECTOR]	= mc_interception,
 	[SVM_EXIT_EXCP_BASE + AC_VECTOR]	= ac_interception,
 	[SVM_EXIT_INTR]				= intr_interception,
@@ -4285,14 +4259,6 @@ static bool svm_has_wbinvd_exit(void)
 	return true;
 }
 
-static void svm_fpu_deactivate(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-
-	set_exception_intercept(svm, NM_VECTOR);
-	update_cr0_intercept(svm);
-}
-
 #define PRE_EX(exit)  { .exit_code = (exit), \
 			.stage = X86_ICPT_PRE_EXCEPT, }
 #define POST_EX(exit) { .exit_code = (exit), \
@@ -4526,8 +4492,6 @@ static struct kvm_x86_ops svm_x86_ops =
 	.cache_reg = svm_cache_reg,
 	.get_rflags = svm_get_rflags,
 	.set_rflags = svm_set_rflags,
-	.fpu_activate = svm_fpu_activate,
-	.fpu_deactivate = svm_fpu_deactivate,
 
 	.tlb_flush = svm_flush_tlb,
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1491,7 +1491,7 @@ static void update_exception_bitmap(stru
 	u32 eb;
 
 	eb = (1u << PF_VECTOR) | (1u << UD_VECTOR) | (1u << MC_VECTOR) |
-	     (1u << NM_VECTOR) | (1u << DB_VECTOR) | (1u << AC_VECTOR);
+	     (1u << DB_VECTOR) | (1u << AC_VECTOR);
 	if ((vcpu->guest_debug &
 	     (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)) ==
 	    (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP))
@@ -1500,8 +1500,6 @@ static void update_exception_bitmap(stru
 		eb = ~0;
 	if (enable_ept)
 		eb &= ~(1u << PF_VECTOR); /* bypass_guest_pf = 0 */
-	if (vcpu->fpu_active)
-		eb &= ~(1u << NM_VECTOR);
 
 	/* When we are running a nested L2 guest and L1 specified for it a
 	 * certain exception bitmap, we must trap the same exceptions and pass
@@ -1904,25 +1902,6 @@ static void vmx_vcpu_put(struct kvm_vcpu
 	}
 }
 
-static void vmx_fpu_activate(struct kvm_vcpu *vcpu)
-{
-	ulong cr0;
-
-	if (vcpu->fpu_active)
-		return;
-	vcpu->fpu_active = 1;
-	cr0 = vmcs_readl(GUEST_CR0);
-	cr0 &= ~(X86_CR0_TS | X86_CR0_MP);
-	cr0 |= kvm_read_cr0_bits(vcpu, X86_CR0_TS | X86_CR0_MP);
-	vmcs_writel(GUEST_CR0, cr0);
-	update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits = X86_CR0_TS;
-	if (is_guest_mode(vcpu))
-		vcpu->arch.cr0_guest_owned_bits &=
-			~get_vmcs12(vcpu)->cr0_guest_host_mask;
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
-}
-
 static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
 
 /*
@@ -1941,33 +1920,6 @@ static inline unsigned long nested_read_
 		(fields->cr4_read_shadow & fields->cr4_guest_host_mask);
 }
 
-static void vmx_fpu_deactivate(struct kvm_vcpu *vcpu)
-{
-	/* Note that there is no vcpu->fpu_active = 0 here. The caller must
-	 * set this *before* calling this function.
-	 */
-	vmx_decache_cr0_guest_bits(vcpu);
-	vmcs_set_bits(GUEST_CR0, X86_CR0_TS | X86_CR0_MP);
-	update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits = 0;
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
-	if (is_guest_mode(vcpu)) {
-		/*
-		 * L1's specified read shadow might not contain the TS bit,
-		 * so now that we turned on shadowing of this bit, we need to
-		 * set this bit of the shadow. Like in nested_vmx_run we need
-		 * nested_read_cr0(vmcs12), but vmcs12->guest_cr0 is not yet
-		 * up-to-date here because we just decached cr0.TS (and we'll
-		 * only update vmcs12->guest_cr0 on nested exit).
-		 */
-		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-		vmcs12->guest_cr0 = (vmcs12->guest_cr0 & ~X86_CR0_TS) |
-			(vcpu->arch.cr0 & X86_CR0_TS);
-		vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));
-	} else
-		vmcs_writel(CR0_READ_SHADOW, vcpu->arch.cr0);
-}
-
 static unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 {
 	unsigned long rflags, save_rflags;
@@ -3586,9 +3538,6 @@ static void vmx_set_cr0(struct kvm_vcpu
 	if (enable_ept)
 		ept_update_paging_mode_cr0(&hw_cr0, cr0, vcpu);
 
-	if (!vcpu->fpu_active)
-		hw_cr0 |= X86_CR0_TS | X86_CR0_MP;
-
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
 	vcpu->arch.cr0 = cr0;
@@ -4644,7 +4593,9 @@ static int vmx_vcpu_setup(struct vcpu_vm
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_init(vmx, vmcs_config.vmentry_ctrl);
 
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~0UL);
+	vmx->vcpu.arch.cr0_guest_owned_bits = X86_CR0_TS;
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~X86_CR0_TS);
+
 	set_cr4_guest_host_mask(vmx);
 
 	return 0;
@@ -4736,7 +4687,7 @@ static void vmx_vcpu_reset(struct kvm_vc
 	vmx_set_cr0(&vmx->vcpu, kvm_read_cr0(vcpu)); /* enter rmode */
 	vmx_set_cr4(&vmx->vcpu, 0);
 	vmx_set_efer(&vmx->vcpu, 0);
-	vmx_fpu_activate(&vmx->vcpu);
+
 	update_exception_bitmap(&vmx->vcpu);
 
 	vpid_sync_context(vmx);
@@ -5022,11 +4973,6 @@ static int handle_exception(struct kvm_v
 	if (is_nmi(intr_info))
 		return 1;  /* already handled by vmx_vcpu_run() */
 
-	if (is_no_device(intr_info)) {
-		vmx_fpu_activate(vcpu);
-		return 1;
-	}
-
 	if (is_invalid_opcode(intr_info)) {
 		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
 		if (er == EMULATE_USER_EXIT)
@@ -5218,22 +5164,6 @@ static int handle_set_cr4(struct kvm_vcp
 		return kvm_set_cr4(vcpu, val);
 }
 
-/* called to set cr0 as approriate for clts instruction exit. */
-static void handle_clts(struct kvm_vcpu *vcpu)
-{
-	if (is_guest_mode(vcpu)) {
-		/*
-		 * We get here when L2 did CLTS, and L1 didn't shadow CR0.TS
-		 * but we did (!fpu_active). We need to keep GUEST_CR0.TS on,
-		 * just pretend it's off (also in arch.cr0 for fpu_activate).
-		 */
-		vmcs_writel(CR0_READ_SHADOW,
-			vmcs_readl(CR0_READ_SHADOW) & ~X86_CR0_TS);
-		vcpu->arch.cr0 &= ~X86_CR0_TS;
-	} else
-		vmx_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
-}
-
 static int handle_cr(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification, val;
@@ -5276,10 +5206,10 @@ static int handle_cr(struct kvm_vcpu *vc
 		}
 		break;
 	case 2: /* clts */
-		handle_clts(vcpu);
+		WARN_ONCE(1, "Guest should always own CR0.TS");
+		vmx_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
 		trace_kvm_cr_write(0, kvm_read_cr0(vcpu));
 		skip_emulated_instruction(vcpu);
-		vmx_fpu_activate(vcpu);
 		return 1;
 	case 1: /*mov from cr*/
 		switch (cr) {
@@ -8299,8 +8229,8 @@ static void prepare_vmcs02(struct kvm_vc
 	vmx_set_efer(vcpu, vcpu->arch.efer);
 
 	/*
-	 * This sets GUEST_CR0 to vmcs12->guest_cr0, with possibly a modified
-	 * TS bit (for lazy fpu) and bits which we consider mandatory enabled.
+	 * This sets GUEST_CR0 to vmcs12->guest_cr0, possibly modifying those
+	 * bits which we consider mandatory enabled.
 	 * The CR0_READ_SHADOW is what L2 should have expected to read given
 	 * the specifications by L1; It's not enough to take
 	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
@@ -8814,24 +8744,15 @@ static void load_vmcs12_host_state(struc
 	vmx_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	/*
 	 * Note that calling vmx_set_cr0 is important, even if cr0 hasn't
-	 * actually changed, because it depends on the current state of
-	 * fpu_active (which may have changed).
-	 * Note that vmx_set_cr0 refers to efer set above.
+	 * actually changed, because vmx_set_cr0 refers to efer set above.
+	 *
+	 * CR0_GUEST_HOST_MASK is already set in the original vmcs01
+	 * (KVM doesn't change it);
 	 */
+	vcpu->arch.cr0_guest_owned_bits = X86_CR0_TS;
 	vmx_set_cr0(vcpu, vmcs12->host_cr0);
-	/*
-	 * If we did fpu_activate()/fpu_deactivate() during L2's run, we need
-	 * to apply the same changes to L1's vmcs. We just set cr0 correctly,
-	 * but we also need to update cr0_guest_host_mask and exception_bitmap.
-	 */
-	update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits = (vcpu->fpu_active ? X86_CR0_TS : 0);
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
-	/*
-	 * Note that CR4_GUEST_HOST_MASK is already set in the original vmcs01
-	 * (KVM doesn't change it)- no reason to call set_cr4_guest_host_mask();
-	 */
+	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs12->host_cr4);
 
@@ -9081,8 +9002,6 @@ static struct kvm_x86_ops vmx_x86_ops =
 	.cache_reg = vmx_cache_reg,
 	.get_rflags = vmx_get_rflags,
 	.set_rflags = vmx_set_rflags,
-	.fpu_activate = vmx_fpu_activate,
-	.fpu_deactivate = vmx_fpu_deactivate,
 
 	.tlb_flush = vmx_flush_tlb,
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5698,6 +5698,12 @@ int kvm_arch_init(void *opaque)
 		goto out;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_EAGER_FPU)) {
+		pr_err("kvm: requires eagerfpu\n");
+		r = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!ops->cpu_has_kvm_support()) {
 		printk(KERN_ERR "kvm: no hardware support\n");
 		r = -EOPNOTSUPP;
@@ -6099,10 +6105,6 @@ static int vcpu_enter_guest(struct kvm_v
 			r = 0;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_DEACTIVATE_FPU, vcpu)) {
-			vcpu->fpu_active = 0;
-			kvm_x86_ops->fpu_deactivate(vcpu);
-		}
 		if (kvm_check_request(KVM_REQ_APF_HALT, vcpu)) {
 			/* Page is swapped out. Do synthetic halt */
 			vcpu->arch.apf.halted = true;
@@ -6159,8 +6161,7 @@ static int vcpu_enter_guest(struct kvm_v
 	preempt_disable();
 
 	kvm_x86_ops->prepare_guest_switch(vcpu);
-	if (vcpu->fpu_active)
-		kvm_load_guest_fpu(vcpu);
+	kvm_load_guest_fpu(vcpu);
 	vcpu->mode = IN_GUEST_MODE;
 
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
@@ -6917,7 +6918,6 @@ void kvm_put_guest_fpu(struct kvm_vcpu *
 	fpu_save_init(&vcpu->arch.guest_fpu);
 	__kernel_fpu_end();
 	++vcpu->stat.fpu_reload;
-	kvm_make_request(KVM_REQ_DEACTIVATE_FPU, vcpu);
 	trace_kvm_fpu(0);
 }
 
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -121,7 +121,6 @@ static inline bool is_error_page(struct
 #define KVM_REQ_MMU_SYNC           7
 #define KVM_REQ_CLOCK_UPDATE       8
 #define KVM_REQ_KICK               9
-#define KVM_REQ_DEACTIVATE_FPU    10
 #define KVM_REQ_EVENT             11
 #define KVM_REQ_APF_HALT          12
 #define KVM_REQ_STEAL_UPDATE      13
@@ -232,7 +231,6 @@ struct kvm_vcpu {
 	struct mutex mutex;
 	struct kvm_run *run;
 
-	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
 	wait_queue_head_t wq;
 	struct pid *pid;

