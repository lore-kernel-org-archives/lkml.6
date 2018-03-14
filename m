Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeCNU7k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:59:40 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:7611 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCNU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:59:38 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: tglx@linutronix.de
Cc: mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        gratian.crisan@ni.com, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH] x86/mm: remove pointless checks in vmalloc_fault
Date: Wed, 14 Mar 2018 14:59:32 -0600
Message-Id: <20180314205932.7193-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc_fault() sets user's pgd or p4d from the kernel page table.
Once it's set, all tables underneath are identical. There is no point
of following the same page table with two separate pointers and makes
sure they see the same with BUG().

Remove the pointless checks in vmalloc_fault(). Also rename the kernel
pgd/p4d pointers to pgd_k/p4d_k so that their names are consistent in
the file.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Gratian Crisan <gratian.crisan@ni.com>
---
Rebased 2/2 patch on tip.
---
 arch/x86/mm/fault.c |   56 +++++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8e012c3f6ad6..73bd8c95ac71 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -417,11 +417,11 @@ void vmalloc_sync_all(void)
  */
 static noinline int vmalloc_fault(unsigned long address)
 {
-	pgd_t *pgd, *pgd_ref;
-	p4d_t *p4d, *p4d_ref;
-	pud_t *pud, *pud_ref;
-	pmd_t *pmd, *pmd_ref;
-	pte_t *pte, *pte_ref;
+	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
 
 	/* Make sure we are in vmalloc area: */
 	if (!(address >= VMALLOC_START && address < VMALLOC_END))
@@ -435,73 +435,51 @@ static noinline int vmalloc_fault(unsigned long address)
 	 * case just flush:
 	 */
 	pgd = (pgd_t *)__va(read_cr3_pa()) + pgd_index(address);
-	pgd_ref = pgd_offset_k(address);
-	if (pgd_none(*pgd_ref))
+	pgd_k = pgd_offset_k(address);
+	if (pgd_none(*pgd_k))
 		return -1;
 
 	if (pgtable_l5_enabled) {
 		if (pgd_none(*pgd)) {
-			set_pgd(pgd, *pgd_ref);
+			set_pgd(pgd, *pgd_k);
 			arch_flush_lazy_mmu_mode();
 		} else {
-			BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
+			BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_k));
 		}
 	}
 
 	/* With 4-level paging, copying happens on the p4d level. */
 	p4d = p4d_offset(pgd, address);
-	p4d_ref = p4d_offset(pgd_ref, address);
-	if (p4d_none(*p4d_ref))
+	p4d_k = p4d_offset(pgd_k, address);
+	if (p4d_none(*p4d_k))
 		return -1;
 
 	if (p4d_none(*p4d) && !pgtable_l5_enabled) {
-		set_p4d(p4d, *p4d_ref);
+		set_p4d(p4d, *p4d_k);
 		arch_flush_lazy_mmu_mode();
 	} else {
-		BUG_ON(p4d_pfn(*p4d) != p4d_pfn(*p4d_ref));
+		BUG_ON(p4d_pfn(*p4d) != p4d_pfn(*p4d_k));
 	}
 
-	/*
-	 * Below here mismatches are bugs because these lower tables
-	 * are shared:
-	 */
 	BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS < 4);
 
 	pud = pud_offset(p4d, address);
-	pud_ref = pud_offset(p4d_ref, address);
-	if (pud_none(*pud_ref))
+	if (pud_none(*pud))
 		return -1;
 
-	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
-		BUG();
-
 	if (pud_large(*pud))
 		return 0;
 
 	pmd = pmd_offset(pud, address);
-	pmd_ref = pmd_offset(pud_ref, address);
-	if (pmd_none(*pmd_ref))
+	if (pmd_none(*pmd))
 		return -1;
 
-	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
-		BUG();
-
 	if (pmd_large(*pmd))
 		return 0;
 
-	pte_ref = pte_offset_kernel(pmd_ref, address);
-	if (!pte_present(*pte_ref))
-		return -1;
-
 	pte = pte_offset_kernel(pmd, address);
-
-	/*
-	 * Don't use pte_page here, because the mappings can point
-	 * outside mem_map, and the NUMA hash lookup cannot handle
-	 * that:
-	 */
-	if (!pte_present(*pte) || pte_pfn(*pte) != pte_pfn(*pte_ref))
-		BUG();
+	if (!pte_present(*pte))
+		return -1;
 
 	return 0;
 }
