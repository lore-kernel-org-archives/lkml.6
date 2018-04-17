Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDQDiX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbeDQDiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:38:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341512175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Tali Perry <tali.perry1@gmail.com>, avifishman70@gmail.com,
        brendanhiggins@google.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        raltherr@google.com, robh+dt@kernel.org, tmaimon77@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1522059386-20601-3-git-send-email-tali.perry1@gmail.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tali Perry <tali.perry1@gmail.com>
References: <1522059386-20601-1-git-send-email-tali.perry1@gmail.com>
 <1522059386-20601-3-git-send-email-tali.perry1@gmail.com>
Message-ID: <152393630051.51482.7797391524865573162@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v12 2/2] clk: npcm7xx: add clock controller
Date: Mon, 16 Apr 2018 20:38:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tali Perry (2018-03-26 03:16:26)
> * Nuvoton NPCM7XX Clock Controller
> 
> Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> 
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> 

There should be a triple dash here.

I applied this to clk-next with these changes squashed in. If anything
is wrong let me know.

----8<----

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 7e4964b9e5c8..dba5384f03a4 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -8,24 +8,16 @@
  */
 
 #include <linux/module.h>
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/rational.h>
 #include <linux/bitfield.h>
-#include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
-
-#include <asm/cp15.h>
 
+#include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
 
 struct npcm7xx_clk_pll {
 	struct clk_hw	hw;
@@ -35,9 +27,6 @@ struct npcm7xx_clk_pll {
 
 #define to_npcm7xx_clk_pll(_hw) container_of(_hw, struct npcm7xx_clk_pll, hw)
 
-struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
-	const char *parent_name, unsigned long flags);
-
 #define PLLCON_LOKI	BIT(31)
 #define PLLCON_LOKS	BIT(30)
 #define PLLCON_FBDV	GENMASK(27, 16)
@@ -55,8 +44,7 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	u64 ret;
 
 	if (parent_rate == 0) {
-		pr_err("%s: parent rate is zero. reg=%x\n", __func__,
-			(u32)(pll->pllcon));
+		pr_err("%s: parent rate is zero", __func__);
 		return 0;
 	}
 
@@ -73,13 +61,13 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	return ret;
 }
 
-const struct clk_ops npcm7xx_clk_pll_ops = {
+static const struct clk_ops npcm7xx_clk_pll_ops = {
 	.recalc_rate = npcm7xx_clk_pll_recalc_rate,
 };
 
-
-struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
-	const char *parent_name, unsigned long flags)
+static struct clk_hw *
+npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
+			 const char *parent_name, unsigned long flags)
 {
 	struct npcm7xx_clk_pll *pll;
 	struct clk_init_data init;
@@ -90,8 +78,7 @@ struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	pr_debug("%s reg, reg=0x%x, name=%s, p=%s\n",
-		__func__, (unsigned int)pllcon, name, parent_name);
+	pr_debug("%s reg, name=%s, p=%s\n", __func__, name, parent_name);
 
 	init.name = name;
 	init.ops = &npcm7xx_clk_pll_ops;
@@ -113,7 +100,6 @@ struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 	return hw;
 }
 
-
 #define NPCM7XX_CLKEN1          (0x00)
 #define NPCM7XX_CLKEN2          (0x28)
 #define NPCM7XX_CLKEN3          (0x30)
@@ -143,7 +129,6 @@ struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 #define NPCM7XX_SECCNT          (0x68)
 #define NPCM7XX_CNTR25M         (0x6C)
 
-
 struct npcm7xx_clk_gate_data {
 	u32 reg;
 	u8 bit_idx;
@@ -219,7 +204,6 @@ struct npcm7xx_clk_pll_data {
 	int onecell_idx;
 };
 
-
 /*
  * Single copy of strings used to refer to clocks within this driver indexed by
  * above enum.
@@ -271,7 +255,6 @@ struct npcm7xx_clk_pll_data {
 #define NPCM7XX_CLK_S_USB_BRIDGE  "usb_bridge"
 #define NPCM7XX_CLK_S_PCI         "pci"
 
-
 static u32 pll_mux_table[] = {0, 1, 2, 3};
 static const char * const pll_mux_parents[] __initconst = {
 	NPCM7XX_CLK_S_PLL0,
@@ -328,7 +311,6 @@ static const char * const dvcssel_mux_parents[] __initconst = {
 	NPCM7XX_CLK_S_PLL2,
 };
 
-
 static const struct npcm7xx_clk_pll_data npcm7xx_plls[] __initconst = {
 	{NPCM7XX_PLLCON0, NPCM7XX_CLK_S_PLL0, NPCM7XX_CLK_S_REFCLK, 0, -1},
 
@@ -342,7 +324,6 @@ static const struct npcm7xx_clk_pll_data npcm7xx_plls[] __initconst = {
 	NPCM7XX_CLK_S_REFCLK, 0, -1},
 };
 
-
 static const struct npcm7xx_clk_mux_data npcm7xx_muxes[] __initconst = {
 	{0, GENMASK(1, 0), cpuck_mux_table, NPCM7XX_CLK_S_CPU_MUX,
 	cpuck_mux_parents, ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL,
@@ -387,7 +368,6 @@ static const struct npcm7xx_clk_div_fixed_data npcm7xx_divs_fx[] __initconst = {
 	{ 1, 2, NPCM7XX_CLK_S_PLL2_DIV2, NPCM7XX_CLK_S_PLL2, 0, -1},
 };
 
-
 /* configurable dividers: */
 static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 	{NPCM7XX_CLKDIV1, 28, 3, NPCM7XX_CLK_S_ADC,
@@ -455,7 +435,6 @@ static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 
 };
 
-
 static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
 	{NPCM7XX_CLKEN1, 31, "smb1-gate", NPCM7XX_CLK_S_APB2, 0},
 	{NPCM7XX_CLKEN1, 30, "smb0-gate", NPCM7XX_CLK_S_APB2, 0},
@@ -557,23 +536,17 @@ static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
 	{NPCM7XX_CLKEN3, 0, "pwmm1-gate", NPCM7XX_CLK_S_APB3, 0},
 };
 
