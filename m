Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98981C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2A7214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jEv1aGjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2A7214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIWO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeJIWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DiqpQHv6qXxkfy8LlSDuv2awn3DP7AfUyj+aZFJg3C0=; b=jEv1aGjfJacPgimNVfdxQQcZ3W
        KmJQWNon7pPqTbzdm6DerGR5xdVwDc3aGpjIU9MGFp1Q01jC74kWckplV3gf78WdpVVBHxeNvVi9E
        H8x6h40UrfCVyConnzhDOz34c38wyqxIURSVK1v/4mdhWc6E48hCZqgBRi/lArAXhjHor8ngfHalN
        XkxsxgSHeosZ94LiwNf2OjHBL3Dzl4ZGCpRnGiVhzoH/yDqepo9hAf/oPs8792Br8GeDH+HZBCovT
        xacQU+OlR816nvq3CpvDbVUsAY3J8DIlIYQFPrXb4lBTswUnIRojymCEHLFMffUDTtjNhbNDL96Zk
        UIoEndFw==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tS5-0001ZV-3y; Tue, 09 Oct 2018 14:57:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] fore200e: devirtualize dma alloc calls
Date:   Tue,  9 Oct 2018 16:57:18 +0200
Message-Id: <20181009145720.32578-6-hch@lst.de>
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

There is no need for an indirection before calling the dma alloc
routines now that we store a struct device in struct fore200e.

Also remove the pointless GFP_ATOMIC for the sbus case, and fix the
up the error handling by removing the 0 dma_addr test - some iommus
can return 0 as a perfectly valid bus address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 128 +++++++++++++++--------------------------
 drivers/atm/fore200e.h |   2 -
 2 files changed, 45 insertions(+), 85 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index beeb71088560..86be269500a9 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -209,6 +209,34 @@ fore200e_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
     kfree(chunk->alloc_addr);
 }
 
+/*
+ * Allocate a DMA consistent chunk of memory intended to act as a communication
+ * mechanism (to hold descriptors, status, queues, etc.) shared by the driver
+ * and the adapter.
+ */
+static int
+fore200e_dma_chunk_alloc(struct fore200e *fore200e, struct chunk *chunk,
+		int size, int nbr, int alignment)
+{
+	/* returned chunks are page-aligned */
+	chunk->alloc_size = size * nbr;
+	chunk->alloc_addr = dma_alloc_coherent(fore200e->dev, chunk->alloc_size,
+					       &chunk->dma_addr, GFP_KERNEL);
+	if (!chunk->alloc_addr)
+		return -ENOMEM;
+	chunk->align_addr = chunk->alloc_addr;
+	return 0;
+}
+
+/*
+ * Free a DMA consistent chunk of memory.
+ */
+static void
+fore200e_dma_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
+{
+	dma_free_coherent(fore200e->dev, chunk->alloc_size, chunk->alloc_addr,
+			  chunk->dma_addr);
+}
 
 static void
 fore200e_spin(int msecs)
@@ -301,10 +329,10 @@ fore200e_uninit_bs_queue(struct fore200e* fore200e)
 	    struct chunk* rbd_block = &fore200e->host_bsq[ scheme ][ magn ].rbd_block;
 	    
 	    if (status->alloc_addr)
-		fore200e->bus->dma_chunk_free(fore200e, status);
+		fore200e_dma_chunk_free(fore200e, status);
 	    
 	    if (rbd_block->alloc_addr)
-		fore200e->bus->dma_chunk_free(fore200e, rbd_block);
+		fore200e_dma_chunk_free(fore200e, rbd_block);
 	}
     }
 }
@@ -370,17 +398,17 @@ fore200e_shutdown(struct fore200e* fore200e)
 
 	/* fall through */
     case FORE200E_STATE_INIT_RXQ:
-	fore200e->bus->dma_chunk_free(fore200e, &fore200e->host_rxq.status);
-	fore200e->bus->dma_chunk_free(fore200e, &fore200e->host_rxq.rpd);
+	fore200e_dma_chunk_free(fore200e, &fore200e->host_rxq.status);
+	fore200e_dma_chunk_free(fore200e, &fore200e->host_rxq.rpd);
 
 	/* fall through */
     case FORE200E_STATE_INIT_TXQ:
-	fore200e->bus->dma_chunk_free(fore200e, &fore200e->host_txq.status);
-	fore200e->bus->dma_chunk_free(fore200e, &fore200e->host_txq.tpd);
+	fore200e_dma_chunk_free(fore200e, &fore200e->host_txq.status);
+	fore200e_dma_chunk_free(fore200e, &fore200e->host_txq.tpd);
 
 	/* fall through */
     case FORE200E_STATE_INIT_CMDQ:
