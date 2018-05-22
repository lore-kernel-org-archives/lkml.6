Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeEVXvT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:51:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46719 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbeEVXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:51:18 -0400
X-Google-Smtp-Source: AB8JxZpVUcfmWo6jFvz9IKnBznak2ufRlys5av1nhrWtFZlhTxFBbcoo21dJs6ykwEWLDMKFW+d2fQ==
From: Laura Abbott <labbott@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] arm64: Make sure permission updates happen for pmd/pud
Date: Tue, 22 May 2018 16:50:49 -0700
Message-Id: <20180522235049.23400-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
disallowed block mappings for ioremap since that code does not honor
break-before-make. The same APIs are also used for permission updating
though and the extra checks prevent the permission updates from happening,
even though this should be permitted. This results in read-only permissions
not being fully applied. Visibly, this can occasionaly be seen as a failure
on the built in rodata test when the test data ends up in a section or
as an odd RW gap on the page table dump. Fix this by keeping the check
for the top level p*d_set_huge APIs but using separate functions for the
update APIs.

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Fixes: 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm64/mm/mmu.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..57517ad86910 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -66,6 +66,9 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+static void __pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot);
+static void __pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot);
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -200,7 +203,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pmd_set_huge(pmdp, phys, prot);
+			__pmd_set_huge(pmdp, phys, prot);
 
 			/*
 			 * After the PMD entry has been populated once, we
@@ -299,7 +302,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		 */
 		if (use_1G_block(addr, next, phys) &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pud_set_huge(pudp, phys, prot);
+			__pud_set_huge(pudp, phys, prot);
 
 			/*
 			 * After the PUD entry has been populated once, we
@@ -929,31 +932,40 @@ int __init arch_ioremap_pmd_supported(void)
 	return 1;
 }
 
-int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
+void __pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
+	BUG_ON(phys & ~PUD_MASK);
+	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
+}
+
+int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
+{
 	/* ioremap_page_range doesn't honour BBM */
 	if (pud_present(READ_ONCE(*pudp)))
 		return 0;
 
-	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
+	__pud_set_huge(pudp, phys, prot);
 	return 1;
 }
 
-int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
+static void __pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+	BUG_ON(phys & ~PMD_MASK);
+	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
+}
 
+int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
+{
 	/* ioremap_page_range doesn't honour BBM */
 	if (pmd_present(READ_ONCE(*pmdp)))
 		return 0;
 
-	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
+	__pmd_set_huge(pmdp, phys, prot);
 	return 1;
 }
 
-- 
2.17.0
