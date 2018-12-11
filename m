Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD5DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6742081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6742081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeLKRMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:12:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeLKRMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:12:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57E2D1596;
        Tue, 11 Dec 2018 09:12:20 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C02F3F6A8;
        Tue, 11 Dec 2018 09:12:18 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        anshuman.khandual@arm.com
Subject: [PATCH v10 7/8] KVM: arm64: Update age handlers to support PUD hugepages
Date:   Tue, 11 Dec 2018 17:10:40 +0000
Message-Id: <1544548241-6417-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punit.agrawal@arm.com>

In preparation for creating larger hugepages at Stage 2, add support
to the age handling notifiers for PUD hugepages when encountered.

Provide trivial helpers for arm32 to allow sharing code.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
[ Replaced BUG() => WARN_ON(1) for arm32 PUD helpers ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |  6 ++++++
 arch/arm64/include/asm/kvm_mmu.h |  5 +++++
 arch/arm64/include/asm/pgtable.h |  1 +
 virt/kvm/arm/mmu.c               | 39 ++++++++++++++++++++-------------------
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 3a40720..4b4b214 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -117,6 +117,12 @@ static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
 	return pud;
 }
 
+static inline bool kvm_s2pud_young(pud_t pud)
+{
+	WARN_ON(1);
+	return false;
+}
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= L_PTE_S2_RDWR;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 612032b..9f941f7 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -273,6 +273,11 @@ static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
 	return pud_mkyoung(pud);
 }
 
+static inline bool kvm_s2pud_young(pud_t pud)
+{
+	return pud_young(pud);
+}
+
 #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
 
 #ifdef __PAGETABLE_PMD_FOLDED
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f51e227..bb0f3f1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -386,6 +386,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
+#define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index bd74960..3893ea6 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1225,6 +1225,11 @@ static int stage2_pmdp_test_and_clear_young(pmd_t *pmd)
 	return stage2_ptep_test_and_clear_young((pte_t *)pmd);
 }
 
+static int stage2_pudp_test_and_clear_young(pud_t *pud)
+{
+	return stage2_ptep_test_and_clear_young((pte_t *)pud);
+}
+
 /**
  * kvm_phys_addr_ioremap - map a device range to guest IPA
  *
@@ -1932,42 +1937,38 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 
 static int kvm_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
 {
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE);
-	pmd = stage2_get_pmd(kvm, NULL, gpa);
-	if (!pmd || pmd_none(*pmd))	/* Nothing there */
+	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
+	if (!stage2_get_leaf_entry(kvm, gpa, &pud, &pmd, &pte))
 		return 0;
 
-	if (pmd_thp_or_huge(*pmd))	/* THP, HugeTLB */
+	if (pud)
+		return stage2_pudp_test_and_clear_young(pud);
+	else if (pmd)
 		return stage2_pmdp_test_and_clear_young(pmd);
-
-	pte = pte_offset_kernel(pmd, gpa);
-	if (pte_none(*pte))
-		return 0;
-
-	return stage2_ptep_test_and_clear_young(pte);
+	else
+		return stage2_ptep_test_and_clear_young(pte);
 }
 
 static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
 {
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE);
-	pmd = stage2_get_pmd(kvm, NULL, gpa);
-	if (!pmd || pmd_none(*pmd))	/* Nothing there */
+	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
+	if (!stage2_get_leaf_entry(kvm, gpa, &pud, &pmd, &pte))
 		return 0;
 
-	if (pmd_thp_or_huge(*pmd))		/* THP, HugeTLB */
+	if (pud)
+		return kvm_s2pud_young(*pud);
+	else if (pmd)
 		return pmd_young(*pmd);
-
-	pte = pte_offset_kernel(pmd, gpa);
-	if (!pte_none(*pte))		/* Just a page... */
+	else
 		return pte_young(*pte);
-
-	return 0;
 }
 
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
-- 
2.7.4

