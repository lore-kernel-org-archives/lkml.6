Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA674ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6A421480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6A421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeIZG5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:57:35 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49713 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbeIZG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:57:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T9TF2nJ_1537922816;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9TF2nJ_1537922816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Sep 2018 08:47:08 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, kirill@shutemov.name, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 -mm] mm: brk: dwongrade mmap_sem to read when shrinking
Date:   Wed, 26 Sep 2018 08:46:56 +0800
Message-Id: <1537922816-108051-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537922816-108051-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1537922816-108051-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brk might be used to shinrk memory mapping too. Use __do_munmap() to
shrink mapping with downgrading mmap_sem to read.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 017bcfa..3da14a1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -193,9 +193,11 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 	unsigned long retval;
 	unsigned long newbrk, oldbrk;
 	struct mm_struct *mm = current->mm;
+	unsigned long origbrk = mm->brk;
 	struct vm_area_struct *next;
 	unsigned long min_brk;
 	bool populate;
+	bool downgrade = false;
 	LIST_HEAD(uf);
 
 	if (down_write_killable(&mm->mmap_sem))
@@ -229,14 +231,26 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 
 	newbrk = PAGE_ALIGN(brk);
 	oldbrk = PAGE_ALIGN(mm->brk);
-	if (oldbrk == newbrk)
-		goto set_brk;
+	if (oldbrk == newbrk) {
+		mm->brk = brk;
+		goto success;
+	}
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk, &uf))
-			goto set_brk;
-		goto out;
+		/*
+		 * mm->brk need to be protected by write mmap_sem, update it
+		 * before downgrading mmap_sem.
+		 * When __do_munmap fail, it will be restored from origbrk.
+		 */
+		mm->brk = brk;
+		retval = __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
+		if (retval < 0) {
+			mm->brk = origbrk;
+			goto out;
+		} else if (retval == 1)
+			downgrade = true;
+		goto success;
 	}
 
 	/* Check against existing mmap mappings. */
@@ -247,18 +261,21 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 	/* Ok, looks good - let it rip. */
 	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
 		goto out;
-
-set_brk:
 	mm->brk = brk;
+
+success:
 	populate = newbrk > oldbrk && (mm->def_flags & VM_LOCKED) != 0;
-	up_write(&mm->mmap_sem);
+	if (downgrade)
+		up_read(&mm->mmap_sem);
+	else
+		up_write(&mm->mmap_sem);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
 
 out:
-	retval = mm->brk;
+	retval = origbrk;
 	up_write(&mm->mmap_sem);
 	return retval;
 }
-- 
1.8.3.1

