Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeDKDrp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:47:45 -0400
Received: from m12-18.163.com ([220.181.12.18]:46859 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeDKDrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:47:43 -0400
From: sxauwsk <sxauwsk@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sxauwsk@163.com, guojian <guojian@innoinstrument.net>,
        wangshikai <wangshikai@inno-instrument.cn>
Subject: [PATCH] spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()
Date: Mon,  9 Apr 2018 19:16:50 +0800
Message-Id: <1523272610-49116-1-git-send-email-sxauwsk@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: EsCowACXsdBEhc1atNCREg--.17491S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1rtF1kuw1UZF13Zw47Arb_yoWfAFbEvF
        1UAws7Gay5JF9FyFy29rsrZryjva1Fqr1kuF1qqas8JwsrZan2vrn5Zr1DKw17Zw4UuFnx
        Zr1vga4DArsxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRJ3ktUUUUU==
X-Originating-IP: [113.140.17.238]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBZA8lJlQG-7C1lAAAsU
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of xspi work in busy condition, may send bytes failed.
Add one bytes delay

Signed-off-by: sxauwsk <sxauwsk@163.com>
Signed-off-by: guojian <guojian@innoinstrument.net>
Signed-off-by: wangshikai <wangshikai@inno-instrument.cn>
---
 drivers/spi/spi-cadence.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5c9516a..66ae055 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -313,6 +313,12 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 
 	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
 	       (xspi->tx_bytes > 0)) {
+
+		/* When xspi in busy condition, bytes may send failed,
+		 * caused communication failure so add one byte delay
+		 */
+		usleep_range(10, 20);
+
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
 		else
-- 
1.7.9.5
