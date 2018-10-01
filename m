Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A194CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD4D20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD4D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJAWeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:34:04 -0400
Received: from foss.arm.com ([217.140.101.70]:51894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeJAWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5AB15BF;
        Mon,  1 Oct 2018 08:55:36 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 181F63F5D3;
        Mon,  1 Oct 2018 08:55:35 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Christoffer Dall <christoffer.dall@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v8 9/9] KVM: arm64: Add support for creating PUD hugepages at stage 2
Date:   Mon,  1 Oct 2018 16:54:43 +0100
Message-Id: <20181001155443.23032-10-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181001155443.23032-1-punit.agrawal@arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM only supports PMD hugepages at stage 2. Now that the various page
handling routines are updated, extend the stage 2 fault handling to
map in PUD hugepages.

Addition of PUD hugepage support enables additional page sizes (e.g.,
1G with 4K granule) which can be useful on cores that support mapping
larger block sizes in the TLB entries.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h         |  20 +++++
 arch/arm/include/asm/stage2_pgtable.h  |   9 +++
 arch/arm64/include/asm/kvm_mmu.h       |  16 ++++
 arch/arm64/include/asm/pgtable-hwdef.h |   2 +
 arch/arm64/include/asm/pgtable.h       |   2 +
 virt/kvm/arm/mmu.c                     | 106 +++++++++++++++++++++++--
 6 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index a42b9505c9a7..da5f078ae68c 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -84,11 +84,14 @@ void kvm_clear_hyp_idmap(void);
 
 #define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
 #define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
+#define kvm_pfn_pud(pfn, prot)	(__pud(0))
 
 #define kvm_pud_pfn(pud)	({ BUG(); 0; })
 
 
 #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
+/* No support for pud hugepages */
+#define kvm_pud_mkhuge(pud)	( {BUG(); pud; })
 
 /*
  * The following kvm_*pud*() functions are provided strictly to allow
@@ -105,6 +108,23 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
 	return false;
 }
 
+static inline void kvm_set_pud(pud_t *pud, pud_t new_pud)
+{
+	BUG();
+}
+
+static inline pud_t kvm_s2pud_mkwrite(pud_t pud)
+{
+	BUG();
+	return pud;
+}
+
+static inline pud_t kvm_s2pud_mkexec(pud_t pud)
+{
+	BUG();
+	return pud;
+}
+
 static inline bool kvm_s2pud_exec(pud_t *pud)
 {
 	BUG();
diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
index f6a7ea805232..a4ec25360e50 100644
--- a/arch/arm/include/asm/stage2_pgtable.h
+++ b/arch/arm/include/asm/stage2_pgtable.h
@@ -68,4 +68,13 @@ stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 #define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
 #define stage2_pud_table_empty(kvm, pudp)	false
 
+static inline bool kvm_stage2_has_pud(struct kvm *kvm)
+{
+#if CONFIG_PGTABLE_LEVELS > 3
+	return true;
+#else
+	return false;
+#endif
+}
+
 #endif	/* __ARM_S2_PGTABLE_H_ */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 3baf72705dcc..b4e9c2cceecb 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -184,12 +184,16 @@ void kvm_clear_hyp_idmap(void);
 #define kvm_mk_pgd(pudp)					\
 	__pgd(__phys_to_pgd_val(__pa(pudp)) | PUD_TYPE_TABLE)
 
+#define kvm_set_pud(pudp, pud)		set_pud(pudp, pud)
+
 #define kvm_pfn_pte(pfn, prot)		pfn_pte(pfn, prot)
 #define kvm_pfn_pmd(pfn, prot)		pfn_pmd(pfn, prot)
+#define kvm_pfn_pud(pfn, prot)		pfn_pud(pfn, prot)
 
 #define kvm_pud_pfn(pud)		pud_pfn(pud)
 
 #define kvm_pmd_mkhuge(pmd)		pmd_mkhuge(pmd)
+#define kvm_pud_mkhuge(pud)		pud_mkhuge(pud)
 
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
@@ -203,6 +207,12 @@ static inline pmd_t kvm_s2pmd_mkwrite(pmd_t pmd)
 	return pmd;
 }
 
+static inline pud_t kvm_s2pud_mkwrite(pud_t pud)
+{
+	pud_val(pud) |= PUD_S2_RDWR;
+	return pud;
+}
+
 static inline pte_t kvm_s2pte_mkexec(pte_t pte)
 {
 	pte_val(pte) &= ~PTE_S2_XN;
@@ -215,6 +225,12 @@ static inline pmd_t kvm_s2pmd_mkexec(pmd_t pmd)
 	return pmd;
 }
 
