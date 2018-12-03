Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB266C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE4D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hegYeheN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE4D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLCUJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:09:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:09:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3JwZoj078799;
        Mon, 3 Dec 2018 20:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=vxLAF8bT0VIgTD2UGzdu92swisUy1mIrbjZx+y8Wxck=;
 b=hegYeheNo5PYGbcsOmPdUBgHYv5ujLGFmWxnqWCcG7cMhXP8j4RUtS3+V7pY69CWOzCF
 AiFW/GOsCSNQYWgrKPUyhvnWNBRYO0BKVDl3L1Hx8EeoPlieI/noPQ9GFbCreHVQI3E/
 9x+Y9fM7dpjCry5zm8owPH84kqFuWq7KcugLSVpqyS5WrxtgGcKrHHTfRs4x9+tEsJ49
 MEs5G5v9VfMTHgNlG9Dpl8e9k6L450TZ7FoyfswHzt7JQBDRYNls011eVLJskd6Ow4IQ
 qfjy2OfjkRpYNwfIWfzkX4gBpm/glU6Wn1l+ycpfTbUrQ2dtwtyWr9YfWMcYNAK/odDY IQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxr8gk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 20:09:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3K93xM018213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 20:09:03 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3K93PW017194;
        Mon, 3 Dec 2018 20:09:03 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 12:09:02 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 3/3] hugetlbfs: remove unnecessary code after i_mmap_rwsem synchronization
Date:   Mon,  3 Dec 2018 12:08:50 -0800
Message-Id: <20181203200850.6460-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181203200850.6460-1-mike.kravetz@oracle.com>
References: <20181203200850.6460-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After expanding i_mmap_rwsem use for better shared pmd and page fault/
truncation synchronization, remove code that is no longer necessary.

Cc: <stable@vger.kernel.org>
Fixes: ebed4bfc8da8 ("hugetlb: fix absurd HugePages_Rsvd")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 46 +++++++++++++++-----------------------------
 mm/hugetlb.c         | 21 ++++++++++----------
 2 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3244147fc42b..a9c00c6ef80d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -383,17 +383,16 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
  * truncation is indicated by end of range being LLONG_MAX
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserv
- *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() prevents page faults in the
- *	truncated range.  It checks i_size before allocation, and again after
- *	with the page table lock for the page held.  The same lock must be
- *	acquired to unmap a page.
+ *	maps and global counts.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserv map
  *	deleted.  The region/reserv map for ranges without associated
- *	pages are not modified.  Page faults can race with hole punch.
- *	This is indicated if we find a mapped page.
+ *	pages are not modified.
+ *
+ * Callers of this routine must hold the i_mmap_rwsem in write mode to prevent
+ * races with page faults.
+ *
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
  */
@@ -423,32 +422,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 		for (i = 0; i < pagevec_count(&pvec); ++i) {
 			struct page *page = pvec.pages[i];
-			u32 hash;
 
 			index = page->index;
-			hash = hugetlb_fault_mutex_hash(h, current->mm,
-							&pseudo_vma,
-							mapping, index, 0);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
-
 			/*
-			 * If page is mapped, it was faulted in after being
-			 * unmapped in caller.  Unmap (again) now after taking
-			 * the fault mutex.  The mutex will prevent faults
-			 * until we finish removing the page.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
+			 * A mapped page is impossible as callers should unmap
+			 * all references before calling.  And, i_mmap_rwsem
+			 * prevents the creation of additional mappings.
 			 */
-			if (unlikely(page_mapped(page))) {
-				BUG_ON(truncate_op);
-
-				i_mmap_lock_write(mapping);
-				hugetlb_vmdelete_list(&mapping->i_mmap,
-					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h));
-				i_mmap_unlock_write(mapping);
-			}
+			VM_BUG_ON(page_mapped(page));
 
 			lock_page(page);
 			/*
@@ -470,7 +451,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -624,7 +604,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/* mutex taken here, fault path and hole punch */
+		/*
+		 * fault mutex taken here, protects against fault path
+		 * and hole punch.  inode_lock previously taken protects
+		 * against truncation.
+		 */
 		hash = hugetlb_fault_mutex_hash(h, mm, &pseudo_vma, mapping,
 						index, addr);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 362601b69c56..89e1a253a40b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3760,16 +3760,16 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * Use page lock to guard against racing truncation
-	 * before we get page_table_lock.
+	 * We can not race with truncation due to holding i_mmap_rwsem.
+	 * Check once here for faults beyond end of file.
 	 */
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto out;
+
 retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
-		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (idx >= size)
-			goto out;
-
 		/*
 		 * Check for page in userfault range
 		 */
@@ -3859,9 +3859,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto backout;
 
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
@@ -3964,8 +3961,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with ptep.  This serves two purposes:
+	 * 1) It prevents huge_pmd_unshare from being called elsewhere
+	 *    and making the ptep no longer valid.
+	 * 2) It synchronizes us with file truncation.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
-- 
2.17.2

