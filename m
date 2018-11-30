Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD861C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9359C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9359C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeK3TSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:18:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:5287 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:18:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="105480429"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2018 00:09:37 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id 882B8580460;
        Fri, 30 Nov 2018 00:09:35 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 10/11] KVM: VMX: Added setup spp page structure.
Date:   Fri, 30 Nov 2018 16:09:20 +0800
Message-Id: <582cad9754a9651595385e901430ab69bbd668b6.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware uses the guest-physical address and bits 11:7 of the
address accessed to lookup the SPPT to fetch a write permission bit for
the 128 byte wide sub-page region being accessed within the 4K
guest-physical page. If the sub-page region write permission bit is set,
the write is allowed; otherwise the write is disallowed and results in
an EPT violation.

Guest-physical pages mapped via leaf EPT-paging-structures for which the
accumulated write-access bit and the SPP bits are both clear (0) generate
EPT violations on memory writes accesses. Guest-physical pages mapped via
EPT-paging-structure for which the accumulated write-access bit is set
(1) allow writes, effectively ignoring the SPP bit on the leaf EPT-paging
structure.

Software will setup the spp page table level4,3,2 as well as EPT page
structure, and fill the level1 via the 32 bit bitmap per a single 4K page.
Now it could be divided to 32 x 128 sub-pages.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |   4 ++
 arch/x86/kvm/mmu.c              | 123 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3218d91..ce6d258 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1402,6 +1402,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t gva, u64 error_code,
 		       void *insn, int insn_len);
+
+int kvm_mmu_setup_spp_structure(struct kvm_vcpu *vcpu,
+				u32 access_map, gfn_t gfn);
+
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d512125..287ee62 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -206,6 +206,11 @@ static const union kvm_mmu_page_role mmu_base_role_mask = {
 		({ spte = mmu_spte_get_lockless(_walker.sptep); 1; });	\
 	     __shadow_walk_next(&(_walker), spte))
 
+#define for_each_shadow_spp_entry(_vcpu, _addr, _walker)    \
+	for (shadow_spp_walk_init(&(_walker), _vcpu, _addr);	\
+	     shadow_walk_okay(&(_walker));			\
+	     shadow_walk_next(&(_walker)))
+
 static struct kmem_cache *pte_list_desc_cache;
 static struct kmem_cache *mmu_page_header_cache;
 static struct percpu_counter kvm_total_used_mmu_pages;
@@ -476,6 +481,11 @@ static int is_shadow_present_pte(u64 pte)
 	return (pte != 0) && !is_mmio_spte(pte);
 }
 
+static int is_spp_mide_page_present(u64 pte)
+{
+	return pte & PT_PRESENT_MASK;
+}
+
 static int is_large_pte(u64 pte)
 {
 	return pte & PT_PAGE_SIZE_MASK;
@@ -495,6 +505,11 @@ static bool is_executable_pte(u64 spte)
 	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
 }
 
+static bool is_spp_spte(struct kvm_mmu_page *sp)
+{
+	return sp->role.spp;
+}
+
 static kvm_pfn_t spte_to_pfn(u64 pte)
 {
 	return (pte & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
@@ -2606,6 +2621,16 @@ static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
 				    addr);
 }
 
+static void shadow_spp_walk_init(struct kvm_shadow_walk_iterator *iterator,
+				 struct kvm_vcpu *vcpu, u64 addr)
+{
+	iterator->addr = addr;
+	iterator->shadow_addr = vcpu->arch.mmu->sppt_root;
+
+	/* SPP Table is a 4-level paging structure */
+	iterator->level = 4;
+}
+
 static bool shadow_walk_okay(struct kvm_shadow_walk_iterator *iterator)
 {
 	if (iterator->level < PT_PAGE_TABLE_LEVEL)
@@ -2656,6 +2681,18 @@ static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
 		mark_unsync(sptep);
 }
 
