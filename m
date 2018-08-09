Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE4BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A86223A2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A86223A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeHJCD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:03:56 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49779 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbeHJCD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:03:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T6MWc.W_1533857777;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6MWc.W_1533857777)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Aug 2018 07:36:27 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v7 PATCH 4/4] mm: unmap special vmas with regular do_munmap()
Date:   Fri, 10 Aug 2018 07:36:03 +0800
Message-Id: <1533857763-43527-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmapping vmas, which have VM_HUGETLB | VM_PFNMAP flag set or
have uprobes set, need get done with write mmap_sem held since
they may update vm_flags.

So, it might be not safe enough to deal with these kind of special
mappings with read mmap_sem. Deal with such mappings with regular
do_munmap() call.

Michal suggested to make this as a separate patch for safer and more
bisectable sake.

Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2234d5a..06cb83c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2766,6 +2766,16 @@ static inline void munlock_vmas(struct vm_area_struct *vma,
 	}
 }
 
+static inline bool can_zap_with_rlock(struct vm_area_struct *vma)
+{
+	if ((vma->vm_file &&
+	     vma_has_uprobes(vma, vma->vm_start, vma->vm_end)) ||
+	     (vma->vm_flags | (VM_HUGETLB | VM_PFNMAP)))
+		return false;
+
+	return true;
+}
+
 /*
  * Zap pages with read mmap_sem held
  *
@@ -2808,6 +2818,17 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 			goto out;
 	}
 
+	/*
+	 * Unmapping vmas, which have VM_HUGETLB | VM_PFNMAP flag set or
+	 * have uprobes set, need get done with write mmap_sem held since
+	 * they may update vm_flags. Deal with such mappings with regular
+	 * do_munmap() call.
+	 */
+	for (vma = start_vma; vma && vma->vm_start < end; vma = vma->vm_next) {
+		if (!can_zap_with_rlock(vma))
+			goto regular_path;
+	}
+
 	/* Handle mlocked vmas */
 	if (mm->locked_vm) {
 		vma = start_vma;
@@ -2828,6 +2849,9 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 
 	return 0;
 
+regular_path:
+	ret = do_munmap(mm, start, len, uf);
+
 out:
 	up_write(&mm->mmap_sem);
 	return ret;
-- 
1.8.3.1

