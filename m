Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2579FC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77952064D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77952064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeI3P5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 11:57:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33532 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbeI3P5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 11:57:43 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BB721A0003;
        Sun, 30 Sep 2018 11:25:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C38481A0096;
        Sun, 30 Sep 2018 11:25:25 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3BF5C402F6;
        Sun, 30 Sep 2018 17:25:21 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, eha@deif.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH v2 3/4] spi: spi-fsl-dspi: Fix cmd_fifo is written before tx_fifo
Date:   Sun, 30 Sep 2018 17:25:34 +0800
Message-Id: <20180930092535.24544-3-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180930092535.24544-1-chuanhua.han@nxp.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem of invalid data writing during the XSPI
mode transfer of the dspi controller.
In XSPI mode,When I executed TX FIFO first and then CMD FIFO for XSPI
transmission, I found that SPIx_SR[TFIWF]=1(Invalid Data present in TX
FIFO since CMD FIFO is empty).
This is the time when no data can be read or written (all the data
obtained is equal to 0).

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v2:
 -The original patch is divided into multiple patches(the original
patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
mode"),one of which is segmented.

 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4dc1064bf408..96e790e90997 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -590,6 +590,7 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
+		cmd_fifo_write(dspi);
 		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
 			/* LSB */
 			tx_fifo_write(dspi, data & 0xFFFF);
@@ -599,7 +600,6 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 			tx_fifo_write(dspi, data >> 16);
 			tx_fifo_write(dspi, data & 0xFFFF);
 		}
-		cmd_fifo_write(dspi);
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
 		 * simultaneously.
-- 
2.17.1

