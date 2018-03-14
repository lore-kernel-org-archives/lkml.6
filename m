Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeCNRwz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:52:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeCNRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:52:45 -0400
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] x86/amd_gart: look at coherent_dma_mask instead of GFP_DMA
Date: Wed, 14 Mar 2018 18:52:04 +0100
Message-Id: <20180314175213.20256-6-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180314175213.20256-1-hch@lst.de>
References: <20180314175213.20256-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to phase out looking at the magic GFP_DMA flag in the dma mapping
routines, so switch the gart driver to use the coherent_dma_mask instead,
which is used to select the GFP_DMA flag in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 52e3abcf3e70..79ac6caaaabb 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -484,7 +484,7 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 	unsigned long align_mask;
 	struct page *page;
 
-	if (force_iommu && !(flag & GFP_DMA)) {
+	if (force_iommu && dev->coherent_dma_mask > DMA_BIT_MASK(24)) {
 		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
 		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
 		if (!page)
-- 
2.14.2
