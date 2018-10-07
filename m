Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2BC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D5C2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c22b+Z/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5C2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJHGsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:48:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60170 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:48:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w97NZ6Ox178050;
        Sun, 7 Oct 2018 23:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=rnwwipCvTDYAeg40/byE+gC9vQXbeVfq0i+KmhBH80s=;
 b=c22b+Z/Z7wWwRWUerVeORgJbzanl7eEhiillY//iKTPF+Js65q+bzj6IKkyqlDcFkLlD
 4m/u2N1eRkTtO06DRH8k5gAY49Crpj5+rquiRHbUgj9wNOGKGipwJkILhr+eQtmQ21NN
 9mfd53E6mXKW8nCd4DR/Iy1cBtkw4qTfrs1gaOTnydaF46QRrKPANeD3VYXoR51aqMJm
 ZY+VJTOhB6Xq5jZFeepCgytcJx0BX53U6r6FhaVFqCtayPvUDo5zE1xsRtbqI+j7F8y7
 BYsqDXFG7p6cZmWBU4Q/OF9xd0xycw39LwYxFCGT4Vkmy9pEIqiGGYHJQkkKFrKexSDR Mg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mxnpqkekw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Oct 2018 23:39:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w97Nd1kC008712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Oct 2018 23:39:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w97Nd1e7001116;
        Sun, 7 Oct 2018 23:39:01 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Oct 2018 23:39:00 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC 1/1] hugetlbfs: introduce truncation/fault mutex to avoid races
Date:   Sun,  7 Oct 2018 16:38:48 -0700
Message-Id: <20181007233848.13397-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181007233848.13397-1-mike.kravetz@oracle.com>
References: <20181007233848.13397-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9039 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810070241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following hugetlbfs truncate/page fault race can be recreated
with programs doing something like the following.

A huegtlbfs file is mmap(MAP_SHARED) with a size of 4 pages.  At
mmap time, 4 huge pages are reserved for the file/mapping.  So,
the global reserve count is 4.  In addition, since this is a shared
mapping an entry for 4 pages is added to the file's reserve map.
The first 3 of the 4 pages are faulted into the file.  As a result,
the global reserve count is now 1.

Task A starts to fault in the last page (routines hugetlb_fault,
hugetlb_no_page).  It allocates a huge page (alloc_huge_page).
The reserve map indicates there is a reserved page, so this is
used and the global reserve count goes to 0.

Now, task B truncates the file to size 0.  It starts by setting
inode size to 0(hugetlb_vmtruncate).  It then unmaps all mapping
of the file (hugetlb_vmdelete_list).  Since task A's page table
lock is not held at the time, truncation is not blocked.  Truncation
removes the 3 pages from the file (remove_inode_hugepages).  When
cleaning up the reserved pages (hugetlb_unreserve_pages), it notices
the reserve map was for 4 pages.  However, it has only freed 3 pages.
So it assumes there is still (4 - 3) 1 reserved pages.  It then
decrements the global reserve count by 1 and it goes negative.

Task A then continues the page fault process and adds it's newly
acquired page to the page cache.  Note that the index of this page
is beyond the size of the truncated file (0).  The page fault process
then notices the file has been truncated and exits.  However, the
page is left in the cache associated with the file.

Now, if the file is immediately deleted the truncate code runs again.
It will find and free the one page associated with the file.  When
cleaning up reserves, it notices the reserve map is empty.  Yet, one
page freed.  So, the global reserve count is decremented by (0 - 1) -1.
This returns the global count to 0 as it should be.  But, it is
possible for someone else to mmap this file/range before it is deleted.
If this happens, a reserve map entry for the allocated page is created
and the reserved page is forever leaked.

To avoid all these conditions, let's simply prevent faults to a file
while it is being truncated.  Add a new truncation specific rw mutex
to hugetlbfs inode extensions.  faults take the mutex in read mode,
truncation takes in write mode.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 24 ++++++++++++++++++++----
 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 25 +++++++++++++++++++------
 mm/userfaultfd.c        |  8 +++++++-
 4 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 40d4c66c7751..07b0ba049c37 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -427,10 +427,17 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash;
 
 			index = page->index;
