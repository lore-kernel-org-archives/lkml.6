Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D003AC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8223F2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="alWxyPZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8223F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeGKUFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:05:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbeGKUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:05:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BJsElc018749;
        Wed, 11 Jul 2018 19:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=tP+V3Borxh0U/KXDOHt/QpWaHV3pNZI43ehZ4rhT/GA=;
 b=alWxyPZoDL+G0cqV3fgTPd1uVu/tIBW40DFAO0WEO0JT+lhsdQ6mb3hSXbbTmUzuw2Zq
 rU+KZR025NbjIXDO0Hs+khH3gUfpuROSZ2L8qyhVqMxbqKhLiiGXsgQnjs6KdLD8Jk6z
 M25yx+s5r32hiiTy8Cty9bl36JbVbYyETLpt5LEcxGZoy+dR18AOxzi2LIpUwS3n9Avo
 eyuGmiUI4JCjAZnsjAvarTX2YhmtSVdyu3uQJk1guJPQ/NZaOs3Foi5JHbY8plEwMT3R
 ZpV1rcgEM1Tsn1enFP7SMBddrffbfof2Y1C8R/4uQY7LB6l926XZ4CdjIUYGONZbSfvK aA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7dyqbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 19:59:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6BJxXvL007447
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 19:59:36 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6BJxUFk008044;
        Wed, 11 Jul 2018 19:59:30 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 12:59:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/hugetlb: remove gigantic page support for HIGHMEM
Date:   Wed, 11 Jul 2018 12:59:13 -0700
Message-Id: <20180711195913.1294-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ee8f248d266e ("hugetlb: add phys addr to struct
huge_bootmem_page")

At one time powerpc used this field and supporting code. However that
was removed with commit 79cc38ded1e1 ("powerpc/mm/hugetlb: Add support
for reserving gigantic huge pages via kernel command line").

There are no users of this field and supporting code, so remove it.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 3 ---
 mm/hugetlb.c            | 9 +--------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 36fa6a2a82e3..c39d9170a8a0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -348,9 +348,6 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
-#ifdef CONFIG_HIGHMEM
-	phys_addr_t phys;
-#endif
 };
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 430be42b6ca1..e39593df050b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2139,16 +2139,9 @@ static void __init gather_bootmem_prealloc(void)
 	struct huge_bootmem_page *m;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
+		struct page *page = virt_to_page(m);
 		struct hstate *h = m->hstate;
-		struct page *page;
 
-#ifdef CONFIG_HIGHMEM
-		page = pfn_to_page(m->phys >> PAGE_SHIFT);
-		memblock_free_late(__pa(m),
-				   sizeof(struct huge_bootmem_page));
-#else
-		page = virt_to_page(m);
-#endif
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
 		WARN_ON(PageReserved(page));
-- 
2.17.1

