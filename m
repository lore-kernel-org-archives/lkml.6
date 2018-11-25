Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28052C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25F920865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25F920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeKZKr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:47:58 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:45496 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKZKr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:47:58 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 65F923A9DBB2370909C9;
        Mon, 26 Nov 2018 07:55:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAPNtVEx093301;
        Mon, 26 Nov 2018 07:55:31 +0800 (GMT-8)
        (envelope-from yang.yang29@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112607553337-12876764 ;
          Mon, 26 Nov 2018 07:55:33 +0800 
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, pavel.tatashin@microsoft.com, vbabka@suse.cz,
        osalvador@suse.de, rppt@linux.vnet.ibm.com, iamjoonsoo.kim@lge.com,
        alexander.h.duyck@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] mm: do not consider SWAP to calculate available when not necessary
Date:   Mon, 26 Nov 2018 07:58:23 +0800
Message-Id: <1543190303-8121-1-git-send-email-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-26 07:55:33,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-26 07:55:30,
        Serialize complete at 2018-11-26 07:55:30
X-MAIL: mse01.zte.com.cn wAPNtVEx093301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When si_mem_available() calculates 'available', it takes SWAP
into account. But if CONFIG_SWAP is N or SWAP is off(some embedded system
would like to do that), there is no need to consider it.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6847177..10e186b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4700,6 +4700,7 @@ static inline void show_node(struct zone *zone)
 
 long si_mem_available(void)
 {
+	struct sysinfo i;
 	long available;
 	unsigned long pagecache;
 	unsigned long wmark_low = 0;
@@ -4708,6 +4709,7 @@ long si_mem_available(void)
 	struct zone *zone;
 	int lru;
 
+	si_swapinfo(&i);
 	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
 		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
 
@@ -4724,9 +4726,13 @@ long si_mem_available(void)
 	 * Not all the page cache can be freed, otherwise the system will
 	 * start swapping. Assume at least half of the page cache, or the
 	 * low watermark worth of cache, needs to stay.
+	 * But if CONFIG_SWAP is N or SWAP is off, do not consider it.
 	 */
 	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
-	pagecache -= min(pagecache / 2, wmark_low);
+#ifdef CONFIG_SWAP
+	if (i.totalswap > 0)
+		pagecache -= min(pagecache / 2, wmark_low);
+#endif
 	available += pagecache;
 
 	/*
-- 
2.15.2

