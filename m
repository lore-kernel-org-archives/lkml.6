Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B578C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F9205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+GR4lGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081F9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbeG0ULc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:11:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33918 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389048AbeG0ULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:11:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3728458pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QH1TTvPQlofOSOVaK9da0D5f9V4qdv+e+owka7pRNb0=;
        b=K+GR4lGWhCuXX4ELqS31FNL13z25WRQ7VS/eNMPYgXPTwhv1YkoyfpsLR9DpEvOo9o
         lhMLFVSEWikYTf4yOYldjoauk0MzTMumZFDjftJPCDxp49E6ZWmAp/ZpfiAYTPFhx5LT
         zlXnykV5kOGFIMQpWcBXlJnc5j/+p/ecBVavc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QH1TTvPQlofOSOVaK9da0D5f9V4qdv+e+owka7pRNb0=;
        b=fkCooeMbBIv2aK3+uVSSTlrS8Pp7gfmMs9rmDuE3km8/QBJ+9Adcs8IGWFSbcwbhD2
         wJCszcYFS+tzuxiLDnaICLujC8MMpdNM+U5oQLRWChxRFcA6zFre0CYX3IDfvbefVLB2
         U6mY0mFJEvHI8iUvTG68M58mEtHucP3R1lG9fneO/F+rN7lY18cqfd7j61XaPvo3QblD
         7Z6v+J0qMX4haGHOO4GbZZ4H87O+pfCbwiuYo3tzM143PxPmMr1iOw+tVGwr0Wk+05SP
         h0mXpwWT7SBb1DeePQUkIg1yfPa5CceyNp2umGduY9Qxk1YUqHFcYqa76X6157Kac4BL
         w8Ww==
X-Gm-Message-State: AOUpUlGcY8mZ6Hf++6xbFAAEzAgZMiUHk9SQAde56XFa71lXC/W7Difb
        KjWOjTw2T98FZZQnpUbNDhUY
X-Google-Smtp-Source: AAOMgpdcBx/8qF+RYVNCmpFOMyaZgzoxbcJu5B1O5c2x31rjy6MGJTnbMQCCVxmmhPsgmJv+dS4DGQ==
X-Received: by 2002:a63:d20e:: with SMTP id a14-v6mr7134377pgg.226.1532717301498;
        Fri, 27 Jul 2018 11:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:48:21 -0700 (PDT)
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
Subject: [PATCH 8/9] clk: actions: Add Actions Semi S700 SoC Reset Management Unit support
Date:   Sat, 28 Jul 2018 00:15:26 +0530
Message-Id: <20180727184527.13287-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
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
index e7cacd677275..d9c0c7870135 100644
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
 
+static struct owl_reset_map s700_resets[] = {
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

