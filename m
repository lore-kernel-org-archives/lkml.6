Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeERI5f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:57:35 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46740 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeERI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:57:28 -0400
X-Google-Smtp-Source: AB8JxZq0hOVGItC/jsH1cCdaJ7bnKo+QZHlDjnkvvCF3sSgtrLRGrBUE+GIMJLxm6OMvtvYVAfPKMw==
From: Lei YU <mine260309@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lei YU <mine260309@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] clk: aspeed: Add 24MHz fixed clock
Date: Fri, 18 May 2018 16:57:02 +0800
Message-Id: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 24MHz fixed clock.
This clock will be used for certain devices, e.g. pwm.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 drivers/clk/clk-aspeed.c                 | 9 ++++++++-
 include/dt-bindings/clock/aspeed-clock.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 5eb50c3..4664088 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/clock/aspeed-clock.h>
 
-#define ASPEED_NUM_CLKS		35
+#define ASPEED_NUM_CLKS		36
 
 #define ASPEED_RESET_CTRL	0x04
 #define ASPEED_CLK_SELECTION	0x08
@@ -474,6 +474,13 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
 
+	/* Fixed 24MHz clock */
+	hw = clk_hw_register_fixed_rate(NULL, "fixed-24m", "clkin",
+					0, 24000000);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
+
 	/*
 	 * TODO: There are a number of clocks that not included in this driver
 	 * as more information is required:
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index d3558d8..ff29d8e 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -38,6 +38,7 @@
 #define ASPEED_CLK_MAC			32
 #define ASPEED_CLK_BCLK			33
 #define ASPEED_CLK_MPLL			34
+#define ASPEED_CLK_24M			35
 
 #define ASPEED_RESET_XDMA		0
 #define ASPEED_RESET_MCTP		1
-- 
2.7.4
