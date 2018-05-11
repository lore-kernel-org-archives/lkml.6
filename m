Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeEKD3v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:29:51 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:44335 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeEKD3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:29:50 -0400
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
X-UNIQUE-TAG: <779cb3b0a34a9535971649ccf55bd14d>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v1 13/13] soc: rockchip: power-domain: add power domain support for px30
Date: Fri, 11 May 2018 11:35:05 +0800
Message-Id: <1526009705-6583-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is modified to support PX30 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 90dcd5e21ae6..d0c5615132e3 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3128-power.h>
 #include <dt-bindings/power/rk3228-power.h>
@@ -114,6 +115,9 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
+#define DOMAIN_PX30(pwr, status, req, wakeup)		\
+	DOMAIN_M(pwr, status, req, (req) + 16, req, wakeup)
+
 #define DOMAIN_RK3288(pwr, status, req, wakeup)		\
 	DOMAIN(pwr, status, req, req, (req) + 16, wakeup)
 
@@ -712,6 +716,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	return error;
 }
 
+static const struct rockchip_domain_info px30_pm_domains[] = {
+	[PX30_PD_USB]		= DOMAIN_PX30(5, 5, 10, false),
+	[PX30_PD_SDCARD]	= DOMAIN_PX30(8, 8, 9, false),
+	[PX30_PD_GMAC]		= DOMAIN_PX30(10, 10, 6, false),
+	[PX30_PD_MMC_NAND]	= DOMAIN_PX30(11, 11, 5, false),
+	[PX30_PD_VPU]		= DOMAIN_PX30(12, 12, 14, false),
+	[PX30_PD_VO]		= DOMAIN_PX30(13, 13, 7, false),
+	[PX30_PD_VI]		= DOMAIN_PX30(14, 14, 8, false),
+	[PX30_PD_GPU]		= DOMAIN_PX30(15, 15, 2, false),
+};
+
 static const struct rockchip_domain_info rk3036_pm_domains[] = {
 	[RK3036_PD_MSCH]	= DOMAIN_RK3036(14, 23, 30, true),
 	[RK3036_PD_CORE]	= DOMAIN_RK3036(13, 17, 24, false),
@@ -811,6 +826,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(31, 31, 29, true),
 };
 
+static const struct rockchip_pmu_info px30_pmu = {
+	.pwr_offset = 0x18,
+	.status_offset = 0x20,
+	.req_offset = 0x64,
+	.idle_offset = 0x6c,
+	.ack_offset = 0x6c,
+
+	.num_domains = ARRAY_SIZE(px30_pm_domains),
+	.domain_info = px30_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3036_pmu = {
 	.req_offset = 0x148,
 	.idle_offset = 0x14c,
@@ -915,6 +941,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 	{
+		.compatible = "rockchip,px30-power-controller",
+		.data = (void *)&px30_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3036-power-controller",
 		.data = (void *)&rk3036_pmu,
 	},
-- 
1.9.1
