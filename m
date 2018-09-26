Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE06AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AA82082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AA82082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeIZJbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:31:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbeIZJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:31:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q3Krt4051509
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:20:59 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqye8wak3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:20:57 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 25 Sep 2018 21:19:07 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 21:19:05 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q3J4gw49807568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 20:19:04 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 874B0C605B;
        Tue, 25 Sep 2018 21:19:04 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91086C605A;
        Tue, 25 Sep 2018 21:19:02 -0600 (MDT)
Received: from skywalker.ibmuc.com (unknown [9.199.41.211])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Sep 2018 21:19:02 -0600 (MDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2] mm: Recheck page table entry with page table lock held
Date:   Wed, 26 Sep 2018 08:48:58 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18092603-0012-0000-0000-000016BBD39D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009772; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093723; UDB=6.00565314; IPR=6.00873760;
 MB=3.00023505; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-26 03:19:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092603-0013-0000-0000-00005489113B
Message-Id: <20180926031858.9692-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=832 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We clear the pte temporarily during read/modify/write update of the pte. If we
take a page fault while the pte is cleared, the application can get SIGBUS. One
such case is with remap_pfn_range without a backing vm_ops->fault callback.
do_fault will return SIGBUS in that case.

cpu 0		 				cpu1
mprotect()
ptep_modify_prot_start()/pte cleared.
.
.						page fault.
.
.
prep_modify_prot_commit()

Fix this by taking page table lock and rechecking for pte_none.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
V1:
* update commit message.

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

