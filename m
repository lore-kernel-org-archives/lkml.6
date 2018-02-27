Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeB0K1t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:27:49 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:51940 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbeB0K1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:27:48 -0500
X-IronPort-AV: E=Sophos;i="5.47,400,1515481200";
   d="scan'208";a="9188935"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] spi: atmel: init FIFOs before spi enable
Date: Tue, 27 Feb 2018 12:25:07 +0200
Message-ID: <1519727107-5821-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet recommends initializing FIFOs before
SPI enable. If we do not do it like this, there may be
a strange behavior. We noticed that DMA does not work properly
with FIFOs if we do not clear them beforehand or enable them
before SPIEN.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/spi/spi-atmel.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 6694709..0478758 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1489,6 +1489,11 @@ static void atmel_spi_init(struct atmel_spi *as)
 {
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+
+	/* It is recommended to enable FIFOs first thing after reset */
+	if (as->fifo_size)
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+
 	if (as->caps.has_wdrbt) {
 		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
@@ -1499,9 +1504,6 @@ static void atmel_spi_init(struct atmel_spi *as)
 	if (as->use_pdc)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
-
-	if (as->fifo_size)
-		spi_writel(as, CR, SPI_BIT(FIFOEN));
 }
 
 static int atmel_spi_probe(struct platform_device *pdev)
-- 
2.7.4
