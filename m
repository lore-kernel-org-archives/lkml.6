Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B6C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683320868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbwL7OIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfAONri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:47:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44207 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfAONrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:47:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so1309755plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GIat+m7TznQx8UqrqhXybGFDW6VxagwmUZvqdNg8Le4=;
        b=QbwL7OIuq4ceJmrG67XvLj+83iRkmvqiwrpIqGlTOJMgyzpbVQ0RIfI5ClhQBjFYy4
         mxXhT8GypbIpFBQnojSCxf+HgWsTnyvcFMBKGgM0cIrhVNH6rYmtZygDSL/QWGQDFW4v
         ndaScbK8r3kkDsYP6QOmcYlYpB6lIfgU2R4F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GIat+m7TznQx8UqrqhXybGFDW6VxagwmUZvqdNg8Le4=;
        b=EMKRrjIrp/TFZ8/34YdhJPS3ZKG/RT903b4eUIAATtGKMAcszkThZ4gE1GreNmYime
         Q37w6p9uoxoTZWgFqmmu0Bb02tAqhMDolDhW3rRQNF12esRECVrC+0L+v7j3A7uXyb68
         PsVv0+j2vFtaBybF6rK8lz7ILuJUkK9H5lr5o0sPgGdGXUAfcvSMBmK4p/WxvrjCOCiu
         uOpOlMZR0g4RLtgpSD6l94e5WQhWBQ8U8eY9x9u8td8Q0qgQtxh+CHitYMnVgqmHWeh4
         9cjdrIk/JVaDJ7SknTCChfNbB3FS9hDnqvV+Vri7RKzIpkafcHrFmU7F40ozCu6uZ+KQ
         b7VA==
X-Gm-Message-State: AJcUukc1+LOxSzN/8YHpppDvf+7I81sCpFOj8b9giQMQZf0NHIG4DDaw
        cntTQpdBvqmnoUCJfPZtc8aq/w==
X-Google-Smtp-Source: ALg8bN4DY4mSSjU73fn+Ma1FdQU680FbM1BHklCfMf7oPqbYFy0t5n+YpVzgnQ/tnTd02uA6z98csA==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr4261570plb.296.1547560056264;
        Tue, 15 Jan 2019 05:47:36 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y71sm5979422pfi.123.2019.01.15.05.47.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 05:47:35 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] spi: sprd: Add the SPI irq function for the SPI DMA mode
Date:   Tue, 15 Jan 2019 21:46:51 +0800
Message-Id: <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

The SPI irq event will use to complete the SPI work in the SPI DMA mode,
so this patch is a preparation for the following DMA mode support.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index fa324ce..bfba30b 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -133,6 +133,7 @@ struct sprd_spi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *clk;
+	int irq;
 	u32 src_clk;
 	u32 hw_mode;
 	u32 trans_len;
@@ -141,6 +142,7 @@ struct sprd_spi {
 	u32 hw_speed_hz;
 	u32 len;
 	int status;
+	struct completion xfer_completion;
 	const void *tx_buf;
 	void *rx_buf;
 	int (*read_bufs)(struct sprd_spi *ss, u32 len);
@@ -575,6 +577,45 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
 	return ret;
 }
 
+static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
+{
+	struct sprd_spi *ss = (struct sprd_spi *)data;
+	u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
+
+	if (val & SPRD_SPI_MASK_TX_END) {
+		writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
+			complete(&ss->xfer_completion);
+		return IRQ_HANDLED;
+	}
+
+	if (val & SPRD_SPI_MASK_RX_END) {
+		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		complete(&ss->xfer_completion);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
+{
+	int ret;
+
+	ss->irq = platform_get_irq(pdev, 0);
+	if (ss->irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq resource\n");
+		return ss->irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
+				0, pdev->name, ss);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
+			ss->irq, ret);
+
+	return ret;
+}
+
 static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
 {
 	struct clk *clk_spi, *clk_parent;
@@ -635,11 +676,16 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	sctlr->max_speed_hz = min_t(u32, ss->src_clk >> 1,
 				    SPRD_SPI_MAX_SPEED_HZ);
 
+	init_completion(&ss->xfer_completion);
 	platform_set_drvdata(pdev, sctlr);
 	ret = sprd_spi_clk_init(pdev, ss);
 	if (ret)
 		goto free_controller;
 
+	ret = sprd_spi_irq_init(pdev, ss);
+	if (ret)
+		goto free_controller;
+
 	ret = clk_prepare_enable(ss->clk);
 	if (ret)
 		goto free_controller;
-- 
1.7.9.5

