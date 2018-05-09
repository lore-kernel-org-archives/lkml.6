Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965872AbeEIR12 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:27:28 -0400
Received: from vern.gendns.com ([206.190.152.46]:51902 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935538AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 02/27] clk: davinci: da850-pll: change PLL0 to CLK_OF_DECLARE
Date: Wed,  9 May 2018 12:25:41 -0500
Message-Id: <20180509172606.29387-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL0 on davinci/da850-type device needs to be registered early in boot
because it is needed for clocksource/clockevent. Change the driver
to use CLK_OF_DECLARE for this special case.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- removed duplicate warning message

v9 changes:
- new patch in v9

 drivers/clk/davinci/pll-da850.c | 21 +++++++++++++++++----
 drivers/clk/davinci/pll.c       |  4 +++-
 drivers/clk/davinci/pll.h       |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
index 00a6ece7b524..fde4642a993f 100644
--- a/drivers/clk/davinci/pll-da850.c
+++ b/drivers/clk/davinci/pll-da850.c
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/of.h>
 #include <linux/types.h>
 
@@ -135,11 +137,22 @@ static const struct davinci_pll_sysclk_info *da850_pll0_sysclk_info[] = {
 	NULL
 };
 
-int of_da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
+void of_da850_pll0_init(struct device_node *node)
 {
-	return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
-				   &da850_pll0_obsclk_info,
-				   da850_pll0_sysclk_info, 7, base, cfgchip);
+	void __iomem *base;
+	struct regmap *cfgchip;
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: ioremap failed\n", __func__);
+		return;
+	}
+
+	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
+
+	of_davinci_pll_init(NULL, node, &da850_pll0_info,
+			    &da850_pll0_obsclk_info,
+			    da850_pll0_sysclk_info, 7, base, cfgchip);
 }
 
 static const struct davinci_pll_clk_info da850_pll1_info = {
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index f362f10d8459..dcfa780f828a 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -770,8 +770,10 @@ static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct device *de
 	return pdata;
 }
 
+/* needed in early boot for clocksource/clockevent */
+CLK_OF_DECLARE(da850_pll0, "ti,da850-pll0", of_da850_pll0_init);
+
 static const struct of_device_id davinci_pll_of_match[] = {
-	{ .compatible = "ti,da850-pll0", .data = of_da850_pll0_init },
 	{ .compatible = "ti,da850-pll1", .data = of_da850_pll1_init },
 	{ }
 };
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 562652fc0759..b2e5c4496645 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -123,7 +123,7 @@ int of_davinci_pll_init(struct device *dev, struct device_node *node,
 /* Platform-specific callbacks */
 
 int da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-int of_da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+void of_da850_pll0_init(struct device_node *node);
 int of_da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 
 int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-- 
2.17.0
