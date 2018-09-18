Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE69ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C272086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C272086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeIRPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:07:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34816 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbeIRPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:06:49 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42DyWn0PFdz1qx9G;
        Tue, 18 Sep 2018 11:35:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42DyWm6xbCz1qr2Y;
        Tue, 18 Sep 2018 11:35:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4K95DQEcQN31; Tue, 18 Sep 2018 11:34:59 +0200 (CEST)
X-Auth-Info: eZ77StSqVjRfIIwiZI9ofVWvB6mYtalXWjjjK4bANnw=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 18 Sep 2018 11:34:59 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/3] ARM: dspi: Provide per DSPI instance of the MCR register (SLAVE mode)
Date:   Tue, 18 Sep 2018 11:34:36 +0200
Message-Id: <20180918093437.26799-3-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vf610 Vybryd can work in two DSPI modes - namely master and slave.
Already we do support master mode.
This commit serves as a prerequisite to add support for slave mode. For
slave mode we do need to preserve the MCR register value to change its
"mode" bit (31) according to the supported state.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7cb3ab0a35a0..472385f0a842 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -126,6 +126,7 @@
 #define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
 
 struct chip_data {
+	u32 mcr_val;
 	u32 ctar_val;
 	u16 void_write_data;
 };
@@ -696,9 +697,9 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		else
 			dspi->bytes_per_word = 4;
 
-		regmap_update_bits(dspi->regmap, SPI_MCR,
-				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val |
+			     SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
@@ -767,6 +768,11 @@ static int dspi_setup(struct spi_device *spi)
 			return -ENOMEM;
 	}
 
+	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS;
+
+	if (dspi->devtype_data->xspi_mode)
+		chip->mcr_val |= SPI_MCR_XSPI;
+
 	pdata = dev_get_platdata(&dspi->pdev->dev);
 
 	if (!pdata) {
@@ -964,8 +970,6 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0));
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 	if (dspi->devtype_data->xspi_mode)
 		regmap_write(dspi->regmap, SPI_CTARE(0),
-- 
2.11.0

