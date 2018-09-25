Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F32B20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F32B20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIZAHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:07:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIZAHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BCA68831F;
        Tue, 25 Sep 2018 17:59:12 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5779F60BEC;
        Tue, 25 Sep 2018 17:58:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
Date:   Tue, 25 Sep 2018 19:58:36 +0200
Message-Id: <20180925175844.20277-2-vkuznets@redhat.com>
In-Reply-To: <20180925175844.20277-1-vkuznets@redhat.com>
References: <20180925175844.20277-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 25 Sep 2018 17:59:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to full MMU split between L1 and L2 make vcpu->arch.mmu
a pointer to the currently used mmu. For now, this is always
vcpu->arch.root_mmu. No functional change.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   5 +-
 arch/x86/kvm/mmu.c              | 165 ++++++++++++++++----------------
 arch/x86/kvm/mmu.h              |   8 +-
 arch/x86/kvm/mmu_audit.c        |  12 +--
 arch/x86/kvm/paging_tmpl.h      |  15 +--
 arch/x86/kvm/svm.c              |  14 +--
 arch/x86/kvm/vmx.c              |  15 +--
 arch/x86/kvm/x86.c              |  20 ++--
 8 files changed, 130 insertions(+), 124 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 09b2e3e2cf1b..95be30cfb33a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -534,7 +534,10 @@ struct kvm_vcpu_arch {
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
index d7e9bce6ff61..ca79ec0d8060 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2165,7 +2165,7 @@ static bool __kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			    struct list_head *invalid_list)
 {
 	if (sp->role.cr4_pae != !!is_pae(vcpu)
-	    || vcpu->arch.mmu.sync_page(vcpu, sp) == 0) {
+	    || vcpu->arch.mmu->sync_page(vcpu, sp) == 0) {
 		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
 		return false;
 	}
@@ -2359,14 +2359,14 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
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
@@ -2441,11 +2441,11 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 {
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
-	iterator->level = vcpu->arch.mmu.shadow_root_level;
+	iterator->level = vcpu->arch.mmu->shadow_root_level;
 
 	if (iterator->level == PT64_ROOT_4LEVEL &&
-	    vcpu->arch.mmu.root_level < PT64_ROOT_4LEVEL &&
-	    !vcpu->arch.mmu.direct_map)
+	    vcpu->arch.mmu->root_level < PT64_ROOT_4LEVEL &&
+	    !vcpu->arch.mmu->direct_map)
 		--iterator->level;
 
 	if (iterator->level == PT32E_ROOT_LEVEL) {
@@ -2453,10 +2453,10 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 		 * prev_root is currently only used for 64-bit hosts. So only
 		 * the active root_hpa is valid here.
 		 */
-		BUG_ON(root != vcpu->arch.mmu.root_hpa);
+		BUG_ON(root != vcpu->arch.mmu->root_hpa);
 
 		iterator->shadow_addr
-			= vcpu->arch.mmu.pae_root[(addr >> 30) & 3];
+			= vcpu->arch.mmu->pae_root[(addr >> 30) & 3];
 		iterator->shadow_addr &= PT64_BASE_ADDR_MASK;
 		--iterator->level;
 		if (!iterator->shadow_addr)
@@ -2467,7 +2467,7 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
 			     struct kvm_vcpu *vcpu, u64 addr)
 {
-	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.mmu.root_hpa,
+	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.mmu->root_hpa,
 				    addr);
 }
 
