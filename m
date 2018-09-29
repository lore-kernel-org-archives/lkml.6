Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ED720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeI3EXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51935 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728707AbeI3ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:33 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H8-OW; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006th-8R; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.437842201@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 060/131] mm: remove rest usage of VM_NONLINEAR and
 pte_file()
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit 0661a33611fca12570cba48d9344ce68834ee86c upstream.

One bit in ->vm_flags is unused now!

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Michal Hocko <mhocko@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Drop changes in mm/debug.c]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/drm_vma_manager.c
+++ b/drivers/gpu/drm/drm_vma_manager.c
@@ -50,8 +50,7 @@
  *
  * You must not use multiple offset managers on a single address_space.
  * Otherwise, mm-core will be unable to tear down memory mappings as the VM will
- * no longer be linear. Please use VM_NONLINEAR in that case and implement your
- * own offset managers.
+ * no longer be linear.
  *
  * This offset manager works on page-based addresses. That is, every argument
  * and return code (with the exception of drm_vma_node_offset_addr()) is given
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -125,7 +125,6 @@ extern unsigned int kobjsize(const void
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
 #define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
 
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -54,7 +54,7 @@ static inline pgoff_t swp_offset(swp_ent
 /* check whether a pte points to a swap entry */
 static inline int is_swap_pte(pte_t pte)
 {
-	return !pte_none(pte) && !pte_present_nonuma(pte) && !pte_file(pte);
+	return !pte_none(pte) && !pte_present_nonuma(pte);
 }
 #endif
 
@@ -66,7 +66,6 @@ static inline swp_entry_t pte_to_swp_ent
 {
 	swp_entry_t arch_entry;
 
-	BUG_ON(pte_file(pte));
 	if (pte_swp_soft_dirty(pte))
 		pte = pte_swp_clear_soft_dirty(pte);
 	arch_entry = __pte_to_swp_entry(pte);
@@ -82,7 +81,6 @@ static inline pte_t swp_entry_to_pte(swp
 	swp_entry_t arch_entry;
 
 	arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
-	BUG_ON(pte_file(__swp_entry_to_pte(arch_entry)));
 	return __swp_entry_to_pte(arch_entry);
 }
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -61,7 +61,7 @@ retry:
 		 */
 		if (likely(!(flags & FOLL_MIGRATION)))
 			goto no_page;
-		if (pte_none(pte) || pte_file(pte))
+		if (pte_none(pte))
 			goto no_page;
 		entry = pte_to_swp_entry(pte);
 		if (!is_migration_entry(entry))
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1749,7 +1749,7 @@ int ksm_madvise(struct vm_area_struct *v
 		 */
 		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
 				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_NONLINEAR | VM_MIXEDMAP))
+				 VM_HUGETLB | VM_MIXEDMAP))
 			return 0;		/* just ignore the advice */
 
 #ifdef VM_SAO
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -155,7 +155,7 @@ static int swapin_walk_pmd_entry(pmd_t *
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
-		if (pte_present(pte) || pte_none(pte) || pte_file(pte))
+		if (pte_present(pte) || pte_none(pte))
 			continue;
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
@@ -298,7 +298,7 @@ static long madvise_remove(struct vm_are
 
 	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
 
-	if (vma->vm_flags & (VM_LOCKED|VM_NONLINEAR|VM_HUGETLB))
+	if (vma->vm_flags & (VM_LOCKED | VM_HUGETLB))
 		return -EINVAL;
 
 	f = vma->vm_file;
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6580,10 +6580,7 @@ static struct page *mc_handle_file_pte(s
 		return NULL;
 
 	mapping = vma->vm_file->f_mapping;
-	if (pte_none(ptent))
-		pgoff = linear_page_index(vma, addr);
-	else /* pte_file(ptent) is true */
-		pgoff = pte_to_pgoff(ptent);
+	pgoff = linear_page_index(vma, addr);
 
 	/* page is moved even if it's not RSS of this task(page-faulted). */
 #ifdef CONFIG_SWAP
@@ -6616,7 +6613,7 @@ static enum mc_target_type get_mctgt_typ
 		page = mc_handle_present_pte(vma, addr, ptent);
 	else if (is_swap_pte(ptent))
 		page = mc_handle_swap_pte(vma, addr, ptent, &ent);
-	else if (pte_none(ptent) || pte_file(ptent))
+	else if (pte_none(ptent))
 		page = mc_handle_file_pte(vma, addr, ptent, &ent);
 
 	if (!page && !ent.val)
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -810,42 +810,40 @@ copy_one_pte(struct mm_struct *dst_mm, s
 
 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
-		if (!pte_file(pte)) {
-			swp_entry_t entry = pte_to_swp_entry(pte);
+		swp_entry_t entry = pte_to_swp_entry(pte);
 
-			if (likely(!non_swap_entry(entry))) {
-				if (swap_duplicate(entry) < 0)
-					return entry.val;
-
-				/* make sure dst_mm is on swapoff's mmlist. */
-				if (unlikely(list_empty(&dst_mm->mmlist))) {
-					spin_lock(&mmlist_lock);
-					if (list_empty(&dst_mm->mmlist))
-						list_add(&dst_mm->mmlist,
-							 &src_mm->mmlist);
-					spin_unlock(&mmlist_lock);
-				}
-				rss[MM_SWAPENTS]++;
-			} else if (is_migration_entry(entry)) {
-				page = migration_entry_to_page(entry);
-
-				if (PageAnon(page))
-					rss[MM_ANONPAGES]++;
-				else
-					rss[MM_FILEPAGES]++;
-
-				if (is_write_migration_entry(entry) &&
-				    is_cow_mapping(vm_flags)) {
-					/*
-					 * COW mappings require pages in both
-					 * parent and child to be set to read.
-					 */
-					make_migration_entry_read(&entry);
-					pte = swp_entry_to_pte(entry);
-					if (pte_swp_soft_dirty(*src_pte))
-						pte = pte_swp_mksoft_dirty(pte);
-					set_pte_at(src_mm, addr, src_pte, pte);
-				}
+		if (likely(!non_swap_entry(entry))) {
+			if (swap_duplicate(entry) < 0)
+				return entry.val;
+
+			/* make sure dst_mm is on swapoff's mmlist. */
+			if (unlikely(list_empty(&dst_mm->mmlist))) {
+				spin_lock(&mmlist_lock);
+				if (list_empty(&dst_mm->mmlist))
+					list_add(&dst_mm->mmlist,
+							&src_mm->mmlist);
+				spin_unlock(&mmlist_lock);
+			}
+			rss[MM_SWAPENTS]++;
+		} else if (is_migration_entry(entry)) {
+			page = migration_entry_to_page(entry);
+
+			if (PageAnon(page))
+				rss[MM_ANONPAGES]++;
+			else
+				rss[MM_FILEPAGES]++;
+
+			if (is_write_migration_entry(entry) &&
+					is_cow_mapping(vm_flags)) {
+				/*
+				 * COW mappings require pages in both
+				 * parent and child to be set to read.
+				 */
+				make_migration_entry_read(&entry);
+				pte = swp_entry_to_pte(entry);
+				if (pte_swp_soft_dirty(*src_pte))
+					pte = pte_swp_mksoft_dirty(pte);
+				set_pte_at(src_mm, addr, src_pte, pte);
 			}
 		}
 		goto out_set_pte;
@@ -1019,11 +1017,9 @@ int copy_page_range(struct mm_struct *ds
 	 * readonly mappings. The tradeoff is that copy_page_range is more
 	 * efficient than faulting.
 	 */
-	if (!(vma->vm_flags & (VM_HUGETLB | VM_NONLINEAR |
-			       VM_PFNMAP | VM_MIXEDMAP))) {
-		if (!vma->anon_vma)
-			return 0;
-	}
+	if (!(vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
+			!vma->anon_vma)
+		return 0;
 
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -124,17 +124,13 @@ static void mincore_pte_range(struct vm_
 	ptep = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		pte_t pte = *ptep;
-		pgoff_t pgoff;
 
 		next = addr + PAGE_SIZE;
 		if (pte_none(pte))
 			mincore_unmapped_range(vma, addr, next, vec);
 		else if (pte_present(pte))
 			*vec = 1;
-		else if (pte_file(pte)) {
-			pgoff = pte_to_pgoff(pte);
-			*vec = mincore_page(vma->vm_file->f_mapping, pgoff);
-		} else { /* pte is a swap entry */
+		else { /* pte is a swap entry */
 			swp_entry_t entry = pte_to_swp_entry(pte);
 
 			if (is_migration_entry(entry)) {
@@ -142,9 +138,8 @@ static void mincore_pte_range(struct vm_
 				*vec = 1;
 			} else {
 #ifdef CONFIG_SWAP
-				pgoff = entry.val;
 				*vec = mincore_page(swap_address_space(entry),
-					pgoff);
+					entry.val);
 #else
 				WARN_ON(1);
 				*vec = 1;
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -110,7 +110,7 @@ static unsigned long change_pte_range(st
 			}
 			if (updated)
 				pages++;
-		} else if (IS_ENABLED(CONFIG_MIGRATION) && !pte_file(oldpte)) {
+		} else if (IS_ENABLED(CONFIG_MIGRATION)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 
 			if (is_write_migration_entry(entry)) {
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -81,8 +81,6 @@ static pte_t move_soft_dirty_pte(pte_t p
 		pte = pte_mksoft_dirty(pte);
 	else if (is_swap_pte(pte))
 		pte = pte_swp_mksoft_dirty(pte);
-	else if (pte_file(pte))
-		pte = pte_file_mksoft_dirty(pte);
 #endif
 	return pte;
 }
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -86,10 +86,7 @@ SYSCALL_DEFINE3(msync, unsigned long, st
 				(vma->vm_flags & VM_SHARED)) {
 			get_file(file);
 			up_read(&mm->mmap_sem);
-			if (vma->vm_flags & VM_NONLINEAR)
-				error = vfs_fsync(file, 1);
-			else
-				error = vfs_fsync_range(file, fstart, fend, 1);
+			error = vfs_fsync_range(file, fstart, fend, 1);
 			fput(file);
 			if (error || start >= end)
 				goto out;

