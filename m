Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeDROu0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:50:26 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:35834 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeDROuV (ORCPT
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
Subject: [PATCH v3 2/5] ARM: timer-sp: Use of_clk_get_parent_count() instead of open coding
Date: Wed, 18 Apr 2018 16:50:02 +0200
Message-Id: <1524063005-1716-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
<linux/of_clk.h>".

v3:
  - Add Acked-by,

v2:
  - of_clk_get_parent_count() was moved to <linux/of_clk.h>,
  - Dropped RFC, as a dummy is now available in the !CONFIG_COMMON_CLK
    case.
---
 drivers/clocksource/timer-sp804.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 3ac9dec9a03852f9..e01222ea888ff9d2 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
@@ -245,7 +246,7 @@ static int __init sp804_of_init(struct device_node *np)
 		clk1 = NULL;
 
 	/* Get the 2nd clock if the timer has 3 timer clocks */
-	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
+	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
 			pr_err("sp804: %s clock not found: %d\n", np->name,
-- 
2.7.4
