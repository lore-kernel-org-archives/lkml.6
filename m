Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0A8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5741320892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5741320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeLETsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:48:14 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55911 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728653AbeLETru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:47:50 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wB5JHVXm013011;
        Wed, 5 Dec 2018 21:17:31 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 5C5F162DA6; Wed,  5 Dec 2018 21:47:29 +0200 (IST)
From:   Tali Perry <tali.perry1@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v1 1/1] clk: npcm: get fixed input clks from DT
Date:   Wed,  5 Dec 2018 21:47:02 +0200
Message-Id: <20181205194702.257430-3-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181205194702.257430-1-tali.perry1@gmail.com>
References: <20181205194702.257430-1-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/clk/clk-npcm7xx.c | 64 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 27a86b7a34db..25f8ccaa3d2f 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -8,17 +8,23 @@
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
 
+
 struct npcm7xx_clk_pll {
 	struct clk_hw	hw;
 	void __iomem	*pllcon;
@@ -44,7 +50,8 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	u64 ret;
 
 	if (parent_rate == 0) {
-		pr_err("%s: parent rate is zero", __func__);
+		pr_err("%s: parent rate is zero. reg=%s\n", __func__,
+		       hw->init->name);
 		return 0;
 	}
 
@@ -65,9 +72,10 @@ static const struct clk_ops npcm7xx_clk_pll_ops = {
 	.recalc_rate = npcm7xx_clk_pll_recalc_rate,
 };
 
-static struct clk_hw *
-npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
-			 const char *parent_name, unsigned long flags)
+static struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon,
+					       const char *name,
+					       const char *parent_name,
+					       unsigned long flags)
 {
 	struct npcm7xx_clk_pll *pll;
 	struct clk_init_data init;
@@ -544,12 +552,14 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	void __iomem *clk_base;
 	struct resource res;
 	struct clk_hw *hw;
+	struct clk *clk;
 	int ret;
 	int i;
 
+	clk_base = NULL;
 	ret = of_address_to_resource(clk_np, 0, &res);
 	if (ret) {
-		pr_err("%pOFn: failed to get resource, ret %d\n", clk_np,
+		pr_err("%s: failed to get resource, ret %d\n", clk_np->name,
 			ret);
 		return;
 	}
@@ -558,9 +568,10 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	if (!clk_base)
 		goto npcm7xx_init_error;
 
-	npcm7xx_clk_data = kzalloc(struct_size(npcm7xx_clk_data, hws,
-				   NPCM7XX_NUM_CLOCKS), GFP_KERNEL);
-	if (!npcm7xx_clk_data)
+	npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
+		NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
+
+	if (!npcm7xx_clk_data->hws)
 		goto npcm7xx_init_np_err;
 
 	npcm7xx_clk_data->num = NPCM7XX_NUM_CLOCKS;
@@ -568,6 +579,31 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
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
@@ -646,11 +682,17 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 
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

