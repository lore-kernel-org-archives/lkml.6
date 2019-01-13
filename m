Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B869FC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874C72087E
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="R0KaZCtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfAMUtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:49:32 -0500
Received: from vern.gendns.com ([98.142.107.122]:32988 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfAMUtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2inpnJwKeTLPPL+VWYfwtbuBFTig9TqMnU7NbVqj5Xs=; b=R0KaZCtYSZzH/zcPEpxOiK2W7W
        0wTHoNmYAL2Sq6p4H8xsbK/HY6KUU9kwdzND/spHVNEd4krtHJXpY2kb+QXv55uCWJgfPUlY0vQIw
        Dkc07BGPBOTP0ylZYILMSm5ZE2ulUdZlpl+AHc/U3bVj8/UOCjgm07mn/5la0QLhzc48sqPqlxaJd
        oP3UK2BeGi8AVxRKt450RMxiSmz8Wek1OQFnHBvqD1EBUQDr3LPqHLOrXngm91uE5L26sIUSpwo4I
        ya7hlIBgFRvLnvwPDX1HtM6qa+MnQilXtQxSy2TBUcrGmla+yuHl5zuOBlxl3+ahNt5hn4SgvmILO
        HcwrplsQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52892 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gimec-0000Nf-Qk; Sun, 13 Jan 2019 15:46:46 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to word length"
Date:   Sun, 13 Jan 2019 14:49:05 -0600
Message-Id: <20190113204905.29795-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab.

That commit breaks displays using tinydrm drivers, such as ili9225.

It causes corruption in the image that is displayed (it looks like only
1/2 of the framebuffer data is sent, the other half of the display
remains blank.)

The following error appears multiple times:

    ili9225 spi1.0: EOW timed out

Eventually, the system locks up without any additional errors.

Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi-omap2-mcspi.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2fd8881fcd65..5a3854ff2e08 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -306,7 +306,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
 	unsigned int wcnt;
-	int max_fifo_depth, bytes_per_word;
+	int max_fifo_depth, fifo_depth, bytes_per_word;
 	u32 chconf, xferlevel;
 
 	mcspi = spi_master_get_devdata(master);
@@ -322,6 +322,10 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
 
+		fifo_depth = gcd(t->len, max_fifo_depth);
+		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
+			goto disable_fifo;
+
 		wcnt = t->len / bytes_per_word;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
@@ -329,17 +333,16 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			xferlevel |= (bytes_per_word - 1) << 8;
+			xferlevel |= (fifo_depth - 1) << 8;
 		}
-
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			xferlevel |= bytes_per_word - 1;
+			xferlevel |= fifo_depth - 1;
 		}
 
 		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
 		mcspi_write_chconf0(spi, chconf);
-		mcspi->fifo_depth = max_fifo_depth;
+		mcspi->fifo_depth = fifo_depth;
 
 		return;
 	}
@@ -598,6 +601,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
+	u32			burst;
 	void __iomem		*chstat_reg;
 	void __iomem            *irqstat_reg;
 	int			wait_res;
@@ -617,14 +621,22 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	count = xfer->len;
+	burst = 1;
+
+	if (mcspi->fifo_depth > 0) {
+		if (count > mcspi->fifo_depth)
+			burst = mcspi->fifo_depth / es;
+		else
+			burst = count / es;
+	}
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = es;
-	cfg.dst_maxburst = es;
+	cfg.src_maxburst = burst;
+	cfg.dst_maxburst = burst;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.17.1

