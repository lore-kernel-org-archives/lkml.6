Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2569EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB2C20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="CeXwZIBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBAGgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:36:23 -0500
Received: from forward101o.mail.yandex.net ([37.140.190.181]:47223 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfBAGgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:36:22 -0500
Received: from mxback23g.mail.yandex.net (mxback23g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:323])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id EF7183C018E5;
        Fri,  1 Feb 2019 09:36:16 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback23g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id v0pvFYIGtX-aGS01h9u;
        Fri, 01 Feb 2019 09:36:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002976;
        bh=vKyFdvgXMOy7XUNRn+kBFtSzywE4LMaWer9HOdvwdrM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=CeXwZIBt+PSQW/AkY9XmJMdScWX+mN1yBc84uRau/NTvpbnX1g0zigO3Vkbzi2i/E
         uNhUTLxx/eNvSFTs8uLKA01XcQAG6GU42YZtgrC5eETC9izPoaK3OvWwDGSoqyEvU9
         OdQSp9BdsXwapk0btcIKQ63Uug5jJu/lT7XQXL1k=
Authentication-Results: mxback23g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5VfXSCstdQ-a8VOl154;
        Fri, 01 Feb 2019 09:36:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 2/3] clk: loongson1: add of support
Date:   Fri,  1 Feb 2019 14:35:39 +0800
Message-Id: <20190201063540.19636-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201063540.19636-1-jiaxun.yang@flygoat.com>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
 <20190201063540.19636-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add of support by split the clk_hw register and
clkdev register, then handle the of clk_hw via
of_clk_hw_onecell_get.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/clk/loongson1/clk-loongson1b.c | 197 ++++++++++++++++++++-----
 drivers/clk/loongson1/clk-loongson1c.c | 164 +++++++++++++++-----
 drivers/clk/loongson1/clk.c            |  47 +++++-
 drivers/clk/loongson1/clk.h            |  18 ++-
 4 files changed, 343 insertions(+), 83 deletions(-)

diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
index f36a97e993c0..2148df31db15 100644
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
  */
 
 #include <linux/clkdev.h>
@@ -12,11 +9,41 @@
 #include <linux/io.h>
 #include <linux/err.h>
 
-#include <loongson1.h>
 #include "clk.h"
+#include <dt-bindings/clock/ls1b-clock.h>
+
+#define LS1B_CLK_COUNT	9
 
-#define OSC		(33 * 1000000)
 #define DIV_APB		2
+/* Clock PLL Divisor Register Bits */
+#define DIV_DC_EN			BIT(31)
+#define DIV_DC_RST			BIT(30)
+#define DIV_CPU_EN			BIT(25)
+#define DIV_CPU_RST			BIT(24)
+#define DIV_DDR_EN			BIT(19)
+#define DIV_DDR_RST			BIT(18)
+#define RST_DC_EN			BIT(5)
+#define RST_DC				BIT(4)
+#define RST_DDR_EN			BIT(3)
+#define RST_DDR				BIT(2)
+#define RST_CPU_EN			BIT(1)
+#define RST_CPU				BIT(0)
+
+#define DIV_DC_SHIFT			26
+#define DIV_CPU_SHIFT			20
+#define DIV_DDR_SHIFT			14
+
+#define DIV_DC_WIDTH			4
+#define DIV_CPU_WIDTH			4
+#define DIV_DDR_WIDTH			4
+
+#define BYPASS_DC_SHIFT			12
+#define BYPASS_DDR_SHIFT		10
+#define BYPASS_CPU_SHIFT		8
+
+#define BYPASS_DC_WIDTH			1
+#define BYPASS_DDR_WIDTH		1
+#define BYPASS_CPU_WIDTH		1
 
 static DEFINE_SPINLOCK(_lock);
 
