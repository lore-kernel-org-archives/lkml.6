Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeDRMtT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:49:19 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36494 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753815AbeDRMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:49:17 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de
Cc: fabio.estevam@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Date: Wed, 18 Apr 2018 14:49:08 +0200
Message-Id: <20180418124908.3079-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6 ULL using PLL3 seems to cause a freeze when setting
the parent to IMX6UL_CLK_PLL3_USB_OTG. This only seems to appear
since commit 6f9575e55632 ("clk: imx: Add CLK_IS_CRITICAL flag
for busy divider and busy mux"), probably because the clock is
now forced to be on.

Fixes: 6f9575e55632("clk: imx: Add CLK_IS_CRITICAL flag for busy divider and busy mux")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This addresses a regression ssen on v4.17-rc1 where the kernel
boots during clock initialization, see also:
https://patchwork.kernel.org/patch/10295927/

 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 114ecbb94ec5..12320118f8de 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -464,7 +464,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
 
 	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
-	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_PLL3_USB_OTG]);
+	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_OSC]);
 	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_CLK2]);
 	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE], clks[IMX6UL_CLK_PLL2_BUS]);
 	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_PRE]);
-- 
2.17.0
