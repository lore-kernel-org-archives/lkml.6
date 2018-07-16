Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2672ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B599208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B599208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeGPKqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:46:07 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:50972 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727566AbeGPKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:46:07 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 06:46:03 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w6G9eM3N003989;
        Mon, 16 Jul 2018 12:40:22 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 41116630C6; Mon, 16 Jul 2018 13:10:21 +0300 (IDT)
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
Date:   Mon, 16 Jul 2018 13:10:07 +0300
Message-Id: <20180716101007.11721-2-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180716101007.11721-1-tali.perry1@gmail.com>
References: <20180716101007.11721-1-tali.perry1@gmail.com>
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
 drivers/clk/clk-npcm7xx.c | 102 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 740af90a9508..6ff97f79fcd7 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -8,17 +8,25 @@
  */
 
 #include <linux/module.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/rational.h>
 #include <linux/bitfield.h>
-
 #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
 
+#include <asm/cp15.h>
+
+
 struct npcm7xx_clk_pll {
 	struct clk_hw	hw;
 	void __iomem	*pllcon;
@@ -27,6 +35,9 @@ struct npcm7xx_clk_pll {
 
 #define to_npcm7xx_clk_pll(_hw) container_of(_hw, struct npcm7xx_clk_pll, hw)
 
+struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
+	const char *parent_name, unsigned long flags);
+
 #define PLLCON_LOKI	BIT(31)
 #define PLLCON_LOKS	BIT(30)
 #define PLLCON_FBDV	GENMASK(27, 16)
@@ -44,7 +55,8 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	u64 ret;
 
 	if (parent_rate == 0) {
-		pr_err("%s: parent rate is zero", __func__);
+		pr_err("%s: parent rate is zero. reg=%x\n", __func__,
+			(u32)(pll->pllcon));
 		return 0;
 	}
 
@@ -61,13 +73,13 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	return ret;
 }
 
-static const struct clk_ops npcm7xx_clk_pll_ops = {
+const struct clk_ops npcm7xx_clk_pll_ops = {
 	.recalc_rate = npcm7xx_clk_pll_recalc_rate,
 };
 
-static struct clk_hw *
-npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
-			 const char *parent_name, unsigned long flags)
+
+struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
+	const char *parent_name, unsigned long flags)
 {
 	struct npcm7xx_clk_pll *pll;
 	struct clk_init_data init;
@@ -78,7 +90,8 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	pr_debug("%s reg, name=%s, p=%s\n", __func__, name, parent_name);
+	pr_debug("%s reg, reg=0x%x, name=%s, p=%s\n",
+		__func__, (unsigned int)pllcon, name, parent_name);
 
 	init.name = name;
 	init.ops = &npcm7xx_clk_pll_ops;
@@ -100,6 +113,7 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 	return hw;
 }
 
+
 #define NPCM7XX_CLKEN1          (0x00)
 #define NPCM7XX_CLKEN2          (0x28)
 #define NPCM7XX_CLKEN3          (0x30)
@@ -129,6 +143,7 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 #define NPCM7XX_SECCNT          (0x68)
 #define NPCM7XX_CNTR25M         (0x6C)
 
