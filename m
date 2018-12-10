Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B752EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE472086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE472086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeLJOAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:00:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbeLJOAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:00:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21191684;
        Mon, 10 Dec 2018 06:00:52 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BF983F575;
        Mon, 10 Dec 2018 06:00:51 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v3 6/7] dma/debug: Remove dma_debug_resize_entries()
Date:   Mon, 10 Dec 2018 14:00:32 +0000
Message-Id: <9b219f4d9e9e9598baec2b15f4337cc608f7501d.1544447601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the only caller now gone, we can clean up this part of dma-debug's
exposed internals and make way to tweak the allocation behaviour.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Add Christoph's review tag

 include/linux/dma-debug.h |  7 ------
 kernel/dma/debug.c        | 46 ---------------------------------------
 2 files changed, 53 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 30213adbb6b9..46e6131a72b6 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -30,8 +30,6 @@ struct bus_type;
 
 extern void dma_debug_add_bus(struct bus_type *bus);
 
-extern int dma_debug_resize_entries(u32 num_entries);
-
 extern void debug_dma_map_single(struct device *dev, const void *addr,
 				 unsigned long len);
 
@@ -101,11 +99,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
 {
 }
 
-static inline int dma_debug_resize_entries(u32 num_entries)
-{
-	return 0;
-}
-
 static inline void debug_dma_map_single(struct device *dev, const void *addr,
 					unsigned long len)
 {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 912c23f4c177..36a42874b05f 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -755,52 +755,6 @@ static void dma_entry_free(struct dma_debug_entry *entry)
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 }
 
-int dma_debug_resize_entries(u32 num_entries)
-{
-	int i, delta, ret = 0;
-	unsigned long flags;
-	struct dma_debug_entry *entry;
-	LIST_HEAD(tmp);
-
-	spin_lock_irqsave(&free_entries_lock, flags);
-
-	if (nr_total_entries < num_entries) {
-		delta = num_entries - nr_total_entries;
-
-		spin_unlock_irqrestore(&free_entries_lock, flags);
-
-		for (i = 0; i < delta; i++) {
-			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-			if (!entry)
-				break;
-
-			list_add_tail(&entry->list, &tmp);
-		}
-
-		spin_lock_irqsave(&free_entries_lock, flags);
-
-		list_splice(&tmp, &free_entries);
-		nr_total_entries += i;
-		num_free_entries += i;
-	} else {
-		delta = nr_total_entries - num_entries;
-
-		for (i = 0; i < delta && !list_empty(&free_entries); i++) {
-			entry = __dma_entry_alloc();
-			kfree(entry);
-		}
-
-		nr_total_entries -= i;
-	}
-
-	if (nr_total_entries != num_entries)
-		ret = 1;
-
-	spin_unlock_irqrestore(&free_entries_lock, flags);
-
-	return ret;
-}
-
 /*
  * DMA-API debugging init code
  *
-- 
2.19.1.dirty

