Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeEQKHW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:07:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59152 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEQKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:07:20 -0400
Date: Thu, 17 May 2018 20:07:13 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Message-Id: <cc9b01d2b0e12938fe0e9581dd9d650ad3c4159c.1526551115.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 1/2] m68k: Set default dma mask for platform devices
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a WARNING splat when loading the macsonic or macmace driver.
Please see commit 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask").

This implementation of arch_setup_pdev_archdata() differs from the
powerpc one, in that this one avoids clobbering a device dma mask
which has already been initialized.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/kernel/dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index c01b9b8f97bf..463572c4943f 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -165,3 +166,12 @@ const struct dma_map_ops m68k_dma_ops = {
 	.sync_sg_for_device	= m68k_dma_sync_sg_for_device,
 };
 EXPORT_SYMBOL(m68k_dma_ops);
+
+void arch_setup_pdev_archdata(struct platform_device *pdev)
+{
+	if (pdev->dev.coherent_dma_mask == DMA_MASK_NONE &&
+	    pdev->dev.dma_mask == NULL) {
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	}
+}
-- 
2.16.1
