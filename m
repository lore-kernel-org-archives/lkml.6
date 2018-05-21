Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEULfV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:35:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEULfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:35:18 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de, m.szyprowski@samsung.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dma-debug: Check scatterlist segments
Date: Mon, 21 May 2018 12:35:13 +0100
Message-Id: <ff44b54b2947c806e9831559eefc8796d841f761.1526901695.git.robin.murphy@arm.com>
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

v3: Fix types to avoid format warning for 32-bit dma_addr_t

 lib/Kconfig.debug | 17 +++++++++++++++++
 lib/dma-debug.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b734cd1..9d78c2fba095 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1651,6 +1651,23 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
+config DMA_API_DEBUG_SG
+	bool "Debug DMA scatter-gather usage"
+	default y
+	depends on DMA_API_DEBUG
+	help
+	  Perform extra checking that callers of dma_map_sg() have respected the
+	  appropriate segment length/boundary limits for the given device when
+	  preparing DMA scatterlists.
+
+	  This is particularly likely to have been overlooked in cases where the
+	  dma_map_sg() API is used for general bulk mapping of pages rather than
+	  preparing literal scatter-gather descriptors, where there is a risk of
+	  unexpected behaviour from DMA API implementations if the scatterlist
+	  is technically out-of-spec.
+
+	  If unsure, say N.
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 7f5cdc1e6b29..45405d81c53e 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -1293,6 +1293,32 @@ static void check_sync(struct device *dev,
 	put_hash_bucket(bucket, &flags);
 }
 
+static void check_sg_segment(struct device *dev, struct scatterlist *sg)
+{
+#ifdef CONFIG_DMA_API_DEBUG_SG
+	unsigned int max_seg = dma_get_max_seg_size(dev);
+	u64 start, end, boundary = dma_get_seg_boundary(dev);
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
+#endif
+}
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
@@ -1423,6 +1449,8 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
 		}
 
+		check_sg_segment(dev, s);
+
 		add_dma_entry(entry);
 	}
 }
-- 
2.17.0.dirty
