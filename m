Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B39C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4631D2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4631D2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeJ2OEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:04:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49827 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729153AbeJ2OEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:04:10 -0400
X-UUID: a9d98cb000d24868b7ff3670f881530e-20181029
X-UUID: a9d98cb000d24868b7ff3670f881530e-20181029
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1181246590; Mon, 29 Oct 2018 13:16:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Oct 2018 13:16:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 13:16:28 +0800
From:   <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "Michal Hocko" <mhocko@kernel.org>
Subject: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
Date:   Mon, 29 Oct 2018 13:16:16 +0800
Message-ID: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 86B9739B61A74A4CABEA7080C5AC30440014C9C39DD983E7247355CD1A4FED4F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

The kbuf used by page owner is allocated by kmalloc(), which means it
can use only normal memory and there might be a "out of memory"
issue when we're out of normal memory.

To solve this problem, use kvmalloc() to allocate kbuf
from normal/highmem. But there is one problem here: kvmalloc()
does not fallback to vmalloc for sub page allocations. So sub
page allocation fails due to out of normal memory cannot fallback
to vmalloc.

Modify kvmalloc() to allow sub page allocations fallback to
vmalloc when CONFIG_HIGHMEM=y and use kvmalloc() to allocate
kbuf.

Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation.

Change since v2:
  - improve kvmalloc, allow sub page allocations fallback to
    vmalloc when CONFIG_HIGHMEM=y

Change since v1:
  - use kvmalloc()
  - clamp buffer size to PAGE_SIZE

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Cc: Joe Perches <joe@perches.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/page_owner.c | 8 ++++----
 mm/util.c       | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index d80adfe702d3..a064cd046361 100644
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
@@ -351,7 +350,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		.skip = 0
 	};
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	count = count > PAGE_SIZE ? PAGE_SIZE : count;
+	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
@@ -397,11 +397,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
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
 
diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..7b1c59b9bfbf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	ret = kmalloc_node(size, kmalloc_flags, node);
 
 	/*
-	 * It doesn't really make sense to fallback to vmalloc for sub page
-	 * requests
+	 * It only makes sense to fallback to vmalloc for sub page
+	 * requests if we might be able to allocate highmem pages.
 	 */
-	if (ret || size <= PAGE_SIZE)
+	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
 		return ret;
 
 	return __vmalloc_node_flags_caller(size, node, flags,
-- 
2.18.0

