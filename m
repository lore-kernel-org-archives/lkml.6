Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45550C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BECF21565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BECF21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeI0AZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:25:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45504 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbeI0AZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:25:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T9Vumj3_1537985434;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9Vumj3_1537985434)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Sep 2018 02:10:43 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, kirill@shutemov.name, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/2 -mm] mm: mremap: dwongrade mmap_sem to read when shrinking
Date:   Thu, 27 Sep 2018 02:10:33 +0800
Message-Id: <1537985434-22655-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than munmap, mremap might be used to shrink memory mapping too.
So, it may hold write mmap_sem for long time when shrinking large
mapping, as what commit ("mm: mmap: zap pages with read mmap_sem in
munmap") described.

The mremap() will not manipulate vmas anymore after __do_munmap() call for
the mapping shrink use case, so it is safe to downgrade to read mmap_sem.

So, the same optimization, which downgrades mmap_sem to read for zapping
pages, is also feasible and reasonable to this case.

The period of holding exclusive mmap_sem for shrinking large mapping
would be reduced significantly with this optimization.

MREMAP_FIXED and MREMAP_MAYMOVE are more complicated to adopt this
optimization since they need manipulate vmas after do_munmap(),
downgrading mmap_sem may create race window.

Simple mapping shrink is the low hanging fruit, and it may cover the
most cases of unmap with munmap together.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: Rephrase the commit log per Michal

 include/linux/mm.h |  2 ++
 mm/mmap.c          |  4 ++--
 mm/mremap.c        | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8..3028028 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2286,6 +2286,8 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
 	struct list_head *uf);
+extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
+		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 847a17d..017bcfa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2687,8 +2687,8 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardinge <jeremy@goop.org>
  */
-static int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		       struct list_head *uf, bool downgrade)
+int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+		struct list_head *uf, bool downgrade)
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
diff --git a/mm/mremap.c b/mm/mremap.c
index 5c2e185..8f1ec2b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -525,6 +525,7 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
 	bool locked = false;
+	bool downgrade = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
@@ -561,12 +562,17 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * do_munmap does all the needed commit accounting
+	 * __do_munmap does all the needed commit accounting, and
+	 * downgrade mmap_sem to read.
 	 */
 	if (old_len >= new_len) {
-		ret = do_munmap(mm, addr+new_len, old_len - new_len, &uf_unmap);
-		if (ret && old_len != new_len)
+		ret = __do_munmap(mm, addr+new_len, old_len - new_len,
+				  &uf_unmap, true);
+		if (ret < 0 && old_len != new_len)
 			goto out;
+		/* Returning 1 indicates mmap_sem is downgraded to read. */
+		else if (ret == 1)
+			downgrade = true;
 		ret = addr;
 		goto out;
 	}
@@ -631,7 +637,10 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 		vm_unacct_memory(charged);
 		locked = 0;
 	}
-	up_write(&current->mm->mmap_sem);
+	if (downgrade)
+		up_read(&current->mm->mmap_sem);
+	else
+		up_write(&current->mm->mmap_sem);
 	if (locked && new_len > old_len)
 		mm_populate(new_addr + old_len, new_len - old_len);
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
-- 
1.8.3.1

