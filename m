Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29570C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FF82184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfOjHy+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfACX53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:57:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59208 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfACX53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:57:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x03NsEDB087010;
        Thu, 3 Jan 2019 23:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=UE7uqpv9AO5lgxMv+d0OQlS1KIGZDvwswaG9ls4o27A=;
 b=YfOjHy+eOxzhZc9POc5F9sTNgTOt+rLOIiBnFzh/v1svaODnyWp9tSYlpIRv6diV5+mt
 9HzzjZcIlk6mcqD436T0A7EtUYz68ODTW8hUlKgEQH5WNU6x7RBVfrg4YyQ8aNLjCAV9
 ADjw5rBa+1Enyk+vQ6otOFD9qfoZQPavpahzGNbOtW/9k1KIwFcP669h+F4KqyqvxrA4
 ePCnRjN7mJTcZ14iTnKFZcgDCW0KBWfnIq27x2M3VDQRqswIOa/UM8fYzcJ+nmuO1FW6
 YYjR77AwUeIdvvip+hhSmxz6sa/CdywqxKGSrhBIYyHRDgFS7svI+h3iBFSpJlWWnva+ 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pp1jr9q4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jan 2019 23:55:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x03NtDti028626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jan 2019 23:55:13 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x03NtDfO006709;
        Thu, 3 Jan 2019 23:55:13 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 15:55:12 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Jan Stancek <jstancek@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlbfs: Revert "use i_mmap_rwsem for more pmd sharing synchronization"
Date:   Thu,  3 Jan 2019 15:54:52 -0800
Message-Id: <20190103235452.29335-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190103235452.29335-1-mike.kravetz@oracle.com>
References: <20190103235452.29335-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901030202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b43a9990055958e70347c56f90ea2ae32c67334c

The reverted commit caused issues with migration and poisoning of anon
huge pages.  The LTP move_pages12 test will cause an "unable to handle
kernel NULL pointer" BUG would occur with stack similar to:

RIP: 0010:down_write+0x1b/0x40
Call Trace:
 migrate_pages+0x81f/0xb90
 __ia32_compat_sys_migrate_pages+0x190/0x190
 do_move_pages_to_node.isra.53.part.54+0x2a/0x50
 kernel_move_pages+0x566/0x7b0
 __x64_sys_move_pages+0x24/0x30
 do_syscall_64+0x5b/0x180
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The purpose of the reverted patch was to fix some long existing races
with huge pmd sharing.  It used i_mmap_rwsem for this purpose with the
idea that this could also be used to address truncate/page fault races
with another patch.  Further analysis has determined that i_mmap_rwsem
can not be used to address all these hugetlbfs synchronization issues.
Therefore, revert this patch while working an another approach to the
underlying issues.

Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c        | 64 +++++++++++----------------------------------
 mm/memory-failure.c | 16 ++----------
 mm/migrate.c        | 13 +--------
 mm/rmap.c           |  4 ---
 mm/userfaultfd.c    | 11 ++------
 5 files changed, 20 insertions(+), 88 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5671ac9d13bb..06643af2905f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3238,7 +3238,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
-	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	struct mmu_notifier_range range;
@@ -3250,23 +3249,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_range_init(&range, src, vma->vm_start,
 					vma->vm_end, MMU_NOTIFY_CLEAR);
 		mmu_notifier_invalidate_range_start(&range);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
-
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
-
 		dst_pte = huge_pte_alloc(dst, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
@@ -3337,8 +3326,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
-	else
-		i_mmap_unlock_read(mapping);
 
 	return ret;
 }
@@ -3785,18 +3772,14 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			};
 
 			/*
-			 * hugetlb_fault_mutex and i_mmap_rwsem must be
-			 * dropped before handling userfault.  Reacquire
-			 * after handling fault to make calling code simpler.
+			 * hugetlb_fault_mutex must be dropped before
+			 * handling userfault.  Reacquire after handling
+			 * fault to make calling code simpler.
 			 */
 			hash = hugetlb_fault_mutex_hash(h, mm, vma, mapping,
 							idx, haddr);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
-
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
-
-			i_mmap_lock_read(mapping);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -3944,11 +3927,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
@@ -3956,31 +3934,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+	} else {
+		ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+		if (!ptep)
+			return VM_FAULT_OOM;
 	}
 