@@ -25,9 +52,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 {
 	u32 pll, rate;
 
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+	pll = __raw_readl(CLK_PLL_FREQ_ADDR);
 	rate = 12 + (pll & GENMASK(5, 0));
-	rate *= OSC;
+	rate *= parent_rate;
 	rate >>= 1;
 
 	return rate;
@@ -37,21 +64,29 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static const char *const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
-static const char *const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
-static const char *const dc_parents[] = { "dc_clk_div", "osc_clk", };
 
-void __init ls1x_clk_init(void)
+struct clk_hw_onecell_data __init *ls1b_clk_init_hw(const char *osc_name)
 {
 	struct clk_hw *hw;
+	struct clk_hw_onecell_data *onecell;
+	const char *parents[2];
+
+	onecell = kzalloc(sizeof(*onecell) +
+			  (LS1B_CLK_COUNT * sizeof(struct clk_hw *)),
+			  GFP_KERNEL);
+
+	if (!onecell)
+		return NULL;
 
-	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_clk", NULL);
+	onecell->num = LS1B_CLK_COUNT;
 
+	parents[1] = osc_name;
 	/* clock derived from 33 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
+	hw = clk_hw_register_pll(NULL, "pll_clk", osc_name,
 				 &ls1x_pll_clk_ops, 0);
-	clk_hw_register_clkdev(hw, "pll_clk", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_PLL] = hw;
 
 	/* clock derived from PLL clk */
 	/*                                 _____
@@ -61,16 +96,22 @@ void __init ls1x_clk_init(void)
 	 *                                |_____|
 	 */
 	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
+				   CLK_GET_RATE_NOCACHE, CLK_PLL_DIV_ADDR,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
 				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "cpu_clk", cpu_parents,
-			       ARRAY_SIZE(cpu_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_CPU_DIV] = hw;
+
+	parents[0] = "cpu_clk_div";
+	hw = clk_hw_register_mux(NULL, "cpu_clk", parents,
+			       ARRAY_SIZE(parents),
+			       CLK_SET_RATE_NO_REPARENT, CLK_PLL_DIV_ADDR,
 			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_CPU] = hw;
 
 	/*                                 _____
 	 *         _______________________|     |
@@ -79,14 +120,20 @@ void __init ls1x_clk_init(void)
 	 *                                |_____|
 	 */
 	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+				   0, CLK_PLL_DIV_ADDR, DIV_DC_SHIFT,
 				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "dc_clk", dc_parents,
-			       ARRAY_SIZE(dc_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_DC_DIV] = hw;
+
+	parents[0] = "dc_clk_div";
+	hw = clk_hw_register_mux(NULL, "dc_clk", parents,
+			       ARRAY_SIZE(parents),
+			       CLK_SET_RATE_NO_REPARENT, CLK_PLL_DIV_ADDR,
 			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_DC] = hw;
 
 	/*                                 _____
 	 *         _______________________|     |
@@ -94,23 +141,76 @@ void __init ls1x_clk_init(void)
 	 *        \___ PLL ___ DDR DIV ___|     |
 	 *                                |_____|
 	 */
-	hw = clk_hw_register_divider(NULL, "ahb_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
+	hw = clk_hw_register_divider(NULL, "ddr_clk_div", "pll_clk",
+				   0, CLK_PLL_DIV_ADDR, DIV_DDR_SHIFT,
 				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
 				   &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "ahb_clk", ahb_parents,
-			       ARRAY_SIZE(ahb_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_DDR_DIV] = hw;
+
+	parents[0] = "ddr_clk_div";
+	hw = clk_hw_register_mux(NULL, "ddr_clk", parents,
+			       ARRAY_SIZE(parents),
+			       CLK_SET_RATE_NO_REPARENT, CLK_PLL_DIV_ADDR,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
-	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_DDR] = hw;
+
+	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ddr_clk", 0, 1,
+					1);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_AHB] = hw;
 
 	/* clock derived from AHB clk */
 	/* APB clk is always half of the AHB clk */
 	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
 					DIV_APB);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1B_CLK_APB] = hw;
