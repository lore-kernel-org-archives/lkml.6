Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeEBO2o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeEBO2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:28:43 -0400
From: Dinh Nguyen <dinguyen@kernel.org>
To: linux-clk@vger.kernel.org
Cc: dinguyen@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: socfpga: stratix10: use platform driver APIs
Date: Wed,  2 May 2018 09:28:32 -0500
Message-Id: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform driver APIs to map memory so that it will automatically free
the memory in case of errors.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-s10.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 3a11c38..c788997 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -260,44 +260,43 @@ static int s10_clk_register_pll(const struct stratix10_pll_clock *clks,
 	return 0;
 }
 
-static struct stratix10_clock_data *__socfpga_s10_clk_init(struct device_node *np,
+static struct stratix10_clock_data *__socfpga_s10_clk_init(struct platform_device *pdev,
 						    int nr_clks)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
 	struct clk **clk_table;
+	struct resource *res;
 	void __iomem *base;
 
-	base = of_iomap(np, 0);
-	if (!base) {
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base)) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		goto err;
+		return ERR_CAST(base);
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
-		goto err;
+		return ERR_CAST(clk_data);
 
 	clk_data->base = base;
-	clk_table = kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
+	clk_table = devm_kcalloc(dev, nr_clks, sizeof(*clk_table), GFP_KERNEL);
 	if (!clk_table)
-		goto err_data;
+		return ERR_CAST(clk_table);
 
 	clk_data->clk_data.clks = clk_table;
 	clk_data->clk_data.clk_num = nr_clks;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
 	return clk_data;
-
-err_data:
-	kfree(clk_data);
-err:
-	return NULL;
 }
 
-static int s10_clkmgr_init(struct device_node *np)
+static int s10_clkmgr_init(struct platform_device *pdev)
 {
 	struct stratix10_clock_data *clk_data;
 
-	clk_data = __socfpga_s10_clk_init(np, STRATIX10_NUM_CLKS);
+	clk_data = __socfpga_s10_clk_init(pdev, STRATIX10_NUM_CLKS);
 	if (!clk_data)
 		return -ENOMEM;
 
@@ -317,11 +316,7 @@ static int s10_clkmgr_init(struct device_node *np)
 
 static int s10_clkmgr_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-
-	s10_clkmgr_init(np);
-
-	return 0;
+	return	s10_clkmgr_init(pdev);
 }
 
 static const struct of_device_id stratix10_clkmgr_match_table[] = {
-- 
2.7.4
