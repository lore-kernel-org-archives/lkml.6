Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F569C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4D2186D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2ls3ngv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE4D2186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeHJMXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:23:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45955 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeHJMXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:23:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so4151395pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TsC3y/G7oQrGj1na8agCg1YEKCvMhOLYf1w2f0QIgow=;
        b=k2ls3ngvhKez/iIT7iQbrKYPZcPToXYYSyVqHh2MPQtpgeDIyc9RSmzrgPPMSS3yTo
         /CWX/d/gm3y4XxUz6gfAHQQtVTNZrIao9rQd2mZn2yUI1OJnzA62hkyfx77uV0CqqlG9
         CmqVEVYb5TNLa7o5w2QoLg50WmHtgOd5GJmhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TsC3y/G7oQrGj1na8agCg1YEKCvMhOLYf1w2f0QIgow=;
        b=ac1e73lZP0SgsujeAU7CqEI9YkQ68LNgmOCjvaVVgLXiteIc9gkklMqaTc9zFalxGs
         HYq6+sx4cZPxt8EQHZte3VSfKmoeWcswNnM8a7wf1TQtJMoK8WIa1q1fIvSotGFInDoO
         a7OcDRE4rdWy4tQmu5P5ZcaB5qvipLtcsIk2HZni1w9QIt9y1OGVxR6TAuAwRmBAbcqa
         B26OM2wJpAG07ZCIzxnno+r77GKke605LL8lsi5c3RyGI8hcSwpDf2OVOyl6QlQ8Qg1k
         PoShvHJDF0SgoxVYTIRTkNhVeT2K/yY9g+YwXFWdwlE177cf2aiLKnabY3b+rDwrYNQP
         kflw==
X-Gm-Message-State: AOUpUlF14qiMQDFHchXaRzrHG1lIEChUCgWUHqrOFqOt44eZDvYDg2WW
        IMNz3HWH59B2ksym/g18PHG+
X-Google-Smtp-Source: AA+uWPwX6gRRlASaOu/1aJ/Uo7aPaNRECLXNzFnMBT58Fg0tnvc1gVPiJxTRe2+52sgUKUld2430wQ==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr5889608pgf.25.1533894837385;
        Fri, 10 Aug 2018 02:53:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:53:56 -0700 (PDT)
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
Subject: [PATCH v3 9/9] clk: actions: Add Actions Semi S900 SoC Reset Management Unit support
Date:   Fri, 10 Aug 2018 15:21:13 +0530
Message-Id: <20180810095113.25292-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-s900.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
index bb7ee872d316..790890978424 100644
--- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -19,8 +19,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
+#include <dt-bindings/reset/actions,s900-reset.h>
 
 #define CMU_COREPLL		(0x0000)
 #define CMU_DEVPLL		(0x0004)
@@ -684,20 +686,100 @@ static struct clk_hw_onecell_data s900_hw_clks = {
 	.num	= CLK_NR_CLKS,
 };
 
