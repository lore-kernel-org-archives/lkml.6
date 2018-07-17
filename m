Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680FBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B5020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B5020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeGQMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:05:05 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51030 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730131AbeGQMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:05:04 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w6HB1YXg032667;
        Tue, 17 Jul 2018 14:01:34 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 32DC6630CD; Tue, 17 Jul 2018 14:31:33 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     sboyd@kernel.org, brendanhiggins@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        weiyongjunl@huawei.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, raltherr@google.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH v1 1/1] clk: npcm7xx: get fixed clocks from DT
Date:   Tue, 17 Jul 2018 14:31:29 +0300
Message-Id: <20180717113129.25033-2-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180717113129.25033-1-tali.perry1@gmail.com>
References: <20180717113129.25033-1-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton NPCM7XX Clock Controller
fix base address and of_clk_get_by_name error handling.
    Also update error messages to be more informative.
    
    In case clk_base allocation is erronoeous the return value is null.
    Also fix handling of of_clk_get_by_name returns an error. 
    Print a better error message pointing to the dt-binding documention.

This patch is re-submitted since it was already pushed to main 
(just the diff, without the full driver which is already in 
master branch.)


Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

---
 drivers/clk/clk-npcm7xx.c | 101 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 740af90a9508..a5206ee88f4c 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -7,17 +7,28 @@
  * Copyright (C) 2018 Nuvoton Technologies tali.perry@nuvoton.com
  */
 
-#include <linux/module.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/bitfield.h>
-
-#include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+
+
+
+ #include <linux/module.h>
+ #include <linux/clk.h>
+ #include <linux/clk-provider.h>
+ #include <linux/device.h>
+ #include <linux/io.h>
+ #include <linux/kernel.h>
+ #include <linux/of.h>
+ #include <linux/of_device.h>
+ #include <linux/of_platform.h>
+ #include <linux/of_address.h>
+ #include <linux/platform_device.h>
+ #include <linux/slab.h>
+ #include <linux/err.h>
+ #include <linux/rational.h>
+ #include <linux/bitfield.h>
+ #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+
+ #include <asm/cp15.h>
+
 
 struct npcm7xx_clk_pll {
 	struct clk_hw	hw;
@@ -27,6 +38,9 @@ struct npcm7xx_clk_pll {
 
 #define to_npcm7xx_clk_pll(_hw) container_of(_hw, struct npcm7xx_clk_pll, hw)
 
+static struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon,
+	const char *name, const char *parent_name, unsigned long flags);
+
 #define PLLCON_LOKI	BIT(31)
 #define PLLCON_LOKS	BIT(30)
 #define PLLCON_FBDV	GENMASK(27, 16)
@@ -44,7 +58,8 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	u64 ret;
 
 	if (parent_rate == 0) {
-		pr_err("%s: parent rate is zero", __func__);
+		pr_err("%s: parent rate is zero. reg=%x\n", __func__,
+			(u32)(pll->pllcon));
 		return 0;
 	}
 
@@ -61,13 +76,12 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	return ret;
 }
 
-static const struct clk_ops npcm7xx_clk_pll_ops = {
+const struct clk_ops npcm7xx_clk_pll_ops = {
 	.recalc_rate = npcm7xx_clk_pll_recalc_rate,
 };
 
-static struct clk_hw *
-npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
-			 const char *parent_name, unsigned long flags)
+static struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon,
+		const char *name, const char *parent_name, unsigned long flags)
 {
 	struct npcm7xx_clk_pll *pll;
 	struct clk_init_data init;
@@ -78,7 +92,8 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	pr_debug("%s reg, name=%s, p=%s\n", __func__, name, parent_name);
+	pr_debug("%s reg, reg=0x%x, name=%s, p=%s\n",
+		__func__, (unsigned int)pllcon, name, parent_name);
 
 	init.name = name;
 	init.ops = &npcm7xx_clk_pll_ops;
@@ -544,9 +559,11 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	void __iomem *clk_base;
 	struct resource res;
 	struct clk_hw *hw;
+	struct clk *clk;
 	int ret;
 	int i;
 
+	clk_base = NULL;
 	ret = of_address_to_resource(clk_np, 0, &res);
 	if (ret) {
 		pr_err("%s: failed to get resource, ret %d\n", clk_np->name,
@@ -560,14 +577,44 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 
 	npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
 		NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
-	if (!npcm7xx_clk_data)
+
+	npcm7xx_clk_data->num = 0;
+
+	if (!npcm7xx_clk_data->hws) {
+		pr_err("Can't alloc npcm7xx_clk_data\n");
 		goto npcm7xx_init_np_err;
+	}
 
 	npcm7xx_clk_data->num = NPCM7XX_NUM_CLOCKS;
 
 	for (i = 0; i < NPCM7XX_NUM_CLOCKS; i++)
 		npcm7xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
+	/* Read fixed clocks. These 3 clocks must be defined in DT */
+	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_REFCLK);
+	if (IS_ERR(clk)) {
+		pr_err("failed to find external REFCLK on device tree, err=%ld\n",
+			PTR_ERR(clk));
+		clk_put(clk);
+		goto npcm7xx_init_fail_no_clk_on_dt;
+	}
+
+	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_SYSBYPCK);
+	if (IS_ERR(clk)) {
+		pr_err("failed to find external SYSBYPCK on device tree, err=%ld\n",
+			PTR_ERR(clk));
+		clk_put(clk);
+		goto npcm7xx_init_fail_no_clk_on_dt;
+	}
+
+	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_MCBYPCK);
+	if (IS_ERR(clk)) {
+		pr_err("failed to find external MCBYPCK on device tree, err=%ld\n",
+			PTR_ERR(clk));
+		clk_put(clk);
+		goto npcm7xx_init_fail_no_clk_on_dt;
+	}
+
 	/* Register plls */
 	for (i = 0; i < ARRAY_SIZE(npcm7xx_plls); i++) {
 		const struct npcm7xx_clk_pll_data *pll_data = &npcm7xx_plls[i];
@@ -584,16 +631,16 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	}
 
 	/* Register fixed dividers */
-	hw = clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
+	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
 			NPCM7XX_CLK_S_PLL1, 0, 1, 2);
-	if (IS_ERR(hw)) {
+	if (IS_ERR(clk)) {
 		pr_err("npcm7xx_clk: Can't register fixed div\n");
 		goto npcm7xx_init_fail;
 	}
 
-	hw = clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
+	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
 			NPCM7XX_CLK_S_PLL2, 0, 1, 2);
-	if (IS_ERR(hw)) {
+	if (IS_ERR(clk)) {
 		pr_err("npcm7xx_clk: Can't register div2\n");
 		goto npcm7xx_init_fail;
 	}
@@ -646,11 +693,17 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 
 	return;
 
+npcm7xx_init_fail_no_clk_on_dt:
+	pr_err("see Documentation/devicetree/bindings/clock/");
+	pr_err("nuvoton,npcm750-clk.txt  for details\n");
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	if (npcm7xx_clk_data->num)
+		kfree(npcm7xx_clk_data->hws);
 npcm7xx_init_np_err:
-	iounmap(clk_base);
+	if (clk_base != NULL)
+		iounmap(clk_base);
 npcm7xx_init_error:
 	of_node_put(clk_np);
+	pr_err("clk setup fail\n");
 }
 CLK_OF_DECLARE(npcm7xx_clk_init, "nuvoton,npcm750-clk", npcm7xx_clk_init);
-- 
2.14.1

