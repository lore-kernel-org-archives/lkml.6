Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCTVdK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:33:10 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40683 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751569AbeCTVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:32:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] mm: nommu: add atomic parameter to do_munmap()
Date: Wed, 21 Mar 2018 05:31:22 +0800
Message-Id: <1521581486-99134-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just add atomic parameter to keep consistent with the API change and
pass "true" to the call site. Nommu code doesn't do the mmap_sem
unlock/relock.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/nommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index ebb6e61..5954c08 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1578,7 +1578,8 @@ static int shrink_vma(struct mm_struct *mm,
  * - under NOMMU conditions the chunk to be unmapped must be backed by a single
  *   VMA, though it need not cover the whole VMA
  */
-int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list_head *uf)
+int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+	      struct list_head *ufi, bool atomic)
 {
 	struct vm_area_struct *vma;
 	unsigned long end;
@@ -1644,7 +1645,7 @@ int vm_munmap(unsigned long addr, size_t len)
 	int ret;
 
 	down_write(&mm->mmap_sem);
-	ret = do_munmap(mm, addr, len, NULL);
+	ret = do_munmap(mm, addr, len, NULL, true);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
-- 
1.8.3.1
