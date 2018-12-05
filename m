Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC872133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC872133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeLET6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:58:25 -0500
Received: from foss.arm.com ([217.140.101.70]:34584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbeLET5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FC6F1650;
        Wed,  5 Dec 2018 11:57:22 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49E2C3F614;
        Wed,  5 Dec 2018 11:57:21 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v2 7/8] dma/debug: Remove dma_debug_resize_entries()
Date:   Wed,  5 Dec 2018 19:56:56 +0000
Message-Id: <229557ee9d279393473997caa825617b6d0b19e3.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With no callers left, we can clean up this part of dma-debug's exposed
internals, making way to tweak the allocation behaviour.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 include/linux/dma-debug.h |  7 -------
 kernel/dma/debug.c        | 30 ------------------------------
 2 files changed, 37 deletions(-)

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
index cd9a12bf6a3a..2202402afe9a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -756,36 +756,6 @@ static void dma_entry_free(struct dma_debug_entry *entry)
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 }
 
-int dma_debug_resize_entries(u32 num_entries)
-{
-	int i, delta, ret = 0;
-	unsigned long flags;
-	struct dma_debug_entry *entry;
-
-	spin_lock_irqsave(&free_entries_lock, flags);
-
-	if (nr_total_entries < num_entries) {
-		delta = num_entries - nr_total_entries;
-
-		ret = dma_debug_add_entries(delta, GFP_ATOMIC);
-	} else {
-		delta = nr_total_entries - num_entries;
-
-		for (i = 0; i < delta && !list_empty(&free_entries); i++) {
-			entry = __dma_entry_alloc();
-			kfree(entry);
-		}
-
-		nr_total_entries -= i;
-		if (nr_total_entries != num_entries)
-			ret = -EBUSY;
-	}
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

