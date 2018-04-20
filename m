Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbeDTIEJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:04:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753854AbeDTIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:04:03 -0400
From: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/22] alpha: use dma_direct_ops for jensen
Date: Fri, 20 Apr 2018 10:02:55 +0200
Message-Id: <20180420080313.18796-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic dma_direct implementation does the same thing as the alpha
pci-noop implementation, just with more bells and whistles.  And unlike
the current code it at least has a theoretical chance to actually compile.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig                   |  1 +
 arch/alpha/include/asm/dma-mapping.h |  4 ++++
 arch/alpha/kernel/pci-noop.c         | 33 ----------------------------
 3 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index aa7df1a36fd0..94af0c7f494a 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -204,6 +204,7 @@ config ALPHA_EIGER
 config ALPHA_JENSEN
 	bool "Jensen"
 	depends on BROKEN
+	select DMA_DIRECT_OPS
 	help
 	  DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
 	  of the first-generation Alpha systems. A number of these systems
diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index b78f61f20796..76ce923ecca1 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -6,7 +6,11 @@ extern const struct dma_map_ops *dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+#ifdef CONFIG_ALPHA_JENSEN
+	return &dma_direct_ops;
+#else
 	return dma_ops;
+#endif
 }
 
 #endif	/* _ALPHA_DMA_MAPPING_H */
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index b6ebb65127a8..c7c5879869d3 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -102,36 +102,3 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	else
 		return -ENODEV;
 }
-
-static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp,
-				       unsigned long attrs)
-{
-	void *ret;
-
-	if (!dev || *dev->dma_mask >= 0xffffffffUL)
-		gfp &= ~GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-	if (ret) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
-	}
-	return ret;
-}
-
-static int alpha_noop_supported(struct device *dev, u64 mask)
-{
-	return mask < 0x00ffffffUL ? 0 : 1;
-}
-
-const struct dma_map_ops alpha_noop_ops = {
-	.alloc			= alpha_noop_alloc_coherent,
-	.free			= dma_noop_free_coherent,
-	.map_page		= dma_noop_map_page,
-	.map_sg			= dma_noop_map_sg,
-	.mapping_error		= dma_noop_mapping_error,
-	.dma_supported		= alpha_noop_supported,
-};
-
-const struct dma_map_ops *dma_ops = &alpha_noop_ops;
-EXPORT_SYMBOL(dma_ops);
-- 
2.17.0