+
+	return onecell;
+
+err:
+	kfree(onecell);
+	return NULL;
+}
+
+void __maybe_unused __init ls1b_register_clkdev(struct clk_hw_onecell_data *onecell)
+{
+	struct clk_hw *hw;
+
+	hw = onecell->hws[LS1B_CLK_PLL];
+	clk_hw_register_clkdev(hw, "pll_clk", NULL);
+
+	hw = onecell->hws[LS1B_CLK_CPU_DIV];
+	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
+
+	hw = onecell->hws[LS1B_CLK_CPU];
+	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
+
+
+	hw = onecell->hws[LS1B_CLK_DC_DIV];
+	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
+
+	hw = onecell->hws[LS1B_CLK_DC];
+	clk_hw_register_clkdev(hw, "dc_clk", NULL);
+
+	hw = onecell->hws[LS1B_CLK_DDR_DIV];
+	clk_hw_register_clkdev(hw, "ddr_clk_div", NULL);
+
+	hw = onecell->hws[LS1B_CLK_DDR];
+	clk_hw_register_clkdev(hw, "ddr_clk_div", NULL);
+
+	hw = onecell->hws[LS1B_CLK_AHB];
+	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
+	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
+
+	hw = onecell->hws[LS1B_CLK_APB];
 	clk_hw_register_clkdev(hw, "apb_clk", NULL);
 	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
 	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
@@ -120,3 +220,24 @@ void __init ls1x_clk_init(void)
 	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
 	clk_hw_register_clkdev(hw, "serial8250", NULL);
 }
+
+static void __init ls1b_clk_of_setup(struct device_node *np)
+{
+	struct clk_hw_onecell_data *onecell;
+	int err;
+	const char *parent = of_clk_get_parent_name(np, 0);
+
+	clk_base = of_iomap(np, 0);
+
+	onecell = ls1b_clk_init_hw(parent);
+	if (!onecell)
+		pr_err("ls1b-clk: unable to register clk_hw");
+
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
+	if (err)
+		pr_err("ls1b-clk: failed to add DT provider: %d\n", err);
+
+	pr_info("ls1b-clk: driver registered");
+}
+
+CLK_OF_DECLARE(clk_ls1b, "loongson,ls1b-clock", ls1b_clk_of_setup);
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
index 3466f7320b40..076a2e1d5df9 100644
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -1,21 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
  */
 
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 
-#include <loongson1.h>
 #include "clk.h"
 
-#define OSC		(24 * 1000000)
+#include <dt-bindings/clock/ls1c-clock.h>
+
+#define LS1C_CLK_COUNT	6
+
 #define DIV_APB		1
 
