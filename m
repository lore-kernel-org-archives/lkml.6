Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeC0QLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:11:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34853 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeC0QLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:11:21 -0400
X-Google-Smtp-Source: AIpwx489oDplS50YGTOFlA+6+TAd3n7so8OmwOJLOGFr9TULassfumgY0QD0XmvODJQVgxLNbuF28w==
From: Maksims Matjakubovs <maksims.matjakubovs@gmail.com>
To: broonie@kernel.org
Cc: maxime.ripard@bootlin.com, wens@csie.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Maksims Matjakubovs <maksims.matjakubovs@gmail.com>
Subject: [PATCH] Allwinner SPI sun6i : add dual mode support.
Date: Tue, 27 Mar 2018 19:11:02 +0300
Message-Id: <1522167062-4079-1-git-send-email-maksims.matjakubovs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Dual mode half duplex Rx and Tx support to Allwinner sun6i/sun8i SPI driver.
Main changes is related to SUN6I_BURST_CTL_CNT_REG register.
SPI transmit is in Dual mode if STC (Master Single Mode Transmit Counter) is 0 and DRM (Master Dual Mode RX Enable) is not set.
SPI receive is in Dual mode if DRM (Master Dual Mode RX Enable) is set.
Tested on Allwinner V3s (sun8i) CPU.

Signed-off-by: Maksims Matjakubovs <maksims.matjakubovs@gmail.com>
---
 drivers/spi/spi-sun6i.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8533f4e..2da52ed 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -84,6 +84,7 @@
 
 #define SUN6I_BURST_CTL_CNT_REG		0x38
 #define SUN6I_BURST_CTL_CNT_STC(cnt)		((cnt) & SUN6I_MAX_XFER_SIZE)
+#define SUN6I_BURST_CTL_CNT_DRM		BIT(28)
 
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
@@ -312,6 +313,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
 	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
 	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
+			(tfr->tx_nbits == SPI_NBITS_DUAL) ? 0 :
+			(tfr->rx_nbits == SPI_NBITS_DUAL) ? SUN6I_BURST_CTL_CNT_DRM :
 			SUN6I_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
@@ -480,7 +483,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+				SPI_RX_DUAL | SPI_TX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
-- 
2.7.4
