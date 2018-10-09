Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F3CC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E028214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H+9zZu3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E028214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJIWOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zGeT7Io0LAGIEFAtof9zIQDO2zWM9WXGsvULSbKYSaU=; b=H+9zZu3ujMIKLQh/nvLl4bGBvo
        ZOrOKlx3TqAPcTH+oYL0UpJUYcLFwd6ImsDCIPT1s9gXzKOSsl3Ox1EtXdMTUZKGGyjegUAW2DE2P
        hMzK6/nx7frcKMNXqcSyh/LRQwTyqfYfNJWD0PhNuMp5yl9bH/pdhqhxZmBn56xEoYPvE5JYRUsr3
        WHagFtef2cezAv+Vjkd/TOramSFw/PHsEoWKqpseOo91lAl/dpNOMTmYoo+PwSgooSCtp/kO8mI5Z
        dhIRT9cXlk2Em59qnqXLmc32Vnm4iJXR4ObpwSNWXcMn3F27AOL37AZy+dqjUUTIS6eKFixum9PiT
        qJvZa4mw==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tS1-0001ZP-TS; Tue, 09 Oct 2018 14:57:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] fore200e: devirtualize dma mapping calls
Date:   Tue,  9 Oct 2018 16:57:17 +0200
Message-Id: <20181009145720.32578-5-hch@lst.de>
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

There is no need for an indirection before calling the dma mapping
routines now that we store a struct device in struct fore200e.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 112 +++++++----------------------------------
 drivers/atm/fore200e.h |   4 --
 2 files changed, 17 insertions(+), 99 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 05951550abb8..beeb71088560 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -193,8 +193,8 @@ fore200e_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk, int size, i
     
     chunk->align_addr = chunk->alloc_addr + offset;
 
-    chunk->dma_addr = fore200e->bus->dma_map(fore200e, chunk->align_addr, size, direction);
-    
+    chunk->dma_addr = dma_map_single(fore200e->dev, chunk->align_addr,
+				     size, direction);
     return 0;
 }
 
@@ -204,8 +204,8 @@ fore200e_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk, int size, i
 static void
 fore200e_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
 {
-    fore200e->bus->dma_unmap(fore200e, chunk->dma_addr, chunk->dma_size, chunk->direction);
-
+    dma_unmap_single(fore200e->dev, chunk->dma_addr, chunk->dma_size,
+		     chunk->direction);
     kfree(chunk->alloc_addr);
 }
 
@@ -427,46 +427,6 @@ static void fore200e_pca_write(u32 val, volatile u32 __iomem *addr)
     writel(cpu_to_le32(val), addr);
 }
 
