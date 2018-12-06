Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBCC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C9B20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C9B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeLFIpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:45:22 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55954 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727763AbeLFIpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:45:22 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wB68EgB9028134;
        Thu, 6 Dec 2018 10:14:43 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id F3BE362DA6; Thu,  6 Dec 2018 10:44:40 +0200 (IST)
From:   Tali Perry <tali.perry1@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH v2] clk: npcm7xx: get fixed clocks from DT
Date:   Thu,  6 Dec 2018 10:44:31 +0200
Message-Id: <20181206084431.315559-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The npcm7xx clock module includes 4 PLLs and then a tree of muxes and dividers.
All muxes and dividers are preset before Linux boots. The presetting can change
according to the board.
Linux drivers need to know what the frequencies are, but they cannot change it,
so this whole driver is intended as read only mechanism for clocks.

Before this change PLLs input clk value was defined inside the driver.
With this fix clock will be on the DT.

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

---

 drivers/clk/clk-npcm7xx.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 27a86b7a34db..4bd2e40997d4 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -8,13 +8,19 @@
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
 
 #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
@@ -544,6 +550,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	void __iomem *clk_base;
 	struct resource res;
 	struct clk_hw *hw;
+	struct clk *clk;
 	int ret;
 	int i;
 
@@ -568,6 +575,31 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
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
@@ -646,11 +678,16 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 
 	return;
 
+npcm7xx_init_fail_no_clk_on_dt:
+	pr_err("see Documentation/devicetree/bindings/clock/");
+	pr_err("nuvoton,npcm750-clk.txt  for details\n");
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	if (npcm7xx_clk_data->num)
+		kfree(npcm7xx_clk_data->hws);
 npcm7xx_init_np_err:
 	iounmap(clk_base);
 npcm7xx_init_error:
 	of_node_put(clk_np);
+	pr_err("clk setup fail\n");
 }
 CLK_OF_DECLARE(npcm7xx_clk_init, "nuvoton,npcm750-clk", npcm7xx_clk_init);
-- 
2.14.1

