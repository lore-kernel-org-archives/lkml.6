Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeCEJRp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:17:45 -0500
Received: from regular1.263xmail.com ([211.150.99.133]:51628 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbeCEJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:17:38 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <6ecf75e644352cd27eb3f50a7505cc27>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: rockchip: power-domain: Add a sanity check on pd->num_clks
Date: Mon,  5 Mar 2018 17:17:22 +0800
Message-Id: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_count_phandle_with_args() can fail and return error(for example,
rk3399 pd_vio doesn't have clocks). That would break the pd probe.

Add a sanity check on pd->num_clks to avoid that.

Fixes: 65084121d59d ("soc: rockchip: power-domain: use clk_bulk APIs")
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/soc/rockchip/pm_domains.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index ad96ddeaeb78..fd58fd475950 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -402,11 +402,16 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 
 	pd->num_clks = of_count_phandle_with_args(node, "clocks",
 						  "#clock-cells");
-
-	pd->clks = devm_kcalloc(pmu->dev, pd->num_clks, sizeof(*pd->clks),
-				GFP_KERNEL);
-	if (!pd->clks)
-		return -ENOMEM;
+	if (pd->num_clks > 0) {
+		pd->clks = devm_kcalloc(pmu->dev, pd->num_clks,
+					sizeof(*pd->clks), GFP_KERNEL);
+		if (!pd->clks)
+			return -ENOMEM;
+	} else {
+		dev_dbg(pmu->dev, "%s: don't have clocks: %d\n",
+			node->name, pd->num_clks);
+		pd->num_clks = 0;
+	}
 
 	for (i = 0; i < pd->num_clks; i++) {
 		pd->clks[i].clk = of_clk_get(node, i);
-- 
2.11.0
