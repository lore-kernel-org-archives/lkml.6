Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0FC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E218721531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E218721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeI0XT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:19:27 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59580 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbeI0XTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:19:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T9a2Upm_1538067582;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9a2Upm_1538067582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Sep 2018 00:59:49 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, kirill@shutemov.name, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/2 -mm] mm: brk: downgrade mmap_sem to read when shrinking
Date:   Fri, 28 Sep 2018 00:59:42 +0800
Message-Id: <1538067582-60038-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538067582-60038-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1538067582-60038-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brk might be used to shrink memory mapping too other than munmap().
So, it may hold write mmap_sem for long time when shrinking large
mapping, as what commit ("mm: mmap: zap pages with read mmap_sem in
munmap") described.

The brk() will not manipulate vmas anymore after __do_munmap() call for
the mapping shrink use case. But, it may set mm->brk after
__do_munmap(), which needs hold write mmap_sem.

However, a simple trick can workaround this by setting mm->brk before
__do_munmap(). Then restore the original value if __do_munmap() fails.
With this trick, it is safe to downgrade to read mmap_sem.

So, the same optimization, which downgrades mmap_sem to read for
zapping pages, is also feasible and reasonable to this case.

The period of holding exclusive mmap_sem for shrinking large mapping
would be reduced significantly with this optimization.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v3: Fixed the comments from Vlastimil and Kirill. And, added their
    Acked-by. Thanks.
v2: Rephrase the commit log per Michal

 mm/mmap.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 017bcfa..68dc4fb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -191,16 +191,19 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long retval;
-	unsigned long newbrk, oldbrk;
+	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *next;
 	unsigned long min_brk;
 	bool populate;
+	bool downgraded = false;
 	LIST_HEAD(uf);
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
+	origbrk = mm->brk;
+
 #ifdef CONFIG_COMPAT_BRK
 	/*
 	 * CONFIG_COMPAT_BRK can still be overridden by setting
@@ -229,14 +232,29 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 
 	newbrk = PAGE_ALIGN(brk);
 	oldbrk = PAGE_ALIGN(mm->brk);
-	if (oldbrk == newbrk)
-		goto set_brk;
+	if (oldbrk == newbrk) {
+		mm->brk = brk;
+		goto success;
+	}
 
-	/* Always allow shrinking brk. */
+	/*
+	 * Always allow shrinking brk.
+	 * __do_munmap() may downgrade mmap_sem to read.
+	 */
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
+			downgraded = true;
+		goto success;
 	}
 
 	/* Check against existing mmap mappings. */
@@ -247,18 +265,21 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
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
+	if (downgraded)
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

