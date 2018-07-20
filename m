Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87966ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE6720833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE6720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeGTOOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:14:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730825AbeGTOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:14:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46638401EF01;
        Fri, 20 Jul 2018 13:26:31 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98BC62026D6B;
        Fri, 20 Jul 2018 13:26:29 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/7] x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
Date:   Fri, 20 Jul 2018 15:26:20 +0200
Message-Id: <20180720132626.5975-2-vkuznets@redhat.com>
In-Reply-To: <20180720132626.5975-1-vkuznets@redhat.com>
References: <20180720132626.5975-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:26:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:26:31 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to full MMU split between L1 and L2 make vcpu->arch.mmu
a pointer to the currently used mmu. For now, this is always
vcpu->arch.root_mmu. No functional change.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   5 +-
 arch/x86/kvm/mmu.c              | 150 ++++++++++++++++++++--------------------
 arch/x86/kvm/mmu.h              |   2 +-
 arch/x86/kvm/mmu_audit.c        |  12 ++--
 arch/x86/kvm/paging_tmpl.h      |  17 ++---
 arch/x86/kvm/svm.c              |  14 ++--
 arch/x86/kvm/vmx.c              |  13 ++--
 arch/x86/kvm/x86.c              |  20 +++---
 8 files changed, 120 insertions(+), 113 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28d9d1b..2aa3c43ca5e5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -521,7 +521,10 @@ struct kvm_vcpu_arch {
 	 * the paging mode of the l1 guest. This context is always used to
 	 * handle faults.
 	 */
-	struct kvm_mmu mmu;
+	struct kvm_mmu *mmu;
+
+	/* Non-nested MMU for L1 */
+	struct kvm_mmu root_mmu;
 
 	/*
 	 * Paging state of an L2 guest (used for nested npt)
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..914e4eea487a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2122,7 +2122,7 @@ static bool __kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		return false;
 	}
 
-	if (vcpu->arch.mmu.sync_page(vcpu, sp) == 0) {
+	if (vcpu->arch.mmu->sync_page(vcpu, sp) == 0) {
 		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
 		return false;
 	}
@@ -2316,14 +2316,14 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	int collisions = 0;
 	LIST_HEAD(invalid_list);
 
-	role = vcpu->arch.mmu.base_role;
+	role = vcpu->arch.mmu->base_role;
 	role.level = level;
 	role.direct = direct;
 	if (role.direct)
 		role.cr4_pae = 0;
 	role.access = access;
-	if (!vcpu->arch.mmu.direct_map
-	    && vcpu->arch.mmu.root_level <= PT32_ROOT_LEVEL) {
+	if (!vcpu->arch.mmu->direct_map
+	    && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
 		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
 		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
 		role.quadrant = quadrant;
@@ -2396,17 +2396,17 @@ static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
 			     struct kvm_vcpu *vcpu, u64 addr)
 {
 	iterator->addr = addr;
-	iterator->shadow_addr = vcpu->arch.mmu.root_hpa;
-	iterator->level = vcpu->arch.mmu.shadow_root_level;
+	iterator->shadow_addr = vcpu->arch.mmu->root_hpa;
+	iterator->level = vcpu->arch.mmu->shadow_root_level;
 
 	if (iterator->level == PT64_ROOT_4LEVEL &&
-	    vcpu->arch.mmu.root_level < PT64_ROOT_4LEVEL &&
-	    !vcpu->arch.mmu.direct_map)
+	    vcpu->arch.mmu->root_level < PT64_ROOT_4LEVEL &&
+	    !vcpu->arch.mmu->direct_map)
 		--iterator->level;
 
 	if (iterator->level == PT32E_ROOT_LEVEL) {
 		iterator->shadow_addr
-			= vcpu->arch.mmu.pae_root[(addr >> 30) & 3];
+			= vcpu->arch.mmu->pae_root[(addr >> 30) & 3];
 		iterator->shadow_addr &= PT64_BASE_ADDR_MASK;
 		--iterator->level;
 		if (!iterator->shadow_addr)
@@ -2974,7 +2974,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 	int emulate = 0;
 	gfn_t pseudo_gfn;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return 0;
 
 	for_each_shadow_entry(vcpu, (u64)gfn << PAGE_SHIFT, iterator) {
@@ -3189,7 +3189,7 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gva_t gva, int level,
 	u64 spte = 0ull;
 	uint retry_count = 0;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return false;
 
 	if (!page_fault_can_be_fast(error_code))
@@ -3362,7 +3362,7 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu)
 {
 	int i;
 	LIST_HEAD(invalid_list);
-	struct kvm_mmu *mmu = &vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	if (!VALID_PAGE(mmu->root_hpa))
 		return;
@@ -3402,20 +3402,20 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu_page *sp;
 	unsigned i;
 
-	if (vcpu->arch.mmu.shadow_root_level >= PT64_ROOT_4LEVEL) {
+	if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
 		spin_lock(&vcpu->kvm->mmu_lock);
 		if(make_mmu_pages_available(vcpu) < 0) {
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			return -ENOSPC;
 		}
 		sp = kvm_mmu_get_page(vcpu, 0, 0,
-				vcpu->arch.mmu.shadow_root_level, 1, ACC_ALL);
+				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
-		vcpu->arch.mmu.root_hpa = __pa(sp->spt);
-	} else if (vcpu->arch.mmu.shadow_root_level == PT32E_ROOT_LEVEL) {
+		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
+	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			hpa_t root = vcpu->arch.mmu.pae_root[i];
+			hpa_t root = vcpu->arch.mmu->pae_root[i];
 
 			MMU_WARN_ON(VALID_PAGE(root));
 			spin_lock(&vcpu->kvm->mmu_lock);
@@ -3428,9 +3428,9 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 			root = __pa(sp->spt);
 			++sp->root_count;
 			spin_unlock(&vcpu->kvm->mmu_lock);
-			vcpu->arch.mmu.pae_root[i] = root | PT_PRESENT_MASK;
+			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
-		vcpu->arch.mmu.root_hpa = __pa(vcpu->arch.mmu.pae_root);
+		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 	} else
 		BUG();
 
@@ -3444,7 +3444,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	gfn_t root_gfn;
 	int i;
 
-	root_gfn = vcpu->arch.mmu.get_cr3(vcpu) >> PAGE_SHIFT;
+	root_gfn = vcpu->arch.mmu->get_cr3(vcpu) >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
 		return 1;
@@ -3453,8 +3453,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
 	 */
-	if (vcpu->arch.mmu.root_level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu.root_hpa;
+	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.mmu->root_hpa;
 
 		MMU_WARN_ON(VALID_PAGE(root));
 
@@ -3464,11 +3464,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			return -ENOSPC;
 		}
 		sp = kvm_mmu_get_page(vcpu, root_gfn, 0,
-				vcpu->arch.mmu.shadow_root_level, 0, ACC_ALL);
+				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
 		root = __pa(sp->spt);
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
-		vcpu->arch.mmu.root_hpa = root;
+		vcpu->arch.mmu->root_hpa = root;
 		return 0;
 	}
 
