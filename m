Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCTVcn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:32:43 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39106 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751458AbeCTVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:32:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] mm: mremap: pass atomic parameter to do_munmap()
Date: Wed, 21 Mar 2018 05:31:21 +0800
Message-Id: <1521581486-99134-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds safe to do unlock/relock to mmap_sem in mremap, so passing
"false" here.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mremap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 049470a..5f8fca4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -353,7 +353,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_moved(vma);
 
-	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
+	if (do_munmap(mm, old_addr, old_len, uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
 		excess = 0;
@@ -462,12 +462,13 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
 		goto out;
 
-	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
+	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early, false);
 	if (ret)
 		goto out;
 
 	if (old_len >= new_len) {
-		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
+		ret = do_munmap(mm, addr+new_len, old_len - new_len,
+				uf_unmap, false);
 		if (ret && old_len != new_len)
 			goto out;
 		old_len = new_len;
@@ -568,7 +569,8 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	 * do_munmap does all the needed commit accounting
 	 */
 	if (old_len >= new_len) {
-		ret = do_munmap(mm, addr+new_len, old_len - new_len, &uf_unmap);
+		ret = do_munmap(mm, addr+new_len, old_len - new_len,
+				&uf_unmap, false);
 		if (ret && old_len != new_len)
 			goto out;
 		ret = addr;
-- 
1.8.3.1
