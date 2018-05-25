Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936283AbeEYOfi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:35:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936227AbeEYOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:35:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/7] ia64: remove the dead iommu_sac_force variable
Date: Fri, 25 May 2018 16:35:07 +0200
Message-Id: <20180525143512.1466-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525143512.1466-1-hch@lst.de>
References: <20180525143512.1466-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like copy and paste from x86 that never actually got used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index b5df084c0af4..50b6ad282a90 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -18,8 +18,6 @@
 dma_addr_t bad_dma_address __read_mostly;
 EXPORT_SYMBOL(bad_dma_address);
 
-static int iommu_sac_force __read_mostly;
-
 int no_iommu __read_mostly;
 #ifdef CONFIG_IOMMU_DEBUG
 int force_iommu __read_mostly = 1;
@@ -61,23 +59,6 @@ int iommu_dma_supported(struct device *dev, u64 mask)
 	if (mask < DMA_BIT_MASK(24))
 		return 0;
 
-	/* Tell the device to use SAC when IOMMU force is on.  This
-	   allows the driver to use cheaper accesses in some cases.
-
-	   Problem with this is that if we overflow the IOMMU area and
-	   return DAC as fallback address the device may not handle it
-	   correctly.
-
-	   As a special case some controllers have a 39bit address
-	   mode that is as efficient as 32bit (aic79xx). Don't force
-	   SAC for these.  Assume all masks <= 40 bits are of this
-	   type. Normally this doesn't make any difference, but gives
-	   more gentle handling of IOMMU overflow. */
-	if (iommu_sac_force && (mask >= DMA_BIT_MASK(40))) {
-		dev_info(dev, "Force SAC with mask %llx\n", mask);
-		return 0;
-	}
-
 	return 1;
 }
 EXPORT_SYMBOL(iommu_dma_supported);
-- 
2.17.0