@@ -3478,17 +3478,17 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (vcpu->arch.mmu.shadow_root_level == PT64_ROOT_4LEVEL)
+	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
 	for (i = 0; i < 4; ++i) {
-		hpa_t root = vcpu->arch.mmu.pae_root[i];
+		hpa_t root = vcpu->arch.mmu->pae_root[i];
 
 		MMU_WARN_ON(VALID_PAGE(root));
-		if (vcpu->arch.mmu.root_level == PT32E_ROOT_LEVEL) {
-			pdptr = vcpu->arch.mmu.get_pdptr(vcpu, i);
+		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
+			pdptr = vcpu->arch.mmu->get_pdptr(vcpu, i);
 			if (!(pdptr & PT_PRESENT_MASK)) {
-				vcpu->arch.mmu.pae_root[i] = 0;
+				vcpu->arch.mmu->pae_root[i] = 0;
 				continue;
 			}
 			root_gfn = pdptr >> PAGE_SHIFT;
@@ -3506,16 +3506,16 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 
-		vcpu->arch.mmu.pae_root[i] = root | pm_mask;
+		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
 	}
-	vcpu->arch.mmu.root_hpa = __pa(vcpu->arch.mmu.pae_root);
+	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 
 	/*
 	 * If we shadow a 32 bit page table with a long mode page
 	 * table we enter this path.
 	 */
-	if (vcpu->arch.mmu.shadow_root_level == PT64_ROOT_4LEVEL) {
-		if (vcpu->arch.mmu.lm_root == NULL) {
+	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
+		if (vcpu->arch.mmu->lm_root == NULL) {
 			/*
 			 * The additional page necessary for this is only
 			 * allocated on demand.
@@ -3527,12 +3527,12 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			if (lm_root == NULL)
 				return 1;
 
-			lm_root[0] = __pa(vcpu->arch.mmu.pae_root) | pm_mask;
+			lm_root[0] = __pa(vcpu->arch.mmu->pae_root) | pm_mask;
 
-			vcpu->arch.mmu.lm_root = lm_root;
+			vcpu->arch.mmu->lm_root = lm_root;
 		}
 
-		vcpu->arch.mmu.root_hpa = __pa(vcpu->arch.mmu.lm_root);
+		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);
 	}
 
 	return 0;
@@ -3540,7 +3540,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.mmu.direct_map)
+	if (vcpu->arch.mmu->direct_map)
 		return mmu_alloc_direct_roots(vcpu);
 	else
 		return mmu_alloc_shadow_roots(vcpu);
@@ -3551,23 +3551,23 @@ static void mmu_sync_roots(struct kvm_vcpu *vcpu)
 	int i;
 	struct kvm_mmu_page *sp;
 
-	if (vcpu->arch.mmu.direct_map)
+	if (vcpu->arch.mmu->direct_map)
 		return;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return;
 
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 	kvm_mmu_audit(vcpu, AUDIT_PRE_SYNC);
-	if (vcpu->arch.mmu.root_level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu.root_hpa;
+	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.mmu->root_hpa;
 		sp = page_header(root);
 		mmu_sync_children(vcpu, sp);
 		kvm_mmu_audit(vcpu, AUDIT_POST_SYNC);
 		return;
 	}
 	for (i = 0; i < 4; ++i) {
-		hpa_t root = vcpu->arch.mmu.pae_root[i];
+		hpa_t root = vcpu->arch.mmu->pae_root[i];
 
 		if (root && VALID_PAGE(root)) {
 			root &= PT64_BASE_ADDR_MASK;
@@ -3646,7 +3646,7 @@ walk_shadow_page_get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 	int root, leaf;
 	bool reserved = false;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		goto exit;
 
 	walk_shadow_page_lockless_begin(vcpu);
@@ -3663,7 +3663,7 @@ walk_shadow_page_get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 		if (!is_shadow_present_pte(spte))
 			break;
 
-		reserved |= is_shadow_zero_bits_set(&vcpu->arch.mmu, spte,
+		reserved |= is_shadow_zero_bits_set(vcpu->arch.mmu, spte,
 						    iterator.level);
 	}
 
@@ -3742,7 +3742,7 @@ static void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr)
 	struct kvm_shadow_walk_iterator iterator;
 	u64 spte;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return;
 
 	walk_shadow_page_lockless_begin(vcpu);
@@ -3769,7 +3769,7 @@ static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
 	if (r)
 		return r;
 
-	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa));
 
 
 	return nonpaging_map(vcpu, gva & PAGE_MASK,
@@ -3782,8 +3782,8 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn)
 
 	arch.token = (vcpu->arch.apf.id++ << 12) | vcpu->vcpu_id;
 	arch.gfn = gfn;
-	arch.direct_map = vcpu->arch.mmu.direct_map;
-	arch.cr3 = vcpu->arch.mmu.get_cr3(vcpu);
+	arch.direct_map = vcpu->arch.mmu->direct_map;
+	arch.cr3 = vcpu->arch.mmu->get_cr3(vcpu);
 
 	return kvm_setup_async_pf(vcpu, gva, kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
@@ -3888,7 +3888,7 @@ static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 	int write = error_code & PFERR_WRITE_MASK;
 	bool map_writable;
 
-	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa));
 
 	if (page_fault_handle_page_track(vcpu, error_code, gfn))
 		return RET_PF_EMULATE;
@@ -3965,7 +3965,7 @@ static unsigned long get_cr3(struct kvm_vcpu *vcpu)
 static void inject_page_fault(struct kvm_vcpu *vcpu,
 			      struct x86_exception *fault)
 {
-	vcpu->arch.mmu.inject_page_fault(vcpu, fault);
+	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
 }
 
 static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
@@ -4473,7 +4473,7 @@ static void paging32E_init_context(struct kvm_vcpu *vcpu,
 
 static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	context->base_role.word = 0;
 	context->base_role.guest_mode = is_guest_mode(vcpu);
@@ -4523,7 +4523,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 {
 	bool smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP);
 	bool smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	MMU_WARN_ON(VALID_PAGE(context->root_hpa));
 
@@ -4552,7 +4552,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	MMU_WARN_ON(VALID_PAGE(context->root_hpa));
 
@@ -4580,7 +4580,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_ept_mmu);
 
 static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	kvm_init_shadow_mmu(vcpu);
 	context->set_cr3           = kvm_x86_ops->set_cr3;
@@ -4598,7 +4598,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
 	/*
-	 * Note that arch.mmu.gva_to_gpa translates l2_gpa to l1_gpa using
+	 * Note that arch.mmu->gva_to_gpa translates l2_gpa to l1_gpa using
 	 * L1's nested page tables (e.g. EPT12). The nested translation
 	 * of l2_gva to l1_gpa is done by arch.nested_mmu.gva_to_gpa using
 	 * L2's page tables as the first level of translation and L1's
@@ -4661,7 +4661,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	if (r)
 		goto out;
 	/* set_cr3() should ensure TLB has been flushed */
-	vcpu->arch.mmu.set_cr3(vcpu, vcpu->arch.mmu.root_hpa);
+	vcpu->arch.mmu->set_cr3(vcpu, vcpu->arch.mmu->root_hpa);
 out:
 	return r;
 }
@@ -4670,7 +4670,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_roots(vcpu);
-	WARN_ON(VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
 
@@ -4684,7 +4684,7 @@ static void mmu_pte_write_new_pte(struct kvm_vcpu *vcpu,
         }
 
 	++vcpu->kvm->stat.mmu_pte_updated;
-	vcpu->arch.mmu.update_pte(vcpu, sp, spte, new);
+	vcpu->arch.mmu->update_pte(vcpu, sp, spte, new);
 }
 
 static bool need_remote_flush(u64 old, u64 new)
@@ -4874,7 +4874,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 			entry = *spte;
 			mmu_page_zap_pte(vcpu->kvm, sp, spte);
 			if (gentry &&
-			      !((sp->role.word ^ vcpu->arch.mmu.base_role.word)
+			      !((sp->role.word ^ vcpu->arch.mmu->base_role.word)
 			      & mask.word) && rmap_can_add(vcpu))
 				mmu_pte_write_new_pte(vcpu, sp, spte, &gentry);
 			if (need_remote_flush(entry, *spte))
@@ -4892,7 +4892,7 @@ int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 	gpa_t gpa;
 	int r;
 
-	if (vcpu->arch.mmu.direct_map)
+	if (vcpu->arch.mmu->direct_map)
 		return 0;
 
 	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
@@ -4928,10 +4928,10 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 {
 	int r, emulation_type = EMULTYPE_RETRY;
 	enum emulation_result er;
-	bool direct = vcpu->arch.mmu.direct_map;
+	bool direct = vcpu->arch.mmu->direct_map;
 
 	/* With shadow page tables, fault_address contains a GVA or nGPA.  */
-	if (vcpu->arch.mmu.direct_map) {
+	if (vcpu->arch.mmu->direct_map) {
 		vcpu->arch.gpa_available = true;
 		vcpu->arch.gpa_val = cr2;
 	}
@@ -4946,8 +4946,9 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 	}
 
 	if (r == RET_PF_INVALID) {
-		r = vcpu->arch.mmu.page_fault(vcpu, cr2, lower_32_bits(error_code),
-					      false);
+		r = vcpu->arch.mmu->page_fault(vcpu, cr2,
+					       lower_32_bits(error_code),
+					       false);
 		WARN_ON(r == RET_PF_INVALID);
 	}
 
@@ -4963,7 +4964,7 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 	 * paging in both guests. If true, we simply unprotect the page
 	 * and resume the guest.
 	 */
-	if (vcpu->arch.mmu.direct_map &&
+	if (vcpu->arch.mmu->direct_map &&
 	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE) {
 		kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2));
 		return 1;
@@ -5000,7 +5001,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_page_fault);
 
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 {
-	vcpu->arch.mmu.invlpg(vcpu, gva);
+	vcpu->arch.mmu->invlpg(vcpu, gva);
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	++vcpu->stat.invlpg;
 }
@@ -5020,8 +5021,8 @@ EXPORT_SYMBOL_GPL(kvm_disable_tdp);
 
 static void free_mmu_pages(struct kvm_vcpu *vcpu)
 {
-	free_page((unsigned long)vcpu->arch.mmu.pae_root);
-	free_page((unsigned long)vcpu->arch.mmu.lm_root);
+	free_page((unsigned long)vcpu->arch.mmu->pae_root);
+	free_page((unsigned long)vcpu->arch.mmu->lm_root);
 }
 
 static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
@@ -5038,18 +5039,19 @@ static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
 	if (!page)
 		return -ENOMEM;
 
-	vcpu->arch.mmu.pae_root = page_address(page);
+	vcpu->arch.mmu->pae_root = page_address(page);
 	for (i = 0; i < 4; ++i)
-		vcpu->arch.mmu.pae_root[i] = INVALID_PAGE;
+		vcpu->arch.mmu->pae_root[i] = INVALID_PAGE;
 
 	return 0;
 }
 
 int kvm_mmu_create(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.walk_mmu = &vcpu->arch.mmu;
-	vcpu->arch.mmu.root_hpa = INVALID_PAGE;
-	vcpu->arch.mmu.translate_gpa = translate_gpa;
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.mmu->root_hpa = INVALID_PAGE;
+	vcpu->arch.mmu->translate_gpa = translate_gpa;
 	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
 
 	return alloc_mmu_pages(vcpu);
@@ -5057,7 +5059,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 
 void kvm_mmu_setup(struct kvm_vcpu *vcpu)
 {
-	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 
 	init_kvm_mmu(vcpu);
 }
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 5b408c0ad612..8207c1146f4d 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -79,7 +79,7 @@ static inline unsigned int kvm_mmu_available_pages(struct kvm *kvm)
 
 static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
 {
-	if (likely(vcpu->arch.mmu.root_hpa != INVALID_PAGE))
+	if (likely(vcpu->arch.mmu->root_hpa != INVALID_PAGE))
 		return 0;
 
 	return kvm_mmu_load(vcpu);
diff --git a/arch/x86/kvm/mmu_audit.c b/arch/x86/kvm/mmu_audit.c
index 1272861e77b9..abac7e208853 100644
--- a/arch/x86/kvm/mmu_audit.c
+++ b/arch/x86/kvm/mmu_audit.c
@@ -59,19 +59,19 @@ static void mmu_spte_walk(struct kvm_vcpu *vcpu, inspect_spte_fn fn)
 	int i;
 	struct kvm_mmu_page *sp;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return;
 
-	if (vcpu->arch.mmu.root_level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu.root_hpa;
+	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.mmu->root_hpa;
 
 		sp = page_header(root);
-		__mmu_spte_walk(vcpu, sp, fn, vcpu->arch.mmu.root_level);
+		__mmu_spte_walk(vcpu, sp, fn, vcpu->arch.mmu->root_level);
 		return;
 	}
 
 	for (i = 0; i < 4; ++i) {
-		hpa_t root = vcpu->arch.mmu.pae_root[i];
+		hpa_t root = vcpu->arch.mmu->pae_root[i];
 
 		if (root && VALID_PAGE(root)) {
 			root &= PT64_BASE_ADDR_MASK;
@@ -122,7 +122,7 @@ static void audit_mappings(struct kvm_vcpu *vcpu, u64 *sptep, int level)
 	hpa =  pfn << PAGE_SHIFT;
 	if ((*sptep & PT64_BASE_ADDR_MASK) != hpa)
 		audit_printk(vcpu->kvm, "levels %d pfn %llx hpa %llx "
-			     "ent %llxn", vcpu->arch.mmu.root_level, pfn,
+			     "ent %llxn", vcpu->arch.mmu->root_level, pfn,
 			     hpa, *sptep);
 }
 
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6288e9d7068e..e86dc5b9d6cd 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -158,14 +158,15 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu_page *sp, u64 *spte,
 				  u64 gpte)
 {
-	if (is_rsvd_bits_set(&vcpu->arch.mmu, gpte, PT_PAGE_TABLE_LEVEL))
+	if (is_rsvd_bits_set(vcpu->arch.mmu, gpte, PT_PAGE_TABLE_LEVEL))
 		goto no_present;
 
 	if (!FNAME(is_present_gpte)(gpte))
 		goto no_present;
 
 	/* if accessed bit is not supported prefetch non accessed gpte */
-	if (PT_HAVE_ACCESSED_DIRTY(&vcpu->arch.mmu) && !(gpte & PT_GUEST_ACCESSED_MASK))
+	if (PT_HAVE_ACCESSED_DIRTY(vcpu->arch.mmu) &&
+	    !(gpte & PT_GUEST_ACCESSED_MASK))
 		goto no_present;
 
 	return false;
@@ -480,7 +481,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 static int FNAME(walk_addr)(struct guest_walker *walker,
 			    struct kvm_vcpu *vcpu, gva_t addr, u32 access)
 {
-	return FNAME(walk_addr_generic)(walker, vcpu, &vcpu->arch.mmu, addr,
+	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu, addr,
 					access);
 }
 
@@ -509,7 +510,7 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access & FNAME(gpte_access)(vcpu, gpte);
-	FNAME(protect_clean_gpte)(&vcpu->arch.mmu, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
 	pfn = pte_prefetch_gfn_to_pfn(vcpu, gfn,
 			no_dirty_log && (pte_access & ACC_WRITE_MASK));
 	if (is_error_pfn(pfn))
@@ -604,7 +605,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 
 	direct_access = gw->pte_access;
 
-	top_level = vcpu->arch.mmu.root_level;
+	top_level = vcpu->arch.mmu->root_level;
 	if (top_level == PT32E_ROOT_LEVEL)
 		top_level = PT32_ROOT_LEVEL;
 	/*
@@ -616,7 +617,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 	if (FNAME(gpte_changed)(vcpu, gw, top_level))
 		goto out_gpte_changed;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		goto out_gpte_changed;
 
 	for (shadow_walk_init(&it, vcpu, addr);
@@ -871,7 +872,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva)
 	 */
 	mmu_topup_memory_caches(vcpu);
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa)) {
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa)) {
 		WARN_ON(1);
 		return;
 	}
@@ -1003,7 +1004,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 		gfn = gpte_to_gfn(gpte);
 		pte_access = sp->role.access;
 		pte_access &= FNAME(gpte_access)(vcpu, gpte);
-		FNAME(protect_clean_gpte)(&vcpu->arch.mmu, &pte_access, gpte);
+		FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
 
 		if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access,
 		      &nr_present))
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f059a73f0fd0..3b3b9839c2b5 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2920,18 +2920,18 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 {
 	WARN_ON(mmu_is_nested(vcpu));
 	kvm_init_shadow_mmu(vcpu);
-	vcpu->arch.mmu.set_cr3           = nested_svm_set_tdp_cr3;
-	vcpu->arch.mmu.get_cr3           = nested_svm_get_tdp_cr3;
-	vcpu->arch.mmu.get_pdptr         = nested_svm_get_tdp_pdptr;
-	vcpu->arch.mmu.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.mmu.shadow_root_level = get_npt_level(vcpu);
-	reset_shadow_zero_bits_mask(vcpu, &vcpu->arch.mmu);
+	vcpu->arch.mmu->set_cr3           = nested_svm_set_tdp_cr3;
+	vcpu->arch.mmu->get_cr3           = nested_svm_get_tdp_cr3;
+	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
+	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.mmu->shadow_root_level = get_npt_level(vcpu);
+	reset_shadow_zero_bits_mask(vcpu, vcpu->arch.mmu);
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.walk_mmu = &vcpu->arch.mmu;
+	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
 static int nested_svm_check_permissions(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 559a12b6184d..418277fd1b7c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4755,9 +4755,10 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *vcpu, int vpid,
 				bool invalidate_gpa)
 {
 	if (enable_ept && (invalidate_gpa || !enable_vpid)) {
-		if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+		if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 			return;
-		ept_sync_context(construct_eptp(vcpu, vcpu->arch.mmu.root_hpa));
+		ept_sync_context(construct_eptp(vcpu,
+						vcpu->arch.mmu->root_hpa));
 	} else {
 		vpid_sync_context(vpid);
 	}
@@ -10577,9 +10578,9 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
 			nested_ept_ad_enabled(vcpu));
-	vcpu->arch.mmu.set_cr3           = vmx_set_cr3;
-	vcpu->arch.mmu.get_cr3           = nested_ept_get_cr3;
-	vcpu->arch.mmu.inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.mmu->set_cr3           = vmx_set_cr3;
+	vcpu->arch.mmu->get_cr3           = nested_ept_get_cr3;
+	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 	return 0;
@@ -10587,7 +10588,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.walk_mmu = &vcpu->arch.mmu;
+	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa70205a..a98fafd6ac24 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -502,7 +502,7 @@ static bool kvm_propagate_fault(struct kvm_vcpu *vcpu, struct x86_exception *fau
 	if (mmu_is_nested(vcpu) && !fault->nested_page_fault)
 		vcpu->arch.nested_mmu.inject_page_fault(vcpu, fault);
 	else
-		vcpu->arch.mmu.inject_page_fault(vcpu, fault);
+		vcpu->arch.mmu->inject_page_fault(vcpu, fault);
 
 	return fault->nested_page_fault;
 }
@@ -601,7 +601,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 	for (i = 0; i < ARRAY_SIZE(pdpte); ++i) {
 		if ((pdpte[i] & PT_PRESENT_MASK) &&
 		    (pdpte[i] &
-		     vcpu->arch.mmu.guest_rsvd_check.rsvd_bits_mask[0][2])) {
+		     vcpu->arch.mmu->guest_rsvd_check.rsvd_bits_mask[0][2])) {
 			ret = 0;
 			goto out;
 		}
@@ -4700,7 +4700,7 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 
 	/* NPT walks are always user-walks */
 	access |= PFERR_USER_MASK;
-	t_gpa  = vcpu->arch.mmu.gva_to_gpa(vcpu, gpa, access, exception);
+	t_gpa  = vcpu->arch.mmu->gva_to_gpa(vcpu, gpa, access, exception);
 
 	return t_gpa;
 }
@@ -5780,7 +5780,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t cr2,
 	if (emulation_type & EMULTYPE_NO_REEXECUTE)
 		return false;
 
-	if (!vcpu->arch.mmu.direct_map) {
+	if (!vcpu->arch.mmu->direct_map) {
 		/*
 		 * Write permission should be allowed since only
 		 * write access need to be emulated.
@@ -5813,7 +5813,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t cr2,
 	kvm_release_pfn_clean(pfn);
 
 	/* The instructions are well-emulated on direct mmu. */
-	if (vcpu->arch.mmu.direct_map) {
+	if (vcpu->arch.mmu->direct_map) {
 		unsigned int indirect_shadow_pages;
 
 		spin_lock(&vcpu->kvm->mmu_lock);
@@ -5877,7 +5877,7 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
 	vcpu->arch.last_retry_eip = ctxt->eip;
 	vcpu->arch.last_retry_addr = cr2;
 
-	if (!vcpu->arch.mmu.direct_map)
+	if (!vcpu->arch.mmu->direct_map)
 		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2, NULL);
 
 	kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
@@ -9171,7 +9171,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 {
 	int r;
 
-	if ((vcpu->arch.mmu.direct_map != work->arch.direct_map) ||
+	if ((vcpu->arch.mmu->direct_map != work->arch.direct_map) ||
 	      work->wakeup_all)
 		return;
 
@@ -9179,11 +9179,11 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	if (unlikely(r))
 		return;
 
-	if (!vcpu->arch.mmu.direct_map &&
-	      work->arch.cr3 != vcpu->arch.mmu.get_cr3(vcpu))
+	if (!vcpu->arch.mmu->direct_map &&
+	      work->arch.cr3 != vcpu->arch.mmu->get_cr3(vcpu))
 		return;
 
-	vcpu->arch.mmu.page_fault(vcpu, work->gva, 0, true);
+	vcpu->arch.mmu->page_fault(vcpu, work->gva, 0, true);
 }
 
 static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
-- 
2.14.4

