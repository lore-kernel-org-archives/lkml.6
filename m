Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbeAaSPT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:15:19 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38530 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753563AbeAaSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:53 -0500
X-Google-Smtp-Source: AH8x224eXzUPEdqPtRFvob7DHTQTwP7/yFuJ0qssGFz2Z61cGVx45tW9CuCrs60EgQgFV9cqeabiuw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] clk: meson: only one loop index is necessary in probe
Date: Wed, 31 Jan 2018 19:09:29 +0100
Message-Id: <20180131180945.18025-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need several loop index variables in the probe function
This is far from being critical but since we are doing a vast
rework of meson clock controllers, now is the time to lower the
entropy a bit

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  8 ++++----
 drivers/clk/meson/gxbb.c    | 13 ++++++-------
 drivers/clk/meson/meson8b.c |  8 ++++----
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 2f2b3845c01d..81565b025b70 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -802,7 +802,7 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	const struct clkc_data *clkc_data;
 	struct resource *res;
 	void __iomem *clk_base;
-	int ret, clkid, i;
+	int ret, i;
 
 	clkc_data = of_device_get_match_data(dev);
 	if (!clkc_data)
@@ -841,13 +841,13 @@ static int axg_clkc_probe(struct platform_device *pdev)
 		clkc_data->clk_dividers[i]->reg = clk_base +
 			(u64)clkc_data->clk_dividers[i]->reg;
 
-	for (clkid = 0; clkid < clkc_data->hw_onecell_data->num; clkid++) {
+	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
 		/* array might be sparse */
-		if (!clkc_data->hw_onecell_data->hws[clkid])
+		if (!clkc_data->hw_onecell_data->hws[i])
 			continue;
 
 		ret = devm_clk_hw_register(dev,
-					clkc_data->hw_onecell_data->hws[clkid]);
+					   clkc_data->hw_onecell_data->hws[i]);
 		if (ret) {
 			dev_err(dev, "Clock registration failed\n");
 			return ret;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 17f44ac751b3..e6adab49c0ba 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1947,7 +1947,7 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 {
 	const struct clkc_data *clkc_data;
 	void __iomem *clk_base;
-	int ret, clkid, i;
+	int ret, i;
 	struct device *dev = &pdev->dev;
 
 	clkc_data = of_device_get_match_data(dev);
@@ -1988,16 +1988,15 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_audio_dividers_count; i++)
 		clkc_data->clk_audio_dividers[i]->base = clk_base;
 
-	/*
-	 * register all clks
-	 */
-	for (clkid = 0; clkid < clkc_data->hw_onecell_data->num; clkid++) {
+
+	/* Register all clks */
+	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
 		/* array might be sparse */
-		if (!clkc_data->hw_onecell_data->hws[clkid])
+		if (!clkc_data->hw_onecell_data->hws[i])
 			continue;
 
 		ret = devm_clk_hw_register(dev,
-					clkc_data->hw_onecell_data->hws[clkid]);
+					   clkc_data->hw_onecell_data->hws[i]);
 		if (ret)
 			goto iounmap;
 	}
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index abac079ff77f..ffadad27375e 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -806,7 +806,7 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
 
 static int meson8b_clkc_probe(struct platform_device *pdev)
 {
-	int ret, clkid, i;
+	int ret, i;
 	struct clk_hw *parent_hw;
 	struct clk *parent_clk;
 	struct device *dev = &pdev->dev;
@@ -844,13 +844,13 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	 * register all clks
 	 * CLKID_UNUSED = 0, so skip it and start with CLKID_XTAL = 1
 	 */
-	for (clkid = CLKID_XTAL; clkid < CLK_NR_CLKS; clkid++) {
+	for (i = CLKID_XTAL; i < CLK_NR_CLKS; i++) {
 		/* array might be sparse */
-		if (!meson8b_hw_onecell_data.hws[clkid])
+		if (!meson8b_hw_onecell_data.hws[i])
 			continue;
 
 		/* FIXME convert to devm_clk_register */
-		ret = devm_clk_hw_register(dev, meson8b_hw_onecell_data.hws[clkid]);
+		ret = devm_clk_hw_register(dev, meson8b_hw_onecell_data.hws[i]);
 		if (ret)
 			return ret;
 	}
-- 
2.14.3
