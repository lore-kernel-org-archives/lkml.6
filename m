Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeDOJIX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:08:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeDOJIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:08:11 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-direct: Don't repeat allocation for no-op GFP_DMA
Date: Sun, 15 Apr 2018 11:08:07 +0200
Message-Id: <20180415090808.19121-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180415090808.19121-1-tiwai@suse.de>
References: <20180415090808.19121-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an allocation with lower dma_coherent mask fails,
dma_direct_alloc() retries the allocation with GFP_DMA.  But, it's
useless for architectures that has no ZONE_DMA, obviously.

Fix it by adding the check of CONFIG_ZONE_DMA before retrying the
allocation.

Fixes: 95f183916d4b ("dma-direct: retry allocations using GFP_DMA for small masks")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/dma-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index c0bba30fef0a..bbfb229aa067 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -84,7 +84,8 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		__free_pages(page, page_order);
 		page = NULL;
 
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
+		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
 		    !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
-- 
2.16.3
