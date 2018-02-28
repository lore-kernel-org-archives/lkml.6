Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeB1MmD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:42:03 -0500
Received: from regular1.263xmail.com ([211.150.99.139]:54601 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeB1MmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:42:02 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <b75e28d9ab47026b9bb4ab16a7c8c135>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, heiko@sntech.de, wxt@rock-chips.com,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: rockchip: power-domain: use clk_bulk APIs
Date: Wed, 28 Feb 2018 20:41:43 +0800
Message-Id: <20180228124143.8364-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_bulk APIs, and also add error handling for clk enable.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/soc/rockchip/pm_domains.c | 90 ++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 39723ef6f7dc..557a2f238301 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -66,7 +66,7 @@ struct rockchip_pm_domain {
 	struct regmap **qos_regmap;
 	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
 	int num_clks;
-	struct clk *clks[];
+	struct clk_bulk_data *clks;
 };
 
 struct rockchip_pmu {
@@ -273,13 +273,18 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 
 static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 {
-	int i;
+	struct rockchip_pmu *pmu = pd->pmu;
+	int ret;
 
-	mutex_lock(&pd->pmu->mutex);
+	mutex_lock(&pmu->mutex);
 
 	if (rockchip_pmu_domain_is_on(pd) != power_on) {
-		for (i = 0; i < pd->num_clks; i++)
-			clk_enable(pd->clks[i]);
+		ret = clk_bulk_enable(pd->num_clks, pd->clks);
+		if (ret < 0) {
+			dev_err(pmu->dev, "failed to enable clocks\n");
+			mutex_unlock(&pmu->mutex);
+			return ret;
+		}
 
 		if (!power_on) {
 			rockchip_pmu_save_qos(pd);
@@ -297,11 +302,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			rockchip_pmu_restore_qos(pd);
 		}
 
-		for (i = pd->num_clks - 1; i >= 0; i--)
-			clk_disable(pd->clks[i]);
+		clk_bulk_disable(pd->num_clks, pd->clks);
 	}
 
-	mutex_unlock(&pd->pmu->mutex);
+	mutex_unlock(&pmu->mutex);
 	return 0;
 }
 
@@ -325,8 +329,6 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	const struct rockchip_domain_info *pd_info;
 	struct rockchip_pm_domain *pd;
 	struct device_node *qos_node;
-	struct clk *clk;
-	int clk_cnt;
 	int i, j;
 	u32 id;
 	int error;
@@ -352,41 +354,36 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		return -EINVAL;
 	}
 
-	clk_cnt = of_count_phandle_with_args(node, "clocks", "#clock-cells");
-	pd = devm_kzalloc(pmu->dev,
-			  sizeof(*pd) + clk_cnt * sizeof(pd->clks[0]),
-			  GFP_KERNEL);
+	pd = devm_kzalloc(pmu->dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
 		return -ENOMEM;
 
 	pd->info = pd_info;
 	pd->pmu = pmu;
 
-	for (i = 0; i < clk_cnt; i++) {
-		clk = of_clk_get(node, i);
-		if (IS_ERR(clk)) {
-			error = PTR_ERR(clk);
+	pd->num_clks = of_count_phandle_with_args(node, "clocks",
+						  "#clock-cells");
+
+	pd->clks = devm_kzalloc(pmu->dev, pd->num_clks * sizeof(pd->clks[0]),
+				GFP_KERNEL);
+	if (!pd->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < pd->num_clks; i++) {
+		pd->clks[i].clk = of_clk_get(node, i);
+		if (IS_ERR(pd->clks[i].clk)) {
+			error = PTR_ERR(pd->clks[i].clk);
 			dev_err(pmu->dev,
 				"%s: failed to get clk at index %d: %d\n",
 				node->name, i, error);
-			goto err_out;
-		}
-
-		error = clk_prepare(clk);
-		if (error) {
-			dev_err(pmu->dev,
-				"%s: failed to prepare clk %pC (index %d): %d\n",
-				node->name, clk, i, error);
-			clk_put(clk);
-			goto err_out;
+			return error;
 		}
-
-		pd->clks[pd->num_clks++] = clk;
-
-		dev_dbg(pmu->dev, "added clock '%pC' to domain '%s'\n",
-			clk, node->name);
 	}
 
+	error = clk_bulk_prepare(pd->num_clks, pd->clks);
+	if (error)
+		goto err_put_clocks;
+
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
 
@@ -396,7 +393,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 					      GFP_KERNEL);
 		if (!pd->qos_regmap) {
 			error = -ENOMEM;
-			goto err_out;
+			goto err_unprepare_clocks;
 		}
 
 		for (j = 0; j < MAX_QOS_REGS_NUM; j++) {
@@ -406,7 +403,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 							    GFP_KERNEL);
 			if (!pd->qos_save_regs[j]) {
 				error = -ENOMEM;
-				goto err_out;
+				goto err_unprepare_clocks;
 			}
 		}
 
@@ -414,13 +411,13 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			qos_node = of_parse_phandle(node, "pm_qos", j);
 			if (!qos_node) {
 				error = -ENODEV;
-				goto err_out;
+				goto err_unprepare_clocks;
 			}
 			pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
 			if (IS_ERR(pd->qos_regmap[j])) {
 				error = -ENODEV;
 				of_node_put(qos_node);
-				goto err_out;
+				goto err_unprepare_clocks;
 			}
 			of_node_put(qos_node);
 		}
@@ -431,7 +428,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		dev_err(pmu->dev,
 			"failed to power on domain '%s': %d\n",
 			node->name, error);
-		goto err_out;
+		goto err_unprepare_clocks;
 	}
 
 	pd->genpd.name = node->name;
@@ -444,17 +441,16 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pmu->genpd_data.domains[id] = &pd->genpd;
 	return 0;
 
-err_out:
-	while (--i >= 0) {
-		clk_unprepare(pd->clks[i]);
-		clk_put(pd->clks[i]);
-	}
+err_unprepare_clocks:
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+err_put_clocks:
+	clk_bulk_put(pd->num_clks, pd->clks);
 	return error;
 }
 
 static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 {
-	int i, ret;
+	int ret;
 
 	/*
 	 * We're in the error cleanup already, so we only complain,
@@ -465,10 +461,8 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 		dev_err(pd->pmu->dev, "failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
 
-	for (i = 0; i < pd->num_clks; i++) {
-		clk_unprepare(pd->clks[i]);
-		clk_put(pd->clks[i]);
-	}
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_put(pd->num_clks, pd->clks);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.11.0
