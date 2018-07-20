Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD64ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801F320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801F320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeGTOPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:15:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731693AbeGTOO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:14:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0973402B032;
        Fri, 20 Jul 2018 13:26:40 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD712026D69;
        Fri, 20 Jul 2018 13:26:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 7/7] x86/kvm/nVMX: optimize MMU switch from nested_vmx_load_cr3()
Date:   Fri, 20 Jul 2018 15:26:26 +0200
Message-Id: <20180720132626.5975-8-vkuznets@redhat.com>
In-Reply-To: <20180720132626.5975-1-vkuznets@redhat.com>
References: <20180720132626.5975-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:26:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:26:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have everything in place to stop doing MMU reload when we switch
from L1 to L2 and back. Generalize shadow_ept_mmu_update_needed() making it
suitable for kvm_mmu_reset_context().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 10 +++++-
 arch/x86/kvm/cpuid.c            |  2 +-
 arch/x86/kvm/mmu.c              | 74 +++++++++++++++++++++++++++++++----------
 arch/x86/kvm/svm.c              |  6 ++--
 arch/x86/kvm/vmx.c              |  7 ++--
 arch/x86/kvm/x86.c              | 14 ++++----
 6 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fa73cf13c4d0..63ad28c40c1d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -327,15 +327,22 @@ struct rsvd_bits_validate {
 
 /* Source data used to setup MMU */
 struct kvm_mmu_sdata_cache {
+	unsigned long cr3;
+
 	unsigned int valid:1;
+	unsigned int smm:1;
 	unsigned int ept_ad:1;
 	unsigned int execonly:1;
+	unsigned int cr0_pg:1;
 	unsigned int cr0_wp:1;
 	unsigned int cr4_pae:1;
 	unsigned int cr4_pse:1;
 	unsigned int cr4_pke:1;
 	unsigned int cr4_smap:1;
 	unsigned int cr4_smep:1;
+	unsigned int cr4_la57:1;
+	unsigned int efer_lma:1;
+	unsigned int efer_nx:1;
 };
 
 /*
@@ -1149,7 +1156,8 @@ void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
 		u64 dirty_mask, u64 nx_mask, u64 x_mask, u64 p_mask,
 		u64 acc_track_mask, u64 me_mask);
 
-void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
+void kvm_mmu_reset_context(struct kvm_vcpu *vcpu, bool check_if_unchanged);
+
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 				      struct kvm_memory_slot *memslot);
 void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7e042e3d47fd..b0efd08075d8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -142,7 +142,7 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
 
 	/* Update physical-address width */
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
-	kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu, false);
 
 	kvm_pmu_refresh(vcpu);
 	return 0;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index eed1773453cd..9c08ee2e517a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4470,10 +4470,8 @@ static void paging32E_init_context(struct kvm_vcpu *vcpu,
 	paging64_init_context_common(vcpu, context, PT32E_ROOT_LEVEL);
 }
 