+/* PLL/SDRAM Frequency configuration register Bits */
+#define PLL_VALID			BIT(31)
+#define FRAC_N				GENMASK(23, 16)
+#define RST_TIME			GENMASK(3, 2)
+#define SDRAM_DIV			GENMASK(1, 0)
+
+/* CPU/CAMERA/DC Frequency configuration register Bits */
+#define DIV_DC_EN			BIT(31)
+#define DIV_DC				GENMASK(30, 24)
+#define DIV_CAM_EN			BIT(23)
+#define DIV_CAM				GENMASK(22, 16)
+#define DIV_CPU_EN			BIT(15)
+#define DIV_CPU				GENMASK(14, 8)
+#define DIV_DC_SEL_EN			BIT(5)
+#define DIV_DC_SEL			BIT(4)
+#define DIV_CAM_SEL_EN			BIT(3)
+#define DIV_CAM_SEL			BIT(2)
+#define DIV_CPU_SEL_EN			BIT(1)
+#define DIV_CPU_SEL			BIT(0)
+
+#define DIV_DC_SHIFT			24
+#define DIV_CAM_SHIFT			16
+#define DIV_CPU_SHIFT			8
+#define DIV_DDR_SHIFT			0
+
+#define DIV_DC_WIDTH			7
+#define DIV_CAM_WIDTH			7
+#define DIV_CPU_WIDTH			7
+#define DIV_DDR_WIDTH			2
+
 static DEFINE_SPINLOCK(_lock);
 
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
@@ -23,9 +52,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 {
 	u32 pll, rate;
 
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+	pll = __raw_readl(CLK_PLL_FREQ_ADDR);
 	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
-	rate *= OSC;
+	rate *= parent_rate;
 	rate >>= 2;
 
 	return rate;
@@ -42,50 +71,95 @@ static const struct clk_div_table ahb_div_table[] = {
 	[3] = { .val = 3, .div = 3 },
 };
 
-void __init ls1x_clk_init(void)
+struct clk_hw_onecell_data __init *ls1c_clk_init_hw(const char *osc_name)
 {
 	struct clk_hw *hw;
+	struct clk_hw_onecell_data *onecell;
+
+	onecell = kzalloc(sizeof(*onecell) +
+			  (LS1C_CLK_COUNT * sizeof(struct clk_hw *)),
+			  GFP_KERNEL);
+
+	if (!onecell)
+		return NULL;
 
-	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_clk", NULL);
+	onecell->num = LS1C_CLK_COUNT;
 
-	/* clock derived from 24 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
+	/* clock derived from OSC clk */
+	hw = clk_hw_register_pll(NULL, "pll_clk", osc_name,
 				&ls1x_pll_clk_ops, 0);
-	clk_hw_register_clkdev(hw, "pll_clk", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1C_CLK_PLL] = hw;
 
-	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
+	hw = clk_hw_register_divider(NULL, "cpu_clk", "pll_clk",
+				   CLK_GET_RATE_NOCACHE, CLK_PLL_DIV_ADDR,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
 				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1C_CLK_CPU] = hw;
 
-	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+
+	hw = clk_hw_register_divider(NULL, "dc_clk", "pll_clk",
+				   0, CLK_PLL_DIV_ADDR, DIV_DC_SHIFT,
 				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "dc_clk", "dc_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "dc_clk", NULL);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1C_CLK_DC] = hw;
 
-	hw = clk_hw_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
-				0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
+	hw = clk_hw_register_divider_table(NULL, "ddr_clk", "cpu_clk",
+				0, CLK_PLL_FREQ_ADDR, DIV_DDR_SHIFT,
 				DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
 				ahb_div_table, &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div",
+	if (!hw)
+		goto err;
+	onecell->hws[LS1C_CLK_DDR] = hw;
+
+
+	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ddr_clk",
 					0, 1, 1);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1C_CLK_AHB] = hw;
+
+
+	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
+					DIV_APB);
+	if (!hw)
+		goto err;
+	onecell->hws[LS1C_CLK_APB] = hw;
+
+	return onecell;
+
+err:
+	kfree(onecell);
+	return NULL;
+}
+
+void __maybe_unused __init ls1c_register_clkdev(struct clk_hw_onecell_data *onecell)
+{
+	struct clk_hw *hw;
+
+	hw = onecell->hws[LS1C_CLK_PLL];
+	clk_hw_register_clkdev(hw, "pll_clk", NULL);
+
+	hw = onecell->hws[LS1C_CLK_CPU];
+	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
+
+	hw = onecell->hws[LS1C_CLK_DC];
+	clk_hw_register_clkdev(hw, "dc_clk", NULL);
+
+	hw = onecell->hws[LS1C_CLK_DDR];
+	clk_hw_register_clkdev(hw, "ddr_clk", NULL);
+
+	hw = onecell->hws[LS1C_CLK_AHB];
 	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
 	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
 	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
 
-	/* clock derived from AHB clk */
-	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
-					DIV_APB);
+	hw = onecell->hws[LS1C_CLK_APB];
 	clk_hw_register_clkdev(hw, "apb_clk", NULL);
 	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
 	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
