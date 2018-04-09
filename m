Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeDIJP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:15:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:15:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: use dma_direct_supported for swiotlb_ops
Date: Mon,  9 Apr 2018 11:15:17 +0200
Message-Id: <20180409091517.6619-2-hch@lst.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180409091517.6619-1-hch@lst.de>
References: <20180409091517.6619-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swiotlb_alloc calls dma_direct_alloc, which can satisfy lower than 32-bit
dma mask requests using GFP_DMA if the architecture supports it.  Various
x86 drivers rely on that, so we need to support that.  At the same time
the whole kernel expects 32-bit dma mask to just work, so the other magic
in swiotlb_dma_support isn't actually needed either.

Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Fixes: 6e4bf5867783 ("x86/dma: Use generic swiotlb_ops")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..32aacd0d56a8 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1087,6 +1087,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
-	.dma_supported		= swiotlb_dma_supported,
+	.dma_supported		= dma_direct_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.16.3
