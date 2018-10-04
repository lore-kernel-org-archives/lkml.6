Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1947CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55EF20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55EF20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeJEEJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:09:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42679 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725758AbeJEEJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:09:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04390;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T9zY.5M_1538687672;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9zY.5M_1538687672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Oct 2018 05:14:40 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        colin.king@canonical.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 -mm] mm: brk: fix unsigned compare against 0 issue
Date:   Fri,  5 Oct 2018 05:14:31 +0800
Message-Id: <1538687672-17795-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analysis reported unsigned compare against 0 issue according to
Colin Ian King.

Defined an int temp variable to check the return value of __do_munmap().

Reported-by: Colin Ian King <colin.king@canonical.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
Andrew, this should be able to be folded into the original patch.

 mm/mmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 68dc4fb..c78f7e9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -242,17 +242,18 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
 	 * __do_munmap() may downgrade mmap_sem to read.
 	 */
 	if (brk <= mm->brk) {
+		int ret;
 		/*
 		 * mm->brk need to be protected by write mmap_sem, update it
 		 * before downgrading mmap_sem.
 		 * When __do_munmap fail, it will be restored from origbrk.
 		 */
 		mm->brk = brk;
-		retval = __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (retval < 0) {
+		ret = __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
+		if (ret < 0) {
 			mm->brk = origbrk;
 			goto out;
-		} else if (retval == 1)
+		} else if (ret == 1)
 			downgraded = true;
 		goto success;
 	}
-- 
1.8.3.1

