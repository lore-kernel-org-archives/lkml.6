Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE10EC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E77821479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZJZ3ZPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E77821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJIWOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJIWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wtAvenQ4F4gKW8pQGhGesc1pSquTkiKjZzZQP+j7QDQ=; b=LZJZ3ZPg7eGqKhl8qsPofOyZ+g
        4FaeZo9wLx+HgfHu09zud2XOscripoKZ3PoBYn2fIcx4lXNfpHcXlkA/pPvOPqanClKyQITe4nPuB
        kFc32os4smtcu8wNvm4uY0JY5xmmOAaBOWIruWzhVRjTTFpjj4PrpXbS0J5JLRHu9znkH16O/UA84
        Xk+Fe/Apn3MUI7if2QHnudXLlFGZfW6Mx47qS93gjvjigLrPK95vGeCf6EOoxaicQYic3XGSfpTdZ
        itXhGIsqAP6wvcGCqcTt+nWDRjH+xkmuWXgg1lyYAu5cI9h6cCqa18g6pp40zi4AWrydsN46K7eGW
        O7MNVqCw==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tRw-0001Z1-3L; Tue, 09 Oct 2018 14:57:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] fore200e: store a struct device in struct fore200e
Date:   Tue,  9 Oct 2018 16:57:15 +0200
Message-Id: <20181009145720.32578-3-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009145720.32578-1-hch@lst.de>
References: <20181009145720.32578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used much better than the untyped void pointer containing
either a PCI or platform device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 65 ++++++++++++++----------------------------
 drivers/atm/fore200e.h |  2 +-
 2 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 008bd8541c61..0b8d2ad8273d 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -432,7 +432,7 @@ static void fore200e_pca_write(u32 val, volatile u32 __iomem *addr)
 static u32
 fore200e_pca_dma_map(struct fore200e* fore200e, void* virt_addr, int size, int direction)
 {
-    u32 dma_addr = dma_map_single(&((struct pci_dev *) fore200e->bus_dev)->dev, virt_addr, size, direction);
+    u32 dma_addr = dma_map_single(fore200e->dev, virt_addr, size, direction);
 
     DPRINTK(3, "PCI DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d,  --> dma_addr = 0x%08x\n",
 	    virt_addr, size, direction, dma_addr);
@@ -447,7 +447,7 @@ fore200e_pca_dma_unmap(struct fore200e* fore200e, u32 dma_addr, int size, int di
     DPRINTK(3, "PCI DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d\n",
 	    dma_addr, size, direction);
 
-    dma_unmap_single(&((struct pci_dev *) fore200e->bus_dev)->dev, dma_addr, size, direction);
+    dma_unmap_single(fore200e->dev, dma_addr, size, direction);
 }
 
 
@@ -456,7 +456,7 @@ fore200e_pca_dma_sync_for_cpu(struct fore200e* fore200e, u32 dma_addr, int size,
 {
     DPRINTK(3, "PCI DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
 
-    dma_sync_single_for_cpu(&((struct pci_dev *) fore200e->bus_dev)->dev, dma_addr, size, direction);
+    dma_sync_single_for_cpu(fore200e->dev, dma_addr, size, direction);
 }
 
 static void
@@ -464,7 +464,7 @@ fore200e_pca_dma_sync_for_device(struct fore200e* fore200e, u32 dma_addr, int si
 {
     DPRINTK(3, "PCI DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
 
-    dma_sync_single_for_device(&((struct pci_dev *) fore200e->bus_dev)->dev, dma_addr, size, direction);
+    dma_sync_single_for_device(fore200e->dev, dma_addr, size, direction);
 }
 
 
@@ -477,7 +477,7 @@ fore200e_pca_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
 {
     /* returned chunks are page-aligned */
     chunk->alloc_size = size * nbr;
-    chunk->alloc_addr = dma_alloc_coherent(&((struct pci_dev *) fore200e->bus_dev)->dev,
+    chunk->alloc_addr = dma_alloc_coherent(fore200e->dev,
 					   chunk->alloc_size,
 					   &chunk->dma_addr,
 					   GFP_KERNEL);
@@ -496,7 +496,7 @@ fore200e_pca_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
 static void
 fore200e_pca_dma_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
 {
-    dma_free_coherent(&((struct pci_dev *) fore200e->bus_dev)->dev,
+    dma_free_coherent(fore200e->dev,
 			chunk->alloc_size,
 			chunk->alloc_addr,
 			chunk->dma_addr);
@@ -570,7 +570,7 @@ fore200e_pca_unmap(struct fore200e* fore200e)
 
 static int fore200e_pca_configure(struct fore200e *fore200e)
 {
-    struct pci_dev* pci_dev = (struct pci_dev*)fore200e->bus_dev;
+    struct pci_dev *pci_dev = to_pci_dev(fore200e->dev);
     u8              master_ctrl, latency;
 
     DPRINTK(2, "device %s being configured\n", fore200e->name);
@@ -657,7 +657,7 @@ fore200e_pca_prom_read(struct fore200e* fore200e, struct prom_data* prom)
 static int
 fore200e_pca_proc_read(struct fore200e* fore200e, char *page)
 {
-    struct pci_dev* pci_dev = (struct pci_dev*)fore200e->bus_dev;
+    struct pci_dev *pci_dev = to_pci_dev(fore200e->dev);
 
     return sprintf(page, "   PCI bus/slot/function:\t%d/%d/%d\n",
 		   pci_dev->bus->number, PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
@@ -702,10 +702,9 @@ static void fore200e_sba_write(u32 val, volatile u32 __iomem *addr)
 
 static u32 fore200e_sba_dma_map(struct fore200e *fore200e, void* virt_addr, int size, int direction)
 {
-	struct platform_device *op = fore200e->bus_dev;
 	u32 dma_addr;
 
-	dma_addr = dma_map_single(&op->dev, virt_addr, size, direction);
+	dma_addr = dma_map_single(fore200e->dev, virt_addr, size, direction);
 
 	DPRINTK(3, "SBUS DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d --> dma_addr = 0x%08x\n",
 		virt_addr, size, direction, dma_addr);
@@ -715,30 +714,24 @@ static u32 fore200e_sba_dma_map(struct fore200e *fore200e, void* virt_addr, int
 
 static void fore200e_sba_dma_unmap(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
 {
-	struct platform_device *op = fore200e->bus_dev;
-
 	DPRINTK(3, "SBUS DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d,\n",
 		dma_addr, size, direction);
 
-	dma_unmap_single(&op->dev, dma_addr, size, direction);
+	dma_unmap_single(fore200e->dev, dma_addr, size, direction);
 }
 
 static void fore200e_sba_dma_sync_for_cpu(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
 {
-	struct platform_device *op = fore200e->bus_dev;
-
 	DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
     
-	dma_sync_single_for_cpu(&op->dev, dma_addr, size, direction);
+	dma_sync_single_for_cpu(fore200e->dev, dma_addr, size, direction);
 }
 
 static void fore200e_sba_dma_sync_for_device(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
 {
-	struct platform_device *op = fore200e->bus_dev;
-
 	DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
 
-	dma_sync_single_for_device(&op->dev, dma_addr, size, direction);
+	dma_sync_single_for_device(fore200e->dev, dma_addr, size, direction);
 }
 
 /* Allocate a DVMA consistent chunk of memory intended to act as a communication mechanism
@@ -747,12 +740,10 @@ static void fore200e_sba_dma_sync_for_device(struct fore200e *fore200e, u32 dma_
 static int fore200e_sba_dma_chunk_alloc(struct fore200e *fore200e, struct chunk *chunk,
 					int size, int nbr, int alignment)
 {
-	struct platform_device *op = fore200e->bus_dev;
-
 	chunk->alloc_size = chunk->align_size = size * nbr;
 
 	/* returned chunks are page-aligned */
-	chunk->alloc_addr = dma_alloc_coherent(&op->dev, chunk->alloc_size,
+	chunk->alloc_addr = dma_alloc_coherent(fore200e->dev, chunk->alloc_size,
 					       &chunk->dma_addr, GFP_ATOMIC);
 
 	if ((chunk->alloc_addr == NULL) || (chunk->dma_addr == 0))
@@ -766,9 +757,7 @@ static int fore200e_sba_dma_chunk_alloc(struct fore200e *fore200e, struct chunk
 /* free a DVMA consistent chunk of memory */
 static void fore200e_sba_dma_chunk_free(struct fore200e *fore200e, struct chunk *chunk)
 {
-	struct platform_device *op = fore200e->bus_dev;
-
-	dma_free_coherent(&op->dev, chunk->alloc_size,
+	dma_free_coherent(fore200e->dev, chunk->alloc_size,
 			  chunk->alloc_addr, chunk->dma_addr);
 }
 
@@ -798,7 +787,7 @@ static void fore200e_sba_reset(struct fore200e *fore200e)
 
 static int __init fore200e_sba_map(struct fore200e *fore200e)
 {
-	struct platform_device *op = fore200e->bus_dev;
+	struct platform_device *op = to_platform_device(fore200e->dev);
 	unsigned int bursts;
 
 	/* gain access to the SBA specific registers  */
@@ -828,7 +817,7 @@ static int __init fore200e_sba_map(struct fore200e *fore200e)
 
 static void fore200e_sba_unmap(struct fore200e *fore200e)
 {
-	struct platform_device *op = fore200e->bus_dev;
+	struct platform_device *op = to_platform_device(fore200e->dev);
 
 	of_iounmap(&op->resource[0], fore200e->regs.sba.hcr, SBA200E_HCR_LENGTH);
 	of_iounmap(&op->resource[1], fore200e->regs.sba.bsr, SBA200E_BSR_LENGTH);
@@ -844,7 +833,7 @@ static int __init fore200e_sba_configure(struct fore200e *fore200e)
 
 static int __init fore200e_sba_prom_read(struct fore200e *fore200e, struct prom_data *prom)
 {
-	struct platform_device *op = fore200e->bus_dev;
+	struct platform_device *op = to_platform_device(fore200e->dev);
 	const u8 *prop;
 	int len;
 
@@ -868,7 +857,7 @@ static int __init fore200e_sba_prom_read(struct fore200e *fore200e, struct prom_
 
 static int fore200e_sba_proc_read(struct fore200e *fore200e, char *page)
 {
-	struct platform_device *op = fore200e->bus_dev;
+	struct platform_device *op = to_platform_device(fore200e->dev);
 	const struct linux_prom_registers *regs;
 
 	regs = of_get_property(op->dev.of_node, "reg", NULL);
@@ -2532,25 +2521,15 @@ static void fore200e_monitor_puts(struct fore200e *fore200e, char *str)
 static int fore200e_load_and_start_fw(struct fore200e *fore200e)
 {
     const struct firmware *firmware;
-    struct device *device;
     const struct fw_header *fw_header;
     const __le32 *fw_data;
     u32 fw_size;
     u32 __iomem *load_addr;
     char buf[48];
-    int err = -ENODEV;
-
-    if (strcmp(fore200e->bus->model_name, "PCA-200E") == 0)
-	device = &((struct pci_dev *) fore200e->bus_dev)->dev;
-#ifdef CONFIG_SBUS
-    else if (strcmp(fore200e->bus->model_name, "SBA-200E") == 0)
-	device = &((struct platform_device *) fore200e->bus_dev)->dev;
-#endif
-    else
-	return err;
+    int err;
 
     sprintf(buf, "%s%s", fore200e->bus->proc_name, FW_EXT);
-    if ((err = request_firmware(&firmware, buf, device)) < 0) {
+    if ((err = request_firmware(&firmware, buf, fore200e->dev)) < 0) {
 	printk(FORE200E "problem loading firmware image %s\n", fore200e->bus->model_name);
 	return err;
     }
@@ -2689,7 +2668,7 @@ static int fore200e_sba_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	fore200e->bus = &fore200e_sbus_ops;
-	fore200e->bus_dev = op;
+	fore200e->dev = &op->dev;
 	fore200e->irq = op->archdata.irqs[0];
 	fore200e->phys_base = op->resource[0].start;
 
@@ -2761,7 +2740,7 @@ static int fore200e_pca_detect(struct pci_dev *pci_dev,
     }
 
     fore200e->bus       = &fore200e_pci_ops;
-    fore200e->bus_dev   = pci_dev;    
+    fore200e->dev	= &pci_dev->dev;
     fore200e->irq       = pci_dev->irq;
     fore200e->phys_base = pci_resource_start(pci_dev, 0);
 
diff --git a/drivers/atm/fore200e.h b/drivers/atm/fore200e.h
index c8a02c8fba15..c8c6ea818ffc 100644
--- a/drivers/atm/fore200e.h
+++ b/drivers/atm/fore200e.h
@@ -844,7 +844,7 @@ typedef struct fore200e {
     enum fore200e_state        state;                  /* device state                       */
 
     char                       name[16];               /* device name                        */
-    void*                      bus_dev;                /* bus-specific kernel data           */
+    struct device	       *dev;
     int                        irq;                    /* irq number                         */
     unsigned long              phys_base;              /* physical base address              */
     void __iomem *             virt_base;              /* virtual base address               */
-- 
2.19.0