+static const struct owl_reset_map s900_resets[] = {
+	[RESET_DMAC]		= { CMU_DEVRST0, BIT(0) },
+	[RESET_SRAMI]		= { CMU_DEVRST0, BIT(1) },
+	[RESET_DDR_CTL_PHY]	= { CMU_DEVRST0, BIT(2) },
+	[RESET_NANDC0]		= { CMU_DEVRST0, BIT(3) },
+	[RESET_SD0]		= { CMU_DEVRST0, BIT(4) },
+	[RESET_SD1]		= { CMU_DEVRST0, BIT(5) },
+	[RESET_PCM1]		= { CMU_DEVRST0, BIT(6) },
+	[RESET_DE]		= { CMU_DEVRST0, BIT(7) },
+	[RESET_LVDS]		= { CMU_DEVRST0, BIT(8) },
+	[RESET_SD2]		= { CMU_DEVRST0, BIT(9) },
+	[RESET_DSI]		= { CMU_DEVRST0, BIT(10) },
+	[RESET_CSI0]		= { CMU_DEVRST0, BIT(11) },
+	[RESET_BISP_AXI]	= { CMU_DEVRST0, BIT(12) },
+	[RESET_CSI1]		= { CMU_DEVRST0, BIT(13) },
+	[RESET_GPIO]		= { CMU_DEVRST0, BIT(15) },
+	[RESET_EDP]		= { CMU_DEVRST0, BIT(16) },
+	[RESET_AUDIO]		= { CMU_DEVRST0, BIT(17) },
+	[RESET_PCM0]		= { CMU_DEVRST0, BIT(18) },
+	[RESET_HDE]		= { CMU_DEVRST0, BIT(21) },
+	[RESET_GPU3D_PA]	= { CMU_DEVRST0, BIT(22) },
+	[RESET_IMX]		= { CMU_DEVRST0, BIT(23) },
+	[RESET_SE]		= { CMU_DEVRST0, BIT(24) },
+	[RESET_NANDC1]		= { CMU_DEVRST0, BIT(25) },
+	[RESET_SD3]		= { CMU_DEVRST0, BIT(26) },
+	[RESET_GIC]		= { CMU_DEVRST0, BIT(27) },
+	[RESET_GPU3D_PB]	= { CMU_DEVRST0, BIT(28) },
+	[RESET_DDR_CTL_PHY_AXI]	= { CMU_DEVRST0, BIT(29) },
+	[RESET_CMU_DDR]		= { CMU_DEVRST0, BIT(30) },
+	[RESET_DMM]		= { CMU_DEVRST0, BIT(31) },
+	[RESET_USB2HUB]		= { CMU_DEVRST1, BIT(0) },
+	[RESET_USB2HSIC]	= { CMU_DEVRST1, BIT(1) },
+	[RESET_HDMI]		= { CMU_DEVRST1, BIT(2) },
+	[RESET_HDCP2TX]		= { CMU_DEVRST1, BIT(3) },
+	[RESET_UART6]		= { CMU_DEVRST1, BIT(4) },
+	[RESET_UART0]		= { CMU_DEVRST1, BIT(5) },
+	[RESET_UART1]		= { CMU_DEVRST1, BIT(6) },
+	[RESET_UART2]		= { CMU_DEVRST1, BIT(7) },
+	[RESET_SPI0]		= { CMU_DEVRST1, BIT(8) },
+	[RESET_SPI1]		= { CMU_DEVRST1, BIT(9) },
+	[RESET_SPI2]		= { CMU_DEVRST1, BIT(10) },
+	[RESET_SPI3]		= { CMU_DEVRST1, BIT(11) },
+	[RESET_I2C0]		= { CMU_DEVRST1, BIT(12) },
+	[RESET_I2C1]		= { CMU_DEVRST1, BIT(13) },
+	[RESET_USB3]		= { CMU_DEVRST1, BIT(14) },
+	[RESET_UART3]		= { CMU_DEVRST1, BIT(15) },
+	[RESET_UART4]		= { CMU_DEVRST1, BIT(16) },
+	[RESET_UART5]		= { CMU_DEVRST1, BIT(17) },
+	[RESET_I2C2]		= { CMU_DEVRST1, BIT(18) },
+	[RESET_I2C3]		= { CMU_DEVRST1, BIT(19) },
+	[RESET_ETHERNET]	= { CMU_DEVRST1, BIT(20) },
+	[RESET_CHIPID]		= { CMU_DEVRST1, BIT(21) },
+	[RESET_I2C4]		= { CMU_DEVRST1, BIT(22) },
+	[RESET_I2C5]		= { CMU_DEVRST1, BIT(23) },
+	[RESET_CPU_SCNT]	= { CMU_DEVRST1, BIT(30) }
+};
+
 static struct owl_clk_desc s900_clk_desc = {
 	.clks	    = s900_clks,
 	.num_clks   = ARRAY_SIZE(s900_clks),
 
 	.hw_clks    = &s900_hw_clks,
+
+	.resets     = s900_resets,
+	.num_resets = ARRAY_SIZE(s900_resets),
 };
 
 static int s900_clk_probe(struct platform_device *pdev)
 {
 	struct owl_clk_desc *desc;
+	struct owl_reset *reset;
+	int ret;
 
 	desc = &s900_clk_desc;
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

