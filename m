Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeBTHla convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:41:30 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:58040 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBTHl3 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Tue, 20 Feb 2018 02:41:29 -0500
Message-Id: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Tue, 20 Feb 2018 00:41:26 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] x86: consider effective protection attributes
 in W+X check
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using just the leaf page table entry flags would cause a false warning
in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
Hand through both the current entry's flags as well as the accumulated
effective value (the latter as pgprotval_t instead of pgprot_t, as it's
not an actual entry's value).

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/dump_pagetables.c |   92 ++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 35 deletions(-)

--- 4.16-rc2/arch/x86/mm/dump_pagetables.c
+++ 4.16-rc2-x86-dumppgt-effective-prot/arch/x86/mm/dump_pagetables.c
@@ -29,6 +29,7 @@
 struct pg_state {
 	int level;
 	pgprot_t current_prot;
+	pgprotval_t effective_prot;
 	unsigned long start_address;
 	unsigned long current_address;
 	const struct addr_marker *marker;
@@ -231,9 +232,9 @@ static unsigned long normalize_addr(unsi
  * print what we collected so far.
  */
 static void note_page(struct seq_file *m, struct pg_state *st,
-		      pgprot_t new_prot, int level)
+		      pgprot_t new_prot, pgprotval_t new_eff, int level)
 {
-	pgprotval_t prot, cur;
+	pgprotval_t prot, cur, eff;
 	static const char units[] = "BKMGTPE";
 
 	/*
@@ -243,23 +244,24 @@ static void note_page(struct seq_file *m
 	 */
 	prot = pgprot_val(new_prot);
 	cur = pgprot_val(st->current_prot);
+	eff = st->effective_prot;
 
 	if (!st->level) {
 		/* First entry */
 		st->current_prot = new_prot;
+		st->effective_prot = new_eff;
 		st->level = level;
 		st->marker = address_markers;
 		st->lines = 0;
 		pt_dump_seq_printf(m, st->to_dmesg, "---[ %s ]---\n",
 				   st->marker->name);
-	} else if (prot != cur || level != st->level ||
+	} else if (prot != cur || new_eff != eff || level != st->level ||
 		   st->current_address >= st->marker[1].start_address) {
 		const char *unit = units;
 		unsigned long delta;
 		int width = sizeof(unsigned long) * 2;
-		pgprotval_t pr = pgprot_val(st->current_prot);
 
-		if (st->check_wx && (pr & _PAGE_RW) && !(pr & _PAGE_NX)) {
+		if (st->check_wx && (eff & _PAGE_RW) && !(eff & _PAGE_NX)) {
 			WARN_ONCE(1,
 				  "x86/mm: Found insecure W+X mapping at address %p/%pS\n",
 				  (void *)st->start_address,
@@ -313,21 +315,30 @@ static void note_page(struct seq_file *m
 
 		st->start_address = st->current_address;
 		st->current_prot = new_prot;
+		st->effective_prot = new_eff;
 		st->level = level;
 	}
 }
 
-static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr, unsigned long P)
+static inline pgprotval_t effective_prot(pgprotval_t prot1, pgprotval_t prot2)
+{
+	return (prot1 & prot2 & (_PAGE_USER | _PAGE_RW)) |
+	       ((prot1 | prot2) & _PAGE_NX);
+}
+
+static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
+			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
 	pte_t *start;
-	pgprotval_t prot;
+	pgprotval_t prot, eff;
 
 	start = (pte_t *)pmd_page_vaddr(addr);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
 		prot = pte_flags(*start);
+		eff = effective_prot(eff_in, prot);
 		st->current_address = normalize_addr(P + i * PTE_LEVEL_MULT);
-		note_page(m, st, __pgprot(prot), 5);
+		note_page(m, st, __pgprot(prot), eff, 5);
 		start++;
 	}
 }
@@ -364,42 +375,45 @@ static inline bool kasan_page_table(stru
 
 #if PTRS_PER_PMD > 1
 
-static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr, unsigned long P)
+static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
+			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
 	pmd_t *start, *pmd_start;
-	pgprotval_t prot;
+	pgprotval_t prot, eff;
 
 	pmd_start = start = (pmd_t *)pud_page_vaddr(addr);
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		st->current_address = normalize_addr(P + i * PMD_LEVEL_MULT);
 		if (!pmd_none(*start)) {
+			prot = pmd_flags(*start);
+			eff = effective_prot(eff_in, prot);
 			if (pmd_large(*start) || !pmd_present(*start)) {
-				prot = pmd_flags(*start);
-				note_page(m, st, __pgprot(prot), 4);
+				note_page(m, st, __pgprot(prot), eff, 4);
 			} else if (!kasan_page_table(m, st, pmd_start)) {
-				walk_pte_level(m, st, *start,
+				walk_pte_level(m, st, *start, eff,
 					       P + i * PMD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 4);
+			note_page(m, st, __pgprot(0), 0, 4);
 		start++;
 	}
 }
 
 #else
-#define walk_pmd_level(m,s,a,p) walk_pte_level(m,s,__pmd(pud_val(a)),p)
+#define walk_pmd_level(m,s,a,e,p) walk_pte_level(m,s,__pmd(pud_val(a)),e,p)
 #define pud_large(a) pmd_large(__pmd(pud_val(a)))
 #define pud_none(a)  pmd_none(__pmd(pud_val(a)))
 #endif
 
 #if PTRS_PER_PUD > 1
 
-static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr, unsigned long P)
+static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
+			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
 	pud_t *start, *pud_start;
-	pgprotval_t prot;
+	pgprotval_t prot, eff;
 	pud_t *prev_pud = NULL;
 
 	pud_start = start = (pud_t *)p4d_page_vaddr(addr);
@@ -407,15 +421,16 @@ static void walk_pud_level(struct seq_fi
 	for (i = 0; i < PTRS_PER_PUD; i++) {
 		st->current_address = normalize_addr(P + i * PUD_LEVEL_MULT);
 		if (!pud_none(*start)) {
+			prot = pud_flags(*start);
+			eff = effective_prot(eff_in, prot);
 			if (pud_large(*start) || !pud_present(*start)) {
-				prot = pud_flags(*start);
-				note_page(m, st, __pgprot(prot), 3);
+				note_page(m, st, __pgprot(prot), eff, 3);
 			} else if (!kasan_page_table(m, st, pud_start)) {
-				walk_pmd_level(m, st, *start,
+				walk_pmd_level(m, st, *start, eff,
 					       P + i * PUD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 3);
+			note_page(m, st, __pgprot(0), 0, 3);
 
 		prev_pud = start;
 		start++;
@@ -423,40 +438,42 @@ static void walk_pud_level(struct seq_fi
 }
 
 #else
-#define walk_pud_level(m,s,a,p) walk_pmd_level(m,s,__pud(p4d_val(a)),p)
+#define walk_pud_level(m,s,a,e,p) walk_pmd_level(m,s,__pud(p4d_val(a)),e,p)
 #define p4d_large(a) pud_large(__pud(p4d_val(a)))
 #define p4d_none(a)  pud_none(__pud(p4d_val(a)))
 #endif
 
 #if PTRS_PER_P4D > 1
 
-static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr, unsigned long P)
+static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
+			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
 	p4d_t *start, *p4d_start;
-	pgprotval_t prot;
+	pgprotval_t prot, eff;
 
 	p4d_start = start = (p4d_t *)pgd_page_vaddr(addr);
 
 	for (i = 0; i < PTRS_PER_P4D; i++) {
 		st->current_address = normalize_addr(P + i * P4D_LEVEL_MULT);
 		if (!p4d_none(*start)) {
+			prot = p4d_flags(*start);
+			eff = effective_prot(eff_in, prot);
 			if (p4d_large(*start) || !p4d_present(*start)) {
-				prot = p4d_flags(*start);
-				note_page(m, st, __pgprot(prot), 2);
+				note_page(m, st, __pgprot(prot), eff, 2);
 			} else if (!kasan_page_table(m, st, p4d_start)) {
-				walk_pud_level(m, st, *start,
+				walk_pud_level(m, st, *start, eff,
 					       P + i * P4D_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 2);
+			note_page(m, st, __pgprot(0), 0, 2);
 
 		start++;
 	}
 }
 
 #else
-#define walk_p4d_level(m,s,a,p) walk_pud_level(m,s,__p4d(pgd_val(a)),p)
+#define walk_p4d_level(m,s,a,e,p) walk_pud_level(m,s,__p4d(pgd_val(a)),e,p)
 #define pgd_large(a) p4d_large(__p4d(pgd_val(a)))
 #define pgd_none(a)  p4d_none(__p4d(pgd_val(a)))
 #endif
@@ -483,7 +500,7 @@ static void ptdump_walk_pgd_level_core(s
 #else
 	pgd_t *start = swapper_pg_dir;
 #endif
-	pgprotval_t prot;
+	pgprotval_t prot, eff;
 	int i;
 	struct pg_state st = {};
 
@@ -499,15 +516,20 @@ static void ptdump_walk_pgd_level_core(s
 	for (i = 0; i < PTRS_PER_PGD; i++) {
 		st.current_address = normalize_addr(i * PGD_LEVEL_MULT);
 		if (!pgd_none(*start) && !is_hypervisor_range(i)) {
+			prot = pgd_flags(*start);
+#ifdef CONFIG_X86_PAE
+			eff = _PAGE_USER | _PAGE_RW;
+#else
+			eff = prot;
+#endif
 			if (pgd_large(*start) || !pgd_present(*start)) {
-				prot = pgd_flags(*start);
-				note_page(m, &st, __pgprot(prot), 1);
+				note_page(m, &st, __pgprot(prot), eff, 1);
 			} else {
-				walk_p4d_level(m, &st, *start,
+				walk_p4d_level(m, &st, *start, eff,
 					       i * PGD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, &st, __pgprot(0), 1);
+			note_page(m, &st, __pgprot(0), 0, 1);
 
 		cond_resched();
 		start++;
@@ -515,7 +537,7 @@ static void ptdump_walk_pgd_level_core(s
 
 	/* Flush out the last page */
 	st.current_address = normalize_addr(PTRS_PER_PGD*PGD_LEVEL_MULT);
-	note_page(m, &st, __pgprot(0), 0);
+	note_page(m, &st, __pgprot(0), 0, 0);
 	if (!checkwx)
 		return;
 	if (st.wx_pages)
