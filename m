Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC95C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC3420890
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MFBV9R0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC3420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeJOOYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:24:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39370 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeJOOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:24:23 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9F6eRrJ039317;
        Mon, 15 Oct 2018 01:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539585627;
        bh=2OxZ69j2xlDziQXmP+WBFk2wdY5rOJpPNrjFdeiQN5I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MFBV9R0MqgnWk6mlbO7UPKp4b6t71UtSomdAegpH1eOTR+D7r3XgAxO9baDR2RkFN
         mkP81vzec5bPqQwTbVR0GYKr0Jm9byNIgqBHJUFvOMf5om7MDm8lNiqKsRv3JMjWvG
         9r+n1nLr+iPntibktC9BA9+GtDXAagnRmIV6XPig=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F6eRKV005892;
        Mon, 15 Oct 2018 01:40:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 01:40:27 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 01:40:27 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F6eH4P023129;
        Mon, 15 Oct 2018 01:40:25 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/3] spi: omap2-mcspi: Set FIFO DMA trigger level to word length
Date:   Mon, 15 Oct 2018 12:08:28 +0530
Message-ID: <20181015063829.26978-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181015063829.26978-1-vigneshr@ti.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

McSPI has 32 byte FIFO in Transmit-Receive mode. Current code tries to
configuration FIFO watermark level for DMA trigger to be GCD of transfer
length and max FIFO size which would mean trigger level may be set to 32
for transmit-receive mode if length is aligned. This does not work in
case of SPI slave mode where FIFO always needs to have data ready
whenever master starts the clock. With DMA trigger size of 32 there will
be a small window during slave TX where DMA is still putting data into
FIFO but master would have started clock for next byte, resulting in
shifting out of stale data. Similarly, on Slave RX side there may be RX
FIFO overflow
Fix this by setting FIFO watermark for DMA trigger to word
length. This means DMA is triggered as soon as FIFO has space for word
length bytes and DMA would make sure FIFO is almost always full
therefore improving FIFO occupancy in both master and slave mode.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 985f00d8a964..88469bb22235 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -300,7 +300,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
 	unsigned int wcnt;
-	int max_fifo_depth, fifo_depth, bytes_per_word;
+	int max_fifo_depth, bytes_per_word;
 	u32 chconf, xferlevel;
 
 	mcspi = spi_master_get_devdata(master);
@@ -316,10 +316,6 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
 
-		fifo_depth = gcd(t->len, max_fifo_depth);
-		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
-			goto disable_fifo;
-
 		wcnt = t->len / bytes_per_word;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
@@ -327,16 +323,17 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			xferlevel |= (fifo_depth - 1) << 8;
+			xferlevel |= (bytes_per_word - 1) << 8;
 		}
+
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			xferlevel |= fifo_depth - 1;
+			xferlevel |= bytes_per_word - 1;
 		}
 
 		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
 		mcspi_write_chconf0(spi, chconf);
-		mcspi->fifo_depth = fifo_depth;
+		mcspi->fifo_depth = max_fifo_depth;
 
 		return;
 	}
@@ -576,7 +573,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
-	u32			burst;
 	void __iomem		*chstat_reg;
 	void __iomem            *irqstat_reg;
 	int			wait_res;
@@ -596,22 +592,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	count = xfer->len;
-	burst = 1;
-
-	if (mcspi->fifo_depth > 0) {
-		if (count > mcspi->fifo_depth)
-			burst = mcspi->fifo_depth / es;
-		else
-			burst = count / es;
-	}
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = burst;
-	cfg.dst_maxburst = burst;
+	cfg.src_maxburst = es;
+	cfg.dst_maxburst = es;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.19.1

