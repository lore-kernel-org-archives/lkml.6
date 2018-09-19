Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAA3ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E3E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPxpUv9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E3E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeISMGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:06:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37339 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeISMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:06:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so2206864pfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UxYp9Fd6cQxttmxSAWHS+kOvGw5onYHLG7nB8EqH7I=;
        b=iPxpUv9YM2oQncReLzlo1rl/sWHUju78qzBVX/OAYcoi1eagyg98xgBQ3+5oJL3iaW
         GWV96pP18tXwXLAhmmMo4E2ljmlQ9GOywT5iMouqVC5TGpl/3qsrfYiTABeNpK36dz/x
         Z+1kO/OV3kNgeoxtFE7+vsr9OWrxJo1PzJT2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UxYp9Fd6cQxttmxSAWHS+kOvGw5onYHLG7nB8EqH7I=;
        b=jTPaUseCch6kIcnw1QhXxN03amXlI9oRu4YeYT3kZbjZHkJft/BZbEVZCAZKz8ZqvN
         f7+m+TwTcs4kQgk1P4F43gSjaPvgXLutWBdLRQtdqkzS+HmpPn7ivIiVISVf668lW4AS
         riWmWlw7+ubFdTWphMzFnfSzhGK4i396mWQxHl8SJ4j2g/nl1a9zQHE1mEoNgcIa8sEA
         WCvV/hjL/q76jaOGWbsDSXucEE5wK5r+pSZTIYbQMyAZoxPuOTs5thG62qPQV5nIF61p
         xCijhdWTPW0hc7ubGJM+oyz8p+JEe7t2jCIjllEIZq8xHLY54qhh33s7I7uwKNogAKe3
         BuCw==
X-Gm-Message-State: APzg51D8qnqVrgmmwu0qjtPTHprQqi4SJZsCiwtQxfhXjqQ3lfoooJHr
        ia5hwkAFXXCrhXKIdo2DLx3Y2g==
X-Google-Smtp-Source: ANB0VdZc+2gPVF+SaGBErUHPlMfEpvdDJvd8gWELQlNaZib6i7Gt+oXWyvy0syRfyje1OQLWJExlUg==
X-Received: by 2002:a63:e54b:: with SMTP id z11-v6mr30498558pgj.328.1537338620266;
        Tue, 18 Sep 2018 23:30:20 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:1039:d81d:d174:8fe9])
        by smtp.googlemail.com with ESMTPSA id y7-v6sm37188874pff.181.2018.09.18.23.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:30:19 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     pihsun@chromium.org, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] spi: mediatek: Don't modify spi_transfer when transfer.
Date:   Wed, 19 Sep 2018 14:29:27 +0800
Message-Id: <20180919062928.238917-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918161504.GM2471@sirena.org.uk>
References: <20180918161504.GM2471@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek SPI driver modifies some fields (tx_buf, rx_buf, len, tx_dma,
rx_dma) of the spi_transfer* passed in when doing transfer_one and in
interrupt handler. This is somewhat unexpected, and there are some
caller (e.g. Cr50 spi driver) that reuse the spi_transfer for multiple
messages. Add a field to record how many bytes have been transferred,
and calculate the right len / buffer based on it instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/spi/spi-mt65xx.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 86bf45667a040..3dc31627c6558 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -98,6 +98,7 @@ struct mtk_spi {
 	struct clk *parent_clk, *sel_clk, *spi_clk;
 	struct spi_transfer *cur_transfer;
 	u32 xfer_len;
+	u32 num_xfered;
 	struct scatterlist *tx_sgl, *rx_sgl;
 	u32 tx_sgl_len, rx_sgl_len;
 	const struct mtk_spi_compatible *dev_comp;
@@ -385,6 +386,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 
 	mdata->cur_transfer = xfer;
 	mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, xfer->len);
+	mdata->num_xfered = 0;
 	mtk_spi_prepare_transfer(master, xfer);
 	mtk_spi_setup_packet(master);
 
@@ -415,6 +417,7 @@ static int mtk_spi_dma_transfer(struct spi_master *master,
 	mdata->tx_sgl_len = 0;
 	mdata->rx_sgl_len = 0;
 	mdata->cur_transfer = xfer;
+	mdata->num_xfered = 0;
 
 	mtk_spi_prepare_transfer(master, xfer);
 
@@ -482,7 +485,7 @@ static int mtk_spi_setup(struct spi_device *spi)
 
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
-	u32 cmd, reg_val, cnt, remainder;
+	u32 cmd, reg_val, cnt, remainder, len;
 	struct spi_master *master = dev_id;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	struct spi_transfer *trans = mdata->cur_transfer;
@@ -497,36 +500,38 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		if (trans->rx_buf) {
 			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
-				     trans->rx_buf, cnt);
+				     trans->rx_buf + mdata->num_xfered, cnt);
 			remainder = mdata->xfer_len % 4;
 			if (remainder > 0) {
 				reg_val = readl(mdata->base + SPI_RX_DATA_REG);
-				memcpy(trans->rx_buf + (cnt * 4),
-					&reg_val, remainder);
+				memcpy(trans->rx_buf +
+					mdata->num_xfered +
+					(cnt * 4),
+					&reg_val,
+					remainder);
 			}
 		}
 
-		trans->len -= mdata->xfer_len;
-		if (!trans->len) {
+		mdata->num_xfered += mdata->xfer_len;
+		if (mdata->num_xfered == trans->len) {
 			spi_finalize_current_transfer(master);
 			return IRQ_HANDLED;
 		}
 
-		if (trans->tx_buf)
-			trans->tx_buf += mdata->xfer_len;
-		if (trans->rx_buf)
-			trans->rx_buf += mdata->xfer_len;
-
-		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, trans->len);
+		len = trans->len - mdata->num_xfered;
+		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = trans->len / 4;
-		iowrite32_rep(mdata->base + SPI_TX_DATA_REG, trans->tx_buf, cnt);
+		cnt = len / 4;
+		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
+				trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = trans->len % 4;
+		remainder = len % 4;
 		if (remainder > 0) {
 			reg_val = 0;
-			memcpy(&reg_val, trans->tx_buf + (cnt * 4), remainder);
+			memcpy(&reg_val,
+				trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+				remainder);
 			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
 		}
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