+static void link_spp_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
+				 struct kvm_mmu_page *sp)
+{
+	u64 spte;
+
+	spte = __pa(sp->spt) | PT_PRESENT_MASK;
+
+	mmu_spte_set(sptep, spte);
+
+	mmu_page_add_parent_pte(vcpu, sp, sptep);
+}
+
 static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 				   unsigned direct_access)
 {
@@ -2686,7 +2723,13 @@ static bool mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 
 	pte = *spte;
 	if (is_shadow_present_pte(pte)) {
-		if (is_last_spte(pte, sp->role.level)) {
+		if (is_spp_spte(sp)) {
+			if (sp->role.level == PT_PAGE_TABLE_LEVEL)
+				//spp page do not need to release rmap.
+				return true;
+			child = page_header(pte & PT64_BASE_ADDR_MASK);
+			drop_parent_pte(child, spte);
+		} else if (is_last_spte(pte, sp->role.level)) {
 			drop_spte(kvm, spte);
 			if (is_large_pte(pte))
 				--kvm->stat.lpages;
@@ -4231,6 +4274,77 @@ static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 	return RET_PF_RETRY;
 }
 
+static u64 format_spp_spte(u32 spp_wp_bitmap)
+{
+	u64 new_spte = 0;
+	int i = 0;
+
+	/*
+	 * One 4K page contains 32 sub-pages, in SPP table L4E, old bits
+	 * are reserved, so we need to transfer u32 subpage write
+	 * protect bitmap to u64 SPP L4E format.
+	 */
+	while (i < 32) {
+		if (spp_wp_bitmap & (1ULL << i))
+			new_spte |= 1ULL << (i * 2);
+
+		i++;
+	}
+
+	return new_spte;
+}
+
+static void mmu_spp_spte_set(u64 *sptep, u64 new_spte)
+{
+	__set_spte(sptep, new_spte);
+}
+
+int kvm_mmu_setup_spp_structure(struct kvm_vcpu *vcpu,
+				u32 access_map, gfn_t gfn)
+{
+	struct kvm_shadow_walk_iterator iter;
+	struct kvm_mmu_page *sp;
+	gfn_t pseudo_gfn;
+	u64 old_spte, spp_spte;
+	struct kvm *kvm = vcpu->kvm;
+
+	spin_lock(&kvm->mmu_lock);
+
+	/* direct_map spp start */
+
+	if (!VALID_PAGE(vcpu->arch.mmu->sppt_root))
+		goto out_unlock;
+
+	for_each_shadow_spp_entry(vcpu, (u64)gfn << PAGE_SHIFT, iter) {
+		if (iter.level == PT_PAGE_TABLE_LEVEL) {
+			spp_spte = format_spp_spte(access_map);
+			old_spte = mmu_spte_get_lockless(iter.sptep);
+			if (old_spte != spp_spte) {
+				mmu_spp_spte_set(iter.sptep, spp_spte);
+				kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+			}
+			break;
+		}
+
+		if (!is_spp_mide_page_present(*iter.sptep)) {
+			u64 base_addr = iter.addr;
+
+			base_addr &= PT64_LVL_ADDR_MASK(iter.level);
+			pseudo_gfn = base_addr >> PAGE_SHIFT;
+			sp = kvm_mmu_get_spp_page(vcpu, pseudo_gfn,
+						  iter.level - 1);
+			link_spp_shadow_page(vcpu, iter.sptep, sp);
+		}
+	}
+
+	spin_unlock(&kvm->mmu_lock);
+	return 0;
+
+out_unlock:
+	spin_unlock(&kvm->mmu_lock);
+	return -EFAULT;
+}
+
 int kvm_mmu_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
 {
 	u32 *access = spp_info->access_map;
@@ -4255,9 +4369,10 @@ int kvm_mmu_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
 	gfn_t gfn = spp_info->base_gfn;
 	int npages = spp_info->npages;
 	struct kvm_memory_slot *slot;
+	struct kvm_vcpu *vcpu;
 	u32 *wp_map;
 	int ret;
-	int i;
+	int i, j;
 
 	for (i = 0; i < npages; i++, gfn++) {
 		slot = gfn_to_memslot(kvm, gfn);
@@ -4281,6 +4396,10 @@ int kvm_mmu_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
 				"Please try to disable the huge page\n", gfn);
 			return -EFAULT;
 		}
+
+		kvm_for_each_vcpu(j, vcpu, kvm)
+			kvm_mmu_setup_spp_structure(vcpu, access, gfn);
+
 		wp_map = gfn_to_subpage_wp_info(slot, gfn);
 		*wp_map = access;
 	}
-- 
2.7.4