-
-
 static DEFINE_SPINLOCK(npcm7xx_clk_lock);
 
-
 static void __init npcm7xx_clk_init(struct device_node *clk_np)
 {
 	struct clk_hw_onecell_data *npcm7xx_clk_data;
 	void __iomem *clk_base;
 	struct resource res;
 	struct clk_hw *hw;
-	struct clk *clk;
 	int ret;
 	int i;
 
-	clk_base = NULL;
-
 	ret = of_address_to_resource(clk_np, 0, &res);
 	if (ret) {
 		pr_err("%s: failed to get resource, ret %d\n", clk_np->name,
@@ -581,49 +554,20 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 		return;
 	}
 
-
 	clk_base = ioremap(res.start, resource_size(&res));
 	if (IS_ERR(clk_base))
 		goto npcm7xx_init_error;
 
-
 	npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
 		NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
-
-	npcm7xx_clk_data->num = 0;
-
-	if (!npcm7xx_clk_data->hws) {
-		pr_err("Can't alloc npcm7xx_clk_data\n");
+	if (!npcm7xx_clk_data)
 		goto npcm7xx_init_np_err;
-	}
 
 	npcm7xx_clk_data->num = NPCM7XX_NUM_CLOCKS;
 
 	for (i = 0; i < NPCM7XX_NUM_CLOCKS; i++)
 		npcm7xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
-	/* Read fixed clocks. These 3 clocks must be defined in DT */
-	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_REFCLK);
-	if (!IS_ERR(clk)) {
-		pr_err("failed to find external REFCLK: %ld\n",
-			PTR_ERR(clk));
-		clk_put(clk);
-	}
-
-	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_SYSBYPCK);
-	if (!IS_ERR(clk)) {
-		pr_err("failed to find external SYSBYPCK: %ld\n",
-			PTR_ERR(clk));
-		clk_put(clk);
-	}
-
-	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_MCBYPCK);
-	if (!IS_ERR(clk)) {
-		pr_err("failed to find external MCBYPCK: %ld\n",
-			PTR_ERR(clk));
-		clk_put(clk);
-	}
-
 	/* Register plls */
 	for (i = 0; i < ARRAY_SIZE(npcm7xx_plls); i++) {
 		const struct npcm7xx_clk_pll_data *pll_data = &npcm7xx_plls[i];
@@ -640,18 +584,16 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	}
 
 	/* Register fixed dividers */
-	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
+	hw = clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
 			NPCM7XX_CLK_S_PLL1, 0, 1, 2);
-	if (IS_ERR(clk)) {
+	if (IS_ERR(hw)) {
 		pr_err("npcm7xx_clk: Can't register fixed div\n");
 		goto npcm7xx_init_fail;
 	}
 
-
-	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
+	hw = clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
 			NPCM7XX_CLK_S_PLL2, 0, 1, 2);
-
-	if (IS_ERR(clk)) {
+	if (IS_ERR(hw)) {
 		pr_err("npcm7xx_clk: Can't register div2\n");
 		goto npcm7xx_init_fail;
 	}
@@ -676,7 +618,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 			npcm7xx_clk_data->hws[mux_data->onecell_idx] = hw;
 	}
 
-	/* Register clock dividers specified in npcm7xx_divs. */
+	/* Register clock dividers specified in npcm7xx_divs */
 	for (i = 0; i < ARRAY_SIZE(npcm7xx_divs); i++) {
 		const struct npcm7xx_clk_div_data *div_data = &npcm7xx_divs[i];
 
@@ -700,23 +642,15 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	if (ret)
 		pr_err("failed to add DT provider: %d\n", ret);
 
-
 	of_node_put(clk_np);
 
 	return;
 
 npcm7xx_init_fail:
-	if (npcm7xx_clk_data->num)
-		kfree(npcm7xx_clk_data->hws);
+	kfree(npcm7xx_clk_data->hws);
 npcm7xx_init_np_err:
-	if (clk_base != NULL)
-		iounmap(clk_base);
+	iounmap(clk_base);
 npcm7xx_init_error:
 	of_node_put(clk_np);
-	pr_err("clk setup fail\n");
 }
-
 CLK_OF_DECLARE(npcm7xx_clk_init, "nuvoton,npcm750-clk", npcm7xx_clk_init);
-
-
-
