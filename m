Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0B726B48
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0B726B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935796AbeFZNYm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:24:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935005AbeFZNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:24:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QDIjCM032000
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:24:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jup1g10v0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:24:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 26 Jun 2018 14:24:38 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 14:24:36 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QDOZ4p31654142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 13:24:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7B7AAE045;
        Tue, 26 Jun 2018 14:24:29 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84027AE056;
        Tue, 26 Jun 2018 14:24:29 +0100 (BST)
Received: from s38lp21.boeblingen.de.ibm.com (unknown [9.152.224.155])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 14:24:29 +0100 (BST)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     mike.kravetz@oracle.com, aarcange@redhat.com
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH] userfaultfd: hugetlbfs: Fix userfaultfd_huge_must_wait pte access
Date:   Tue, 26 Jun 2018 14:24:21 +0100
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18062613-0020-0000-0000-0000029F1DF3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062613-0021-0000-0000-000020EB9731
Message-Id: <20180626132421.78084-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use huge_ptep_get to translate huge ptes to normal ptes so we can
check them with the huge_pte_* functions. Otherwise some architectures
will check the wrong values and will not wait for userspace to bring
in the memory.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
---
 fs/userfaultfd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 123bf7d516fc..594d192b2331 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -222,24 +222,26 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 unsigned long reason)
 {
 	struct mm_struct *mm = ctx->mm;
-	pte_t *pte;
+	pte_t *ptep, pte;
 	bool ret = true;
 
 	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
 
-	pte = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
-	if (!pte)
+	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
+
+	if (!ptep)
 		goto out;
 
 	ret = false;
+	pte = huge_ptep_get(ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.
 	 */
-	if (huge_pte_none(*pte))
+	if (huge_pte_none(pte))
 		ret = true;
-	if (!huge_pte_write(*pte) && (reason & VM_UFFD_WP))
+	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
 out:
 	return ret;
-- 
2.14.3