@@ -3079,7 +3079,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 	int emulate = 0;
 	gfn_t pseudo_gfn;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return 0;
 
 	for_each_shadow_entry(vcpu, (u64)gfn << PAGE_SHIFT, iterator) {
@@ -3294,7 +3294,7 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gva_t gva, int level,
 	u64 spte = 0ull;
 	uint retry_count = 0;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return false;
 
 	if (!page_fault_can_be_fast(error_code))
@@ -3468,7 +3468,7 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, ulong roots_to_free)
 {
 	int i;
 	LIST_HEAD(invalid_list);
-	struct kvm_mmu *mmu = &vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	bool free_active_root = roots_to_free & KVM_MMU_ROOT_CURRENT;
 
 	BUILD_BUG_ON(KVM_MMU_NUM_PREV_ROOTS >= BITS_PER_LONG);
@@ -3528,20 +3528,20 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
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
@@ -3554,9 +3554,9 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
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
 
@@ -3570,7 +3570,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	gfn_t root_gfn;
 	int i;
 
-	root_gfn = vcpu->arch.mmu.get_cr3(vcpu) >> PAGE_SHIFT;
+	root_gfn = vcpu->arch.mmu->get_cr3(vcpu) >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
 		return 1;
@@ -3579,8 +3579,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
 	 */
-	if (vcpu->arch.mmu.root_level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu.root_hpa;
+	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.mmu->root_hpa;
 
 		MMU_WARN_ON(VALID_PAGE(root));
 
@@ -3590,11 +3590,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
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
 
@@ -3604,17 +3604,17 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
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
@@ -3632,16 +3632,16 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
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
@@ -3653,12 +3653,12 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
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
@@ -3666,7 +3666,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.mmu.direct_map)
+	if (vcpu->arch.mmu->direct_map)
 		return mmu_alloc_direct_roots(vcpu);
 	else
 		return mmu_alloc_shadow_roots(vcpu);
@@ -3677,17 +3677,16 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 	int i;
 	struct kvm_mmu_page *sp;
 
-	if (vcpu->arch.mmu.direct_map)
+	if (vcpu->arch.mmu->direct_map)
 		return;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return;
 
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	if (vcpu->arch.mmu.root_level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu.root_hpa;
-
+	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.mmu->root_hpa;
 		sp = page_header(root);
 
 		/*
@@ -3718,7 +3717,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 	kvm_mmu_audit(vcpu, AUDIT_PRE_SYNC);
 
 	for (i = 0; i < 4; ++i) {
-		hpa_t root = vcpu->arch.mmu.pae_root[i];
+		hpa_t root = vcpu->arch.mmu->pae_root[i];
 
 		if (root && VALID_PAGE(root)) {
 			root &= PT64_BASE_ADDR_MASK;
@@ -3792,7 +3791,7 @@ walk_shadow_page_get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 	int root, leaf;
 	bool reserved = false;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		goto exit;
 
 	walk_shadow_page_lockless_begin(vcpu);
@@ -3809,7 +3808,7 @@ walk_shadow_page_get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 		if (!is_shadow_present_pte(spte))
 			break;
 
-		reserved |= is_shadow_zero_bits_set(&vcpu->arch.mmu, spte,
+		reserved |= is_shadow_zero_bits_set(vcpu->arch.mmu, spte,
 						    iterator.level);
 	}
 
@@ -3888,7 +3887,7 @@ static void shadow_page_table_clear_flood(struct kvm_vcpu *vcpu, gva_t addr)
 	struct kvm_shadow_walk_iterator iterator;
 	u64 spte;
 
-	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
 		return;
 
 	walk_shadow_page_lockless_begin(vcpu);
@@ -3915,7 +3914,7 @@ static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
 	if (r)
 		return r;
 
-	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa));
 
 
 	return nonpaging_map(vcpu, gva & PAGE_MASK,
@@ -3928,8 +3927,8 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn)
 
 	arch.token = (vcpu->arch.apf.id++ << 12) | vcpu->vcpu_id;
 	arch.gfn = gfn;
-	arch.direct_map = vcpu->arch.mmu.direct_map;
-	arch.cr3 = vcpu->arch.mmu.get_cr3(vcpu);
+	arch.direct_map = vcpu->arch.mmu->direct_map;
+	arch.cr3 = vcpu->arch.mmu->get_cr3(vcpu);
 
 	return kvm_setup_async_pf(vcpu, gva, kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
@@ -4035,7 +4034,7 @@ static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 	int write = error_code & PFERR_WRITE_MASK;
 	bool map_writable;
 
-	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa));
 
 	if (page_fault_handle_page_track(vcpu, error_code, gfn))
 		return RET_PF_EMULATE;
@@ -4111,7 +4110,7 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 {
 	uint i;
 	struct kvm_mmu_root_info root;
-	struct kvm_mmu *mmu = &vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	root.cr3 = mmu->get_cr3(vcpu);
 	root.hpa = mmu->root_hpa;
@@ -4134,7 +4133,7 @@ static bool fast_cr3_switch(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 			    union kvm_mmu_page_role new_role,
 			    bool skip_tlb_flush)
 {
-	struct kvm_mmu *mmu = &vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	/*
 	 * For now, limit the fast switch to 64-bit hosts+VMs in order to avoid
@@ -4203,7 +4202,7 @@ static unsigned long get_cr3(struct kvm_vcpu *vcpu)
 static void inject_page_fault(struct kvm_vcpu *vcpu,
 			      struct x86_exception *fault)
 {
-	vcpu->arch.mmu.inject_page_fault(vcpu, fault);
+	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
 }
 
 static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
@@ -4724,7 +4723,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
 
 static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	context->base_role.word = mmu_base_role_mask.word &
 				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
@@ -4796,7 +4795,7 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
 
 void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	if (!is_paging(vcpu))
 		nonpaging_init_context(vcpu, context);
@@ -4816,7 +4815,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 static union kvm_mmu_page_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
 {
-	union kvm_mmu_page_role role = vcpu->arch.mmu.base_role;
+	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;
 
 	role.level = PT64_ROOT_4LEVEL;
 	role.direct = false;
@@ -4830,7 +4829,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty, gpa_t new_eptp)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 	union kvm_mmu_page_role root_page_role =
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty);
 
@@ -4857,7 +4856,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_ept_mmu);
 
 static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.mmu;
+	struct kvm_mmu *context = vcpu->arch.mmu;
 
 	kvm_init_shadow_mmu(vcpu);
 	context->set_cr3           = kvm_x86_ops->set_cr3;
@@ -4875,7 +4874,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
 	/*
-	 * Note that arch.mmu.gva_to_gpa translates l2_gpa to l1_gpa using
+	 * Note that arch.mmu->gva_to_gpa translates l2_gpa to l1_gpa using
 	 * L1's nested page tables (e.g. EPT12). The nested translation
 	 * of l2_gva to l1_gpa is done by arch.nested_mmu.gva_to_gpa using
 	 * L2's page tables as the first level of translation and L1's
@@ -4914,10 +4913,10 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots)
 	if (reset_roots) {
 		uint i;
 
-		vcpu->arch.mmu.root_hpa = INVALID_PAGE;
+		vcpu->arch.mmu->root_hpa = INVALID_PAGE;
 
 		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-			vcpu->arch.mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
+			vcpu->arch.mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
 	}
 
 	if (mmu_is_nested(vcpu))
@@ -4966,7 +4965,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_roots(vcpu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
 
@@ -4980,7 +4979,7 @@ static void mmu_pte_write_new_pte(struct kvm_vcpu *vcpu,
         }
 
 	++vcpu->kvm->stat.mmu_pte_updated;
-	vcpu->arch.mmu.update_pte(vcpu, sp, spte, new);
+	vcpu->arch.mmu->update_pte(vcpu, sp, spte, new);
 }
 
 static bool need_remote_flush(u64 old, u64 new)
@@ -5160,7 +5159,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 			entry = *spte;
 			mmu_page_zap_pte(vcpu->kvm, sp, spte);
 			if (gentry &&
-			      !((sp->role.word ^ vcpu->arch.mmu.base_role.word)
+			      !((sp->role.word ^ vcpu->arch.mmu->base_role.word)
 			      & mmu_base_role_mask.word) && rmap_can_add(vcpu))
 				mmu_pte_write_new_pte(vcpu, sp, spte, &gentry);
 			if (need_remote_flush(entry, *spte))
@@ -5178,7 +5177,7 @@ int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 	gpa_t gpa;
 	int r;
 
-	if (vcpu->arch.mmu.direct_map)
+	if (vcpu->arch.mmu->direct_map)
 		return 0;
 
 	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
@@ -5214,10 +5213,10 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 {
 	int r, emulation_type = 0;
 	enum emulation_result er;
-	bool direct = vcpu->arch.mmu.direct_map;
+	bool direct = vcpu->arch.mmu->direct_map;
 
 	/* With shadow page tables, fault_address contains a GVA or nGPA.  */
-	if (vcpu->arch.mmu.direct_map) {
+	if (vcpu->arch.mmu->direct_map) {
 		vcpu->arch.gpa_available = true;
 		vcpu->arch.gpa_val = cr2;
 	}
@@ -5230,8 +5229,9 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 	}
 
 	if (r == RET_PF_INVALID) {
-		r = vcpu->arch.mmu.page_fault(vcpu, cr2, lower_32_bits(error_code),
-					      false);
+		r = vcpu->arch.mmu->page_fault(vcpu, cr2,
+					       lower_32_bits(error_code),
+					       false);
 		WARN_ON(r == RET_PF_INVALID);
 	}
 
@@ -5247,7 +5247,7 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 	 * paging in both guests. If true, we simply unprotect the page
 	 * and resume the guest.
 	 */
-	if (vcpu->arch.mmu.direct_map &&
+	if (vcpu->arch.mmu->direct_map &&
 	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE) {
 		kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2));
 		return 1;
@@ -5295,7 +5295,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_page_fault);
 
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 {
-	struct kvm_mmu *mmu = &vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	int i;
 
 	/* INVLPG on a * non-canonical address is a NOP according to the SDM.  */
@@ -5326,7 +5326,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_invlpg);
 
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 {
-	struct kvm_mmu *mmu = &vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	bool tlb_flush = false;
 	uint i;
 
@@ -5370,8 +5370,8 @@ EXPORT_SYMBOL_GPL(kvm_disable_tdp);
 
 static void free_mmu_pages(struct kvm_vcpu *vcpu)
 {
-	free_page((unsigned long)vcpu->arch.mmu.pae_root);
-	free_page((unsigned long)vcpu->arch.mmu.lm_root);
+	free_page((unsigned long)vcpu->arch.mmu->pae_root);
+	free_page((unsigned long)vcpu->arch.mmu->lm_root);
 }
 
 static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
@@ -5391,9 +5391,9 @@ static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
 	if (!page)
 		return -ENOMEM;
 
-	vcpu->arch.mmu.pae_root = page_address(page);
+	vcpu->arch.mmu->pae_root = page_address(page);
 	for (i = 0; i < 4; ++i)
-		vcpu->arch.mmu.pae_root[i] = INVALID_PAGE;
+		vcpu->arch.mmu->pae_root[i] = INVALID_PAGE;
 
 	return 0;
 }
@@ -5402,20 +5402,21 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 {
 	uint i;
 
-	vcpu->arch.walk_mmu = &vcpu->arch.mmu;
-	vcpu->arch.mmu.root_hpa = INVALID_PAGE;
-	vcpu->arch.mmu.translate_gpa = translate_gpa;
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
+	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
 	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-		vcpu->arch.mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
+		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
 
 	return alloc_mmu_pages(vcpu);
 }
 
 void kvm_mmu_setup(struct kvm_vcpu *vcpu)
 {
-	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu.root_hpa));
+	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 
 	/*
 	 * kvm_mmu_setup() is called only on vCPU initialization.  
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 1fab69c0b2f3..f602b26140a3 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -80,7 +80,7 @@ static inline unsigned int kvm_mmu_available_pages(struct kvm *kvm)
 
 static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
 {
-	if (likely(vcpu->arch.mmu.root_hpa != INVALID_PAGE))
+	if (likely(vcpu->arch.mmu->root_hpa != INVALID_PAGE))
 		return 0;
 
 	return kvm_mmu_load(vcpu);
@@ -102,9 +102,9 @@ static inline unsigned long kvm_get_active_pcid(struct kvm_vcpu *vcpu)
 
 static inline void kvm_mmu_load_cr3(struct kvm_vcpu *vcpu)
 {
-	if (VALID_PAGE(vcpu->arch.mmu.root_hpa))
-		vcpu->arch.mmu.set_cr3(vcpu, vcpu->arch.mmu.root_hpa |
-					     kvm_get_active_pcid(vcpu));
+	if (VALID_PAGE(vcpu->arch.mmu->root_hpa))
+		vcpu->arch.mmu->set_cr3(vcpu, vcpu->arch.mmu->root_hpa |
+					      kvm_get_active_pcid(vcpu));
 }
 
 /*
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
index 14ffd973df54..7cf2185b7eb5 100644
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
 	pte_access = sp->role.access & FNAME(gpte_access)(gpte);
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
@@ -1004,7 +1005,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 		gfn = gpte_to_gfn(gpte);
 		pte_access = sp->role.access;
 		pte_access &= FNAME(gpte_access)(gpte);
-		FNAME(protect_clean_gpte)(&vcpu->arch.mmu, &pte_access, gpte);
+		FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
 
 		if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access,
 		      &nr_present))
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index d96092b35936..2936c63bcc2f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2918,18 +2918,18 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
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
index 06412ba46aa3..4b8dc85afe34 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5129,9 +5129,10 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *vcpu, int vpid,
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
@@ -9180,7 +9181,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		}
 
 		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-			if (kvm_get_pcid(vcpu, vcpu->arch.mmu.prev_roots[i].cr3)
+			if (kvm_get_pcid(vcpu, vcpu->arch.mmu->prev_roots[i].cr3)
 			    == operand.pcid)
 				roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
 
@@ -11335,9 +11336,9 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 			VMX_EPT_EXECUTE_ONLY_BIT,
 			nested_ept_ad_enabled(vcpu),
 			nested_ept_get_cr3(vcpu));
-	vcpu->arch.mmu.set_cr3           = vmx_set_cr3;
-	vcpu->arch.mmu.get_cr3           = nested_ept_get_cr3;
-	vcpu->arch.mmu.inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.mmu->set_cr3           = vmx_set_cr3;
+	vcpu->arch.mmu->get_cr3           = nested_ept_get_cr3;
+	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 	return 0;
@@ -11345,7 +11346,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.walk_mmu = &vcpu->arch.mmu;
+	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index edbf00ec56b3..d58dc530ed84 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -503,7 +503,7 @@ static bool kvm_propagate_fault(struct kvm_vcpu *vcpu, struct x86_exception *fau
 	if (mmu_is_nested(vcpu) && !fault->nested_page_fault)
 		vcpu->arch.nested_mmu.inject_page_fault(vcpu, fault);
 	else
-		vcpu->arch.mmu.inject_page_fault(vcpu, fault);
+		vcpu->arch.mmu->inject_page_fault(vcpu, fault);
 
 	return fault->nested_page_fault;
 }
@@ -602,7 +602,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 	for (i = 0; i < ARRAY_SIZE(pdpte); ++i) {
 		if ((pdpte[i] & PT_PRESENT_MASK) &&
 		    (pdpte[i] &
-		     vcpu->arch.mmu.guest_rsvd_check.rsvd_bits_mask[0][2])) {
+		     vcpu->arch.mmu->guest_rsvd_check.rsvd_bits_mask[0][2])) {
 			ret = 0;
 			goto out;
 		}
@@ -4803,7 +4803,7 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 
 	/* NPT walks are always user-walks */
 	access |= PFERR_USER_MASK;