-			hash = hugetlb_fault_mutex_hash(h, current->mm,
+			/*
+			 * Only need to acquire fault mutex in hole punch case.
+			 * For truncation, we are synchronized via truncation
+			 * mutex.
+			 */
+			if (!truncate_op) {
+				hash = hugetlb_fault_mutex_hash(h, current->mm,
 							&pseudo_vma,
 							mapping, index, 0);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			}
 
 			/*
 			 * If page is mapped, it was faulted in after being
@@ -471,7 +478,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			if (!truncate_op)
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -498,16 +506,19 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
+	down_write(&info->trunc_rwsem);
 	i_size_write(inode, offset);
 	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
+	up_write(&info->trunc_rwsem);
 	return 0;
 }
 
@@ -626,7 +637,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/* mutex taken here, fault path and hole punch */
+		/*
+		 * mutex taken here, for fault path and hole punch.
+		 * No need to worry about truncation as we are synchronized
+		 * with inode mutex
+		 */
 		hash = hugetlb_fault_mutex_hash(h, mm, &pseudo_vma, mapping,
 						index, addr);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
@@ -761,6 +776,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
+		init_rwsem(&info->trunc_rwsem);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 36fa6a2a82e3..73844107ee8a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -277,6 +277,7 @@ struct hugetlbfs_inode_info {
 	struct shared_policy policy;
 	struct inode vfs_inode;
 	unsigned int seals;
+	struct rw_semaphore trunc_rwsem;
 };
 
 static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3103099f64fd..10142c922aab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3696,6 +3696,7 @@ static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
+	struct hugetlbfs_inode_info *hinode_info = HUGETLBFS_I(mapping->host);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -3738,14 +3739,18 @@ static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			};
 
 			/*
-			 * hugetlb_fault_mutex must be dropped before
-			 * handling userfault.  Reacquire after handling
-			 * fault to make calling code simpler.
+			 * hugetlb_fault_mutex and truncation mutex must be
+			 * dropped before handling userfault.  Reacquire after
+			 * handling fault to make calling code simpler.
 			 */
 			hash = hugetlb_fault_mutex_hash(h, mm, vma, mapping,
 							idx, haddr);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			up_read(&hinode_info->trunc_rwsem);
+
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
+
+			down_read(&hinode_info->trunc_rwsem);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -3894,6 +3899,7 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	struct hugetlbfs_inode_info *hinode_info;
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
@@ -3914,10 +3920,16 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	idx = vma_hugecache_offset(h, vma, haddr);
 
 	/*
-	 * Serialize hugepage allocation and instantiation, so that we don't
-	 * get spurious allocation failures if two CPUs race to instantiate
-	 * the same page in the page cache.
+	 * Use truncate mutex to serialize truncation and page faults.  This
+	 * prevents ANY faults from happening on the file during truncation.
+	 * The fault mutex serializes hugepage allocation and instantiation
+	 * on the same page.  This prevents spurious allocation failures if
+	 * two CPUs race to instantiate the same page in the page cache.
+	 *
+	 * Acquire truncate mutex BEFORE fault mutex.
 	 */
+	hinode_info = HUGETLBFS_I(mapping->host);
+	down_read(&hinode_info->trunc_rwsem);
 	hash = hugetlb_fault_mutex_hash(h, mm, vma, mapping, idx, haddr);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -4005,6 +4017,7 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	up_read(&hinode_info->trunc_rwsem);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5029f241908f..554d1731028e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -169,6 +169,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	pgoff_t idx;
 	u32 hash;
 	struct address_space *mapping;
+	struct hugetlbfs_inode_info *hinode_info;
 
 	/*
 	 * There is no default zero huge page for all huge page sizes as
@@ -244,10 +245,12 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		VM_BUG_ON(dst_addr & ~huge_page_mask(h));
 
 		/*
-		 * Serialize via hugetlb_fault_mutex
+		 * Serialize via truncation and hugetlb_fault_mutex
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
+		hinode_info = HUGETLBFS_I(mapping->host);
+		down_read(&hinode_info->trunc_rwsem);
 		hash = hugetlb_fault_mutex_hash(h, dst_mm, dst_vma, mapping,
 								idx, dst_addr);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
@@ -256,6 +259,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_addr, huge_page_size(h));
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			up_read(&hinode_info->trunc_rwsem);
 			goto out_unlock;
 		}
 
@@ -263,6 +267,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pteval = huge_ptep_get(dst_pte);
 		if (!huge_pte_none(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			up_read(&hinode_info->trunc_rwsem);
 			goto out_unlock;
 		}
 
@@ -270,6 +275,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 						dst_addr, src_addr, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		up_read(&hinode_info->trunc_rwsem);
 		vm_alloc_shared = vm_shared;
 
 		cond_resched();
-- 
2.17.1

