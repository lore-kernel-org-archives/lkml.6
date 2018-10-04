Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB70C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD0720877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD0720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJEEKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:10:07 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34927 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725758AbeJEEKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:10:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T9zY.5M_1538687672;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9zY.5M_1538687672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Oct 2018 05:14:40 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        colin.king@canonical.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 -mm] mm: mremap: fix unsigned compare against 0 issue
Date:   Fri,  5 Oct 2018 05:14:32 +0800
Message-Id: <1538687672-17795-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538687672-17795-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1538687672-17795-1-git-send-email-yang.shi@linux.alibaba.com>
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

 mm/mremap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3524d16..f9d5d1f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -566,12 +566,14 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	 * downgrade mmap_sem to read.
 	 */
 	if (old_len >= new_len) {
-		ret = __do_munmap(mm, addr+new_len, old_len - new_len,
+		int retval;
+		retval = __do_munmap(mm, addr+new_len, old_len - new_len,
 				  &uf_unmap, true);
-		if (ret < 0 && old_len != new_len)
+		if (retval < 0 && old_len != new_len) {
+			ret = retval;
 			goto out;
 		/* Returning 1 indicates mmap_sem is downgraded to read. */
-		else if (ret == 1)
+		} else if (retval == 1)
 			downgraded = true;
 		ret = addr;
 		goto out;
-- 
1.8.3.1

