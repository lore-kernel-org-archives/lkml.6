Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF7D218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dbRSTjZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBKNUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:20:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfBKNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c4Qaalwdx/PeL4lWqKqE61S7gRsLfxuZGvUBuTczS0Q=; b=dbRSTjZm5wqHALuNGzvTarv16u
        YPp1W8z4zH2indapHoAntbURI6FhhrpxqsiugJA/4KuYuau1y86RRDvUppG8cWH/Ic7cYUs2frosj
        IewPcsiHtBrrnCcpAo603QkvbW+NjZVB5ZwCPS6xxvdR9AUh7tO1jsN6Z8h9jxUq2YmpAOLUEKUMn
        mVGXt5AW0gWdkpe01Ig0/+S+JikhQT3E7dlX3TBON2svQW+z+x0OAemo1O+2r3LZNm97A1PgtFyUb
        ITflhe9PzNu5C1y2PDh7I8UhpncksxUbzcX/eocdGFuVtRgXdYq18cU6kQpcCmzw44+tvaTob+xkv
        GDvx4jrQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBVL-0007pP-21; Mon, 11 Feb 2019 13:20:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] net: caif: pass struct device to DMA API functions
Date:   Mon, 11 Feb 2019 14:19:57 +0100
Message-Id: <20190211132004.29143-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211132004.29143-1-hch@lst.de>
References: <20190211132004.29143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Also use the proper Kconfig symbol to check for DMA API availability.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/caif/caif_spi.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/caif/caif_spi.c b/drivers/net/caif/caif_spi.c
index d28a1398c091..7608bc3e00df 100644
--- a/drivers/net/caif/caif_spi.c
+++ b/drivers/net/caif/caif_spi.c
@@ -73,35 +73,37 @@ MODULE_PARM_DESC(spi_down_tail_align, "SPI downlink tail alignment.");
 #define LOW_WATER_MARK   100
 #define HIGH_WATER_MARK  (LOW_WATER_MARK*5)
 
-#ifdef CONFIG_UML
+#ifndef CONFIG_HAS_DMA
 
 /*
  * We sometimes use UML for debugging, but it cannot handle
  * dma_alloc_coherent so we have to wrap it.
  */
-static inline void *dma_alloc(dma_addr_t *daddr)
+static inline void *dma_alloc(struct cfspi *cfspi, dma_addr_t *daddr)
 {
 	return kmalloc(SPI_DMA_BUF_LEN, GFP_KERNEL);
 }
 
-static inline void dma_free(void *cpu_addr, dma_addr_t handle)
+static inline void dma_free(struct cfspi *cfspi, void *cpu_addr,
+		dma_addr_t handle)
 {
 	kfree(cpu_addr);
 }
 
 #else
 
-static inline void *dma_alloc(dma_addr_t *daddr)
+static inline void *dma_alloc(struct cfspi *cfspi, dma_addr_t *daddr)
 {
-	return dma_alloc_coherent(NULL, SPI_DMA_BUF_LEN, daddr,
+	return dma_alloc_coherent(&cfspi->pdev->dev, SPI_DMA_BUF_LEN, daddr,
 				GFP_KERNEL);
 }
 
-static inline void dma_free(void *cpu_addr, dma_addr_t handle)
+static inline void dma_free(struct cfspi *cfspi, void *cpu_addr,
+		dma_addr_t handle)
 {
-	dma_free_coherent(NULL, SPI_DMA_BUF_LEN, cpu_addr, handle);
+	dma_free_coherent(&cfspi->pdev->dev, SPI_DMA_BUF_LEN, cpu_addr, handle);
 }
-#endif	/* CONFIG_UML */
+#endif	/* CONFIG_HAS_DMA */
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -610,13 +612,13 @@ static int cfspi_init(struct net_device *dev)
 	}
 
 	/* Allocate DMA buffers. */
-	cfspi->xfer.va_tx[0] = dma_alloc(&cfspi->xfer.pa_tx[0]);
+	cfspi->xfer.va_tx[0] = dma_alloc(cfspi, &cfspi->xfer.pa_tx[0]);
 	if (!cfspi->xfer.va_tx[0]) {
 		res = -ENODEV;
 		goto err_dma_alloc_tx_0;
 	}
 
-	cfspi->xfer.va_rx = dma_alloc(&cfspi->xfer.pa_rx);
+	cfspi->xfer.va_rx = dma_alloc(cfspi, &cfspi->xfer.pa_rx);
 
 	if (!cfspi->xfer.va_rx) {
 		res = -ENODEV;
@@ -665,9 +667,9 @@ static int cfspi_init(struct net_device *dev)
 	return 0;
 
  err_create_wq:
-	dma_free(cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
+	dma_free(cfspi, cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
  err_dma_alloc_rx:
-	dma_free(cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
+	dma_free(cfspi, cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
  err_dma_alloc_tx_0:
 	return res;
 }
@@ -683,8 +685,8 @@ static void cfspi_uninit(struct net_device *dev)
 
 	cfspi->ndev = NULL;
 	/* Free DMA buffers. */
-	dma_free(cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
-	dma_free(cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
+	dma_free(cfspi, cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
+	dma_free(cfspi, cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
 	set_bit(SPI_TERMINATE, &cfspi->state);
 	wake_up_interruptible(&cfspi->wait);
 	destroy_workqueue(cfspi->wq);
-- 
2.20.1

