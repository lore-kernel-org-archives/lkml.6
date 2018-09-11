Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D36EC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52B5206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52B5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeILB7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:59:44 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54652 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbeILB7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:59:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0T8Sg6Yy_1536699501;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T8Sg6Yy_1536699501)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Sep 2018 04:58:30 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, akpm@linux-foundation.org, dave.hansen@intel.com,
        oleg@redhat.com, srikar@linux.vnet.ibm.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v9 PATCH 4/4] mm: unmap VM_PFNMAP mappings with optimized path
Date:   Wed, 12 Sep 2018 04:58:13 +0800
Message-Id: <1536699493-69195-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmapping VM_PFNMAP mappings, vm flags need to be updated. Since
the vmas have been detached, so it sounds safe to update vm flags with
read mmap_sem.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 086f8b5..0b6b231 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2778,7 +2778,7 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 			       size_t len, struct list_head *uf)
 {
 	unsigned long end;
-	struct vm_area_struct *start_vma, *prev, *vma;
+	struct vm_area_struct *start_vma, *prev;
 	int ret = 0;
 
 	if (!addr_ok(start, len))
@@ -2811,16 +2811,6 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 			goto out;
 	}
 
-	/*
-	 * Unmapping vmas, which have VM_PFNMAP
-	 * need get done with write mmap_sem held since they may update
-	 * vm_flags. Deal with such mappings with regular do_munmap() call.
-	 */
-	for (vma = start_vma; vma && vma->vm_start < end; vma = vma->vm_next) {
-		if (vma->vm_flags & VM_PFNMAP)
-			goto regular_path;
-	}
-
 	/* Handle mlocked vmas */
 	if (mm->locked_vm)
 		munlock_vmas(start_vma, end);
@@ -2844,9 +2834,6 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 
 	return 0;
 
-regular_path:
-	ret = do_munmap(mm, start, len, uf);
-
 out:
 	up_write(&mm->mmap_sem);
 	return ret;
-- 
1.8.3.1

