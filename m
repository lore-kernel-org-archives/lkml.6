Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C57CECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC48F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC48F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeILB7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:59:54 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43576 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726850AbeILB7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:59:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0T8Sg6Yy_1536699501;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T8Sg6Yy_1536699501)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Sep 2018 04:58:30 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, akpm@linux-foundation.org, dave.hansen@intel.com,
        oleg@redhat.com, srikar@linux.vnet.ibm.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v9 PATCH 3/4] mm: unmap VM_HUGETLB mappings with optimized path
Date:   Wed, 12 Sep 2018 04:58:12 +0800
Message-Id: <1536699493-69195-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmapping VM_HUGETLB mappings, vm flags need to be updated. Since
the vmas have been detached, so it sounds safe to update vm flags with
read mmap_sem.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 937d2f2..086f8b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2812,12 +2812,12 @@ static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
 	}
 
 	/*
-	 * Unmapping vmas, which have VM_HUGETLB or VM_PFNMAP
+	 * Unmapping vmas, which have VM_PFNMAP
 	 * need get done with write mmap_sem held since they may update
 	 * vm_flags. Deal with such mappings with regular do_munmap() call.
 	 */
 	for (vma = start_vma; vma && vma->vm_start < end; vma = vma->vm_next) {
-		if (vma->vm_flags & (VM_HUGETLB | VM_PFNMAP))
+		if (vma->vm_flags & VM_PFNMAP)
 			goto regular_path;
 	}
 
-- 
1.8.3.1

