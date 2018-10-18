Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1AA2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YL13SZyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1AA2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJRVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:00:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJRVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hkr57JMs/oRKnGwYUtXI/iU5/AWAGlfP1EXCknMMBtA=; b=YL13SZyVS2IwvV3ggIv7IzOxE
        eOEUXSAmA54JKSKu91pJWlIcbWzWurBxcraGTf6Soh8hhGquxAGolNTfUDGWi2lJlspei1HyAZkgf
        U1G+8pFz0mynNoDWUIhIoWyN1x9jcUPMWDYj8SMlKTAOAjDHO6jFzzalAMcpF9gxC3Q4cKojH6d4c
        ombN4WCdE1hglooSewpLobw5NNG9l6HkJ+z/0ZJTGjePkvFyHJATUGKE+DhqS6pBRReV00UnU6Pg1
        WPKbTm7UXspJsI9FZdXCxbjlJikt7C2noKH2qi88eTRoP1KvkpAgp2JgXeK1yB+LxqO3XPV7OtJEM
        QojfgY10g==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gD7tr-00043L-LM; Thu, 18 Oct 2018 12:59:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     maximlevitsky@gmail.com, boris.brezillon@bootlin.com,
        miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: r852: use generic DMA API
Date:   Thu, 18 Oct 2018 14:59:35 +0200
Message-Id: <20181018125935.9028-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic DMA API instead of the legacy PCI DMA API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/nand/raw/r852.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 39be65b35ac25..35f0b343cf908 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -151,8 +151,9 @@ static void r852_dma_done(struct r852_device *dev, int error)
 	dev->dma_stage = 0;
 
 	if (dev->phys_dma_addr && dev->phys_dma_addr != dev->phys_bounce_buffer)
-		pci_unmap_single(dev->pci_dev, dev->phys_dma_addr, R852_DMA_LEN,
-			dev->dma_dir ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
+		dma_unmap_single(&dev->pci_dev->dev, dev->phys_dma_addr,
+			R852_DMA_LEN,
+			dev->dma_dir ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
 /*
@@ -197,11 +198,10 @@ static void r852_do_dma(struct r852_device *dev, uint8_t *buf, int do_read)
 		bounce = 1;
 
 	if (!bounce) {
-		dev->phys_dma_addr = pci_map_single(dev->pci_dev, (void *)buf,
+		dev->phys_dma_addr = dma_map_single(&dev->pci_dev->dev, buf,
 			R852_DMA_LEN,
-			(do_read ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE));
-
-		if (pci_dma_mapping_error(dev->pci_dev, dev->phys_dma_addr))
+			do_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		if (dma_mapping_error(&dev->pci_dev->dev, dev->phys_dma_addr))
 			bounce = 1;
 	}
 
@@ -835,7 +835,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 
 	pci_set_master(pci_dev);
 
-	error = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
+	error = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 	if (error)
 		goto error2;
 
@@ -885,8 +885,8 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	dev->pci_dev = pci_dev;
 	pci_set_drvdata(pci_dev, dev);
 
-	dev->bounce_buffer = pci_alloc_consistent(pci_dev, R852_DMA_LEN,
-		&dev->phys_bounce_buffer);
+	dev->bounce_buffer = dma_alloc_coherent(&pci_dev->dev, R852_DMA_LEN,
+		&dev->phys_bounce_buffer, GFP_KERNEL);
 
 	if (!dev->bounce_buffer)
 		goto error6;
@@ -946,8 +946,8 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 error8:
 	pci_iounmap(pci_dev, dev->mmio);
 error7:
-	pci_free_consistent(pci_dev, R852_DMA_LEN,
-		dev->bounce_buffer, dev->phys_bounce_buffer);
+	dma_free_coherent(&pci_dev->dev, R852_DMA_LEN, dev->bounce_buffer,
+			  dev->phys_bounce_buffer);
 error6:
 	kfree(dev);
 error5:
@@ -980,8 +980,8 @@ static void r852_remove(struct pci_dev *pci_dev)
 	/* Cleanup */
 	kfree(dev->tmp_buffer);
 	pci_iounmap(pci_dev, dev->mmio);
-	pci_free_consistent(pci_dev, R852_DMA_LEN,
-		dev->bounce_buffer, dev->phys_bounce_buffer);
+	dma_free_coherent(&pci_dev->dev, R852_DMA_LEN, dev->bounce_buffer,
+			  dev->phys_bounce_buffer);
 
 	kfree(dev->chip);
 	kfree(dev);
-- 
2.19.1

