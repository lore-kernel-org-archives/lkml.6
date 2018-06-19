Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46BFC5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6571E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6571E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030567AbeFSVJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:09:07 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47031 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755447AbeFSVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:09:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T3.ushs_1529442518;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3.ushs_1529442518)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jun 2018 05:08:51 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thp: use mm_file_counter to determine update which rss counter
Date:   Wed, 20 Jun 2018 05:08:38 +0800
Message-Id: <1529442518-17398-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit eca56ff906bdd0239485e8b47154a6e73dd9a2f3 ("mm, shmem: add
internal shmem resident memory accounting"), MM_SHMEMPAGES is added to
separate the shmem accounting from regular files. So, all shmem pages
should be accounted to MM_SHMEMPAGES instead of MM_FILEPAGES.

And, normal 4K shmem pages have been accounted to MM_SHMEMPAGES, so
shmem thp pages should be not treated differently. Accouting them to
MM_SHMEMPAGES via mm_counter_file() since shmem pages are swap backed
to keep consistent with normal 4K shmem pages.

This will not change the rss counter of processes since shmem pages are
still a part of it.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c | 4 ++--
 mm/memory.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cd7c1a..2687f7c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1740,7 +1740,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		} else {
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
-			add_mm_counter(tlb->mm, MM_FILEPAGES, -HPAGE_PMD_NR);
+			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		}
 
 		spin_unlock(ptl);
@@ -2088,7 +2088,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			SetPageReferenced(page);
 		page_remove_rmap(page, true);
 		put_page(page);
-		add_mm_counter(mm, MM_FILEPAGES, -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
 	} else if (is_huge_zero_pmd(*pmd)) {
 		/*
diff --git a/mm/memory.c b/mm/memory.c
index 7206a63..4a2f2a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3372,7 +3372,7 @@ static int do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, MM_FILEPAGES, HPAGE_PMD_NR);
+	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
 	page_add_file_rmap(page, true);
 	/*
 	 * deposit and withdraw with pmd lock held
-- 
1.8.3.1

