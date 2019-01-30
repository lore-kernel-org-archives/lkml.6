Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A50C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33099218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GkJ93X0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfA3VPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:15:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55236 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbfA3VPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:15:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0UL49WS184680;
        Wed, 30 Jan 2019 21:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=rIMxUgtCRDVG/wcjmAlSmIOvfoTijxHPeFRFSa1Tavw=;
 b=GkJ93X0VCjyIV801XmWlC6UeUB/GCUYojQMy2FQosiwGh3DBOK/0IdCg143XqPAYC2CZ
 wfDsz4LFxWEHH58K6WjudPj2vMVZVLbNo9butG2yu7i24H4IgiZVWkX1w4sIeFvSSJRG
 7LjD84TGcBA+t48FQVytOk9OCsMV6BoqRCJ7ST//SYC0BThE+1Hsz00qJipaP+DkLtyK
 f++tsrKBoGajB9FUi0V2S04X5VwTE4E4XN3GEP3QK4kXNpdMN2U3j+OGrNpaAg30WYM4
 oEPRSY+0PjX6soREV/rzFLDoM9WTcRzc76d0ZEC4FxyH+WIi8TaVz0Smk/z2XEuOO9SH sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q8d2edah2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 21:15:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ULEwIe011439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 21:14:59 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ULEvN7006299;
        Wed, 30 Jan 2019 21:14:57 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 13:14:57 -0800
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
Subject: [PATCH] huegtlbfs: fix page leak during migration of file pages
Date:   Wed, 30 Jan 2019 13:14:43 -0800
Message-Id: <20190130211443.16678-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=499 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901300156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files can be created and mapped in an explicitly mounted hugetlbfs
filesystem.  If pages in such files are migrated, the filesystem
usage will not be decremented for the associated pages.  This can
result in mmap or page allocation failures as it appears there are
fewer pages in the filesystem than there should be.

For example, a test program which hole punches, faults and migrates
pages in such a file (1G in size) will eventually fail because it
can not allocate a page.  Reported counts and usage at time of failure:

node0
537	free_hugepages
1024	nr_hugepages
0	surplus_hugepages
node1
1000	free_hugepages
1024	nr_hugepages
0	surplus_hugepages

Filesystem                         Size  Used Avail Use% Mounted on
nodev                              4.0G  4.0G     0 100% /var/opt/hugepool

Note that the filesystem shows 4G of pages used, while actual usage is
511 pages (just under 1G).  Failed trying to allocate page 512.

If a hugetlb page is associated with an explicitly mounted filesystem,
this information in contained in the page_private field.  At migration
time, this information is not preserved.  To fix, simply transfer
page_private from old to new page at migration time if necessary. Also,
migrate_page_states() unconditionally clears page_private and PagePrivate
of the old page.  It is unlikely, but possible that these fields could
be non-NULL and are needed at hugetlb free page time.  So, do not touch
these fields for hugetlb pages.

Cc: <stable@vger.kernel.org>
Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 10 ++++++++++
 mm/migrate.c         | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 32920a10100e..fb6de1db8806 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -859,6 +859,16 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
 	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
+
+	/*
+	 * page_private is subpool pointer in hugetlb pages, transfer
+	 * if needed.
+	 */
+	if (page_private(page) && !page_private(newpage)) {
+		set_page_private(newpage, page_private(page));
+		set_page_private(page, 0);
+	}
+
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
 	else
diff --git a/mm/migrate.c b/mm/migrate.c
index f7e4bfdc13b7..0d9708803553 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -703,8 +703,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	 */
 	if (PageSwapCache(page))
 		ClearPageSwapCache(page);
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
+	/*
+	 * Unlikely, but PagePrivate and page_private could potentially
+	 * contain information needed at hugetlb free page time.
+	 */
+	if (!PageHuge(page)) {
+		ClearPagePrivate(page);
+		set_page_private(page, 0);
+	}
 
 	/*
 	 * If any waiters have accumulated on the new page then
-- 
2.17.2

