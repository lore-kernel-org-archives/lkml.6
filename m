Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69826C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16779206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgoWKQ7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16779206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeIMBbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:31:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeIMBbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:31:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKOqel064255;
        Wed, 12 Sep 2018 20:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=LPbElgD1pjqcX2q4LMCQ5E4+C12izc55GF8PnMhHfqY=;
 b=OgoWKQ7dyHbbAKQDA9GUsXRlMKKJyhvt2zGzjop5gHZ131dW802OunB5izfFMRWjcQJc
 CmY2BOaIcIL9U8bMhw/D7oPo3FJkmJJGwyWf0LLCiXPCjCCMMsnou5erP9xNgV4Ijhom
 Ov8hCWrMpcKdyXz4cVuzONHmKUMBVR6OvJU/jFOYEFVx3n1rpLikEJtFBwDGZA3KK+z4
 jYYL0So7rIrQF74cOq1XRd7cMmUoqPH/1iAltiwMmC3M+W6kuXRwOSr2nPV71rqodOcr
 YTtB5yZDMl9V9n/ETMr9KSIy6IMIFhRKtga9bIY+gX7u+5zD5eL8FifuO9P1NtvwzdvP Sg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5utmeuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOwB1015194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:24:59 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOvih024073;
        Wed, 12 Sep 2018 20:24:57 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:24:57 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 1/6] Add check to match numa node id when gathering pte stats
Date:   Wed, 12 Sep 2018 13:23:59 -0700
Message-Id: <1536783844-4145-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to check if numa node id matches when gathering pte stats,
to be used by later patches.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 fs/proc/task_mmu.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5ea1d64..0e2095c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1569,9 +1569,15 @@ struct numa_maps {
 	unsigned long mapcount_max;
 	unsigned long dirty;
 	unsigned long swapcache;
+        unsigned long nextaddr;
+		 long nid;
+		 long isvamaps;
 	unsigned long node[MAX_NUMNODES];
 };
 
+#define        NUMA_VAMAPS_NID_NOPAGES         (-1)
+#define        NUMA_VAMAPS_NID_NONE    (-2)
+
 struct numa_maps_private {
 	struct proc_maps_private proc_maps;
 	struct numa_maps md;
@@ -1653,6 +1659,20 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 }
 #endif
 
+static bool
+vamap_match_nid(struct numa_maps *md, unsigned long addr, struct page *page)
+{
+	long target = (page ? page_to_nid(page) : NUMA_VAMAPS_NID_NOPAGES);
+
+	if (md->nid == NUMA_VAMAPS_NID_NONE)
+		md->nid = target;
+	if (md->nid == target)
+		return 0;
+	/* did not match */
+	md->nextaddr = addr;
+	return 1;
+}
+
 static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		unsigned long end, struct mm_walk *walk)
 {
@@ -1661,6 +1681,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	pte_t *orig_pte;
 	pte_t *pte;
+	int ret = 0;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -1668,11 +1689,13 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		struct page *page;
 
 		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
-		if (page)
+		if (md->isvamaps)
+			ret = vamap_match_nid(md, addr, page);
+		if (page && !ret)
 			gather_stats(page, md, pmd_dirty(*pmd),
 				     HPAGE_PMD_SIZE/PAGE_SIZE);
 		spin_unlock(ptl);
-		return 0;
+		return ret;
 	}
 
 	if (pmd_trans_unstable(pmd))
@@ -1681,6 +1704,10 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
+		if (md->isvamaps && vamap_match_nid(md, addr, page)) {
+			ret = 1;
+			break;
+		}
 		if (!page)
 			continue;
 		gather_stats(page, md, pte_dirty(*pte), 1);
@@ -1688,7 +1715,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
 	cond_resched();
-	return 0;
+	return ret;
 }
 #ifdef CONFIG_HUGETLB_PAGE
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
@@ -1697,15 +1724,18 @@ static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 	pte_t huge_pte = huge_ptep_get(pte);
 	struct numa_maps *md;
 	struct page *page;
+	int ret = 0;
+	md = walk->private;
 
 	if (!pte_present(huge_pte))
-		return 0;
+		return (md->isvamaps ? vamap_match_nid(md, addr, NULL) : 0);
 
 	page = pte_page(huge_pte);
-	if (!page)
-		return 0;
+	if (md->isvamaps)
+		ret = vamap_match_nid(md, addr, page);
+	if (!page || ret)
+		return ret;
 
-	md = walk->private;
 	gather_stats(page, md, pte_dirty(huge_pte), 1);
 	return 0;
 }
-- 
2.7.4

