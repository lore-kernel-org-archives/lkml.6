Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936376AbeEYOhu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:37:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936185AbeEYOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:35:30 -0400
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 1/7] core, dma-direct: add a flag 32-bit dma limits
Date: Fri, 25 May 2018 16:35:06 +0200
Message-Id: <20180525143512.1466-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525143512.1466-1-hch@lst.de>
References: <20180525143512.1466-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various PCI bridges (VIA PCI, Xilinx PCIe) limit DMA to only 32-bits
even if the device itself supports more.  Add a single bit flag to
struct device (to be moved into the dma extension once we around it)
to flag such devices and reject larger DMA to them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/device.h | 3 +++
 lib/dma-direct.c       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 477956990f5e..fa317e45f5e6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -904,6 +904,8 @@ struct dev_links_info {
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
  *              device.
+ * @dma_32bit_limit: bridge limited to 32bit DMA even if the device itself
+ *		indicates support for a higher limit in the dma_mask field.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -992,6 +994,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			dma_32bit_limit:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index bbfb229aa067..0151a7b2bc87 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -165,6 +165,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	if (mask < DMA_BIT_MASK(32))
 		return 0;
 #endif
+	/*
+	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
+	 * if the device itself might support it.
+	 */
+	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
+		return 0;
 	return 1;
 }
 
-- 
2.17.0
