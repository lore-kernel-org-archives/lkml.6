Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153CEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB63E21785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0oSYYzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63E21785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeHMGWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 02:22:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeHMGWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 02:22:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7D3e6b2124913;
        Mon, 13 Aug 2018 03:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Pilx790CvHyY7hwm6VSZj46Ygh+pR4v37iu/tSwUVWM=;
 b=k0oSYYzCFLPacFtJXZ9vG+b8eXDFZ3H4VVA6sp1GRenua7t4uM1x2Qv0hopqpiFk9goP
 tKAUJsCeFGkixExLZs6J6mwFZ5zfp58IeJGtE+tiTheH2UUHymlyiqrRI6wk6I1hz2PF
 zBa/V6BgJEzzjaGDlDSLRxQL0q61C7bqcrX98cu+RFHJFSgZopu5V6QB9gVYTIJ/NvI9
 zc2iNbssY61u1DEywil34z6D7e7zAgdf/GSv6Zx18IzFXPLYePQRZGkM+vlAKG41tbqX
 Gvn/TtlYf4xW869MozDSy2ii9P85EjHoEOJqRHBJv6tCMLtfKjUL6U6VzAv2eSEUwlvH fw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ksq7t2g3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 03:41:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7D3fUOa024950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 03:41:30 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7D3fThs012107;
        Mon, 13 Aug 2018 03:41:29 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 03:41:28 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm: migration: fix migration of huge PMD shared pages
Date:   Sun, 12 Aug 2018 20:41:08 -0700
Message-Id: <20180813034108.27269-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page migration code employs try_to_unmap() to try and unmap the
source page.  This is accomplished by using rmap_walk to find all
vmas where the page is mapped.  This search stops when page mapcount
is zero.  For shared PMD huge pages, the page map count is always 1
not matter the number of mappings.  Shared mappings are tracked via
the reference count of the PMD page.  Therefore, try_to_unmap stops
prematurely and does not completely unmap all mappings of the source
page.

This problem can result is data corruption as writes to the original
source page can happen after contents of the page are copied to the
target page.  Hence, data is lost.

This problem was originally seen as DB corruption of shared global
areas after a huge page was soft offlined.  DB developers noticed
they could reproduce the issue by (hotplug) offlining memory used
to back huge pages.  A simple testcase can reproduce the problem by
creating a shared PMD mapping (note that this must be at least
PUD_SIZE in size and PUD_SIZE aligned (1GB on x86)), and using
migrate_pages() to migrate process pages between nodes.

To fix, have the try_to_unmap_one routine check for huge PMD sharing
by calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a
shared mapping it will be 'unshared' which removes the page table
entry and drops reference on PMD page.  After this, flush caches and
TLB.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
I am not %100 sure on the required flushing, so suggestions would be
appreciated.  This also should go to stable.  It has been around for
a long time so still looking for an appropriate 'fixes:'.

 mm/rmap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 09a799c9aebd..45583758bf16 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1409,6 +1409,27 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
 		address = pvmw.address;
 
+		/*
+		 * PMDs for hugetlbfs pages could be shared.  In this case,
+		 * pages with shared PMDs will have a mapcount of 1 no matter
+		 * how many times it is actually mapped.  Map counting for
+		 * PMD sharing is mostly done via the reference count on the
+		 * PMD page itself.  If the page we are trying to unmap is a
+		 * hugetlbfs page, attempt to 'unshare' at the PMD level.
+		 * huge_pmd_unshare takes care of clearing the PUD and
+		 * reference counting on the PMD page which effectively unmaps
+		 * the page.  Take care of flushing cache and TLB for page in
+		 * this specific mapping here.
+		 */
+		if (PageHuge(page) &&
+		    huge_pmd_unshare(mm, &address, pvmw.pte)) {
+			unsigned long end_add = address + vma_mmu_pagesize(vma);
+
+			flush_cache_range(vma, address, end_add);
+			flush_tlb_range(vma, address, end_add);
+			mmu_notifier_invalidate_range(mm, address, end_add);
+			continue;
+		}
 
 		if (IS_ENABLED(CONFIG_MIGRATION) &&
 		    (flags & TTU_MIGRATION) &&
-- 
2.17.1

