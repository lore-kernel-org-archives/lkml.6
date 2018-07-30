Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179EC20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179EC20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeG3QVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:21:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55978 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeG3QVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:21:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fk9Qh-0004K3-0x; Mon, 30 Jul 2018 14:45:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: omap2-mcspi: remove several redundant variables
Date:   Mon, 30 Jul 2018 15:45:46 +0100
Message-Id: <20180730144546.10699-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable count, l, mcspi and spi_cntrl are being assigned but are
never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'count' set but not used [-Wunused-but-set-variable]
warning: variable 'l' set but not used [-Wunused-but-set-variable]
warning: variable 'mcspi' set but not used [-Wunused-but-set-variable]
warning: variable 'spi_cntrl' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-omap2-mcspi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6c628a54e946..508c61c669e7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -398,11 +398,9 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-	count = xfer->len;
 
 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
@@ -582,7 +580,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	unsigned int		count;
-	u32			l;
 	u8			*rx;
 	const u8		*tx;
 	struct dma_slave_config	cfg;
@@ -595,8 +592,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-	l = mcspi_cached_chconf0(spi);
-
 
 	if (cs->word_len <= 8) {
 		width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -676,7 +671,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 static unsigned
 omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	unsigned int		count, c;
 	u32			l;
@@ -686,7 +680,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	void __iomem		*chstat_reg;
 	int			word_len;
 
-	mcspi = spi_master_get_devdata(spi->master);
 	count = xfer->len;
 	c = count;
 	word_len = cs->word_len;
@@ -883,13 +876,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
-	struct spi_master *spi_cntrl;
 	u32 l = 0, clkd = 0, div, extclk = 0, clkg = 0;
 	u8 word_len = spi->bits_per_word;
 	u32 speed_hz = spi->max_speed_hz;
 
 	mcspi = spi_master_get_devdata(spi->master);
-	spi_cntrl = mcspi->master;
 
 	if (t != NULL && t->bits_per_word)
 		word_len = t->bits_per_word;
-- 
2.17.1

