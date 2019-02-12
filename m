Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F647C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC86217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfBLC7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfBLC7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:59:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6202C7F3E7;
        Tue, 12 Feb 2019 02:59:01 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BCBD600C6;
        Tue, 12 Feb 2019 02:58:52 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v2 12/26] userfaultfd: wp: apply _PAGE_UFFD_WP bit
Date:   Tue, 12 Feb 2019 10:56:18 +0800
Message-Id: <20190212025632.28946-13-peterx@redhat.com>
In-Reply-To: <20190212025632.28946-1-peterx@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 12 Feb 2019 02:59:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, introduce two new flags MM_CP_UFFD_WP[_RESOLVE] for
change_protection() when used with uffd-wp and make sure the two new
flags are exclusively used.  Then,

  - For MM_CP_UFFD_WP: apply the _PAGE_UFFD_WP bit and remove _PAGE_RW
    when a range of memory is write protected by uffd

  - For MM_CP_UFFD_WP_RESOLVE: remove the _PAGE_UFFD_WP bit and recover
    _PAGE_RW when write protection is resolved from userspace

And use this new interface in mwriteprotect_range() to replace the old
MM_CP_DIRTY_ACCT.

Do this change for both PTEs and huge PMDs.  Then we can start to
identify which PTE/PMD is write protected by general (e.g., COW or soft
dirty tracking), and which is for userfaultfd-wp.

Since we should keep the _PAGE_UFFD_WP when doing pte_modify(), add it
into _PAGE_CHG_MASK as well.  Meanwhile, since we have this new bit, we
can be even more strict when detecting uffd-wp page faults in either
do_wp_page() or wp_huge_pmd().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable_types.h |  2 +-
 include/linux/mm.h                   |  5 +++++
 mm/huge_memory.c                     | 14 +++++++++++++-
 mm/memory.c                          |  4 ++--
 mm/mprotect.c                        | 12 ++++++++++++
 mm/userfaultfd.c                     |  8 ++++++--
 6 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 8cebcff91e57..dd9c6295d610 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -133,7 +133,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_UFFD_WP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9fe3b0066324..f38fbe9c8bc9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1657,6 +1657,11 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_DIRTY_ACCT                  (1UL << 0)
 /* Whether this protection change is for NUMA hints */
 #define  MM_CP_PROT_NUMA                   (1UL << 1)
+/* Whether this change is for write protecting */
+#define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
+#define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
+#define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
+					    MM_CP_UFFD_WP_RESOLVE)
 
 extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8d65b0f041f9..817335b443c2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1868,6 +1868,8 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	bool preserve_write;
 	int ret;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
@@ -1934,6 +1936,13 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	entry = pmd_modify(entry, newprot);
 	if (preserve_write)
 		entry = pmd_mk_savedwrite(entry);
+	if (uffd_wp) {
+		entry = pmd_wrprotect(entry);
+		entry = pmd_mkuffd_wp(entry);
+	} else if (uffd_wp_resolve) {
+		entry = pmd_mkwrite(entry);
+		entry = pmd_clear_uffd_wp(entry);
+	}
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
@@ -2083,7 +2092,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
-	bool young, write, soft_dirty, pmd_migration = false;
+	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
 	unsigned long addr;
 	int i;
 
@@ -2165,6 +2174,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
+		uffd_wp = pmd_uffd_wp(old_pmd);
 	}
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	page_ref_add(page, HPAGE_PMD_NR - 1);
@@ -2198,6 +2208,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mkold(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
+			if (uffd_wp)
+				entry = pte_mkuffd_wp(entry);
 		}
 		pte = pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
diff --git a/mm/memory.c b/mm/memory.c
index 00781c43407b..f8d83ae16eff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2483,7 +2483,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	if (userfaultfd_wp(vma)) {
+	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
@@ -3692,7 +3692,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_wp(vmf->vma))
+		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a6ba448c8565..9d4433044c21 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -46,6 +46,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	int target_node = NUMA_NO_NODE;
 	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * Can be called with only the mmap_sem for reading by
@@ -117,6 +119,14 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (preserve_write)
 				ptent = pte_mk_savedwrite(ptent);
 
+			if (uffd_wp) {
+				ptent = pte_wrprotect(ptent);
+				ptent = pte_mkuffd_wp(ptent);
+			} else if (uffd_wp_resolve) {
+				ptent = pte_mkwrite(ptent);
+				ptent = pte_clear_uffd_wp(ptent);
+			}
+
 			/* Avoid taking write faults for known dirty pages */
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
@@ -301,6 +311,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 {
 	unsigned long pages;
 
+	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
+
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
 	else
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 73a208c5c1e7..80bcd642911d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -73,8 +73,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
-	if (dst_vma->vm_flags & VM_WRITE && !wp_copy)
-		_dst_pte = pte_mkwrite(_dst_pte);
+	if (dst_vma->vm_flags & VM_WRITE) {
+		if (wp_copy)
+			_dst_pte = pte_mkuffd_wp(_dst_pte);
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+	}
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 	if (dst_vma->vm_file) {
-- 
2.17.1

