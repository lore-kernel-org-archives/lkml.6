Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742D52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfAPS4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:56:41 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:61494 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbfAPS4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:56:41 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a08c:f56:b2dd:7ae0])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id E772BB00490;
        Wed, 16 Jan 2019 19:56:30 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH 4/6] spi: ath79: Remove now useless code
Date:   Wed, 16 Jan 2019 19:55:47 +0100
Message-Id: <20190116185549.23295-4-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom setup/cleanup routines included in the ath79 driver only
take care of setting the initial CS state. However that is already
handled by the bitbang code, so this code can be removed.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 43 ++---------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 09c4fb7fcf7a..847f354ebef1 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -109,44 +109,6 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
 }
 
-static int ath79_spi_setup_cs(struct spi_device *spi)
-{
-	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
-
-	if (!spi->cs_gpiod) {
-		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
-
-		if (spi->mode & SPI_CS_HIGH)
-			sp->ioc_base &= ~cs_bit;
-		else
-			sp->ioc_base |= cs_bit;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
-
-	return 0;
-}
-
-static int ath79_spi_setup(struct spi_device *spi)
-{
-	int status = 0;
-
-	if (!spi->controller_state) {
-		status = ath79_spi_setup_cs(spi);
-		if (status)
-			return status;
-	}
-
-	status = spi_bitbang_setup(spi);
-
-	return status;
-}
-
-static void ath79_spi_cleanup(struct spi_device *spi)
-{
-	spi_bitbang_cleanup(spi);
-}
-
 static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
 			       u32 word, u8 bits, unsigned flags)
 {
@@ -199,8 +161,8 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->setup = ath79_spi_setup;
-	master->cleanup = ath79_spi_cleanup;
+	master->setup = spi_bitbang_setup;
+	master->cleanup = spi_bitbang_cleanup;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->num_chipselect;
@@ -209,7 +171,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
 	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
-	sp->bitbang.setup_transfer = spi_bitbang_setup_transfer;
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.19.1

