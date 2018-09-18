Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D5ECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E871D2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E871D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeIRPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:06:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47813 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeIRPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:06:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42DyWp2Y6Hz1qx96;
        Tue, 18 Sep 2018 11:35:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42DyWp2JmKz1qr2Y;
        Tue, 18 Sep 2018 11:35:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 6M0bvvb4N8vZ; Tue, 18 Sep 2018 11:35:01 +0200 (CEST)
X-Auth-Info: pwsWq3Jq9rnTc4tuFv1rUu8vI7rUrM3SDAzcPtLNq74=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 18 Sep 2018 11:35:01 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/3] ARM: dspi: Provide support for DSPI slave more operation (Vybryd vf610)
Date:   Tue, 18 Sep 2018 11:34:37 +0200
Message-Id: <20180918093437.26799-4-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP's Vybryd vf610 can work as a SPI slave device (the CS and clock
signal are provided by master).

It is possible to specify a single device to work in that mode. As we do
use DMA for transferring data, the RX channel must be prepared for
incoming data.
Moreover, in slave mode we just set a subset of control fields in
configuration registers (CTAR0, PUSHR).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spi-fsl-dspi.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 472385f0a842..1d71f6fd2e0b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -209,6 +209,14 @@ struct fsl_dspi {
 	struct fsl_dspi_dma	*dma;
 };
 
+static inline bool dspi_slave_mode(struct fsl_dspi *dspi)
+{
+	if (!(dspi->cur_chip->mcr_val & SPI_MCR_MASTER))
+		return true;
+
+	return false;
+}
+
 static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 {
 	u32 txdata = 0;
@@ -230,6 +238,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
+	if (dspi_slave_mode(dspi))
+		return data;
+
 	if (dspi->len > 0)
 		cmd |= SPI_PUSHR_CMD_CONT;
 	return cmd << 16 | data;
@@ -326,6 +337,11 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dma_async_issue_pending(dma->chan_rx);
 	dma_async_issue_pending(dma->chan_tx);
 
+	if (dspi_slave_mode(dspi)) {
+		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
+		return 0;
+	}
+
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
 					DMA_COMPLETION_TIMEOUT);
 	if (time_left == 0) {
@@ -781,6 +797,10 @@ static int dspi_setup(struct spi_device *spi)
 
 		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
 				&sck_cs_delay);
+
+		if (of_property_read_bool(spi->dev.of_node,
+					  "fsl,spi-slave-mode"))
+			chip->mcr_val &= ~SPI_MCR_MASTER;
 	} else {
 		cs_sck_delay = pdata->cs_sck_delay;
 		sck_cs_delay = pdata->sck_cs_delay;
@@ -798,14 +818,18 @@ static int dspi_setup(struct spi_device *spi)
 	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
 
 	chip->ctar_val = SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
-		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
-		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
-		| SPI_CTAR_PCSSCK(pcssck)
-		| SPI_CTAR_CSSCK(cssck)
-		| SPI_CTAR_PASC(pasc)
-		| SPI_CTAR_ASC(asc)
-		| SPI_CTAR_PBR(pbr)
-		| SPI_CTAR_BR(br);
+		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0);
+
+	if (chip->mcr_val & SPI_MCR_MASTER) {
+		chip->ctar_val |= SPI_CTAR_LSBFE(spi->mode &
+						 SPI_LSB_FIRST ? 1 : 0)
+			| SPI_CTAR_PCSSCK(pcssck)
+			| SPI_CTAR_CSSCK(cssck)
+			| SPI_CTAR_PASC(pasc)
+			| SPI_CTAR_ASC(asc)
+			| SPI_CTAR_PBR(pbr)
+			| SPI_CTAR_BR(br);
+	}
 
 	spi_set_ctldata(spi, chip);
 
-- 
2.11.0

