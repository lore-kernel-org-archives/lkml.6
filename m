Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeCTVce (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:32:34 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55303 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751498AbeCTVcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:32:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] ipc: shm: pass atomic parameter to do_munmap()
Date: Wed, 21 Mar 2018 05:31:23 +0800
Message-Id: <1521581486-99134-6-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks safe to do unlock/relock mmap_sem in the middle of shmat(), so
passing "false" here.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 ipc/shm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865..1617523 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1537,7 +1537,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start,
+				  NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1564,7 +1565,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file))
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start,
+				  NULL, false);
 		vma = next;
 	}
 
@@ -1573,7 +1575,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	 * given
 	 */
 	if (vma && vma->vm_start == addr && vma->vm_ops == &shm_vm_ops) {
-		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start,
+			  NULL, false);
 		retval = 0;
 	}
 
-- 
1.8.3.1
