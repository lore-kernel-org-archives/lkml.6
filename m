Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeCTVcD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:32:03 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46123 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751701AbeCTVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:31:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] mm: mmap: pass atomic parameter to do_munmap() call sites
Date: Wed, 21 Mar 2018 05:31:20 +0800
Message-Id: <1521581486-99134-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks safe to release mmap_sem in the middle for vm_munmap and brk,
so passing "false" to do_munmap() call.
However it sounds not safe to mmap_region() which is called by
SyS_mmap().

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ad6ae7a..374e4ec 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -225,7 +225,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk, &uf))
+		if (!do_munmap(mm, newbrk, oldbrk-newbrk, &uf, false))
 			goto set_brk;
 		goto out;
 	}
@@ -1643,7 +1643,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Clear old maps */
 	while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,
 			      &rb_parent)) {
-		if (do_munmap(mm, addr, len, uf))
+		if (do_munmap(mm, addr, len, uf, true))
 			return -ENOMEM;
 	}
 
@@ -2778,7 +2778,7 @@ int vm_munmap(unsigned long start, size_t len)
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
-	ret = do_munmap(mm, start, len, &uf);
+	ret = do_munmap(mm, start, len, &uf, false);
 	up_write(&mm->mmap_sem);
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
@@ -2945,7 +2945,7 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 	 */
 	while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,
 			      &rb_parent)) {
-		if (do_munmap(mm, addr, len, uf))
+		if (do_munmap(mm, addr, len, uf, false))
 			return -ENOMEM;
 	}
 
-- 
1.8.3.1
