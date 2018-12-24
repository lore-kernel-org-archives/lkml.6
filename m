Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D293C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5837F2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeLXGk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 01:40:28 -0500
Received: from gateway36.websitewelcome.com ([50.116.126.2]:30232 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbeLXGk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 01:40:28 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 50B05400C6C57
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 23:51:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id bJucg06lr2qH7bJucgi3lw; Mon, 24 Dec 2018 00:40:26 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=50094 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gbJub-000Gyx-OC; Mon, 24 Dec 2018 00:40:25 -0600
Date:   Mon, 24 Dec 2018 00:40:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] clk: imx: imx7ulp: use struct_size() in kzalloc()
Message-ID: <20181224064025.GA9588@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gbJub-000Gyx-OC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:50094
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 4e18f629f823..ce306631e844 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -48,8 +48,8 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SCG1_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
@@ -136,8 +136,8 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_PCC2_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC2_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
@@ -183,8 +183,8 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_PCC3_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC3_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
@@ -228,8 +228,8 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_SMC1_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SMC1_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
-- 
2.20.1

