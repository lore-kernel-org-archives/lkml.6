Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F294C22451
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F294C22451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeFUVlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:41:14 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42111 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933115AbeFUVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:41:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T37i56h_1529617247;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T37i56h_1529617247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jun 2018 05:40:56 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: register mm for khugepaged when merging vma for shmem
Date:   Fri, 22 Jun 2018 05:40:47 +0800
Message-Id: <1529617247-126312-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When merging anonymous page vma, if the size of vam can fit in at least
one hugepage, the mm will be registered for khugepaged for collapsing
THP in the future.

But, it skips shmem vma. Doing so for shmem too when merging vma in
order to increase the odd to collapse hugepage by khugepaged.

Also increase the count of shmem THP collapse. It looks missed before.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d7b2a4b..27f5ce2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -440,8 +440,12 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 		 * page fault if needed.
 		 */
 		return 0;
-	if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
-		/* khugepaged not yet working on file or special mappings */
+	if ((vma->vm_ops && !shmem_file(vma->vm_file)) ||
+	    (vm_flags & VM_NO_KHUGEPAGED))
+		/*
+		 * khugepaged not yet working on non-shmem file or special
+		 * mappings
+		 */
 		return 0;
 	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
 	hend = vma->vm_end & HPAGE_PMD_MASK;
@@ -1517,6 +1521,8 @@ static void collapse_shmem(struct mm_struct *mm,
 		unlock_page(new_page);
 
 		*hpage = NULL;
+
+		khugepaged_pages_collapsed++;
 	} else {
 		/* Something went wrong: rollback changes to the radix-tree */
 		shmem_uncharge(mapping->host, nr_none);
-- 
1.8.3.1