-static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
+static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
 {
-	struct kvm_mmu *context = vcpu->arch.mmu;
-
 	context->base_role.word = 0;
 	context->base_role.guest_mode = is_guest_mode(vcpu);
 	context->base_role.smm = is_smm(vcpu);
@@ -4548,21 +4546,30 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 
-static inline bool shadow_ept_mmu_update_needed(struct kvm_vcpu *vcpu,
-					bool execonly, bool accessed_dirty)
+static inline bool mmu_update_needed(struct kvm_vcpu *vcpu,
+				     struct kvm_mmu *context,
+				     bool execonly, bool accessed_dirty)
 {
-	struct kvm_mmu *context = vcpu->arch.mmu;
 	bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
 	bool cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
 	bool cr4_pke = kvm_read_cr4_bits(vcpu, X86_CR4_PKE) != 0;
-	bool cr0_wp = is_write_protection(vcpu);
+	bool cr4_la57 = kvm_read_cr4_bits(vcpu, X86_CR4_LA57) != 0;
 	bool cr4_pse = is_pse(vcpu);
+	bool cr0_wp = is_write_protection(vcpu);
+	bool cr0_pg = is_paging(vcpu);
+	bool efer_nx = is_nx(vcpu);
+	bool efer_lma = is_long_mode(vcpu);
+	bool smm = is_smm(vcpu);
 	bool res = false;
 
 	if (!context->scache.valid) {
 		res = true;
 		context->scache.valid = 1;
 	}
+	if (context->scache.smm != smm) {
+		context->scache.smm = smm;
+		res = true;
+	}
 	if (context->scache.ept_ad != accessed_dirty) {
 		context->scache.ept_ad = accessed_dirty;
 		res = true;
@@ -4587,10 +4594,26 @@ static inline bool shadow_ept_mmu_update_needed(struct kvm_vcpu *vcpu,
 		res = true;
 		context->scache.cr4_pke = cr4_pke;
 	}
+	if (context->scache.cr4_la57 != cr4_la57) {
+		res = true;
+		context->scache.cr4_la57 = cr4_la57;
+	}
 	if (context->scache.cr0_wp != cr0_wp) {
 		res = true;
 		context->scache.cr0_wp = cr0_wp;
 	}
+	if (context->scache.cr0_pg != cr0_pg) {
+		res = true;
+		context->scache.cr0_pg = cr0_pg;
+	}
+	if (context->scache.efer_nx != efer_nx) {
+		res = true;
+		context->scache.efer_nx = efer_nx;
+	}
+	if (context->scache.efer_lma != efer_lma) {
+		res = true;
+		context->scache.efer_lma = efer_lma;
+	}
 
 	return res;
 }
@@ -4600,7 +4623,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
 
-	if (!shadow_ept_mmu_update_needed(vcpu, execonly, accessed_dirty))
+	if (!mmu_update_needed(vcpu, context, execonly, accessed_dirty))
 		return;
 
 	context->shadow_root_level = PT64_ROOT_4LEVEL;
@@ -4627,10 +4650,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_ept_mmu);
 
-static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
+static void init_kvm_softmmu(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
 {
-	struct kvm_mmu *context = vcpu->arch.mmu;
-
 	kvm_init_shadow_mmu(vcpu);
 	context->set_cr3           = kvm_x86_ops->set_cr3;
 	context->get_cr3           = get_cr3;
@@ -4638,10 +4659,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 	context->inject_page_fault = kvm_inject_page_fault;
 }
 
-static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
+static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
+				struct kvm_mmu *g_context)
 {
-	struct kvm_mmu *g_context = &vcpu->arch.nested_mmu;
-
 	g_context->get_cr3           = get_cr3;
 	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
@@ -4681,16 +4701,34 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 	update_last_nonleaf_level(vcpu, g_context);
 }
 
-void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
+void kvm_mmu_reset_context(struct kvm_vcpu *vcpu, bool check_if_unchanged)
 {
+	struct kvm_mmu *context = mmu_is_nested(vcpu) ?
+		&vcpu->arch.nested_mmu : vcpu->arch.mmu;
+
+	if (check_if_unchanged && !mmu_update_needed(vcpu, context, 0, 0) &&
+	    context->scache.cr3 == vcpu->arch.mmu->get_cr3(vcpu)) {
+		/*
+		 * Nothing changed but TLB should always be flushed, e.g. when
+		 * we switch between L1 and L2.
+		 */
+		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+		return;
+	} else if (!check_if_unchanged) {
+		context->scache.valid = 0;
+	}
+
 	kvm_mmu_unload(vcpu);
 
 	if (mmu_is_nested(vcpu))
-		init_kvm_nested_mmu(vcpu);
+		init_kvm_nested_mmu(vcpu, context);
 	else if (tdp_enabled)
-		init_kvm_tdp_mmu(vcpu);
+		init_kvm_tdp_mmu(vcpu, context);
 	else
-		init_kvm_softmmu(vcpu);
+		init_kvm_softmmu(vcpu, context);
+
+	if (check_if_unchanged)
+		context->scache.cr3 = vcpu->arch.mmu->get_cr3(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_reset_context);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 3b3b9839c2b5..6c1db96971c0 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1574,7 +1574,7 @@ static void init_vmcb(struct vcpu_svm *svm)
 	 * It also updates the guest-visible cr0 value.
 	 */
 	svm_set_cr0(&svm->vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
-	kvm_mmu_reset_context(&svm->vcpu);
+	kvm_mmu_reset_context(&svm->vcpu, false);
 
 	save->cr4 = X86_CR4_PAE;
 	/* rdx = ?? */
@@ -3380,7 +3380,7 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 	nested_svm_unmap(page);
 
 	nested_svm_uninit_mmu_context(&svm->vcpu);
-	kvm_mmu_reset_context(&svm->vcpu);
+	kvm_mmu_reset_context(&svm->vcpu, false);
 	kvm_mmu_load(&svm->vcpu);
 
 	return 0;
@@ -3466,7 +3466,7 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 		(void)kvm_set_cr3(&svm->vcpu, nested_vmcb->save.cr3);
 
 	/* Guest paging mode is active - reset mmu */
-	kvm_mmu_reset_context(&svm->vcpu);
+	kvm_mmu_reset_context(&svm->vcpu, false);
 
 	svm->vmcb->save.cr2 = svm->vcpu.arch.cr2 = nested_vmcb->save.cr2;
 	kvm_register_write(&svm->vcpu, VCPU_REGS_RAX, nested_vmcb->save.rax);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 3467665a75d5..a85ed004a4ba 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4696,7 +4696,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	fix_rmode_seg(VCPU_SREG_GS, &vmx->rmode.segs[VCPU_SREG_GS]);
 	fix_rmode_seg(VCPU_SREG_FS, &vmx->rmode.segs[VCPU_SREG_FS]);
 
-	kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu, false);
 }
 
 static void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
@@ -11123,6 +11123,8 @@ static bool nested_cr3_valid(struct kvm_vcpu *vcpu, unsigned long val)
 static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool nested_ept,
 			       u32 *entry_failure_code)
 {
+	bool mmu_reset_force = false;
+
 	if (cr3 != kvm_read_cr3(vcpu) || (!nested_ept && pdptrs_changed(vcpu))) {
 		if (!nested_cr3_valid(vcpu, cr3)) {
 			*entry_failure_code = ENTRY_FAIL_DEFAULT;
@@ -11135,6 +11137,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
 		 */
 		if (!is_long_mode(vcpu) && is_pae(vcpu) && is_paging(vcpu) &&
 		    !nested_ept) {
+			mmu_reset_force = true;
 			if (!load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3)) {
 				*entry_failure_code = ENTRY_FAIL_PDPTE;
 				return 1;
@@ -11145,7 +11148,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
 		__set_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail);
 	}
 
-	kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu, !mmu_reset_force);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5510a7f50195..3288a7e303ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -695,7 +695,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 
 	if ((cr0 ^ old_cr0) & update_bits)
-		kvm_mmu_reset_context(vcpu);
+		kvm_mmu_reset_context(vcpu, false);
 
 	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
 	    kvm_arch_has_noncoherent_dma(vcpu->kvm) &&
@@ -836,7 +836,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 	if (((cr4 ^ old_cr4) & pdptr_bits) ||
 	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
-		kvm_mmu_reset_context(vcpu);
+		kvm_mmu_reset_context(vcpu, false);
 
 	if ((cr4 ^ old_cr4) & (X86_CR4_OSXSAVE | X86_CR4_PKE))
 		kvm_update_cpuid(vcpu);
@@ -1162,7 +1162,7 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 
 	/* Update reserved bits */
 	if ((efer ^ old_efer) & EFER_NX)
-		kvm_mmu_reset_context(vcpu);
+		kvm_mmu_reset_context(vcpu, false);
 
 	return 0;
 }
@@ -5898,7 +5898,7 @@ static void kvm_smm_changed(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 	}
 
-	kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu, false);
 }
 
 static void kvm_set_hflags(struct kvm_vcpu *vcpu, unsigned emul_flags)
@@ -7156,7 +7156,7 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 		kvm_x86_ops->set_efer(vcpu, 0);
 
 	kvm_update_cpuid(vcpu);
-	kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu, false);
 }
 
 static void process_smi(struct kvm_vcpu *vcpu)
@@ -8058,7 +8058,7 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
 	if (mmu_reset_needed)
-		kvm_mmu_reset_context(vcpu);
+		kvm_mmu_reset_context(vcpu, false);
 
 	max_bits = KVM_NR_INTERRUPTS;
 	pending_vec = find_first_bit(
@@ -8333,7 +8333,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
-	kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu, false);
 	vcpu_put(vcpu);
 	return 0;
 }
-- 
2.14.4

