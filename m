Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeDROu3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:50:29 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:43080 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeDROuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:50:21 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/5] soc: rockchip: power-domain: Use of_clk_get_parent_count() instead of open coding
Date: Wed, 18 Apr 2018 16:50:03 +0200
Message-Id: <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of_clk_get_parent_count() returns zero on failure, while
of_count_phandle_with_args() might return a negative error code, this
also fixes the issue of possibly using a negative number in the
allocation below.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
<linux/of_clk.h>".

v3:
  - Add Reviewed-by,

v2:
  - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
---
 drivers/soc/rockchip/pm_domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 53efc386b1ada8cf..13913d40c8213e36 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -14,6 +14,7 @@
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
@@ -400,8 +401,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->info = pd_info;
 	pd->pmu = pmu;
 
-	pd->num_clks = of_count_phandle_with_args(node, "clocks",
-						  "#clock-cells");
+	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
 		pd->clks = devm_kcalloc(pmu->dev, pd->num_clks,
 					sizeof(*pd->clks), GFP_KERNEL);
-- 
2.7.4
