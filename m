Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFD1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675E020892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675E020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeLESHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:07:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeLESHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:07:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I6kuF1375680
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:06:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I6k5V1375677;
        Wed, 5 Dec 2018 10:06:46 -0800
Date:   Wed, 5 Dec 2018 10:06:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-0a9fe8ca844d43f3f547f0e166122b6048121c8f@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org, luto@kernel.org,
        hpa@zytor.com, riel@surriel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, tglx@linutronix.de, peterz@infradead.org,
        bp@alien8.de
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org, luto@kernel.org,
          hpa@zytor.com, riel@surriel.com, dave.hansen@intel.com,
          kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
          bigeasy@linutronix.de, dan.j.williams@intel.com,
          tglx@linutronix.de, dave.hansen@linux.intel.com,
          peterz@infradead.org, bp@alien8.de
In-Reply-To: <154395944177.32119.8524957429632012270.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154395944177.32119.8524957429632012270.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Validate kernel_physical_mapping_init() PTE
 population
Git-Commit-ID: 0a9fe8ca844d43f3f547f0e166122b6048121c8f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0a9fe8ca844d43f3f547f0e166122b6048121c8f
Gitweb:     https://git.kernel.org/tip/0a9fe8ca844d43f3f547f0e166122b6048121c8f
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:37:21 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 09:03:06 +0100

x86/mm: Validate kernel_physical_mapping_init() PTE population

The usage of __flush_tlb_all() in the kernel_physical_mapping_init()
path is not necessary. In general flushing the TLB is not required when
updating an entry from the !present state. However, to give confidence
in the future removal of TLB flushing in this path, use the new
set_pte_safe() family of helpers to assert that the !present assumption
is true in this path.

[ mingo: Minor readability edits. ]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154395944177.32119.8524957429632012270.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgalloc.h           | 27 +++++++++++++++++++++++++++
 arch/x86/mm/init_64.c                    | 24 ++++++++++++------------
 include/asm-generic/5level-fixup.h       |  1 +
 include/asm-generic/pgtable-nop4d-hack.h |  1 +
 include/asm-generic/pgtable-nop4d.h      |  1 +
 include/asm-generic/pgtable-nopud.h      |  1 +
 6 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index ec7f43327033..1ea41aaef68b 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -80,6 +80,13 @@ static inline void pmd_populate_kernel(struct mm_struct *mm,
 	set_pmd(pmd, __pmd(__pa(pte) | _PAGE_TABLE));
 }
 
+static inline void pmd_populate_kernel_safe(struct mm_struct *mm,
+				       pmd_t *pmd, pte_t *pte)
+{
+	paravirt_alloc_pte(mm, __pa(pte) >> PAGE_SHIFT);
+	set_pmd_safe(pmd, __pmd(__pa(pte) | _PAGE_TABLE));
+}
+
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				struct page *pte)
 {
@@ -132,6 +139,12 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	paravirt_alloc_pmd(mm, __pa(pmd) >> PAGE_SHIFT);
 	set_pud(pud, __pud(_PAGE_TABLE | __pa(pmd)));
 }
+
+static inline void pud_populate_safe(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	paravirt_alloc_pmd(mm, __pa(pmd) >> PAGE_SHIFT);
+	set_pud_safe(pud, __pud(_PAGE_TABLE | __pa(pmd)));
+}
 #endif	/* CONFIG_X86_PAE */
 
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -141,6 +154,12 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 	set_p4d(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
 }
 
+static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
+{
+	paravirt_alloc_pud(mm, __pa(pud) >> PAGE_SHIFT);
+	set_p4d_safe(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
+}
+
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
@@ -173,6 +192,14 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 	set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
 }
 
+static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
+{
+	if (!pgtable_l5_enabled())
+		return;
+	paravirt_alloc_p4d(mm, __pa(p4d) >> PAGE_SHIFT);
+	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
+}
+
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 5fab264948c2..3e25ac2793ef 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -432,7 +432,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pte(pte, __pte(0));
+				set_pte_safe(pte, __pte(0));
 			continue;
 		}
 
@@ -452,7 +452,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			pr_info("   pte=%p addr=%lx pte=%016lx\n", pte, paddr,
 				pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL).pte);
 		pages++;
-		set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
+		set_pte_safe(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
 		paddr_last = (paddr & PAGE_MASK) + PAGE_SIZE;
 	}
 
