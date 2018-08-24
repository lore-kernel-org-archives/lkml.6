Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC51C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54B21580
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54B21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHXKGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:06:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbeHXKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:06:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7O6TVsc051396
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:33:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2cgyrpac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:33:34 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 24 Aug 2018 00:33:33 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 00:33:29 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7O6XSh449152164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 23:33:28 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A3E6E050;
        Fri, 24 Aug 2018 00:33:29 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75BF36E04C;
        Fri, 24 Aug 2018 00:33:26 -0600 (MDT)
Received: from skywalker.ibmuc.com (unknown [9.85.81.195])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 00:33:26 -0600 (MDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: [PATCH] mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
Date:   Fri, 24 Aug 2018 12:03:14 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18082406-8235-0000-0000-00000DF063C3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009601; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078035; UDB=6.00555865; IPR=6.00858010;
 MB=3.00022900; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 06:33:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082406-8236-0000-0000-00004263106E
Message-Id: <20180824063314.21981-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scanning for movable pages, filter out Hugetlb pages if hugepage migration
is not supported. Without this we hit infinte loop in __offline pages where we
do
	pfn = scan_movable_pages(start_pfn, end_pfn);
	if (pfn) { /* We have movable pages */
		ret = do_migrate_range(pfn, end_pfn);
		goto repeat;
	}

We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
we just check for Kernel config. The gigantic page size check is done in
page_huge_active.

Acked-by: Michal Hocko <mhocko@suse.com>
Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory_hotplug.c | 3 ++-
 mm/page_alloc.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9eea6e809a4e..38d94b703e9d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1333,7 +1333,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 			if (__PageMovable(page))
 				return pfn;
 			if (PageHuge(page)) {
-				if (page_huge_active(page))
+				if (hugepage_migration_supported(page_hstate(page)) &&
+				    page_huge_active(page))
 					return pfn;
 				else
 					pfn = round_up(pfn + 1,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c677c1506d73..b8d91f59b836 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7709,6 +7709,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page)) {
+
+			if (!hugepage_migration_supported(page_hstate(page)))
+				goto unmovable;
+
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
 		}
-- 
2.17.1

