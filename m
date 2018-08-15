Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B99DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BB721528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BB721528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeHOVnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:43:37 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55403 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbeHOVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:43:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T6gJtNa_1534358999;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6gJtNa_1534358999)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Aug 2018 02:50:08 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v8 PATCH 5/5] mm: unmap VM_PFNMAP mappings with optimized path
Date:   Thu, 16 Aug 2018 02:49:50 +0800
Message-Id: <1534358990-85530-6-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmapping VM_PFNMAP mappings, vm flags need to be updated. Since
the vmas have been detached, so it sounds safe to update vm flags with
read mmap_sem.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3b9f734..0a9960d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2811,16 +2811,13 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 	}
 
 	/*
-	 * Unmapping vmas, which have:
-	 *   VM_PFNMAP or
-	 *   uprobes
-	 * need get done with write mmap_sem held since they may update
-	 * vm_flags. Deal with such mappings with regular do_munmap() call.
+	 * Unmapping vmas, which have uprobes need get done with write
+	 * mmap_sem held since they may update vm_flags. Deal with such
+	 * mappings with regular do_munmap() call.
 	 */
 	for (vma = start_vma; vma && vma->vm_start < end; vma = vma->vm_next) {
-		if ((vma->vm_file &&
-		    has_uprobes(vma, vma->vm_start, vma->vm_end)) ||
-		    (vma->vm_flags & VM_PFNMAP))
+		if (vma->vm_file &&
+		    has_uprobes(vma, vma->vm_start, vma->vm_end))
 			goto regular_path;
 	}
 
-- 
1.8.3.1