-	/*
-	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
-	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
-	 * is OK, as huge_pte_alloc will return the same value unless
-	 * something changed.
-	 */
 	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
-	if (!ptep) {
-		i_mmap_unlock_read(mapping);
-		return VM_FAULT_OOM;
-	}
+	idx = vma_hugecache_offset(h, vma, haddr);
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
-	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(h, mm, vma, mapping, idx, haddr);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -4068,7 +4035,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -4674,12 +4640,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
- * code much cleaner.
- *
- * This routine must be called with i_mmap_rwsem held in at least read mode.
- * For hugetlbfs, this prevents removal of any page table entries associated
- * with the address space.  This is important as we are setting up sharing
- * based on existing page table entries (mappings).
+ * code much cleaner. pmd allocation is essential for the shared case because
+ * pud has to be populated inside the same i_mmap_rwsem section - otherwise
+ * racing tasks could either miss the sharing (see huge_pte_offset) or select a
+ * bad pmd for sharing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -4696,6 +4660,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
 
+	i_mmap_lock_write(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -4725,6 +4690,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_write(mapping);
 	return pte;
 }
 
@@ -4735,7 +4701,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6379fff1a5ff..7c72f2a95785 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -966,7 +966,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
-	bool unmap_success = true;
+	bool unmap_success;
 	int kill = 1, forcekill;
 	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
@@ -1028,19 +1028,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	if (!PageHuge(hpage)) {
-		unmap_success = try_to_unmap(hpage, ttu);
-	} else if (mapping) {
-		/*
-		 * For hugetlb pages, try_to_unmap could potentially call
-		 * huge_pmd_unshare.  Because of this, take semaphore in
-		 * write mode here and set TTU_RMAP_LOCKED to indicate we
-		 * have taken the lock at this higer level.
-		 */
-		i_mmap_lock_write(mapping);
-		unmap_success = try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
-		i_mmap_unlock_write(mapping);
-	}
+	unmap_success = try_to_unmap(hpage, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
diff --git a/mm/migrate.c b/mm/migrate.c
index d8730bd8d878..b4f0557b83fb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1324,19 +1324,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		struct address_space *mapping = page_mapping(hpage);
-
-		/*
-		 * try_to_unmap could potentially call huge_pmd_unshare.
-		 * Because of this, take semaphore in write mode here and
-		 * set TTU_RMAP_LOCKED to let lower levels know we have
-		 * taken the lock.
-		 */
-		i_mmap_lock_write(mapping);
 		try_to_unmap(hpage,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS|
-			TTU_RMAP_LOCKED);
-		i_mmap_unlock_write(mapping);
+			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
 		page_was_mapped = 1;
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 000de5d02468..62e47f3462cf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -25,7 +25,6 @@
  *     page->flags PG_locked (lock_page)
  *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *         mapping->i_mmap_rwsem
- *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *           anon_vma->rwsem
  *             mm->page_table_lock or pte_lock
  *               zone_lru_lock (in mark_page_accessed, isolate_lru_page)
@@ -1381,9 +1380,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/*
 		 * If sharing is possible, start and end will be adjusted
 		 * accordingly.
-		 *
-		 * If called for a huge page, caller must hold i_mmap_rwsem
-		 * in write mode as it is possible to call huge_pmd_unshare.
 		 */
 		adjust_range_if_pmd_sharing_possible(vma, &range.start,
 						     &range.end);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 065c1ce191c4..d59b5a73dfb3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -267,14 +267,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		VM_BUG_ON(dst_addr & ~huge_page_mask(h));
 
 		/*
-		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
-		 * i_mmap_rwsem ensures the dst_pte remains valid even
-		 * in the case of shared pmds.  fault mutex prevents
-		 * races with other faulting threads.
+		 * Serialize via hugetlb_fault_mutex
 		 */
-		mapping = dst_vma->vm_file->f_mapping;
-		i_mmap_lock_read(mapping);
 		idx = linear_page_index(dst_vma, dst_addr);
+		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(h, dst_mm, dst_vma, mapping,
 								idx, dst_addr);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
@@ -283,7 +279,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_addr, huge_page_size(h));
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -291,7 +286,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pteval = huge_ptep_get(dst_pte);
 		if (!huge_pte_none(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -299,7 +293,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 						dst_addr, src_addr, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 		vm_alloc_shared = vm_shared;
 
 		cond_resched();
-- 
2.17.2