-	t_gpa  = vcpu->arch.mmu.gva_to_gpa(vcpu, gpa, access, exception);
+	t_gpa  = vcpu->arch.mmu->gva_to_gpa(vcpu, gpa, access, exception);
 
 	return t_gpa;
 }
@@ -5889,7 +5889,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t cr2,
 	if (WARN_ON_ONCE(is_guest_mode(vcpu)))
 		return false;
 
-	if (!vcpu->arch.mmu.direct_map) {
+	if (!vcpu->arch.mmu->direct_map) {
 		/*
 		 * Write permission should be allowed since only
 		 * write access need to be emulated.
@@ -5922,7 +5922,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t cr2,
 	kvm_release_pfn_clean(pfn);
 
 	/* The instructions are well-emulated on direct mmu. */
-	if (vcpu->arch.mmu.direct_map) {
+	if (vcpu->arch.mmu->direct_map) {
 		unsigned int indirect_shadow_pages;
 
 		spin_lock(&vcpu->kvm->mmu_lock);
@@ -5989,7 +5989,7 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
 	vcpu->arch.last_retry_eip = ctxt->eip;
 	vcpu->arch.last_retry_addr = cr2;
 
-	if (!vcpu->arch.mmu.direct_map)
+	if (!vcpu->arch.mmu->direct_map)
 		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2, NULL);
 
 	kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
@@ -9327,7 +9327,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 {
 	int r;
 
-	if ((vcpu->arch.mmu.direct_map != work->arch.direct_map) ||
+	if ((vcpu->arch.mmu->direct_map != work->arch.direct_map) ||
 	      work->wakeup_all)
 		return;
 
@@ -9335,11 +9335,11 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
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
2.17.1

