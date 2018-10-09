Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF6214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pfn34Y3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEF6214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJIWPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:15:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeJIWPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZEacMIXix2Uza8hkPethF1vxI2J7PRFVaUXHkyp7sJA=; b=pfn34Y3Xuvf8ooNy3fCBRUfBou
        h33xagujbQPSxcIGRcPLO8KD3u3BfPtaTfBx0XIZhsZiMKzoyjgRukHWUtv1U06OX94fvfz/T8tOh
        vjGGEKobao0i9Ja5fB/jaCtWEKZyqeA/76VfRVPx/XOn/94bOO7qS331p3UsfzBu2PxNk0JGHXgRV
        Th0W04bhDLrMpXWFlai9jk4pfYl5XyJbyDDvs9myr1F2qHmzU/njb651mrlJEDoNv/cvp/iVzaj3Y
        cbo8EwHAwYDcqO/tTMIKF2pnuAudv1/7rvXod7Nt24AT98dSiwISybUzzkC5OmOskULdjhyCzewQr
        mg/FHnjg==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tSB-0001Zv-6Y; Tue, 09 Oct 2018 14:57:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] fore200e: check for dma mapping failures
Date:   Tue,  9 Oct 2018 16:57:20 +0200
Message-Id: <20181009145720.32578-8-hch@lst.de>
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

The driver was lacking any handling for failures from the DMA mapping
routines.  With an iommu or swiotlb this can be fatal.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 7eda1a8c3d8c..2b5dc8fe1d85 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -195,6 +195,10 @@ fore200e_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk, int size, i
 
     chunk->dma_addr = dma_map_single(fore200e->dev, chunk->align_addr,
 				     size, direction);
+    if (dma_mapping_error(fore200e->dev, chunk->dma_addr)) {
+	kfree(chunk->alloc_addr);
+	return -ENOMEM;
+    }
     return 0;
 }
 
@@ -576,6 +580,8 @@ fore200e_pca_prom_read(struct fore200e* fore200e, struct prom_data* prom)
 
     prom_dma = dma_map_single(fore200e->dev, prom, sizeof(struct prom_data),
 			      DMA_FROM_DEVICE);
+    if (dma_mapping_error(fore200e->dev, prom_dma))
+	return -ENOMEM;
 
     fore200e->bus->write(prom_dma, &entry->cp_entry->cmd.prom_block.prom_haddr);
     
@@ -1597,6 +1603,11 @@ fore200e_send(struct atm_vcc *vcc, struct sk_buff *skb)
     tpd = entry->tpd;
     tpd->tsd[ 0 ].buffer = dma_map_single(fore200e->dev, data, tx_len,
 					  DMA_TO_DEVICE);
+    if (dma_mapping_error(fore200e->dev, tpd->tsd[0].buffer)) {
+	if (tx_copy)
+	    kfree(data);
+	return -ENOMEM;
+    }
     tpd->tsd[ 0 ].length = tx_len;
 
     FORE200E_NEXT_ENTRY(txq->head, QUEUE_SIZE_TX);
@@ -1671,6 +1682,8 @@ fore200e_getstats(struct fore200e* fore200e)
     
     stats_dma_addr = dma_map_single(fore200e->dev, fore200e->stats,
 				    sizeof(struct stats), DMA_FROM_DEVICE);
+    if (dma_mapping_error(fore200e->dev, stats_dma_addr))
+    	return -ENOMEM;
     
     FORE200E_NEXT_ENTRY(cmdq->head, QUEUE_SIZE_CMD);
 
-- 
2.19.0

