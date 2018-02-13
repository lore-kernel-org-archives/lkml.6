Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934289AbeBMPmU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:42:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeBMPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:42:18 -0500
Date: Tue, 13 Feb 2018 07:30:55 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-aad983913d77af2c3394f29b88d7bb75ebd7d172@git.kernel.org>
Cc: tglx@linutronix.de, kirill.shutemov@linux.intel.com, mingo@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        mingo@kernel.org, luto@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, bp@alien8.de, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20180131135404.40692-3-kirill.shutemov@linux.intel.com>
References: <20180131135404.40692-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/encrypt: Simplify sme_populate_pgd() and
 sme_populate_pgd_large()
Git-Commit-ID: aad983913d77af2c3394f29b88d7bb75ebd7d172
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  aad983913d77af2c3394f29b88d7bb75ebd7d172
Gitweb:     https://git.kernel.org/tip/aad983913d77af2c3394f29b88d7bb75ebd7d172
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 31 Jan 2018 16:54:03 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 15:59:49 +0100

x86/mm/encrypt: Simplify sme_populate_pgd() and sme_populate_pgd_large()

sme_populate_pgd() and sme_populate_pgd_large() operate on the identity
mapping, which means they want virtual addresses to be equal to physical
one, without PAGE_OFFSET shift.

We also need to avoid paravirtualization call there.

Getting this done is tricky. We cannot use usual page table helpers.
It forces us to open-code a lot of things. It makes code ugly and hard
to modify.

We can get it work with the page table helpers, but it requires few
preprocessor tricks.

  - Define __pa() and __va() to be compatible with identity mapping.

  - Undef CONFIG_PARAVIRT and CONFIG_PARAVIRT_SPINLOCKS before including
    any file. This way we can avoid paravirtualization calls.

Now we can user normal page table helpers just fine.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180131135404.40692-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/mem_encrypt_identity.c | 159 +++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 87 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index a28978a..4b6a2e3 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -12,6 +12,24 @@
 
 #define DISABLE_BRANCH_PROFILING
 
+/*
+ * Since we're dealing with identity mappings, physical and virtual
+ * addresses are the same, so override these defines which are ultimately
+ * used by the headers in misc.h.
+ */
+#define __pa(x)  ((unsigned long)(x))
+#define __va(x)  ((void *)((unsigned long)(x)))
+
+/*
+ * Special hack: we have to be careful, because no indirections are
+ * allowed here, and paravirt_ops is a kind of one. As it will only run in
+ * baremetal anyway, we just keep it from happening. (This list needs to
+ * be extended when new paravirt and debugging variants are added.)
+ */
+#undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_SPINLOCKS
+
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
 
@@ -73,116 +91,83 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pmd_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
-	pgd_t *pgd_p;
-	p4d_t *p4d_p;
-	pud_t *pud_p;
-	pmd_t *pmd_p;
-
-	pgd_p = ppd->pgd + pgd_index(ppd->vaddr);
-	if (native_pgd_val(*pgd_p)) {
-		if (IS_ENABLED(CONFIG_X86_5LEVEL))
-			p4d_p = (p4d_t *)(native_pgd_val(*pgd_p) & ~PTE_FLAGS_MASK);
-		else
-			pud_p = (pud_t *)(native_pgd_val(*pgd_p) & ~PTE_FLAGS_MASK);
-	} else {
-		pgd_t pgd;
-
-		if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
-			p4d_p = ppd->pgtable_area;
-			memset(p4d_p, 0, sizeof(*p4d_p) * PTRS_PER_P4D);
-			ppd->pgtable_area += sizeof(*p4d_p) * PTRS_PER_P4D;
-
-			pgd = native_make_pgd((pgdval_t)p4d_p + PGD_FLAGS);
-		} else {
-			pud_p = ppd->pgtable_area;
-			memset(pud_p, 0, sizeof(*pud_p) * PTRS_PER_PUD);
-			ppd->pgtable_area += sizeof(*pud_p) * PTRS_PER_PUD;
-
-			pgd = native_make_pgd((pgdval_t)pud_p + PGD_FLAGS);
-		}
-		native_set_pgd(pgd_p, pgd);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = ppd->pgd + pgd_index(ppd->vaddr);
+	if (pgd_none(*pgd)) {
+		p4d = ppd->pgtable_area;
+		memset(p4d, 0, sizeof(*p4d) * PTRS_PER_P4D);
+		ppd->pgtable_area += sizeof(*p4d) * PTRS_PER_P4D;
+		set_pgd(pgd, __pgd(PGD_FLAGS | __pa(p4d)));
 	}
 
