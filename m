Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeEKD17 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:27:59 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:38914 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEKD15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:27:57 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <cb808838abf6ed99f69fe932a3bc74cc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 07/13] soc: rockchip: power-domain: add power domain support for rk3128
Date: Fri, 11 May 2018 11:33:12 +0800
Message-Id: <1526009592-1906-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is modified to support RK3128 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 01d4ba26a054..99a2dd8a7801 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/rk3036-power.h>
+#include <dt-bindings/power/rk3128-power.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/power/rk3366-power.h>
@@ -720,6 +721,14 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3036_PD_SYS]		= DOMAIN_RK3036(8, 22, 29, false),
 };
 
+static const struct rockchip_domain_info rk3128_pm_domains[] = {
+	[RK3128_PD_CORE]	= DOMAIN_RK3288(0, 0, 4, false),
+	[RK3128_PD_MSCH]	= DOMAIN_RK3288(-1, -1, 6, true),
+	[RK3128_PD_VIO]		= DOMAIN_RK3288(3, 3, 2, false),
+	[RK3128_PD_VIDEO]	= DOMAIN_RK3288(2, 2, 1, false),
+	[RK3128_PD_GPU]		= DOMAIN_RK3288(1, 1, 3, false),
+};
+
 static const struct rockchip_domain_info rk3288_pm_domains[] = {
 	[RK3288_PD_VIO]		= DOMAIN_RK3288(7, 7, 4, false),
 	[RK3288_PD_HEVC]	= DOMAIN_RK3288(14, 10, 9, false),
@@ -796,6 +805,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	.domain_info = rk3036_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3128_pmu = {
+	.pwr_offset = 0x04,
+	.status_offset = 0x08,
+	.req_offset = 0x0c,
+	.idle_offset = 0x10,
+	.ack_offset = 0x10,
+
+	.num_domains = ARRAY_SIZE(rk3128_pm_domains),
+	.domain_info = rk3128_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3288_pmu = {
 	.pwr_offset = 0x08,
 	.status_offset = 0x0c,
@@ -875,6 +895,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		.data = (void *)&rk3036_pmu,
 	},
 	{
+		.compatible = "rockchip,rk3128-power-controller",
+		.data = (void *)&rk3128_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3288-power-controller",
 		.data = (void *)&rk3288_pmu,
 	},
-- 
1.9.1
