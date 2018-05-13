Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEMBAy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 21:00:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57766 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeEMBAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 21:00:52 -0400
Date: Sun, 13 May 2018 11:00:50 +1000
To: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC] m68k: Set up dma mask for platform devices
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1751747AbeEMBAy/20180513010055Z+396@vger.kernel.org>

This avoids a WARNING splat when loading the macsonic or macmace driver.
Please see commit 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask").

This implementation of arch_setup_pdev_archdata() differs from the one
in arch/powerpc in that this one avoids clobbering an existing dma mask.
For example, this approach preserves the mask set by the initializer for
struct platform_device mcf_fec0.

Note that either approach would make that initializer redundant and
commit f61e64310b75 ("m68k: set dma and coherent masks for platform
FEC ethernets") could be reverted.
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