-	if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
-		p4d_p += p4d_index(ppd->vaddr);
-		if (native_p4d_val(*p4d_p)) {
-			pud_p = (pud_t *)(native_p4d_val(*p4d_p) & ~PTE_FLAGS_MASK);
-		} else {
-			p4d_t p4d;
-
-			pud_p = ppd->pgtable_area;
-			memset(pud_p, 0, sizeof(*pud_p) * PTRS_PER_PUD);
-			ppd->pgtable_area += sizeof(*pud_p) * PTRS_PER_PUD;
-
-			p4d = native_make_p4d((pudval_t)pud_p + P4D_FLAGS);
-			native_set_p4d(p4d_p, p4d);
-		}
+	p4d = p4d_offset(pgd, ppd->vaddr);
+	if (p4d_none(*p4d)) {
+		pud = ppd->pgtable_area;
+		memset(pud, 0, sizeof(*pud) * PTRS_PER_PUD);
+		ppd->pgtable_area += sizeof(*pud) * PTRS_PER_PUD;
+		set_p4d(p4d, __p4d(P4D_FLAGS | __pa(pud)));
 	}
 
-	pud_p += pud_index(ppd->vaddr);
-	if (native_pud_val(*pud_p)) {
-		if (native_pud_val(*pud_p) & _PAGE_PSE)
-			return NULL;
-
-		pmd_p = (pmd_t *)(native_pud_val(*pud_p) & ~PTE_FLAGS_MASK);
-	} else {
-		pud_t pud;
-
-		pmd_p = ppd->pgtable_area;
-		memset(pmd_p, 0, sizeof(*pmd_p) * PTRS_PER_PMD);
-		ppd->pgtable_area += sizeof(*pmd_p) * PTRS_PER_PMD;
-
-		pud = native_make_pud((pmdval_t)pmd_p + PUD_FLAGS);
-		native_set_pud(pud_p, pud);
+	pud = pud_offset(p4d, ppd->vaddr);
+	if (pud_none(*pud)) {
+		pmd = ppd->pgtable_area;
+		memset(pmd, 0, sizeof(*pmd) * PTRS_PER_PMD);
+		ppd->pgtable_area += sizeof(*pmd) * PTRS_PER_PMD;
+		set_pud(pud, __pud(PUD_FLAGS | __pa(pmd)));
 	}
 
-	return pmd_p;
+	if (pud_large(*pud))
+		return NULL;
+
+	return pud;
 }
 
 static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
-	pmd_t *pmd_p;
+	pud_t *pud;
+	pmd_t *pmd;
 
-	pmd_p = sme_prepare_pgd(ppd);
-	if (!pmd_p)
+	pud = sme_prepare_pgd(ppd);
+	if (!pud)
 		return;
 
-	pmd_p += pmd_index(ppd->vaddr);
-	if (!native_pmd_val(*pmd_p) || !(native_pmd_val(*pmd_p) & _PAGE_PSE))
-		native_set_pmd(pmd_p, native_make_pmd(ppd->paddr | ppd->pmd_flags));
+	pmd = pmd_offset(pud, ppd->vaddr);
+	if (pmd_large(*pmd))
+		return;
+
+	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
 static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
-	pmd_t *pmd_p;
-	pte_t *pte_p;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
 
-	pmd_p = sme_prepare_pgd(ppd);
-	if (!pmd_p)
+	pud = sme_prepare_pgd(ppd);
+	if (!pud)
 		return;
 
-	pmd_p += pmd_index(ppd->vaddr);
-	if (native_pmd_val(*pmd_p)) {
-		if (native_pmd_val(*pmd_p) & _PAGE_PSE)
-			return;
-
-		pte_p = (pte_t *)(native_pmd_val(*pmd_p) & ~PTE_FLAGS_MASK);
-	} else {
-		pmd_t pmd;
-
-		pte_p = ppd->pgtable_area;
-		memset(pte_p, 0, sizeof(*pte_p) * PTRS_PER_PTE);
-		ppd->pgtable_area += sizeof(*pte_p) * PTRS_PER_PTE;
-
-		pmd = native_make_pmd((pteval_t)pte_p + PMD_FLAGS);
-		native_set_pmd(pmd_p, pmd);
+	pmd = pmd_offset(pud, ppd->vaddr);
+	if (pmd_none(*pmd)) {
+		pte = ppd->pgtable_area;
+		memset(pte, 0, sizeof(pte) * PTRS_PER_PTE);
+		ppd->pgtable_area += sizeof(pte) * PTRS_PER_PTE;
+		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
 	}
 
-	pte_p += pte_index(ppd->vaddr);
-	if (!native_pte_val(*pte_p))
-		native_set_pte(pte_p, native_make_pte(ppd->paddr | ppd->pte_flags));
+	if (pmd_large(*pmd))
+		return;
+
+	pte = pte_offset_map(pmd, ppd->vaddr);
+	if (pte_none(*pte))
+		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
