Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE77CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6970C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+B+IElC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6970C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbeG0ULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:11:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43751 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389048AbeG0ULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:11:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so2673803plv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Omam1wZGPqzcV3XwslkPsL4Brev19/KvykBbYtjwDKo=;
        b=B+B+IElCkr/tQ85xZ6iBY8KMuapYu6tTxJohzROw8ij32WH9i3VE4ybzB4hNF3cMCn
         RxDBQmq/FX4QLceAcf95ujucmQg+g4wgVzJd/S4zP2ZYxq7/VxL9XmLBoDPsO+EkWwdx
         WDiNV6BXW8Yl0XozT1XAxlpXeR+50+DVewb5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Omam1wZGPqzcV3XwslkPsL4Brev19/KvykBbYtjwDKo=;
        b=qKT8cf/pzLFQCL2bNcO3YmaGewbKIE/EANSnjseMz5Aqo39p95reI+DwsvaU39f3PS
         j3Zq7x4d66OmfgMhr4LRrij2IA6fIPjFEq47WR+373XX0zNDvQesfGvPOt3gt4XoawWv
         zCh9ZLvqNLVqN7oSEgcYrpcDn+eEC5+WST+pxQPhQKTfg0uecRdq5G+/cqHHa2pVtfcF
         omxRSe7hKuh2HwQHJO4fFO06/MUpYt1xVZfCXr9VDq+oHM6k3KiKjUNwlvjqvjIKSdYG
         Dn9plGJu3ArlCNwui4I8XDvCm7Uk3AGQ2SBD7jY3MbOyAp9LKKGMNdMbexTAXXtSyoWx
         DP8g==
X-Gm-Message-State: AOUpUlHqt0MZgwArMO928/sJdppMtBBW0GUCNl+UxSgm/qlvdM0/Yyme
        7NfpAN4Pny1w8ChlRpJJCHiR
X-Google-Smtp-Source: AAOMgpdUhVBiv9JzqXmnry+GyCGCPEgeYgtkbMaQKHctzmexU7C2GVgG2GRPlI38D2jg7Qhsb8znXw==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7-v6mr7049061plm.90.1532717313435;
        Fri, 27 Jul 2018 11:48:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:48:32 -0700 (PDT)
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
Subject: [PATCH 9/9] clk: actions: Add Actions Semi S900 SoC Reset Management Unit support
Date:   Sat, 28 Jul 2018 00:15:27 +0530
Message-Id: <20180727184527.13287-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
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
index bb7ee872d316..4d38b1265cc3 100644
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
 
+static struct owl_reset_map s900_resets[] = {
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