-	fore200e->bus->dma_chunk_free(fore200e, &fore200e->host_cmdq.status);
+	fore200e_dma_chunk_free(fore200e, &fore200e->host_cmdq.status);
 
 	/* fall through */
     case FORE200E_STATE_INITIALIZE:
@@ -427,41 +455,6 @@ static void fore200e_pca_write(u32 val, volatile u32 __iomem *addr)
     writel(cpu_to_le32(val), addr);
 }
 
-/* allocate a DMA consistent chunk of memory intended to act as a communication mechanism
-   (to hold descriptors, status, queues, etc.) shared by the driver and the adapter */
-
-static int
-fore200e_pca_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
-			     int size, int nbr, int alignment)
-{
-    /* returned chunks are page-aligned */
-    chunk->alloc_size = size * nbr;
-    chunk->alloc_addr = dma_alloc_coherent(fore200e->dev,
-					   chunk->alloc_size,
-					   &chunk->dma_addr,
-					   GFP_KERNEL);
-    
-    if ((chunk->alloc_addr == NULL) || (chunk->dma_addr == 0))
-	return -ENOMEM;
-
-    chunk->align_addr = chunk->alloc_addr;
-    
-    return 0;
-}
-
-
-/* free a DMA consistent chunk of memory */
-
-static void
-fore200e_pca_dma_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
-{
-    dma_free_coherent(fore200e->dev,
-			chunk->alloc_size,
-			chunk->alloc_addr,
-			chunk->dma_addr);
-}
-
-
 static int
 fore200e_pca_irq_check(struct fore200e* fore200e)
 {
@@ -631,8 +624,6 @@ static const struct fore200e_bus fore200e_pci_ops = {
 	.status_alignment	= 32,
 	.read			= fore200e_pca_read,
 	.write			= fore200e_pca_write,
-	.dma_chunk_alloc	= fore200e_pca_dma_chunk_alloc,
-	.dma_chunk_free		= fore200e_pca_dma_chunk_free,
 	.configure		= fore200e_pca_configure,
 	.map			= fore200e_pca_map,
 	.reset			= fore200e_pca_reset,
@@ -656,33 +647,6 @@ static void fore200e_sba_write(u32 val, volatile u32 __iomem *addr)
     sbus_writel(val, addr);
 }
 
-/* Allocate a DVMA consistent chunk of memory intended to act as a communication mechanism
- * (to hold descriptors, status, queues, etc.) shared by the driver and the adapter.
- */
-static int fore200e_sba_dma_chunk_alloc(struct fore200e *fore200e, struct chunk *chunk,
-					int size, int nbr, int alignment)
-{
-	chunk->alloc_size = size * nbr;
-
-	/* returned chunks are page-aligned */
-	chunk->alloc_addr = dma_alloc_coherent(fore200e->dev, chunk->alloc_size,
-					       &chunk->dma_addr, GFP_ATOMIC);
-
-	if ((chunk->alloc_addr == NULL) || (chunk->dma_addr == 0))
-		return -ENOMEM;
-
-	chunk->align_addr = chunk->alloc_addr;
-    
-	return 0;
-}
-
-/* free a DVMA consistent chunk of memory */
-static void fore200e_sba_dma_chunk_free(struct fore200e *fore200e, struct chunk *chunk)
-{
-	dma_free_coherent(fore200e->dev, chunk->alloc_size,
-			  chunk->alloc_addr, chunk->dma_addr);
-}
-
 static void fore200e_sba_irq_enable(struct fore200e *fore200e)
 {
 	u32 hcr = fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_STICKY;
@@ -796,8 +760,6 @@ static const struct fore200e_bus fore200e_sbus_ops = {
 	.status_alignment	= 32,
 	.read			= fore200e_sba_read,
 	.write			= fore200e_sba_write,
-	.dma_chunk_alloc	= fore200e_sba_dma_chunk_alloc,
-	.dma_chunk_free		= fore200e_sba_dma_chunk_free,
 	.configure		= fore200e_sba_configure,
 	.map			= fore200e_sba_map,
 	.reset			= fore200e_sba_reset,
@@ -2111,7 +2073,7 @@ static int fore200e_init_bs_queue(struct fore200e *fore200e)
 	    bsq = &fore200e->host_bsq[ scheme ][ magn ];
 
 	    /* allocate and align the array of status words */
-	    if (fore200e->bus->dma_chunk_alloc(fore200e,
+	    if (fore200e_dma_chunk_alloc(fore200e,
 					       &bsq->status,
 					       sizeof(enum status), 
 					       QUEUE_SIZE_BS,
@@ -2120,13 +2082,13 @@ static int fore200e_init_bs_queue(struct fore200e *fore200e)
 	    }
 
 	    /* allocate and align the array of receive buffer descriptors */
-	    if (fore200e->bus->dma_chunk_alloc(fore200e,
+	    if (fore200e_dma_chunk_alloc(fore200e,
 					       &bsq->rbd_block,
 					       sizeof(struct rbd_block),
 					       QUEUE_SIZE_BS,
 					       fore200e->bus->descr_alignment) < 0) {
 		
-		fore200e->bus->dma_chunk_free(fore200e, &bsq->status);
+		fore200e_dma_chunk_free(fore200e, &bsq->status);
 		return -ENOMEM;
 	    }
 	    
@@ -2167,7 +2129,7 @@ static int fore200e_init_rx_queue(struct fore200e *fore200e)
     DPRINTK(2, "receive queue is being initialized\n");
 
     /* allocate and align the array of status words */
-    if (fore200e->bus->dma_chunk_alloc(fore200e,
+    if (fore200e_dma_chunk_alloc(fore200e,
 				       &rxq->status,
 				       sizeof(enum status), 
 				       QUEUE_SIZE_RX,
@@ -2176,13 +2138,13 @@ static int fore200e_init_rx_queue(struct fore200e *fore200e)
     }
 
     /* allocate and align the array of receive PDU descriptors */
-    if (fore200e->bus->dma_chunk_alloc(fore200e,
+    if (fore200e_dma_chunk_alloc(fore200e,
 				       &rxq->rpd,
 				       sizeof(struct rpd), 
 				       QUEUE_SIZE_RX,
 				       fore200e->bus->descr_alignment) < 0) {
 	
-	fore200e->bus->dma_chunk_free(fore200e, &rxq->status);
+	fore200e_dma_chunk_free(fore200e, &rxq->status);
 	return -ENOMEM;
     }
 
@@ -2226,7 +2188,7 @@ static int fore200e_init_tx_queue(struct fore200e *fore200e)
     DPRINTK(2, "transmit queue is being initialized\n");
 
     /* allocate and align the array of status words */
-    if (fore200e->bus->dma_chunk_alloc(fore200e,
+    if (fore200e_dma_chunk_alloc(fore200e,
 				       &txq->status,
 				       sizeof(enum status), 
 				       QUEUE_SIZE_TX,
@@ -2235,13 +2197,13 @@ static int fore200e_init_tx_queue(struct fore200e *fore200e)
     }
 
     /* allocate and align the array of transmit PDU descriptors */
-    if (fore200e->bus->dma_chunk_alloc(fore200e,
+    if (fore200e_dma_chunk_alloc(fore200e,
 				       &txq->tpd,
 				       sizeof(struct tpd), 
 				       QUEUE_SIZE_TX,
 				       fore200e->bus->descr_alignment) < 0) {
 	
-	fore200e->bus->dma_chunk_free(fore200e, &txq->status);
+	fore200e_dma_chunk_free(fore200e, &txq->status);
 	return -ENOMEM;
     }
 
@@ -2288,7 +2250,7 @@ static int fore200e_init_cmd_queue(struct fore200e *fore200e)
     DPRINTK(2, "command queue is being initialized\n");
 
     /* allocate and align the array of status words */
-    if (fore200e->bus->dma_chunk_alloc(fore200e,
+    if (fore200e_dma_chunk_alloc(fore200e,
 				       &cmdq->status,
 				       sizeof(enum status), 
 				       QUEUE_SIZE_CMD,
diff --git a/drivers/atm/fore200e.h b/drivers/atm/fore200e.h
index f62fc9b85db0..caf0ea6a328a 100644
--- a/drivers/atm/fore200e.h
+++ b/drivers/atm/fore200e.h
@@ -805,8 +805,6 @@ typedef struct fore200e_bus {
     int                  status_alignment;    /* status words DMA alignment requirement */
     u32                  (*read)(volatile u32 __iomem *);
     void                 (*write)(u32, volatile u32 __iomem *);
-    int                  (*dma_chunk_alloc)(struct fore200e*, struct chunk*, int, int, int);
-    void                 (*dma_chunk_free)(struct fore200e*, struct chunk*);
     int                  (*configure)(struct fore200e*); 
     int                  (*map)(struct fore200e*); 
     void                 (*reset)(struct fore200e*);
-- 
2.19.0

