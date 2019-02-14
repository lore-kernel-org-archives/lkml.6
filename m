Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07DDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BC2222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wBeqv5HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfBNBcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:32:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50470 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfBNBcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:32:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E1T435154335;
        Thu, 14 Feb 2019 01:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=QG0jTDVpSEhIsvVHTjY51M5aGJDrl2PK59ahq/4ZWQE=;
 b=wBeqv5HA1DTKd9/12GocSoQKSYtA7Sz8KHKZ8dFkiwj8L+QAu/EwDd0jlXfM4R9hBbp0
 nUB34eRkmcLZFtPpDvU5KxEfpBusCO0XgXQbNVOpfQz5ShentEWSLjX67KVJKwkJ69jF
 YhosyobDqqYW4b+v0E83+VGCF+BpyLy3kYiOBW2y7W+0hWUYGZSYlQCy4qtHT6wO5297
 b1/g6DmeDFh5J5ooHFMErntXIUFfe3IlRb9F2m+K9i5eqa2Uv9UGcTFOTCzcfNQb378H
 yCjajvAYo3jI9mR38JG3lM3L28GMucnhDq1Lh1zlS3L82y/oU0U3RsWExHl0HMPdUzb8 1w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhreknb9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 01:32:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E1W8ix011793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 01:32:08 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E1W75S005313;
        Thu, 14 Feb 2019 01:32:07 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 01:32:07 +0000
Subject: Re: [PATCH] huegtlbfs: fix races and page leaks during migration
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
References: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
 <20190212221400.3512-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <74510272-7319-7372-9ea6-ec914734c179@oracle.com>
Date:   Wed, 13 Feb 2019 17:32:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212221400.3512-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 2:14 PM, Mike Kravetz wrote:
> 
> Hugetlb pages can also be leaked at migration time if the pages are
> associated with a file in an explicitly mounted hugetlbfs filesystem.
> For example, a test program which hole punches, faults and migrates
> pages in such a file (1G in size) will eventually fail because it
> can not allocate a page.  Reported counts and usage at time of failure:
> 
> node0
> 537     free_hugepages
> 1024    nr_hugepages
> 0       surplus_hugepages
> node1
> 1000    free_hugepages
> 1024    nr_hugepages
> 0       surplus_hugepages
> 
> Filesystem                         Size  Used Avail Use% Mounted on
> nodev                              4.0G  4.0G     0 100% /var/opt/hugepool
> 
> Note that the filesystem shows 4G of pages used, while actual usage is
> 511 pages (just under 1G).  Failed trying to allocate page 512.

My apologies.  The test scenario described above does not trigger the
page leak issue fixed with this patch.  It actually triggers another
undiagnosed and unfixed issue with huge page migration that I will
be working on.  Sigh!

The leak with migration of huge pages in explicitly mounted filesystem
is still fixed by this patch.  However, the commit message should be
changed to more accurately reflect testing and observed outcomes.  The
patch with only commit message changes is below:

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 12 Feb 2019 10:58:28 -0800
Subject: [PATCH] huegtlbfs: fix races and page leaks during migration

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
For example, consider a two node system with 4GB worth of huge pages
available.  A program mmaps a 2G file in a hugetlbfs filesystem.  It
then migrates the pages associated with the file from one node to
another.  When the program exits, huge page counts are as follows:

node0
1024    free_hugepages
1024    nr_hugepages

node1
0       free_hugepages
1024    nr_hugepages

Filesystem                         Size  Used Avail Use% Mounted on
nodev                              4.0G  2.0G  2.0G  50% /var/opt/hugepool

That is as expected.  2G of huge pages are taken from the free_hugepages
counts, and 2G is the size of the file in the explicitly mounted filesystem.
If the file is then removed, the counts become:

node0
1024    free_hugepages
1024    nr_hugepages

node1
1024    free_hugepages
1024    nr_hugepages

Filesystem                         Size  Used Avail Use% Mounted on
nodev                              4.0G  2.0G  2.0G  50% /var/opt/hugepool

Note that the filesystem still shows 2G of pages used, while there
actually are no huge pages in use.  The only way to 'fix' the
filesystem accounting is to unmount the filesystem

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
@@ -859,6 +859,18 @@ static int hugetlbfs_migrate_page(struct address_space
*mapping,
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
@@ -3625,7 +3625,6 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct
vm_area_struct *vma,
 	copy_user_huge_page(new_page, old_page, address, vma,
 			    pages_per_huge_page(h));
 	__SetPageUptodate(new_page);
-	set_page_huge_active(new_page);

 	mmun_start = haddr;
 	mmun_end = mmun_start + huge_page_size(h);
@@ -3647,6 +3646,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct
vm_area_struct *vma,
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

