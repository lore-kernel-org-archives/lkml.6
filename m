Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeDPPS3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:18:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:60014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeDPPS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:18:28 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] dma-direct: Try reallocation with GFP_DMA32 if possible
Date: Mon, 16 Apr 2018 17:18:19 +0200
Message-Id: <20180416151819.27520-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the recent swiotlb bug revealed, we seem to have given up the
direct DMA allocation too early and felt back to swiotlb allocation.
The reason is that swiotlb allocator expected that dma_direct_alloc()
would try harder to get pages even below 64bit DMA mask with
GFP_DMA32, but the function doesn't do that but only deals with
GFP_DMA case.

This patch adds a similar fallback reallocation with GFP_DMA32 as
we've done with GFP_DMA.  The condition is that the coherent mask is
smaller than 64bit (i.e. some address limitation), and neither GFP_DMA
nor GFP_DMA32 is set beforehand.

Signed-off-by: Takashi Iwai <tiwai@suse.de>

---

This is a resend of a test patch included in the previous thread
("swiotlb: Fix unexpected swiotlb_alloc_coherent() failures").

 lib/dma-direct.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index bbfb229aa067..970d39155618 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -84,6 +84,13 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		__free_pages(page, page_order);
 		page = NULL;
 
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
+		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
+			gfp |= GFP_DMA32;
+			goto again;
+		}
+
 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
 		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
 		    !(gfp & GFP_DMA)) {
-- 
2.16.3
