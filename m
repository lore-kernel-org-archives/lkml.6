Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A839C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F342083D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfB0OsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:48:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728025AbfB0OsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:48:22 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1REm8tC128615
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:48:21 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwuj4c1fj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:48:20 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 27 Feb 2019 14:48:18 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 14:48:14 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1REmDtL17629292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:48:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FFB6C6059;
        Wed, 27 Feb 2019 14:48:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A5DC6055;
        Wed, 27 Feb 2019 14:48:10 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.49.135])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 14:48:09 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v8 4/4] powerpc/mm/iommu: Allow large IOMMU page size only for hugetlb backing
Date:   Wed, 27 Feb 2019 20:17:36 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
References: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022714-8235-0000-0000-00000E661291
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010674; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167143; UDB=6.00609716; IPR=6.00947753;
 MB=3.00025765; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-27 14:48:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022714-8236-0000-0000-0000449E73C8
Message-Id: <20190227144736.5872-5-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THP pages can get split during different code paths. An incremented reference
count does imply we will not split the compound page. But the pmd entry can be
converted to level 4 pte entries. Keep the code simpler by allowing large
IOMMU page size only if the guest ram is backed by hugetlb pages.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/mmu_context_iommu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 85b4e9f5c615..e7a9c4f6bfca 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -98,8 +98,6 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	struct mm_iommu_table_group_mem_t *mem;
 	long i, ret, locked_entries = 0;
 	unsigned int pageshift;
-	unsigned long flags;
-	unsigned long cur_ua;
 
 	mutex_lock(&mem_list_mutex);
 
@@ -167,22 +165,14 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	for (i = 0; i < entries; ++i) {
 		struct page *page = mem->hpages[i];
 
-		cur_ua = ua + (i << PAGE_SHIFT);
-		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
-			pte_t *pte;
+		/*
+		 * Allow to use larger than 64k IOMMU pages. Only do that
+		 * if we are backed by hugetlb.
+		 */
+		if ((mem->pageshift > PAGE_SHIFT) && PageHuge(page)) {
 			struct page *head = compound_head(page);
-			unsigned int compshift = compound_order(head);
-			unsigned int pteshift;
-
-			local_irq_save(flags); /* disables as well */
-			pte = find_linux_pte(mm->pgd, cur_ua, NULL, &pteshift);
-
-			/* Double check it is still the same pinned page */
-			if (pte && pte_page(*pte) == head &&
-			    pteshift == compshift + PAGE_SHIFT)
-				pageshift = max_t(unsigned int, pteshift,
-						PAGE_SHIFT);
-			local_irq_restore(flags);
+
+			pageshift = compound_order(head) + PAGE_SHIFT;
 		}
 		mem->pageshift = min(mem->pageshift, pageshift);
 		/*
-- 
2.20.1

