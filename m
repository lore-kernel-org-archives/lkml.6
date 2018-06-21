Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D606C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F104F22533
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F104F22533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934159AbeFUXQc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:16:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52461 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934057AbeFUXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:16:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T389Jdj_1529622950;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T389Jdj_1529622950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jun 2018 07:16:01 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/2] mm: thp: inc counter for collapsed shmem THP
Date:   Fri, 22 Jun 2018 07:15:49 +0800
Message-Id: <1529622949-75504-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1529622949-75504-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1529622949-75504-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed is used
to record the counter of collapsed THP, but it just gets inc'ed in
anonymous THP collapse path, do this for shmem THP collapse too.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
v1 --> v2:
* Seperate from the previous patch per Kirill's comment

 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9b0ec30..4018826 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1521,6 +1521,8 @@ static void collapse_shmem(struct mm_struct *mm,
 		unlock_page(new_page);
 
 		*hpage = NULL;
+
+		khugepaged_pages_collapsed++;
 	} else {
 		/* Something went wrong: rollback changes to the radix-tree */
 		shmem_uncharge(mapping->host, nr_none);
-- 
1.8.3.1

