Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17C1222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koGfxH8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfBMNJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:09:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46388 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388524AbfBMNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:09:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so1107047pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QcFdWQHjdu1mwrSFy/NEtDlZqRSzgcgUFSraxc9UEiM=;
        b=koGfxH8Ex+qosJuEYvhxVsCpO9+z5yuDeASESs2gedOD6YrCOuajZ9TIg3Mr8rfG0z
         O7zeUO2GGVldsi0pD8zo3EbnPSHk1n2Yw4zcmr7cuOeGMGPC4+R8CkSCya7/tkLbb4hu
         QCzhFNrCFIXNMzlkisprmzI3l26UeTny7T6SjaaEYOeXuAVOa23ybq3MYEbQweXXwND+
         XocyUVtKnXOVgb8cN8Rxyt6lvT/doZTcSX82vrazj4X+DRUsn7JdYkBRCm66zTislSS1
         2eLRYR3BMO8AzdMFMs7UyQGQvlya+4HxKDYftaOe7R6gi8y19a40ZeOWFHELYJAe8g5x
         5MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QcFdWQHjdu1mwrSFy/NEtDlZqRSzgcgUFSraxc9UEiM=;
        b=OcYgbuHNMoV22qVKtVQLRrzG1J90DZIiD2Foe/ueYJeP0Q+7YmH8fpgjLoKH5/iefR
         4cxRT1KAJejEBnNrQF+hEnh4fwMMzaFuYg/HqVky1zdVdNDGDOk71rXWa5U97WhBtlwn
         fqtV6UF31B+e1h/t5wybo/J4/JfnSWCYceuyQ8JQOBxztEzduhGGTr2e9NSvRv+Di1aE
         KHrZz96g84igSFBD6ZyfnFiFJc//tJXUA+GTNxsQUzKWqdpX5qolwLJIHdKHTDw9tNwl
         VfrnhSXg54uKCbSlqfiXko5NJpNpsyx94vT4WZJKzC+hj0mfrbN54RNm3vc8qTQdfnzt
         cOZQ==
X-Gm-Message-State: AHQUAuaXH6hLuJ/sszfbBcjLfNeInBNDtwQWBa+67n7O1A40uUhrJFiX
        EV2612KjQAJH8HItpjSnW1TbiQ==
X-Google-Smtp-Source: AHgI3IaQSNMA+yUhLBZE9E7PnmckFcqFQvmSE0Zb3cFc2NqvhJvhvb6h8Ssp/7/REF3QSgfr9pOI+w==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr352525pgi.361.1550063369412;
        Wed, 13 Feb 2019 05:09:29 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c23sm18740744pgh.73.2019.02.13.05.09.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 05:09:28 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sprd: Add a prefix for SPI DMA channel macros
Date:   Wed, 13 Feb 2019 21:08:16 +0800
Message-Id: <94b245cf862bddcbeba065b6adc3e20f4155bdca.1550063176.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a prefix for SPI DMA channel macros to avoid namespace conflicts,
and no functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 0c04a1d..1b7eebb 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -135,14 +135,14 @@
 #define SPRD_SPI_DMA_STEP		8
 
 enum sprd_spi_dma_channel {
-	SPI_RX,
-	SPI_TX,
-	SPI_MAX,
+	SPRD_SPI_RX,
+	SPRD_SPI_TX,
+	SPRD_SPI_MAX,
 };
 
 struct sprd_spi_dma {
 	bool enable;
-	struct dma_chan *dma_chan[SPI_MAX];
+	struct dma_chan *dma_chan[SPRD_SPI_MAX];
 	enum dma_slave_buswidth width;
 	u32 fragmens_len;
 	u32 rx_len;
@@ -516,7 +516,7 @@ static int sprd_spi_dma_submit(struct dma_chan *dma_chan,
 
 static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_RX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_RX];
 	struct dma_slave_config config = {
 		.src_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -534,7 +534,7 @@ static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_TX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_TX];
 	struct dma_slave_config config = {
 		.dst_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -552,23 +552,23 @@ static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_request(struct sprd_spi *ss)
 {
-	ss->dma.dma_chan[SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_RX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPI_RX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+	ss->dma.dma_chan[SPRD_SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
 
 		dev_err(ss->dev, "request RX DMA channel failed!\n");
-		return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
 	}
 
-	ss->dma.dma_chan[SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_TX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPI_TX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+	ss->dma.dma_chan[SPRD_SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_TX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 
 		dev_err(ss->dev, "request TX DMA channel failed!\n");
-		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
-		return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 	}
 
 	return 0;
@@ -576,11 +576,11 @@ static int sprd_spi_dma_request(struct sprd_spi *ss)
 
 static void sprd_spi_dma_release(struct sprd_spi *ss)
 {
-	if (ss->dma.dma_chan[SPI_RX])
-		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+	if (ss->dma.dma_chan[SPRD_SPI_RX])
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
 
-	if (ss->dma.dma_chan[SPI_TX])
-		dma_release_channel(ss->dma.dma_chan[SPI_TX]);
+	if (ss->dma.dma_chan[SPRD_SPI_TX])
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_TX]);
 }
 
 static int sprd_spi_dma_txrx_bufs(struct spi_device *sdev,
-- 
1.7.9.5

