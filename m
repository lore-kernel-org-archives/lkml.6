Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D838F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D838F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbeISWoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:44:03 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32924 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731592AbeISWoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:44:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0T91h4Va_1537376628;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T91h4Va_1537376628)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Sep 2018 01:03:55 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, kirill@shutemov.name, akpm@linux-foundation.org
Cc:     dave.hansen@intel.com, oleg@redhat.com, srikar@linux.vnet.ibm.com,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v11 PATCH 3/3] mm: unmap VM_PFNMAP mappings with optimized path
Date:   Thu, 20 Sep 2018 01:03:41 +0800
Message-Id: <1537376621-51150-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537376621-51150-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1537376621-51150-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmapping VM_PFNMAP mappings, vm flags need to be updated. Since
the vmas have been detached, so it sounds safe to update vm flags with
read mmap_sem.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mmap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 490340e..847a17d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2771,15 +2771,6 @@ static int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 				munlock_vma_pages_all(tmp);
 			}
 
-			/*
-			 * Unmapping vmas, which have VM_HUGETLB or VM_PFNMAP,
-			 * need get done with write mmap_sem held since they may
-			 * update vm_flags.
-			 */
-			if (downgrade &&
-			    (tmp->vm_flags & VM_PFNMAP))
-				downgrade = false;
-
 			tmp = tmp->vm_next;
 		}
 	}
-- 
1.8.3.1

