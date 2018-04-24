Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeDXQM3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:12:29 -0400
Received: from foss.arm.com ([217.140.101.70]:56310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbeDXQMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:12:24 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de, m.szyprowski@samsung.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: Check scatterlist segments
Date: Tue, 24 Apr 2018 17:12:19 +0100
Message-Id: <5952922c7980b5c9091692d886bbca220e7371c2.1524586299.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.0.dirty
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers/subsystems creating scatterlists for DMA should be taking care
to respect the scatter-gather limitations of the appropriate device, as
described by dma_parms. A DMA API implementation cannot feasibly split
a scatterlist into *more* entries than originally passed, so it is not
well defined what they should do when given a segment larger than the
limit they are also required to respect.

Conversely, devices which are less limited than the rather conservative
defaults, or indeed have no limitations at all (e.g. GPUs with their own
internal MMU), should be encouraged to set appropriate dma_parms, as
they may get more efficient DMA mapping performance out of it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 lib/dma-debug.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 7f5cdc1e6b29..9f158941004d 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -1293,6 +1293,30 @@ static void check_sync(struct device *dev,
 	put_hash_bucket(bucket, &flags);
 }
 
+static void check_sg_segment(struct device *dev, struct scatterlist *sg)
+{
+	unsigned int max_seg = dma_get_max_seg_size(dev);
+	dma_addr_t start, end, boundary = dma_get_seg_boundary(dev);
+
+	/*
+	 * Either the driver forgot to set dma_parms appropriately, or
+	 * whoever generated the list forgot to check them.
+	 */
+	if (sg->length > max_seg)
+		err_printk(dev, NULL, "DMA-API: mapping sg segment longer than device claims to support [len=%u] [max=%u]\n",
+			   sg->length, max_seg);
+	/*
+	 * In some cases this could potentially be the DMA API
+	 * implementation's fault, but it would usually imply that
+	 * the scatterlist was built inappropriately to begin with.
+	 */
+	start = sg_dma_address(sg);
+	end = start + sg_dma_len(sg) - 1;
+	if ((start ^ end) & ~boundary)
+		err_printk(dev, NULL, "DMA-API: mapping sg segment across boundary [start=0x%016llx] [end=0x%016llx] [boundary=0x%016llx]\n",
+			   start, end, boundary);
+}
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
@@ -1423,6 +1447,8 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
 		}
 
+		check_sg_segment(dev, s);
+
 		add_dma_entry(entry);
 	}
 }
-- 
2.17.0.dirty