@@ -487,7 +487,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pmd(pmd, __pmd(0));
+				set_pmd_safe(pmd, __pmd(0));
 			continue;
 		}
 
@@ -524,7 +524,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_2M)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte((pte_t *)pmd,
+			set_pte_safe((pte_t *)pmd,
 				pfn_pte((paddr & PMD_MASK) >> PAGE_SHIFT,
 					__pgprot(pgprot_val(prot) | _PAGE_PSE)));
 			spin_unlock(&init_mm.page_table_lock);
@@ -536,7 +536,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot);
 
 		spin_lock(&init_mm.page_table_lock);
-		pmd_populate_kernel(&init_mm, pmd, pte);
+		pmd_populate_kernel_safe(&init_mm, pmd, pte);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	update_page_count(PG_LEVEL_2M, pages);
@@ -573,7 +573,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pud(pud, __pud(0));
+				set_pud_safe(pud, __pud(0));
 			continue;
 		}
 
@@ -611,7 +611,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_1G)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte((pte_t *)pud,
+			set_pte_safe((pte_t *)pud,
 				pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
 					PAGE_KERNEL_LARGE));
 			spin_unlock(&init_mm.page_table_lock);
@@ -624,7 +624,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 					   page_size_mask, prot);
 
 		spin_lock(&init_mm.page_table_lock);
-		pud_populate(&init_mm, pud, pmd);
+		pud_populate_safe(&init_mm, pud, pmd);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	__flush_tlb_all();
@@ -659,7 +659,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_p4d(p4d, __p4d(0));
+				set_p4d_safe(p4d, __p4d(0));
 			continue;
 		}
 
@@ -677,7 +677,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 					   page_size_mask);
 
 		spin_lock(&init_mm.page_table_lock);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_safe(&init_mm, p4d, pud);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	__flush_tlb_all();
@@ -723,9 +723,9 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
-			pgd_populate(&init_mm, pgd, p4d);
+			pgd_populate_safe(&init_mm, pgd, p4d);
 		else
-			p4d_populate(&init_mm, p4d_offset(pgd, vaddr), (pud_t *) p4d);
+			p4d_populate_safe(&init_mm, p4d_offset(pgd, vaddr), (pud_t *) p4d);
 		spin_unlock(&init_mm.page_table_lock);
 		pgd_changed = true;
 	}
diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index 73474bb52344..bb6cb347018c 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -26,6 +26,7 @@
 #define p4d_clear(p4d)			pgd_clear(p4d)
 #define p4d_val(p4d)			pgd_val(p4d)
 #define p4d_populate(mm, p4d, pud)	pgd_populate(mm, p4d, pud)
+#define p4d_populate_safe(mm, p4d, pud)	pgd_populate(mm, p4d, pud)
 #define p4d_page(p4d)			pgd_page(p4d)
 #define p4d_page_vaddr(p4d)		pgd_page_vaddr(p4d)
 
diff --git a/include/asm-generic/pgtable-nop4d-hack.h b/include/asm-generic/pgtable-nop4d-hack.h
index 1d6dd38c0e5e..829bdb0d6327 100644
--- a/include/asm-generic/pgtable-nop4d-hack.h
+++ b/include/asm-generic/pgtable-nop4d-hack.h
@@ -31,6 +31,7 @@ static inline void pgd_clear(pgd_t *pgd)	{ }
 #define pud_ERROR(pud)				(pgd_ERROR((pud).pgd))
 
 #define pgd_populate(mm, pgd, pud)		do { } while (0)
+#define pgd_populate_safe(mm, pgd, pud)		do { } while (0)
 /*
  * (puds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 04cb913797bc..aebab905e6cd 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -26,6 +26,7 @@ static inline void pgd_clear(pgd_t *pgd)	{ }
 #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
 
 #define pgd_populate(mm, pgd, p4d)		do { } while (0)
+#define pgd_populate_safe(mm, pgd, p4d)		do { } while (0)
 /*
  * (p4ds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index 9bef475db6fe..c77a1d301155 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -35,6 +35,7 @@ static inline void p4d_clear(p4d_t *p4d)	{ }
 #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
 
 #define p4d_populate(mm, p4d, pud)		do { } while (0)
+#define p4d_populate_safe(mm, p4d, pud)		do { } while (0)
 /*
  * (puds are folded into p4ds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