-
-static u32
-fore200e_pca_dma_map(struct fore200e* fore200e, void* virt_addr, int size, int direction)
-{
-    u32 dma_addr = dma_map_single(fore200e->dev, virt_addr, size, direction);
-
-    DPRINTK(3, "PCI DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d,  --> dma_addr = 0x%08x\n",
-	    virt_addr, size, direction, dma_addr);
-    
-    return dma_addr;
-}
-
-
-static void
-fore200e_pca_dma_unmap(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
-{
-    DPRINTK(3, "PCI DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d\n",
-	    dma_addr, size, direction);
-
-    dma_unmap_single(fore200e->dev, dma_addr, size, direction);
-}
-
-
-static void
-fore200e_pca_dma_sync_for_cpu(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
-{
-    DPRINTK(3, "PCI DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
-
-    dma_sync_single_for_cpu(fore200e->dev, dma_addr, size, direction);
-}
-
-static void
-fore200e_pca_dma_sync_for_device(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
-{
-    DPRINTK(3, "PCI DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
-
-    dma_sync_single_for_device(fore200e->dev, dma_addr, size, direction);
-}
-
-
 /* allocate a DMA consistent chunk of memory intended to act as a communication mechanism
    (to hold descriptors, status, queues, etc.) shared by the driver and the adapter */
 
@@ -621,7 +581,8 @@ fore200e_pca_prom_read(struct fore200e* fore200e, struct prom_data* prom)
     opcode.opcode = OPCODE_GET_PROM;
     opcode.pad    = 0;
 
-    prom_dma = fore200e->bus->dma_map(fore200e, prom, sizeof(struct prom_data), DMA_FROM_DEVICE);
+    prom_dma = dma_map_single(fore200e->dev, prom, sizeof(struct prom_data),
+			      DMA_FROM_DEVICE);
 
     fore200e->bus->write(prom_dma, &entry->cp_entry->cmd.prom_block.prom_haddr);
     
@@ -633,7 +594,7 @@ fore200e_pca_prom_read(struct fore200e* fore200e, struct prom_data* prom)
 
     *entry->status = STATUS_FREE;
 
-    fore200e->bus->dma_unmap(fore200e, prom_dma, sizeof(struct prom_data), DMA_FROM_DEVICE);
+    dma_unmap_single(fore200e->dev, prom_dma, sizeof(struct prom_data), DMA_FROM_DEVICE);
 
     if (ok == 0) {
 	printk(FORE200E "unable to get PROM data from device %s\n", fore200e->name);
@@ -670,10 +631,6 @@ static const struct fore200e_bus fore200e_pci_ops = {
 	.status_alignment	= 32,
 	.read			= fore200e_pca_read,
 	.write			= fore200e_pca_write,
-	.dma_map		= fore200e_pca_dma_map,
-	.dma_unmap		= fore200e_pca_dma_unmap,
-	.dma_sync_for_cpu	= fore200e_pca_dma_sync_for_cpu,
-	.dma_sync_for_device	= fore200e_pca_dma_sync_for_device,
 	.dma_chunk_alloc	= fore200e_pca_dma_chunk_alloc,
 	.dma_chunk_free		= fore200e_pca_dma_chunk_free,
 	.configure		= fore200e_pca_configure,
@@ -699,40 +656,6 @@ static void fore200e_sba_write(u32 val, volatile u32 __iomem *addr)
     sbus_writel(val, addr);
 }
 
-static u32 fore200e_sba_dma_map(struct fore200e *fore200e, void* virt_addr, int size, int direction)
-{
-	u32 dma_addr;
-
-	dma_addr = dma_map_single(fore200e->dev, virt_addr, size, direction);
-
-	DPRINTK(3, "SBUS DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d --> dma_addr = 0x%08x\n",
-		virt_addr, size, direction, dma_addr);
-    
-	return dma_addr;
-}
-
-static void fore200e_sba_dma_unmap(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
-{
-	DPRINTK(3, "SBUS DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d,\n",
-		dma_addr, size, direction);
-
-	dma_unmap_single(fore200e->dev, dma_addr, size, direction);
-}
-
-static void fore200e_sba_dma_sync_for_cpu(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
-{
-	DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
-    
-	dma_sync_single_for_cpu(fore200e->dev, dma_addr, size, direction);
-}
-
-static void fore200e_sba_dma_sync_for_device(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
-{
-	DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
-
-	dma_sync_single_for_device(fore200e->dev, dma_addr, size, direction);
-}
-
 /* Allocate a DVMA consistent chunk of memory intended to act as a communication mechanism
  * (to hold descriptors, status, queues, etc.) shared by the driver and the adapter.
  */
@@ -873,10 +796,6 @@ static const struct fore200e_bus fore200e_sbus_ops = {
 	.status_alignment	= 32,
 	.read			= fore200e_sba_read,
 	.write			= fore200e_sba_write,
-	.dma_map		= fore200e_sba_dma_map,
-	.dma_unap		= fore200e_sba_dma_unmap,
-	.dma_sync_for_cpu	= fore200e_sba_dma_sync_for_cpu,
-	.dma_sync_for_device	= fore200e_sba_dma_sync_for_device,
 	.dma_chunk_alloc	= fore200e_sba_dma_chunk_alloc,
 	.dma_chunk_free		= fore200e_sba_dma_chunk_free,
 	.configure		= fore200e_sba_configure,
@@ -917,7 +836,7 @@ fore200e_tx_irq(struct fore200e* fore200e)
 	kfree(entry->data);
 	
 	/* remove DMA mapping */
-	fore200e->bus->dma_unmap(fore200e, entry->tpd->tsd[ 0 ].buffer, entry->tpd->tsd[ 0 ].length,
+	dma_unmap_single(fore200e->dev, entry->tpd->tsd[ 0 ].buffer, entry->tpd->tsd[ 0 ].length,
 				 DMA_TO_DEVICE);
 
 	vc_map = entry->vc_map;
@@ -1138,12 +1057,14 @@ fore200e_push_rpd(struct fore200e* fore200e, struct atm_vcc* vcc, struct rpd* rp
 	buffer = FORE200E_HDL2BUF(rpd->rsd[ i ].handle);
 	
 	/* Make device DMA transfer visible to CPU.  */
-	fore200e->bus->dma_sync_for_cpu(fore200e, buffer->data.dma_addr, rpd->rsd[ i ].length, DMA_FROM_DEVICE);
+	dma_sync_single_for_cpu(fore200e->dev, buffer->data.dma_addr,
+				rpd->rsd[i].length, DMA_FROM_DEVICE);
 	
 	skb_put_data(skb, buffer->data.align_addr, rpd->rsd[i].length);
 
 	/* Now let the device get at it again.  */
-	fore200e->bus->dma_sync_for_device(fore200e, buffer->data.dma_addr, rpd->rsd[ i ].length, DMA_FROM_DEVICE);
+	dma_sync_single_for_device(fore200e->dev, buffer->data.dma_addr,
+				   rpd->rsd[i].length, DMA_FROM_DEVICE);
     }
 
     DPRINTK(3, "rx skb: len = %d, truesize = %d\n", skb->len, skb->truesize);
@@ -1712,7 +1633,8 @@ fore200e_send(struct atm_vcc *vcc, struct sk_buff *skb)
     entry->data   = tx_copy ? data : NULL;
 
     tpd = entry->tpd;
-    tpd->tsd[ 0 ].buffer = fore200e->bus->dma_map(fore200e, data, tx_len, DMA_TO_DEVICE);
+    tpd->tsd[ 0 ].buffer = dma_map_single(fore200e->dev, data, tx_len,
+					  DMA_TO_DEVICE);
     tpd->tsd[ 0 ].length = tx_len;
 
     FORE200E_NEXT_ENTRY(txq->head, QUEUE_SIZE_TX);
@@ -1785,8 +1707,8 @@ fore200e_getstats(struct fore200e* fore200e)
 	    return -ENOMEM;
     }
     
-    stats_dma_addr = fore200e->bus->dma_map(fore200e, fore200e->stats,
-					    sizeof(struct stats), DMA_FROM_DEVICE);
+    stats_dma_addr = dma_map_single(fore200e->dev, fore200e->stats,
+				    sizeof(struct stats), DMA_FROM_DEVICE);
     
     FORE200E_NEXT_ENTRY(cmdq->head, QUEUE_SIZE_CMD);
 
@@ -1803,7 +1725,7 @@ fore200e_getstats(struct fore200e* fore200e)
 
     *entry->status = STATUS_FREE;
 
-    fore200e->bus->dma_unmap(fore200e, stats_dma_addr, sizeof(struct stats), DMA_FROM_DEVICE);
+    dma_unmap_single(fore200e->dev, stats_dma_addr, sizeof(struct stats), DMA_FROM_DEVICE);
     
     if (ok == 0) {
 	printk(FORE200E "unable to get statistics from device %s\n", fore200e->name);
diff --git a/drivers/atm/fore200e.h b/drivers/atm/fore200e.h
index c8c6ea818ffc..f62fc9b85db0 100644
--- a/drivers/atm/fore200e.h
+++ b/drivers/atm/fore200e.h
@@ -805,10 +805,6 @@ typedef struct fore200e_bus {
     int                  status_alignment;    /* status words DMA alignment requirement */
     u32                  (*read)(volatile u32 __iomem *);
     void                 (*write)(u32, volatile u32 __iomem *);
-    u32                  (*dma_map)(struct fore200e*, void*, int, int);
-    void                 (*dma_unmap)(struct fore200e*, u32, int, int);
-    void                 (*dma_sync_for_cpu)(struct fore200e*, u32, int, int);
-    void                 (*dma_sync_for_device)(struct fore200e*, u32, int, int);
     int                  (*dma_chunk_alloc)(struct fore200e*, struct chunk*, int, int, int);
     void                 (*dma_chunk_free)(struct fore200e*, struct chunk*);
     int                  (*configure)(struct fore200e*); 
-- 
2.19.0