+
 struct npcm7xx_clk_gate_data {
 	u32 reg;
 	u8 bit_idx;
@@ -204,6 +219,7 @@ struct npcm7xx_clk_pll_data {
 	int onecell_idx;
 };
 
+
 /*
  * Single copy of strings used to refer to clocks within this driver indexed by
  * above enum.
@@ -255,6 +271,7 @@ struct npcm7xx_clk_pll_data {
 #define NPCM7XX_CLK_S_USB_BRIDGE  "usb_bridge"
 #define NPCM7XX_CLK_S_PCI         "pci"
 
+
 static u32 pll_mux_table[] = {0, 1, 2, 3};
 static const char * const pll_mux_parents[] __initconst = {
 	NPCM7XX_CLK_S_PLL0,
@@ -311,6 +328,7 @@ static const char * const dvcssel_mux_parents[] __initconst = {
 	NPCM7XX_CLK_S_PLL2,
 };
 
+
 static const struct npcm7xx_clk_pll_data npcm7xx_plls[] __initconst = {
 	{NPCM7XX_PLLCON0, NPCM7XX_CLK_S_PLL0, NPCM7XX_CLK_S_REFCLK, 0, -1},
 
@@ -324,6 +342,7 @@ static const struct npcm7xx_clk_pll_data npcm7xx_plls[] __initconst = {
 	NPCM7XX_CLK_S_REFCLK, 0, -1},
 };
 
+
 static const struct npcm7xx_clk_mux_data npcm7xx_muxes[] __initconst = {
 	{0, GENMASK(1, 0), cpuck_mux_table, NPCM7XX_CLK_S_CPU_MUX,
 	cpuck_mux_parents, ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL,
@@ -368,6 +387,7 @@ static const struct npcm7xx_clk_div_fixed_data npcm7xx_divs_fx[] __initconst = {
 	{ 1, 2, NPCM7XX_CLK_S_PLL2_DIV2, NPCM7XX_CLK_S_PLL2, 0, -1},
 };
 
+
 /* configurable dividers: */
 static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 	{NPCM7XX_CLKDIV1, 28, 3, NPCM7XX_CLK_S_ADC,
@@ -435,6 +455,7 @@ static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 
 };
 
+
 static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
 	{NPCM7XX_CLKEN1, 31, "smb1-gate", NPCM7XX_CLK_S_APB2, 0},
 	{NPCM7XX_CLKEN1, 30, "smb0-gate", NPCM7XX_CLK_S_APB2, 0},
@@ -536,17 +557,23 @@ static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
 	{NPCM7XX_CLKEN3, 0, "pwmm1-gate", NPCM7XX_CLK_S_APB3, 0},
 };
 
+
+
 static DEFINE_SPINLOCK(npcm7xx_clk_lock);
 
+
 static void __init npcm7xx_clk_init(struct device_node *clk_np)
 {
 	struct clk_hw_onecell_data *npcm7xx_clk_data;
 	void __iomem *clk_base;
 	struct resource res;
 	struct clk_hw *hw;
+	struct clk *clk;
 	int ret;
 	int i;
 
+	clk_base = NULL;
+
 	ret = of_address_to_resource(clk_np, 0, &res);
 	if (ret) {
 		pr_err("%s: failed to get resource, ret %d\n", clk_np->name,
@@ -554,20 +581,52 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 		return;
 	}
 
+
 	clk_base = ioremap(res.start, resource_size(&res));
 	if (!clk_base)
 		goto npcm7xx_init_error;
 
+
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
@@ -584,16 +643,18 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
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
+
+	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
 			NPCM7XX_CLK_S_PLL2, 0, 1, 2);
-	if (IS_ERR(hw)) {
+
+	if (IS_ERR(clk)) {
 		pr_err("npcm7xx_clk: Can't register div2\n");
 		goto npcm7xx_init_fail;
 	}
@@ -618,7 +679,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 			npcm7xx_clk_data->hws[mux_data->onecell_idx] = hw;
 	}
 
-	/* Register clock dividers specified in npcm7xx_divs */
+	/* Register clock dividers specified in npcm7xx_divs. */
 	for (i = 0; i < ARRAY_SIZE(npcm7xx_divs); i++) {
 		const struct npcm7xx_clk_div_data *div_data = &npcm7xx_divs[i];
 
@@ -642,15 +703,26 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	if (ret)
 		pr_err("failed to add DT provider: %d\n", ret);
 
+
 	of_node_put(clk_np);
 
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
+
 CLK_OF_DECLARE(npcm7xx_clk_init, "nuvoton,npcm750-clk", npcm7xx_clk_init);
+
+
+
-- 
2.14.1