@@ -95,3 +169,23 @@ void __init ls1x_clk_init(void)
 	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
 	clk_hw_register_clkdev(hw, "serial8250", NULL);
 }
+
+static void __init ls1c_clk_of_setup(struct device_node *np)
+{
+	struct clk_hw_onecell_data *onecell;
+	int err;
+	const char *parent = of_clk_get_parent_name(np, 0);
+
+	clk_base = of_iomap(np, 0);
+
+	onecell = ls1c_clk_init_hw(parent);
+	if (!onecell)
+		pr_err("ls1c-clk: unable to register clk_hw");
+
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
+	if (err)
+		pr_err("ls1c-clk: failed to add DT provider: %d\n", err);
+
+	pr_info("ls1c-clk: driver registered");
+}
+CLK_OF_DECLARE(clk_ls1c, "loongson,ls1c-clock", ls1c_clk_of_setup);
diff --git a/drivers/clk/loongson1/clk.c b/drivers/clk/loongson1/clk.c
index 983ce9f6edbb..b4dc7dd8e0cd 100644
--- a/drivers/clk/loongson1/clk.c
+++ b/drivers/clk/loongson1/clk.c
@@ -1,14 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
  */
 
+#include <linux/clkdev.h>
+
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+
+#include <asm/mach-loongson32/platform.h>
+
+void __iomem *clk_base;
+
+#define LS1C_OSC		(24 * 1000000)
+#define LS1B_OSC		(33 * 1000000)
+
+#define LS1X_CLK_BASE	0x1fe78030
 
 #include "clk.h"
 
@@ -43,3 +53,30 @@ struct clk_hw *__init clk_hw_register_pll(struct device *dev,
 
 	return hw;
 }
+
+void __init ls1x_clk_init(void)
+{
+	struct clk_hw *hw;
+	struct clk_hw_onecell_data *onecell;
+
+	clk_base = (void __iomem *)KSEG1ADDR(LS1X_CLK_BASE);
+#ifdef CONFIG_LOONGSON1_LS1B
+	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, LS1B_OSC);
+	clk_hw_register_clkdev(hw, "osc_clk", NULL);
+	onecell = ls1c_clk_init_hw("osc_clk");
+	if (!onecell)
+		panic("ls1x-clk: unable to register clk_hw");
+
+	ls1c_register_clkdev(onecell);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, LS1C_OSC);
+	clk_hw_register_clkdev(hw, "osc_clk", NULL);
+	onecell = ls1c_clk_init_hw("osc_clk");
+	if (!onecell)
+		panic("ls1x-clk: unable to register clk_hw");
+
+	ls1c_register_clkdev(onecell);
+#else
+	panic("ls1x-clk: not loongson platform");
+#endif
+}
diff --git a/drivers/clk/loongson1/clk.h b/drivers/clk/loongson1/clk.h
index 085d74b5d496..be7cc72c0ea3 100644
--- a/drivers/clk/loongson1/clk.h
+++ b/drivers/clk/loongson1/clk.h
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
  */
 
 #ifndef __LOONGSON1_CLK_H
@@ -16,4 +13,15 @@ struct clk_hw *clk_hw_register_pll(struct device *dev,
 				   const struct clk_ops *ops,
 				   unsigned long flags);
 
+struct clk_hw_onecell_data __init *ls1c_clk_init_hw(const char *osc_name);
+struct clk_hw_onecell_data __init *ls1b_clk_init_hw(const char *osc_name);
+
+void __maybe_unused __init ls1c_register_clkdev(struct clk_hw_onecell_data *onecell);
+void __maybe_unused __init ls1b_register_clkdev(struct clk_hw_onecell_data *onecell);
+
+extern void __iomem *clk_base;
+
+#define CLK_PLL_FREQ_ADDR	clk_base
+#define CLK_PLL_DIV_ADDR	(clk_base + 0x4)
+
 #endif /* __LOONGSON1_CLK_H */
-- 
2.20.1

