Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFF5C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15392223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4q/EnaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15392223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeHJMW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:22:56 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46475 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:22:56 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so3831676ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MBvuFBV5qOIqECOgSkO0pJBwuy9QapS51eF1dTzfyKM=;
        b=X4q/EnaTj5HPDdqWNia1bWuuReYbl+ISTTpJpcQL0Px9yOKJyvqbL3y8BKgH5NEw8g
         lG7qOQbIDSose8IC/UeflAyQdAA9yPLA+q4RRZ05cotp5LAB+0m5Opq+WVVQ5aTzfxiz
         K20bv7LfFQ8IqGNOquTEmbDnw9A8/N9AFQgPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MBvuFBV5qOIqECOgSkO0pJBwuy9QapS51eF1dTzfyKM=;
        b=YSDi1gRd+zb8PWpAB6VIRRdNMdMSHNQ2rVThrH+4uqDPqRTklCITFFvAUaAixmeIn/
         A1xeCt+8VQovpjhpIi80tMcAGMgnYnrSirQ0W6EiWuvOJuTY1VVroKwsW5sKSC1oxm3M
         zCRjagBwh2thtDM13XRG59w8jUJ8OIIzG40anAqgAZG/28B+rU6mI1xL9EvPlsvUNyg7
         B7GkDMVx43CP0P5KKntdiGxcd6WBTRePYivW8o0CiPbyys6A+uFT67As5s8n96lB+Sfr
         HHusBPpl/8osIvA+XXUb/5ftqCiQt4u5gGtbFhayvVkpIcwP4DKv2ZjD6sy0/dG1jKLR
         K7hA==
X-Gm-Message-State: AOUpUlHOWfgcOwLi9x+RoJHb0noFG0KCAYjs46O9X0el2jk5N6R3GMpe
        oQke82Pqkha+8Mp5ogXYY/MM
X-Google-Smtp-Source: AA+uWPxk3BqsozV5EVOJ5H2WeVSHGJMAqIkpGgRSuZHVJnEQ6aiLOkRl1Cwzww9uWeC5/EQjM/mWag==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr5446981pls.233.1533894827058;
        Fri, 10 Aug 2018 02:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:53:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 8/9] clk: actions: Add Actions Semi S700 SoC Reset Management Unit support
Date:   Fri, 10 Aug 2018 15:21:12 +0530
Message-Id: <20180810095113.25292-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi S700 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-s700.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index e7cacd677275..a2f34d13fb54 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -20,8 +20,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/reset/actions,s700-reset.h>
 
 #define CMU_COREPLL		(0x0000)
 #define CMU_DEVPLL		(0x0004)
@@ -569,20 +571,69 @@ static struct clk_hw_onecell_data s700_hw_clks = {
 		.num    = CLK_NR_CLKS,
 };
 
+static const struct owl_reset_map s700_resets[] = {
+	[RESET_DE]	= { CMU_DEVRST0, BIT(0) },
+	[RESET_LCD0]	= { CMU_DEVRST0, BIT(1) },
+	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
+	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
+	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
+	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
+	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
+	[RESET_I2C3]	= { CMU_DEVRST1, BIT(3) },
+	[RESET_SPI0]	= { CMU_DEVRST1, BIT(4) },
+	[RESET_SPI1]	= { CMU_DEVRST1, BIT(5) },
+	[RESET_SPI2]	= { CMU_DEVRST1, BIT(6) },
+	[RESET_SPI3]	= { CMU_DEVRST1, BIT(7) },
+	[RESET_UART0]	= { CMU_DEVRST1, BIT(8) },
+	[RESET_UART1]	= { CMU_DEVRST1, BIT(9) },
+	[RESET_UART2]	= { CMU_DEVRST1, BIT(10) },
+	[RESET_UART3]	= { CMU_DEVRST1, BIT(11) },
+	[RESET_UART4]	= { CMU_DEVRST1, BIT(12) },
+	[RESET_UART5]	= { CMU_DEVRST1, BIT(13) },
+	[RESET_UART6]	= { CMU_DEVRST1, BIT(14) },
+	[RESET_KEY]	= { CMU_DEVRST1, BIT(24) },
+	[RESET_GPIO]	= { CMU_DEVRST1, BIT(25) },
+	[RESET_AUDIO]	= { CMU_DEVRST1, BIT(29) },
+};
+
 static struct owl_clk_desc s700_clk_desc = {
 	.clks       = s700_clks,
 	.num_clks   = ARRAY_SIZE(s700_clks),
 
 	.hw_clks    = &s700_hw_clks,
+
+	.resets     = s700_resets,
+	.num_resets = ARRAY_SIZE(s700_resets),
 };
 
 static int s700_clk_probe(struct platform_device *pdev)
 {
 	struct owl_clk_desc *desc;
+	struct owl_reset *reset;
+	int ret;
 
 	desc = &s700_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
 
+	/*
+	 * FIXME: Reset controller registration should be moved to
+	 * common code, once all SoCs of Owl family supports it.
+	 */
+	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->rcdev.of_node = pdev->dev.of_node;
+	reset->rcdev.ops = &owl_reset_ops;
+	reset->rcdev.nr_resets = desc->num_resets;
+	reset->reset_map = desc->resets;
+	reset->regmap = desc->regmap;
+
+	ret = devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register reset controller\n");
+
 	return owl_clk_probe(&pdev->dev, desc->hw_clks);
 }
 
-- 
2.17.1

