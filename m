Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5746C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDDB2802D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDDB2802D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965209AbeF2WlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:41:04 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43027 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936850AbeF2Wkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:40:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0T3dXmHm_1530312021;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3dXmHm_1530312021)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Jun 2018 06:40:30 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 PATCH 3/5] mm: refactor do_munmap() to extract the common part
Date:   Sat, 30 Jun 2018 06:39:43 +0800
Message-Id: <1530311985-31251-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces two new helper functions:
  * munmap_addr_sanity()
  * munmap_lookup_vma()

They will be used by do_munmap() and the new do_munmap with zapping
large mapping early in the later patch.

There is no functional change, just code refactor.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 107 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 35 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d1eb87e..87dcf83 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2686,34 +2686,45 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
 
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-	      struct list_head *uf)
+static inline bool munmap_addr_sanity(unsigned long start, size_t len)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE - start)
+		return false;
 
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
-		return -EINVAL;
+	if (PAGE_ALIGN(len) == 0)
+		return false;
 
-	len = PAGE_ALIGN(len);
-	if (len == 0)
-		return -EINVAL;
+	return true;
+}
+
+/*
+ * munmap_lookup_vma: find the first overlap vma and split overlap vmas.
+ * @mm: mm_struct
+ * @vma: the first overlapping vma
+ * @prev: vma's prev
+ * @start: start address
+ * @end: end address
+ *
+ * returns 1 if successful, 0 or errno otherwise
+ */
+static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
+			     struct vm_area_struct **prev, unsigned long start,
+			     unsigned long end)
+{
+	struct vm_area_struct *tmp, *last;
+	int ret;
 
 	/* Find the first overlapping VMA */
-	vma = find_vma(mm, start);
-	if (!vma)
+	tmp = find_vma(mm, start);
+	if (!tmp)
 		return 0;
-	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
+
+	*prev = tmp->vm_prev;
+
+	/* we have start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
-	end = start + len;
-	if (vma->vm_start >= end)
+	if (tmp->vm_start >= end)
 		return 0;
 
 	/*
@@ -2723,31 +2734,57 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
-	if (start > vma->vm_start) {
-		int error;
-
+	if (start > tmp->vm_start) {
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (end < tmp->vm_end &&
+		    mm->map_count > sysctl_max_map_count)
 			return -ENOMEM;
 
-		error = __split_vma(mm, vma, start, 0);
-		if (error)
-			return error;
-		prev = vma;
+		ret = __split_vma(mm, tmp, start, 0);
+		if (ret)
+			return ret;
+		*prev = tmp;
 	}
 
 	/* Does it split the last one? */
 	last = find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		int error = __split_vma(mm, last, end, 1);
-		if (error)
-			return error;
+		ret = __split_vma(mm, last, end, 1);
+		if (ret)
+			return ret;
 	}
-	vma = prev ? prev->vm_next : mm->mmap;
+
+	*vma = *prev ? (*prev)->vm_next : mm->mmap;
+
+	return 1;
+}
+
+/* Munmap is split into 2 main parts -- this part which finds
+ * what needs doing, and the areas themselves, which do the
+ * work.  This now handles partial unmappings.
+ * Jeremy Fitzhardinge <jeremy@goop.org>
+ */
+int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+	      struct list_head *uf)
+{
+	unsigned long end;
+	struct vm_area_struct *vma = NULL, *prev;
+	int ret = 0;
+
+	if (!munmap_addr_sanity(start, len))
+		return -EINVAL;
+
+	len = PAGE_ALIGN(len);
+
+	end = start + len;
+
+	ret = munmap_lookup_vma(mm, &vma, &prev, start, end);
+	if (ret != 1)
+		return ret;
 
 	if (unlikely(uf)) {
 		/*
@@ -2759,9 +2796,9 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error = userfaultfd_unmap_prep(vma, start, end, uf);
-		if (error)
-			return error;
+		ret = userfaultfd_unmap_prep(vma, start, end, uf);
+		if (ret)
+			return ret;
 	}
 
 	/*
-- 
1.8.3.1

