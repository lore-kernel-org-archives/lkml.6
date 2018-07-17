Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92672ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BC720837
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BC720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeGQXDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:03:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59063 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbeGQXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6F0E4207AB; Wed, 18 Jul 2018 00:28:17 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3D844207B4;
        Wed, 18 Jul 2018 00:28:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 03/16] clk: at91: h32mx: separate registration from DT parsing
Date:   Wed, 18 Jul 2018 00:27:44 +0200
Message-Id: <20180717222757.10253-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate registration out of of_sama5d4_clk_h32mx_setup to allow other code
to use it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-h32mx.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index e0daa4a31f88..a3274648b6c0 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -86,25 +86,19 @@ static const struct clk_ops h32mx_ops = {
 	.set_rate = clk_sama5d4_h32mx_set_rate,
 };
 
-static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
+struct clk_hw * __init
+at91_clk_register_h32mx(struct regmap *regmap, const char *name,
+			const char *parent_name)
 {
 	struct clk_sama5d4_h32mx *h32mxclk;
 	struct clk_init_data init;
-	const char *parent_name;
-	struct regmap *regmap;
 	int ret;
 
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
 	h32mxclk = kzalloc(sizeof(*h32mxclk), GFP_KERNEL);
 	if (!h32mxclk)
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
+		return ERR_PTR(-ENOMEM);
 
-	init.name = np->name;
+	init.name = name;
 	init.ops = &h32mx_ops;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
@@ -116,10 +110,30 @@ static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 	ret = clk_hw_register(NULL, &h32mxclk->hw);
 	if (ret) {
 		kfree(h32mxclk);
-		return;
+		return ERR_PTR(ret);
 	}
 
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, &h32mxclk->hw);
+	return &h32mxclk->hw;
+}
+
+static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	hw = at91_clk_register_h32mx(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
 	       of_sama5d4_clk_h32mx_setup);
-- 
2.18.0

