Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B654820672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B654820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeJ2LDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:03:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61381 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729048AbeJ2LDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:03:38 -0400
X-UUID: 2f5d12a114f64df4890027a0fc7a5d4d-20181029
X-UUID: 2f5d12a114f64df4890027a0fc7a5d4d-20181029
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 606640263; Mon, 29 Oct 2018 10:16:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Oct 2018 10:16:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 10:16:45 +0800
From:   <miles.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCHv2] mm/page_owner: use kvmalloc instead of kmalloc
Date:   Mon, 29 Oct 2018 10:16:43 +0800
Message-ID: <1540779403-27622-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2932E7EEAC6E230EB2461690D3E152278D1DC363304DC491F1C165FE4D5DF8202000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

The kbuf used by page owner is allocated by kmalloc(), which means it
can use only normal memory and there might be a "out of memory"
issue when we're out of normal memory.

Use kvmalloc() so we can also allocate kbuf from
normal/hihghmem on 32bit kernel.

Clamp the kbuf size to PAGE_SIZE.

Change since v1:
  - use kvmalloc()
  - clamp buffer size to PAGE_SIZE

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Cc: Joe Perches <joe@perches.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/page_owner.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index d80adfe..a064cd0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
 #include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/bootmem.h>
 #include <linux/stacktrace.h>
@@ -351,7 +350,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 		.skip = 0
 	};
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	count = count > PAGE_SIZE ? PAGE_SIZE : count;
+	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
@@ -397,11 +397,11 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	if (copy_to_user(buf, kbuf, ret))
 		ret = -EFAULT;
 
-	kfree(kbuf);
+	kvfree(kbuf);
 	return ret;
 
 err:
-	kfree(kbuf);
+	kvfree(kbuf);
 	return -ENOMEM;
 }
 
-- 
1.9.1

