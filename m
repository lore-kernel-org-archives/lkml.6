Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0ACC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC92222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pypCt11B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfBLWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:15:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBLWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:15:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CM3hMC027722;
        Tue, 12 Feb 2019 22:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=tx8yofQ7GDtc8w7ZnLR4b4Phwy1fVbZgK2ukQvv27ZE=;
 b=pypCt11B+jkaTl4hUp/50uGx/FaaXb5YnO7F5AsPLoiqyyf24wvyQQ9nw+Rdj4p30g8R
 D723oZVd7WlUGccYEhjn4V3F8rRryYD1UbTZNasaa0SowSM5POQHDgWplkRjp3kLDNcF
 U6HxiQup+0IFZ68VQcUzQFS2DXzEYKjS5SRHV60gpP07AFSpNog0U7PQ4aZhHeNf6l09
 bzIHIin9qLV5OWOkCiDP8t1oyaLlSx6IdZ4C94uSkmZd73nveSfXEyOqWbhrnN1Gw9Cr
 Ewbwjhhvykq5+k7qTDf3sT9wlrIeFrLFvGWML9jS6/i2EOoYE9vYt5blib6WCr8gtZ6L 9Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrekepuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 22:14:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1CME9Oj026407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 22:14:09 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1CME7mS016086;
        Tue, 12 Feb 2019 22:14:07 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 14:14:07 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH] huegtlbfs: fix races and page leaks during migration
Date:   Tue, 12 Feb 2019 14:14:00 -0800
Message-Id: <20190212221400.3512-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
References: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=717 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb pages should only be migrated if they are 'active'.  The routines
set/clear_page_huge_active() modify the active state of hugetlb pages.
When a new hugetlb page is allocated at fault time, set_page_huge_active
is called before the page is locked.  Therefore, another thread could
race and migrate the page while it is being added to page table by the
fault code.  This race is somewhat hard to trigger, but can be seen by
strategically adding udelay to simulate worst case scheduling behavior.
Depending on 'how' the code races, various BUG()s could be triggered.

To address this issue, simply delay the set_page_huge_active call until
after the page is successfully added to the page table.

Hugetlb pages can also be leaked at migration time if the pages are
associated with a file in an explicitly mounted hugetlbfs filesystem.
For example, a test program which hole punches, faults and migrates
pages in such a file (1G in size) will eventually fail because it
can not allocate a page.  Reported counts and usage at time of failure:

node0
537     free_hugepages
1024    nr_hugepages
0       surplus_hugepages
node1
1000    free_hugepages
1024    nr_hugepages
0       surplus_hugepages

Filesystem                         Size  Used Avail Use% Mounted on
nodev                              4.0G  4.0G     0 100% /var/opt/hugepool

Note that the filesystem shows 4G of pages used, while actual usage is
511 pages (just under 1G).  Failed trying to allocate page 512.

If a hugetlb page is associated with an explicitly mounted filesystem,
this information in contained in the page_private field.  At migration
time, this information is not preserved.  To fix, simply transfer
page_private from old to new page at migration time if necessary.

Cc: <stable@vger.kernel.org>
Fixes: bcc54222309c ("mm: hugetlb: introduce page_huge_active")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 12 ++++++++++++
 mm/hugetlb.c         |  9 ++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 32920a10100e..a7fa037b876b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -859,6 +859,18 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
 	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
+
+	/*
+	 * page_private is subpool pointer in hugetlb pages.  Transfer to
+	 * new page.  PagePrivate is not associated with page_private for
+	 * hugetlb pages and can not be set here as only page_huge_active
+	 * pages can be migrated.
+	 */
+	if (page_private(page)) {
+		set_page_private(newpage, page_private(page));
+		set_page_private(page, 0);
+	}
+
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
 	else
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a80832487981..f859e319e3eb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3625,7 +3625,6 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	copy_user_huge_page(new_page, old_page, address, vma,
 			    pages_per_huge_page(h));
 	__SetPageUptodate(new_page);
-	set_page_huge_active(new_page);
 
 	mmun_start = haddr;
 	mmun_end = mmun_start + huge_page_size(h);
@@ -3647,6 +3646,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
+		set_page_huge_active(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -3792,7 +3792,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		set_page_huge_active(page);
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
@@ -3863,6 +3862,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	spin_unlock(ptl);
+
+	/* May already be set if not newly allocated page */
+	set_page_huge_active(page);
+
 	unlock_page(page);
 out:
 	return ret;
@@ -4097,7 +4100,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * the set_pte_at() write.
 	 */
 	__SetPageUptodate(page);
-	set_page_huge_active(page);
 
 	mapping = dst_vma->vm_file->f_mapping;
 	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
@@ -4165,6 +4167,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
+	set_page_huge_active(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
-- 
2.17.2

