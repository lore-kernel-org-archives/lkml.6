Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEBKFg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:05:36 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55402 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750932AbeEBKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:05:33 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] swiotlb: Suppress "Out of SW-IOMMU" errors for NO_WARN
Date: Wed,  2 May 2018 11:05:01 +0100
Message-Id: <20180502100501.28440-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: 78.156.65.138
X-Country: code=GB country="United Kingdom" ip=78.156.65.138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the warning suppression from commit d0bc0c2a31c9 ("swiotlb:
suppress warning when __GFP_NOWARN is set") to suppress the warnings
when DMA_ATTR_NO_WARN is given by caller. In such cases the caller wants
to handle the error themselves.

Fixes: d0bc0c2a31c9 ("swiotlb: suppress warning when __GFP_NOWARN is set")
Cc: Christian König <christian.koenig@amd.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index fece57566d45..2bfb936c5708 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -768,11 +768,14 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
-	     int do_panic)
+	     unsigned long attrs, int do_panic)
 {
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return;
 
+	if (attrs & DMA_ATTR_NO_WARN)
+		return;
+
 	/*
 	 * Ran out of IOMMU space for this operation. This is very bad.
 	 * Unfortunately the drivers cannot handle this operation properly.
@@ -823,7 +826,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	map = map_single(dev, phys, size, dir, attrs);
 	if (map == SWIOTLB_MAP_ERROR) {
-		swiotlb_full(dev, size, dir, 1);
+		swiotlb_full(dev, size, dir, attrs, 1);
 		return __phys_to_dma(dev, io_tlb_overflow_buffer);
 	}
 
@@ -959,7 +962,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 			if (map == SWIOTLB_MAP_ERROR) {
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
-				swiotlb_full(hwdev, sg->length, dir, 0);
+				swiotlb_full(hwdev, sg->length, dir, attrs, 0);
 				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
 						       attrs);
-- 
2.17.0
