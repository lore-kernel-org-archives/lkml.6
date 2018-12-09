Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DDF20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DDF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeLIWOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38000 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727862AbeLIWOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:01 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002il-6e; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003VL-9B; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Mark Brown" <broonie@linaro.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.806695552@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 203/328] spi: rspi: Handle dmaengine_prep_slave_sg()
 failures gracefully
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

commit 85912a88c1ebcad04a5cfec971771195ce8d6691 upstream.

As typically a shmobile SoC has less DMA channels than devices that can use
DMA, we may want to prioritize access to the DMA channels in the future.
This means that dmaengine_prep_slave_sg() may start failing arbitrarily.

Handle dmaengine_prep_slave_sg() failures gracefully by falling back to
PIO.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-rspi.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -477,7 +477,7 @@ static int rspi_dma_transfer(struct rspi
 					tx->sgl, tx->nents, DMA_TO_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			return -EIO;
+			goto no_dma;
 
 		irq_mask |= SPCR_SPTIE;
 	}
@@ -486,7 +486,7 @@ static int rspi_dma_transfer(struct rspi
 					rx->sgl, rx->nents, DMA_FROM_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx)
-			return -EIO;
+			goto no_dma;
 
 		irq_mask |= SPCR_SPRIE;
 	}
@@ -540,6 +540,12 @@ static int rspi_dma_transfer(struct rspi
 		enable_irq(rspi->rx_irq);
 
 	return ret;
+
+no_dma:
+	pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
+		     dev_driver_string(&rspi->master->dev),
+		     dev_name(&rspi->master->dev));
+	return -EAGAIN;
 }
 
 static void rspi_receive_init(const struct rspi_data *rspi)
@@ -593,8 +599,10 @@ static int rspi_common_transfer(struct r
 
 	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
 		/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
-		return rspi_dma_transfer(rspi, &xfer->tx_sg,
-					 xfer->rx_buf ? &xfer->rx_sg : NULL);
+		ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
+					xfer->rx_buf ? &xfer->rx_sg : NULL);
+		if (ret != -EAGAIN)
+			return ret;
 	}
 
 	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
@@ -648,8 +656,11 @@ static int qspi_transfer_out(struct rspi
 {
 	int ret;
 
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, &xfer->tx_sg, NULL);
+	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
+		ret = rspi_dma_transfer(rspi, &xfer->tx_sg, NULL);
+		if (ret != -EAGAIN)
+			return ret;
+	}
 
 	ret = rspi_pio_transfer(rspi, xfer->tx_buf, NULL, xfer->len);
 	if (ret < 0)
@@ -663,8 +674,11 @@ static int qspi_transfer_out(struct rspi
 
 static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 {
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
+	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
+		int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
+		if (ret != -EAGAIN)
+			return ret;
+	}
 
 	return rspi_pio_transfer(rspi, NULL, xfer->rx_buf, xfer->len);
 }

