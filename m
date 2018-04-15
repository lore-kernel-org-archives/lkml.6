Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeDOJIY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:08:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54325 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeDOJIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:08:11 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] swiotlb: Fix dma_supported() to consider direct allocation
Date: Sun, 15 Apr 2018 11:08:08 +0200
Message-Id: <20180415090808.19121-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180415090808.19121-1-tiwai@suse.de>
References: <20180415090808.19121-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Along with the recent change to use the common swiotlb dma_ops, x86
also takes over the swiotlb_dma_supported().  This caused a regression
when a low bit DMA mask is set; e.g. parport_pc driver now fails to
set the 24bit DMA mask:

  parport_pc parport_pc.956: Unable to set coherent dma mask: disabling DMA

It's because swiotlb_dma_supported() only checks the swiotlb range,
and the 24bit DMA mask is below io_tlb_end.  OTOH, in the past kernel
versions, x86's swiotlb dma_supported() was NULL, which was
effectively evaluated as the direct DMA, hence the lower DMA mask was
allowed.

This patch fixes the regression by extending swiotlb_dma_supported()
to check the direct DMA at first for covering the primary allocation
before swiotlb.

Fixes: 6e4bf5867783 ("x86/dma: Use generic swiotlb_ops")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/swiotlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index de7cc540450f..a81502ea79e7 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1042,6 +1042,10 @@ swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
 int
 swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
+#ifdef CONFIG_DMA_DIRECT_OPS
+	if (dma_direct_supported(hwdev, mask))
+		return 1;
+#endif
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
-- 
2.16.3
