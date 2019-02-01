Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F173A21901
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dv3neyaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfBAIte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:49:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbfBAIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EDCotptuNgPwBtYaw+R0wEyOKfRmfUUw71HtLikhNLA=; b=Dv3neyaRGIu+SiwE9QyF7BMirl
        TtVPfoQaeoohV30jRW4quZEBxwq41HRwagK8Rlw36NvKcsk8ickC5rAj8X1k2C8ZWbk6nxIRRLSen
        nzN74fwBrPKdtHLfeLR3sVJmaanh9E/SlWAewWQf7/ozNF+Rla6nKQTt4zOcf9zuIHCeOsSxJLh+6
        OSxA7h53T37EaJEfCDBtfnC2pkWtLC/FaYJ+ywUIgsNBCt3f2CovwppI0WzO+h8ejL8LIZBpKuj1k
        RnumHHkGa6qc0bLGZVMFTy0NaO0rQRTbv+IO0c3Tykd9DlCJ01GJJuqJVe2GUp6oj1wARcKrKoW1E
        VqfY6XhQ==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUV3-0001TO-0W; Fri, 01 Feb 2019 08:48:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 13/18] fotg210-udc: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:56 +0100
Message-Id: <20190201084801.10983-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index fe9cf415f2f1..cec49294bac6 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -326,6 +326,7 @@ static void fotg210_wait_dma_done(struct fotg210_ep *ep)
 static void fotg210_start_dma(struct fotg210_ep *ep,
 			struct fotg210_request *req)
 {
+	struct device *dev = &ep->fotg210->gadget.dev;
 	dma_addr_t d;
 	u8 *buffer;
 	u32 length;
@@ -348,10 +349,10 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
 			length = req->req.length;
 	}
 
-	d = dma_map_single(NULL, buffer, length,
+	d = dma_map_single(dev, buffer, length,
 			ep->dir_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	if (dma_mapping_error(NULL, d)) {
+	if (dma_mapping_error(dev, d)) {
 		pr_err("dma_mapping_error\n");
 		return;
 	}
@@ -366,7 +367,7 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
 	/* update actual transfer length */
 	req->req.actual += length;
 
-	dma_unmap_single(NULL, d, length, DMA_TO_DEVICE);
+	dma_unmap_single(dev, d, length, DMA_TO_DEVICE);
 }
 
 static void fotg210_ep0_queue(struct fotg210_ep *ep,
-- 
2.20.1

