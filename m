Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D17720578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gQ/zumw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfAOG6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:58:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41662 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfAOG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:58:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0F6vjaP080541;
        Tue, 15 Jan 2019 00:57:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547535465;
        bh=iNYNbDDI+/kurMIElx2IHFIugEuGQcRQkRSrnXRnsEk=;
        h=From:To:CC:Subject:Date;
        b=gQ/zumw0kp5Iw3Uqey7gvlj07JYvC8TtOrZTnwpoKPnV0Cscu1xnppRwTV2udBbCV
         vwnmOCfrTXI7fm5csq1wJodCTmUmBJ9ievHCrhivINQBdRkhLrDcWOpwTT4Vaf+hcU
         m/uUY1H0jiGn93P20RKZiC5VkOxQJGAqEd9uD5io=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0F6vjNY122244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 00:57:45 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 00:57:45 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 00:57:44 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0F6vgHM014646;
        Tue, 15 Jan 2019 00:57:42 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        David Lechner <david@lechnology.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, <linux-omap@vger.kernel.org>
Subject: [PATCH] spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch
Date:   Tue, 15 Jan 2019 12:28:32 +0530
Message-ID: <20190115065832.23705-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
broke SPI transfers where bits_per_word != 8. This is because of
mimsatch between McSPI FIFO level event trigger size (SPI word length) and
DMA request size(word length * maxburst). This leads to data
corruption, lockup and errors like:

	spi1.0: EOW timed out

Fix this by setting DMA maxburst size to 1 so that
McSPI FIFO level event trigger size matches DMA request size.

Fixes: b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
Cc: stable@vger.kernel.org
Reported-by: David Lechner <david@lechnology.com>
Tested-by: David Lechner <david@lechnology.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2fd8881fcd65..8be304379628 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = es;
-	cfg.dst_maxburst = es;
+	cfg.src_maxburst = 1;
+	cfg.dst_maxburst = 1;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.20.1

