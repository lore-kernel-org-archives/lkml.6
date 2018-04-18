Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDROuc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:50:32 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:43100 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeDROuV (ORCPT
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
Subject: [PATCH v3 4/5] soc/tegra: pmc: Use of_clk_get_parent_count() instead of open coding
Date: Wed, 18 Apr 2018 16:50:04 +0200
Message-Id: <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of_clk_get_parent_count() returns zero on failure, while
of_count_phandle_with_args() might return a negative error code, this
also fixes the issue of possibly using a very big number in the
allocation below.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
<linux/of_clk.h>".

v3:
  - Add Acked-by,

v2:
  - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
---
 drivers/soc/tegra/pmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d9fcdb592b3966a5..d8cb48a4b8eb1b78 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -31,6 +31,7 @@
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -725,7 +726,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
 	unsigned int i, count;
 	int err;
 
-	count = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	count = of_clk_get_parent_count(np);
 	if (count == 0)
 		return -ENODEV;
 
-- 
2.7.4
