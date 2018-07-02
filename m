Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1049A252B0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1049A252B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeGBHvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:51:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932142AbeGBHu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:50:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w627i7G6103353
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:50:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyekk3dqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:50:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 2 Jul 2018 08:50:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 08:50:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w627onmJ38338762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 07:50:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5109AE04D;
        Mon,  2 Jul 2018 08:50:37 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2D6EAE045;
        Mon,  2 Jul 2018 08:50:37 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jul 2018 08:50:37 +0100 (BST)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 6F6A720F65E; Mon,  2 Jul 2018 09:50:49 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCHi v2] mm: do not drop unused pages when userfaultd is running
Date:   Mon,  2 Jul 2018 09:50:49 +0200
X-Mailer: git-send-email 2.17.0
X-TM-AS-GCONF: 00
x-cbid: 18070207-0012-0000-0000-00000285BB52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070207-0013-0000-0000-000020B730F1
Message-Id: <20180702075049.9157-1-borntraeger@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM guests on s390 can notify the host of unused pages. This can result
in pte_unused callbacks to be true for KVM guest memory.

If a page is unused (checked with pte_unused) we might drop this page
instead of paging it. This can have side-effects on userfaultd, when the
page in question was already migrated:

The next access of that page will trigger a fault and a user fault
instead of faulting in a new and empty zero page. As QEMU does not
expect a userfault on an already migrated page this migration will fail.

The most straightforward solution is to ignore the pte_unused hint if a
userfault context is active for this VMA.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
rfc->v2: use userfaultfd_armed
 mm/rmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 6db729dc4c50..e8fa564676b6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -64,6 +64,7 @@
 #include <linux/backing-dev.h>
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
+#include <linux/userfaultfd_k.h>
 
 #include <asm/tlbflush.h>
 
@@ -1481,7 +1482,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
-		} else if (pte_unused(pteval)) {
+		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
-- 
2.17.0

