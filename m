Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeDQCJA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:09:00 -0400
Received: from m12-18.163.com ([220.181.12.18]:48405 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbeDQCI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:08:58 -0400
From: sxauwsk <sxauwsk@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sxauwsk <sxauwsk@163.com>
Subject: [PATCH] spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()
Date: Mon, 16 Apr 2018 20:07:31 +0800
Message-Id: <1523880451-37748-1-git-send-email-sxauwsk@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: EsCowADHZicwV9VahLSRFg--.23040S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1rCF43GryrJw1rGr15urg_yoWDtwbEvr
        18Crs7Gay5GF9FyFy29Fs7AFyjvF4kGr1v9a90q39xJanrAFn2vFy8ZF1Du3srAw4UuFn3
        urn5Gas7Ar13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiTmh3UUUUU==
X-Originating-IP: [113.140.17.238]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/1tbiDhIrJlXlm7L7awAAsY
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of xspi work in busy condition, may send bytes failed then caused
communication failure. once something wrong, spi controller did't work any more.

My test found this situation appear in both of read/write operation.
so when TX FIFO is full, add one byte delay before send data.

Signed-off-by: sxauwsk <sxauwsk@163.com>
---
 drivers/spi/spi-cadence.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5c9516a..9694042 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -313,6 +313,14 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)

	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
 	       (xspi->tx_bytes > 0)) {
+
+		/* When xspi in busy condition, bytes may send failed,
+		 * then spi control did't work thoroughly, add one byte delay
+		 */
+		if (cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET) &
+		    CDNS_SPI_IXR_TXFULL_MASK)
+			usleep_range(10, 20);
+
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
 		else
--
1.7.9.5
