Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeCTVcp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:32:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41258 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751667AbeCTVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:32:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/8] fs: proc/vmcore: pass atomic parameter to do_munmap()
Date: Wed, 21 Mar 2018 05:31:24 +0800
Message-Id: <1521581486-99134-7-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just pass "true" here since vmcore map is not a hot path there is not
too much gain to release mmap_sem in the middle.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 fs/proc/vmcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index a45f0af..02683eb 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -388,7 +388,7 @@ static int remap_oldmem_pfn_checked(struct vm_area_struct *vma,
 	}
 	return 0;
 fail:
-	do_munmap(vma->vm_mm, from, len, NULL);
+	do_munmap(vma->vm_mm, from, len, NULL, true);
 	return -EAGAIN;
 }
 
@@ -481,7 +481,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 	return 0;
 fail:
-	do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
+	do_munmap(vma->vm_mm, vma->vm_start, len, NULL, true);
 	return -EAGAIN;
 }
 #else
-- 
1.8.3.1
