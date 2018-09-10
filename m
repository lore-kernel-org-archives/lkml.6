Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84809C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5C420833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MO6yuRou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5C420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeIJIqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:46:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36743 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeIJIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:46:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so9742527pgo.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SG8sWWsUdQ+QzU3DR1/zmYzm4TBejOsatzqsOC1dbUU=;
        b=MO6yuRoub75Fge2FUR3Cs2ems7spAWXzGd9SaUiZBClGnvR49R6YJ9Brtp2SDVgMPW
         CiUuNdukgcHa760+BJ9ijW+451d70oXLmmRC6Pzn+QKuEa3pgr1JQQ8Lf4JB/NUhRVY2
         4yopA2nD1m1eXShM3un2QoWBiHZviKyGDzVVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SG8sWWsUdQ+QzU3DR1/zmYzm4TBejOsatzqsOC1dbUU=;
        b=Y1ry6SkZRzpjAx4cLMJ+OoTY4T0Aiu8xOAPAcCGOyQ/xUAKWHh8rfWxgm+UrcZ/Txk
         Zv6rXSZus5UyY8Qy09WleG8s5+ls+dshOaF3pADq+llQhqD2Rnhr4S3F3MOYA31LezR0
         Ccm3GFpOf6SBKN+n8rvEvveJlEqgO2Ju/U2lh5REooOiPRoxUg16gJSgdZg+yeFnWoQO
         vPqiIpvIQW7s3SDJHvM5O3PuP8ne54KKPxlMRe+uq7mvpJ8TrIdlMJ/XFJWNmKTUSUnl
         8JA5mYWprJzI540Iq/rXShrD86o6qN8Bi9S2SNLYBTDJliBQLiDgtJJ2/fkbbhKh0rco
         iTUg==
X-Gm-Message-State: APzg51D40G7eBedcRQiJB4uf12QW1VuGIFt+gt98lGaNoCxOkMa5cpbT
        x0ojepUVnR9/X1z9KKKeToHAkA==
X-Google-Smtp-Source: ANB0Vdahp8iBOTB20SkX/l621r8+oWce7o4T17Syo965DCVzreBhpQTFFHxMSeTEldc+fcdYja+JCg==
X-Received: by 2002:a63:d150:: with SMTP id c16-v6mr20549007pgj.188.1536551666605;
        Sun, 09 Sep 2018 20:54:26 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id m21-v6sm20223932pgd.6.2018.09.09.20.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 20:54:25 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     pihsun@chromium.org, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] spi: mediatek: Don't modify spi_transfer when transfer.
Date:   Mon, 10 Sep 2018 11:54:21 +0800
Message-Id: <20180910035421.101505-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180910035047.98496-1-pihsun@chromium.org>
References: <20180910035047.98496-1-pihsun@chromium.org>
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

Change-Id: I23e218cd964f16c0b2b26127d4a5ca6529867673
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

