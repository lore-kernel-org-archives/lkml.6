Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3271EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A87520652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A87520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeJWRgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:36:07 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56244 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJWRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:36:07 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42fSNt0J4Rz1qvwS;
        Tue, 23 Oct 2018 11:13:34 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42fSNs6Y3Mz1qqkT;
        Tue, 23 Oct 2018 11:13:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id vNXlwOShSaoy; Tue, 23 Oct 2018 11:13:31 +0200 (CEST)
X-Auth-Info: 5pMVXgmrSD+FeSl91CSnxx9giud9uKVbvGXAH6oug1k=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 23 Oct 2018 11:13:31 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [RESEND PATCHv2] ARM: dspi: Provide support for DSPI slave more operation (Vybryd vf610)
Date:   Tue, 23 Oct 2018 11:13:19 +0200
Message-Id: <20181023091319.27868-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180927150709.17010-1-lukma@denx.de>
References: <20180927150709.17010-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP's Vybryd vf610 can work as a SPI slave device (the CS and clock
signals are provided by master).

It is possible to specify a single device to work in that mode. As we do
use DMA for transferring data, the RX channel must be prepared for
incoming data.
Moreover, in slave mode we just set a subset of control fields in
configuration registers (CTAR0, PUSHR).

For testing the spidev_test program has been used.
Test script for this patch can be found here:
https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh


Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:

- Remove patch which adds extra NXP specific DTS property to support slave
mode and reuse the generic one (spi-slave)
- Remove patch which brings back the mcr_register local copy. It is not
needed as generic SPI slave infrastructure is used.
- Rewrite the code to use spi_controller_is_slave() helper functions
---
 drivers/spi/spi-fsl-dspi.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3082e72e4f6c..94b6a9690062 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -233,6 +233,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
+	if (spi_controller_is_slave(dspi->master))
+		return data;
+
 	if (dspi->len > 0)
 		cmd |= SPI_PUSHR_CMD_CONT;
 	return cmd << 16 | data;
@@ -329,6 +332,11 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dma_async_issue_pending(dma->chan_rx);
 	dma_async_issue_pending(dma->chan_tx);
 
+	if (spi_controller_is_slave(dspi->master)) {
+		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
+		return 0;
+	}
+
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
 					DMA_COMPLETION_TIMEOUT);
 	if (time_left == 0) {
@@ -798,14 +806,18 @@ static int dspi_setup(struct spi_device *spi)
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
+	if (!spi_controller_is_slave(dspi->master)) {
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
 
@@ -970,8 +982,13 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0));
+	unsigned int mcr = SPI_MCR_PCSIS |
+		(dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0);
+
+	if (!spi_controller_is_slave(dspi->master))
+		mcr |= SPI_MCR_MASTER;
+
+	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 	if (dspi->devtype_data->xspi_mode)
 		regmap_write(dspi->regmap, SPI_CTARE(0),
@@ -1027,6 +1044,9 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 		master->bus_num = bus_num;
 
+		if (of_property_read_bool(np, "spi-slave"))
+			master->slave = true;
+
 		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 		if (!dspi->devtype_data) {
 			dev_err(&pdev->dev, "can't get devtype_data\n");
-- 
2.11.0

