Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935233AbeBPLGu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:06:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935163AbeBPLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:06:30 -0500
Date: Fri, 16 Feb 2018 02:55:03 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-98219dda2ab56ce2a967fdebf81e838d676d9ddc@git.kernel.org>
Cc: torvalds@linux-foundation.org, dwmw2@infradead.org,
        arjan@linux.intel.com, dan.j.williams@intel.com, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, hpa@zytor.com, bp@suse.de,
        kirill.shutemov@linux.intel.com, luto@kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com
Reply-To: dave.hansen@linux.intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, luto@kernel.org, bp@suse.de,
        hpa@zytor.com, peterz@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        arjan@linux.intel.com, tglx@linutronix.de, dwmw2@infradead.org,
        torvalds@linux-foundation.org
In-Reply-To: <20180214182542.69302-8-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-8-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Fold p4d page table layer at runtime
Git-Commit-ID: 98219dda2ab56ce2a967fdebf81e838d676d9ddc
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

Commit-ID:  98219dda2ab56ce2a967fdebf81e838d676d9ddc
Gitweb:     https://git.kernel.org/tip/98219dda2ab56ce2a967fdebf81e838d676d9ddc
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:40 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:48 +0100

x86/mm: Fold p4d page table layer at runtime

Change page table helpers to fold p4d at runtime.
The logic is the same as in <asm-generic/pgtable-nop4d.h>.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214182542.69302-8-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/paravirt.h | 10 ++++++----
 arch/x86/include/asm/pgalloc.h  |  5 ++++-
 arch/x86/include/asm/pgtable.h  | 11 ++++++++++-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 892df37..3fbaad2 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -569,14 +569,16 @@ static inline p4dval_t p4d_val(p4d_t p4d)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	pgdval_t val = native_pgd_val(pgd);
-
-	PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp, val);
+	if (pgtable_l5_enabled)
+		PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp, native_pgd_val(pgd));
+	else
+		set_p4d((p4d_t *)(pgdp), (p4d_t) { pgd.pgd });
 }
 
 static inline void pgd_clear(pgd_t *pgdp)
 {
-	set_pgd(pgdp, __pgd(0));
+	if (pgtable_l5_enabled)
+		set_pgd(pgdp, __pgd(0));
 }
 
 #endif  /* CONFIG_PGTABLE_LEVELS == 5 */
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index aff42e1..263c142 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -167,6 +167,8 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #if CONFIG_PGTABLE_LEVELS > 4
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 {
+	if (!pgtable_l5_enabled)
+		return;
 	paravirt_alloc_p4d(mm, __pa(p4d) >> PAGE_SHIFT);
 	set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
 }
@@ -191,7 +193,8 @@ extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long address)
 {
-	___p4d_free_tlb(tlb, p4d);
+	if (pgtable_l5_enabled)
+		___p4d_free_tlb(tlb, p4d);
 }
 
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 63c2552..c8baa7f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -65,7 +65,7 @@ extern pmdval_t early_pmd_flags;
 
 #ifndef __PAGETABLE_P4D_FOLDED
 #define set_pgd(pgdp, pgd)		native_set_pgd(pgdp, pgd)
-#define pgd_clear(pgd)			native_pgd_clear(pgd)
+#define pgd_clear(pgd)			(pgtable_l5_enabled ? native_pgd_clear(pgd) : 0)
 #endif
 
 #ifndef set_p4d
@@ -859,6 +859,8 @@ static inline unsigned long p4d_index(unsigned long address)
 #if CONFIG_PGTABLE_LEVELS > 4
 static inline int pgd_present(pgd_t pgd)
 {
+	if (!pgtable_l5_enabled)
+		return 1;
 	return pgd_flags(pgd) & _PAGE_PRESENT;
 }
 
@@ -876,6 +878,8 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 /* to find an entry in a page-table-directory. */
 static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
+	if (!pgtable_l5_enabled)
+		return (p4d_t *)pgd;
 	return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
 }
 
@@ -883,6 +887,9 @@ static inline int pgd_bad(pgd_t pgd)
 {
 	unsigned long ignore_flags = _PAGE_USER;
 
+	if (!pgtable_l5_enabled)
+		return 0;
+
 	if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
 		ignore_flags |= _PAGE_NX;
 
@@ -891,6 +898,8 @@ static inline int pgd_bad(pgd_t pgd)
 
 static inline int pgd_none(pgd_t pgd)
 {
+	if (!pgtable_l5_enabled)
+		return 0;
 	/*
 	 * There is no need to do a workaround for the KNL stray
 	 * A/D bit erratum here.  PGDs only point to page tables
