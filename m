Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDQMas (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:30:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9580 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752580AbeDQMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:30:47 -0400
X-UUID: 7e91da36efe44c53a116c020d05e7dca-20180417
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        chunhui dai <chunhui.dai@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1] clk: mediatek: correct the clocks for MT2701 HDMI PHY module
Date: Tue, 17 Apr 2018 20:30:27 +0800
Message-ID: <dc75b5b289d1f6e4914e60543c2611f387f0c164.1523944160.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hdmitx_dig_cts clock signal is not a child of clk26m,
and the actual output of the PLL block is derived from
the tvdpll via a configurable PLL post-divider.

It is used as the PLL reference input to the HDMI PHY module.

Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
Signed-off-by: Chunhui Dai <chunhui.dai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v1:
 - add the "Fixes:" tag.
---
 drivers/clk/mediatek/clk-mt2701.c      |  8 ++++++--
 include/dt-bindings/clock/mt2701-clk.h | 16 ++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index deca752..4dda898 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -46,8 +46,6 @@
 		340 * MHZ),
 	FIXED_CLK(CLK_TOP_HDMI_0_PLL340M, "hdmi_0_pll340m", "clk26m",
 		340 * MHZ),
-	FIXED_CLK(CLK_TOP_HDMITX_CLKDIG_CTS, "hdmitx_dig_cts", "clk26m",
-		300 * MHZ),
 	FIXED_CLK(CLK_TOP_HADDS2_FB, "hadds2_fbclk", "clk26m",
 		27 * MHZ),
 	FIXED_CLK(CLK_TOP_WBG_DIG_416M, "wbg_dig_ck_416m", "clk26m",
@@ -977,6 +975,10 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 				21, 0x2d0, 4, 0x0, 0x2d4, 0),
 };
 
+static const struct mtk_fixed_factor apmixed_fixed_divs[] = {
+	FACTOR(CLK_APMIXED_HDMI_REF, "hdmi_ref", "tvdpll", 1, 1),
+};
+
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -988,6 +990,8 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, apmixed_plls, ARRAY_SIZE(apmixed_plls),
 								clk_data);
+	mtk_clk_register_factors(apmixed_fixed_divs, ARRAY_SIZE(apmixed_fixed_divs),
+								clk_data);
 
 	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 24e93df..1956ebb 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -171,13 +171,12 @@
 #define CLK_TOP_8BDAC				151
 #define CLK_TOP_WBG_DIG_416M			152
 #define CLK_TOP_DPI				153
-#define CLK_TOP_HDMITX_CLKDIG_CTS		154
-#define CLK_TOP_DSI0_LNTC_DSI			155
-#define CLK_TOP_AUD_EXT1			156
-#define CLK_TOP_AUD_EXT2			157
-#define CLK_TOP_NFI1X_PAD			158
-#define CLK_TOP_AXISEL_D4			159
-#define CLK_TOP_NR				160
+#define CLK_TOP_DSI0_LNTC_DSI			154
+#define CLK_TOP_AUD_EXT1			155
+#define CLK_TOP_AUD_EXT2			156
+#define CLK_TOP_NFI1X_PAD			157
+#define CLK_TOP_AXISEL_D4			158
+#define CLK_TOP_NR				159
 
 /* APMIXEDSYS */
 
@@ -194,7 +193,8 @@
 #define CLK_APMIXED_HADDS2PLL			11
 #define CLK_APMIXED_AUD2PLL			12
 #define CLK_APMIXED_TVD2PLL			13
-#define CLK_APMIXED_NR				14
+#define CLK_APMIXED_HDMI_REF			14
+#define CLK_APMIXED_NR				15
 
 /* DDRPHY */
 
-- 
1.9.1
