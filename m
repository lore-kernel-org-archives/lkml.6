Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeDPGrp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:47:45 -0400
Received: from m12-18.163.com ([220.181.12.18]:44408 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeDPGrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:47:43 -0400
From: sxauwsk <sxauwsk@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangshikai@inno-instrument.cn, sxauwsk <sxauwsk@163.com>,
        guojian <guojian@innoinstrument.net>
Subject: [PATCH] [PATCH v1] spi: cadence: Add usleep_range() for  cdns_spi_fill_tx_fifo()
Date: Mon, 16 Apr 2018 14:46:40 +0800
Message-Id: <1523861200-34130-1-git-send-email-sxauwsk@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: EsCowAAn5EXvRtRaPtkLFg--.12687S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF43Xw1DZw4DtryUAFWfAFb_yoWkKrbEvF
        18Aw1DGw45KF9rA3W29FsxAFWv9an5Cr1kuFWqqa9xJw47Z3Z2vr95Zr1DuwsxCa1UWF9x
        ZrnYkayUArnxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRJ3ktUUUUU==
X-Originating-IP: [113.140.17.238]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/1tbiQBAqJlSIVnL2AAAAsS
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of xspi work in busy condition, may send bytes failed.
once something wrong, spi controller did't work any more

My test found this situation appear in both of read/write process.
so when TX FIFO is full, add one byte delay before send data;

Signed-off-by: sxauwsk <sxauwsk@163.com>
Signed-off-by: guojian <guojian@innoinstrument.net>
Signed-off-by: wangshikai <wangshikai@inno-instrument.cn>
---
 drivers/spi/spi-cadence.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 66ae055..9694042 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -315,9 +315,11 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 	       (xspi->tx_bytes > 0)) {
 
 		/* When xspi in busy condition, bytes may send failed,
-		 * caused communication failure so add one byte delay
+		 * then spi control did't work thoroughly, add one byte delay
 		 */
-		usleep_range(10, 20);
+		if (cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET) &
+		    CDNS_SPI_IXR_TXFULL_MASK)
+			usleep_range(10, 20);
 
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
-- 
1.7.9.5
