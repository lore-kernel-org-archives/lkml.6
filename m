Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2418820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2418820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeLIWNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37960 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbeLIWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:46 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002ir-7J; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003VQ-Ap; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Mark Brown" <broonie@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.129699538@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 204/328] spi: rspi: Fix leaking of unused DMA descriptors
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3819bc8752367eae0d72fa1c473dc88ea45631a7 upstream.

If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
unused DMA descriptors.

As per Documentation/dmaengine.txt, once a DMA descriptor has been
obtained, it must be submitted. Hence:
  - First prepare and submit all DMA descriptors,
  - Prepare the SPI controller for DMA,
  - Start DMA by calling dma_async_issue_pending(),
  - Make sure to call dmaengine_terminate_all() on all descriptors that
    haven't completed.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-rspi.c | 94 ++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 36 deletions(-)

--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -472,25 +472,52 @@ static int rspi_dma_transfer(struct rspi
 	dma_cookie_t cookie;
 	int ret;
 
-	if (tx) {
-		desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx,
-					tx->sgl, tx->nents, DMA_TO_DEVICE,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_tx)
-			goto no_dma;
-
-		irq_mask |= SPCR_SPTIE;
-	}
+	/* First prepare and submit the DMA request(s), as this may fail */
 	if (rx) {
 		desc_rx = dmaengine_prep_slave_sg(rspi->master->dma_rx,
 					rx->sgl, rx->nents, DMA_FROM_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_rx)
-			goto no_dma;
+		if (!desc_rx) {
+			ret = -EAGAIN;
+			goto no_dma_rx;
+		}
+
+		desc_rx->callback = rspi_dma_complete;
+		desc_rx->callback_param = rspi;
+		cookie = dmaengine_submit(desc_rx);
+		if (dma_submit_error(cookie)) {
+			ret = cookie;
+			goto no_dma_rx;
+		}
 
 		irq_mask |= SPCR_SPRIE;
 	}
 
+	if (tx) {
+		desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx,
+					tx->sgl, tx->nents, DMA_TO_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc_tx) {
+			ret = -EAGAIN;
+			goto no_dma_tx;
+		}
+
+		if (rx) {
+			/* No callback */
+			desc_tx->callback = NULL;
+		} else {
+			desc_tx->callback = rspi_dma_complete;
+			desc_tx->callback_param = rspi;
+		}
+		cookie = dmaengine_submit(desc_tx);
+		if (dma_submit_error(cookie)) {
+			ret = cookie;
+			goto no_dma_tx;
+		}
+
+		irq_mask |= SPCR_SPTIE;
+	}
+
 	/*
 	 * DMAC needs SPxIE, but if SPxIE is set, the IRQ routine will be
 	 * called. So, this driver disables the IRQ while DMA transfer.
@@ -503,34 +530,24 @@ static int rspi_dma_transfer(struct rspi
 	rspi_enable_irq(rspi, irq_mask);
 	rspi->dma_callbacked = 0;
 
-	if (rx) {
-		desc_rx->callback = rspi_dma_complete;
-		desc_rx->callback_param = rspi;
-		cookie = dmaengine_submit(desc_rx);
-		if (dma_submit_error(cookie))
-			return cookie;
+	/* Now start DMA */
+	if (rx)
 		dma_async_issue_pending(rspi->master->dma_rx);
-	}
-	if (tx) {
-		if (rx) {
-			/* No callback */
-			desc_tx->callback = NULL;
-		} else {
-			desc_tx->callback = rspi_dma_complete;
-			desc_tx->callback_param = rspi;
-		}
-		cookie = dmaengine_submit(desc_tx);
-		if (dma_submit_error(cookie))
-			return cookie;
+	if (tx)
 		dma_async_issue_pending(rspi->master->dma_tx);
-	}
 
 	ret = wait_event_interruptible_timeout(rspi->wait,
 					       rspi->dma_callbacked, HZ);
 	if (ret > 0 && rspi->dma_callbacked)
 		ret = 0;
-	else if (!ret)
+	else if (!ret) {
+		dev_err(&rspi->master->dev, "DMA timeout\n");
 		ret = -ETIMEDOUT;
+		if (tx)
+			dmaengine_terminate_all(rspi->master->dma_tx);
+		if (rx)
+			dmaengine_terminate_all(rspi->master->dma_rx);
+	}
 
 	rspi_disable_irq(rspi, irq_mask);
 
@@ -541,11 +558,16 @@ static int rspi_dma_transfer(struct rspi
 
 	return ret;
 
-no_dma:
-	pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
-		     dev_driver_string(&rspi->master->dev),
-		     dev_name(&rspi->master->dev));
-	return -EAGAIN;
+no_dma_tx:
+	if (rx)
+		dmaengine_terminate_all(rspi->master->dma_rx);
+no_dma_rx:
+	if (ret == -EAGAIN) {
+		pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
+			     dev_driver_string(&rspi->master->dev),
+			     dev_name(&rspi->master->dev));
+	}
+	return ret;
 }
 
 static void rspi_receive_init(const struct rspi_data *rspi)

