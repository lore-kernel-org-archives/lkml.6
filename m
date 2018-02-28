Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeB1LLq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:11:46 -0500
Received: from regular1.263xmail.com ([211.150.99.130]:42891 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeB1LLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:11:45 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <c4012917dcc1ddd35eec3614e2fecef6>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: tfiga@chromium.org, dmitry.torokhov@gmail.com, robin.murphy@arm.com,
        heiko@sntech.de, wxt@rock-chips.com,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
Date: Wed, 28 Feb 2018 19:11:13 +0800
Message-Id: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are adding all of the attached devices' clocks as pm clocks
and enable them when powering on the power domain.

This seems unnecessary, because those clocks are already controlled in
the devices' drivers with better error handling.

Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/soc/rockchip/pm_domains.c | 42 ---------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 5c342167b9db..39723ef6f7dc 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/err.h>
-#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -320,44 +319,6 @@ static int rockchip_pd_power_off(struct generic_pm_domain *domain)
 	return rockchip_pd_power(pd, false);
 }
 
-static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
-				  struct device *dev)
-{
-	struct clk *clk;
-	int i;
-	int error;
-
-	dev_dbg(dev, "attaching to power domain '%s'\n", genpd->name);
-
-	error = pm_clk_create(dev);
-	if (error) {
-		dev_err(dev, "pm_clk_create failed %d\n", error);
-		return error;
-	}
-
-	i = 0;
-	while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
-		dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
-		error = pm_clk_add_clk(dev, clk);
-		if (error) {
-			dev_err(dev, "pm_clk_add_clk failed %d\n", error);
-			clk_put(clk);
-			pm_clk_destroy(dev);
-			return error;
-		}
-	}
-
-	return 0;
-}
-
-static void rockchip_pd_detach_dev(struct generic_pm_domain *genpd,
-				   struct device *dev)
-{
-	dev_dbg(dev, "detaching from power domain '%s'\n", genpd->name);
-
-	pm_clk_destroy(dev);
-}
-
 static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 				      struct device_node *node)
 {
@@ -476,9 +437,6 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.name = node->name;
 	pd->genpd.power_off = rockchip_pd_power_off;
 	pd->genpd.power_on = rockchip_pd_power_on;
-	pd->genpd.attach_dev = rockchip_pd_attach_dev;
-	pd->genpd.detach_dev = rockchip_pd_detach_dev;
-	pd->genpd.flags = GENPD_FLAG_PM_CLK;
 	if (pd_info->active_wakeup)
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	pm_genpd_init(&pd->genpd, NULL, false);
-- 
2.11.0
