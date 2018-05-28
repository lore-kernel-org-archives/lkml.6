Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937345AbeE1K3d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937302AbeE1K3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:29:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nitin Gupta <nitin.m.gupta@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 071/329] sparc64: update pmdp_invalidate() to return old pmd value
Date: Mon, 28 May 2018 12:00:00 +0200
Message-Id: <20180528100248.751889596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitin Gupta <nitin.m.gupta@oracle.com>

[ Upstream commit a8e654f01cb725d0bfd741ebca1bf4c9337969cc ]

It's required to avoid losing dirty and accessed bits.

[akpm@linux-foundation.org: add a `do' to the do-while loop]
Link: http://lkml.kernel.org/r/20171213105756.69879-9-kirill.shutemov@linux.intel.com
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/include/asm/pgtable_64.h |    2 +-
 arch/sparc/mm/tlb.c                 |   23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -952,7 +952,7 @@ void update_mmu_cache_pmd(struct vm_area
 			  pmd_t *pmd);
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -219,17 +219,28 @@ void set_pmd_at(struct mm_struct *mm, un
 	}
 }
 
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old;
+
+	do {
+		old = *pmdp;
+	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
+
+	return old;
+}
+
 /*
  * This routine is only called when splitting a THP
  */
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry = *pmdp;
-
-	pmd_val(entry) &= ~_PAGE_VALID;
+	pmd_t old, entry;
 
-	set_pmd_at(vma->vm_mm, address, pmdp, entry);
+	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
+	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 
 	/*
@@ -240,6 +251,8 @@ void pmdp_invalidate(struct vm_area_stru
 	if ((pmd_val(entry) & _PAGE_PMD_HUGE) &&
 	    !is_huge_zero_page(pmd_page(entry)))
 		(vma->vm_mm)->context.thp_pte_count--;
+
+	return old;
 }
 
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