+static inline pud_t kvm_s2pud_mkexec(pud_t pud)
+{
+	pud_val(pud) &= ~PUD_S2_XN;
+	return pud;
+}
+
 static inline void kvm_set_s2pte_readonly(pte_t *ptep)
 {
 	pteval_t old_pteval, pteval;
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 10ae592b78b8..e327665e94d1 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -193,6 +193,8 @@
 #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 #define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
 
+#define PUD_S2_RDONLY		(_AT(pudval_t, 1) << 6)   /* HAP[2:1] */
+#define PUD_S2_RDWR		(_AT(pudval_t, 3) << 6)   /* HAP[2:1] */
 #define PUD_S2_XN		(_AT(pudval_t, 2) << 53)  /* XN[1:0] */
 
 /*
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4d9476e420d9..0afc34f94ff5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -389,6 +389,8 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
+#define pud_mkhuge(pud)		(__pud(pud_val(pud) & ~PUD_TABLE_BIT))
+
 #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
 #define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 1cf84507bbd6..5b72ddf25efc 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -115,6 +115,25 @@ static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
 	put_page(virt_to_page(pmd));
 }
 
+/**
+ * stage2_dissolve_pud() - clear and flush huge PUD entry
+ * @kvm:	pointer to kvm structure.
+ * @addr:	IPA
+ * @pud:	pud pointer for IPA
+ *
+ * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
+ * pages in the range dirty.
+ */
+static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
+{
+	if (!stage2_pud_huge(kvm, *pudp))
+		return;
+
+	stage2_pud_clear(kvm, pudp);
+	kvm_tlb_flush_vmid_ipa(kvm, addr);
+	put_page(virt_to_page(pudp));
+}
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
@@ -1022,7 +1041,7 @@ static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 	pmd_t *pmd;
 
 	pud = stage2_get_pud(kvm, cache, addr);
-	if (!pud)
+	if (!pud || stage2_pud_huge(kvm, *pud))
 		return NULL;
 
 	if (stage2_pud_none(kvm, *pud)) {
@@ -1083,6 +1102,36 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	return 0;
 }
 
+static int stage2_set_pud_huge(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			       phys_addr_t addr, const pud_t *new_pudp)
+{
+	pud_t *pudp, old_pud;
+
+	pudp = stage2_get_pud(kvm, cache, addr);
+	VM_BUG_ON(!pudp);
+
+	old_pud = *pudp;
+
+	/*
+	 * A large number of vcpus faulting on the same stage 2 entry,
+	 * can lead to a refault due to the
+	 * stage2_pud_clear()/tlb_flush(). Skip updating the page
+	 * tables if there is no change.
+	 */
+	if (pud_val(old_pud) == pud_val(*new_pudp))
+		return 0;
+
+	if (stage2_pud_present(kvm, old_pud)) {
+		stage2_pud_clear(kvm, pudp);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+	} else {
+		get_page(virt_to_page(pudp));
+	}
+
+	kvm_set_pud(pudp, *new_pudp);
+	return 0;
+}
+
 /*
  * stage2_get_leaf_entry - walk the stage2 VM page tables and return
  * true if a valid and present leaf-entry is found. A pointer to the
@@ -1149,6 +1198,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			  phys_addr_t addr, const pte_t *new_pte,
 			  unsigned long flags)
 {
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
 	bool iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
@@ -1157,7 +1207,31 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	VM_BUG_ON(logging_active && !cache);
 
 	/* Create stage-2 page table mapping - Levels 0 and 1 */
-	pmd = stage2_get_pmd(kvm, cache, addr);
+	pud = stage2_get_pud(kvm, cache, addr);
+	if (!pud) {
+		/*
+		 * Ignore calls from kvm_set_spte_hva for unallocated
+		 * address ranges.
+		 */
+		return 0;
+	}
+
+	/*
+	 * While dirty page logging - dissolve huge PUD, then continue
+	 * on to allocate page.
+	 */
+	if (logging_active)
+		stage2_dissolve_pud(kvm, addr, pud);
+
+	if (stage2_pud_none(kvm, *pud)) {
+		if (!cache)
+			return 0; /* ignore calls from kvm_set_spte_hva */
+		pmd = mmu_memory_cache_alloc(cache);
+		stage2_pud_populate(kvm, pud, pmd);
+		get_page(virt_to_page(pud));
+	}
+
+	pmd = stage2_pmd_offset(kvm, pud, addr);
 	if (!pmd) {
 		/*
 		 * Ignore calls from kvm_set_spte_hva for unallocated
@@ -1563,13 +1637,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	vma_pagesize = vma_kernel_pagesize(vma);
-	if (vma_pagesize == PMD_SIZE && !logging_active) {
+	/*
+	 * PUD level may not exist for a VM but PMD is guaranteed to
+	 * exist.
+	 */
+	if ((vma_pagesize == PMD_SIZE ||
+	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pud(kvm))) &&
+	    !logging_active) {
+		struct hstate *h = hstate_vma(vma);
+
 		hugetlb = true;
-		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
+		gfn = (fault_ipa & huge_page_mask(h)) >> PAGE_SHIFT;
 	} else {
 		/*
 		 * Fallback to PTE if it's not one of the Stage 2
-		 * supported hugepage sizes
+		 * supported hugepage sizes or the corresponding level
+		 * doesn't exist
 		 */
 		vma_pagesize = PAGE_SIZE;
 
@@ -1669,7 +1752,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	needs_exec = exec_fault ||
 		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
 
-	if (hugetlb && vma_pagesize == PMD_SIZE) {
+	if (hugetlb && vma_pagesize == PUD_SIZE) {
+		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
+
+		new_pud = kvm_pud_mkhuge(new_pud);
+		if (writable)
+			new_pud = kvm_s2pud_mkwrite(new_pud);
+
+		if (needs_exec)
+			new_pud = kvm_s2pud_mkexec(new_pud);
+
+		ret = stage2_set_pud_huge(kvm, memcache, fault_ipa, &new_pud);
+	} else if (hugetlb && vma_pagesize == PMD_SIZE) {
 		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
 
 		new_pmd = kvm_pmd_mkhuge(new_pmd);
-- 
2.18.0

