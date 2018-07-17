Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D281820850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D281820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbeGQPFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:05:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42448 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731794AbeGQPFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:05:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2377A208FF; Tue, 17 Jul 2018 16:32:08 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id C674E20765;
        Tue, 17 Jul 2018 16:31:57 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: [PATCH RESEND 3/5] spi: imx: Use correct number of bytes per words
Date:   Tue, 17 Jul 2018 16:31:52 +0200
Message-Id: <20180717143154.28241-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI core enforces that we always use the next power-of-two number of
bytes to store words. As a result, a 24 bits word will be stored in 4
bytes.

This commit fixes the spi_imx_bytes_per_word function to return the
correct number of bytes.

This also allows to get rid of unnecessary checks in the can_dma
function, since the SPI core validates that we always have a transfer
length that is a multiple of the number of bytes per word.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ecafbda5ec94..3ae706dac660 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -202,7 +202,12 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 
 static int spi_imx_bytes_per_word(const int bits_per_word)
 {
-	return DIV_ROUND_UP(bits_per_word, BITS_PER_BYTE);
+	if (bits_per_word <= 8)
+		return 1;
+	else if (bits_per_word <= 16)
+		return 2;
+	else
+		return 4;
 }
 
 static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
@@ -219,9 +224,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 
 	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 
-	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
-		return false;
-
 	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
 		if (!(transfer->len % (i * bytes_per_word)))
 			break;
-- 
2.11.0

