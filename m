Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76071C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A7D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A7D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeITPH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:07:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbeITPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:07:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8K9J8Op127744
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 05:25:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mm535sume-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 05:25:23 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 20 Sep 2018 05:25:22 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 05:25:21 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8K9PK5M27525130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 09:25:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EA3CAC05F;
        Thu, 20 Sep 2018 05:24:54 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520F3AC059;
        Thu, 20 Sep 2018 05:24:52 -0400 (EDT)
Received: from skywalker.ibmuc.com (unknown [9.85.86.4])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 05:24:51 -0400 (EDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] mm: Recheck page table entry with page table lock held
Date:   Thu, 20 Sep 2018 14:54:08 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18092009-0060-0000-0000-000002B3009F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009739; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090986; UDB=6.00563664; IPR=6.00871009;
 MB=3.00023408; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 09:25:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092009-0061-0000-0000-0000469302D3
Message-Id: <20180920092408.9128-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We clear the pte temporarily during read/modify/write update of the pte. If we
take a page fault while the pte is cleared, the application can get SIGBUS. One
such case is with remap_pfn_range without a backing vm_ops->fault callback.
do_fault will return SIGBUS in that case.

Fix this by taking page table lock and rechecking for pte_none.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c467102a5cbc..c2f933184303 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3745,10 +3745,33 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
-	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
-	if (!vma->vm_ops->fault)
-		ret = VM_FAULT_SIGBUS;
-	else if (!(vmf->flags & FAULT_FLAG_WRITE))
+	/*
+	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
+	 */
+	if (!vma->vm_ops->fault) {
+
+		/*
+		 * pmd entries won't be marked none during a R/M/W cycle.
+		 */
+		if (unlikely(pmd_none(*vmf->pmd)))
+			ret = VM_FAULT_SIGBUS;
+		else {
+			vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+			/*
+			 * Make sure this is not a temporary clearing of pte
+			 * by holding ptl and checking again. A R/M/W update
+			 * of pte involves: take ptl, clearing the pte so that
+			 * we don't have concurrent modification by hardware
+			 * followed by an update.
+			 */
+			spin_lock(vmf->ptl);
+			if (unlikely(pte_none(*vmf->pte)))
+				ret = VM_FAULT_SIGBUS;
+			else
+				ret = VM_FAULT_NOPAGE;
+			spin_unlock(vmf->ptl);
+		}
+	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
 	else if (!(vma->vm_flags & VM_SHARED))
 		ret = do_cow_fault(vmf);
-- 
2.17.1

