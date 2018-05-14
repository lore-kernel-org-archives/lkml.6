Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeENDX5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:23:57 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:44155 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeENDXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:23:55 -0400
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
X-UNIQUE-TAG: <6fa686f46dd733e9678aa9bd41aa9498>
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
Subject: [PATCH v2 03/13] Soc: rockchip: power-domain: add power domain support for rk3036
Date: Mon, 14 May 2018 11:29:01 +0800
Message-Id: <1526268541-9298-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caesar Wang <wxt@rock-chips.com>

This driver is modified to support RK3036 SoC.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 53efc386b1ad..ebd7c41898c0 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/power/rk3366-power.h>
@@ -102,6 +103,14 @@ struct rockchip_pmu {
 	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
 	.active_wakeup = wakeup,			\
 }
+#define DOMAIN_RK3036(req, ack, idle, wakeup)		\
+{							\
+	.req_mask = (req >= 0) ? BIT(req) : 0,		\
+	.req_w_mask = (req >= 0) ?  BIT(req + 16) : 0,	\
+	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
+	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
+	.active_wakeup = wakeup,			\
+}
 
 #define DOMAIN_RK3288(pwr, status, req, wakeup)		\
 	DOMAIN(pwr, status, req, req, (req) + 16, wakeup)
@@ -701,6 +710,16 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	return error;
 }
 
+static const struct rockchip_domain_info rk3036_pm_domains[] = {
+	[RK3036_PD_MSCH]	= DOMAIN_RK3036(14, 23, 30, true),
+	[RK3036_PD_CORE]	= DOMAIN_RK3036(13, 17, 24, false),
+	[RK3036_PD_PERI]	= DOMAIN_RK3036(12, 18, 25, false),
+	[RK3036_PD_VIO]		= DOMAIN_RK3036(11, 19, 26, false),
+	[RK3036_PD_VPU]		= DOMAIN_RK3036(10, 20, 27, false),
+	[RK3036_PD_GPU]		= DOMAIN_RK3036(9, 21, 28, false),
+	[RK3036_PD_SYS]		= DOMAIN_RK3036(8, 22, 29, false),
+};
+
 static const struct rockchip_domain_info rk3288_pm_domains[] = {
 	[RK3288_PD_VIO]		= DOMAIN_RK3288(7, 7, 4, false),
 	[RK3288_PD_HEVC]	= DOMAIN_RK3288(14, 10, 9, false),
@@ -768,6 +787,15 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(31, 31, 29, true),
 };
 
+static const struct rockchip_pmu_info rk3036_pmu = {
+	.req_offset = 0x148,
+	.idle_offset = 0x14c,
+	.ack_offset = 0x14c,
+
+	.num_domains = ARRAY_SIZE(rk3036_pm_domains),
+	.domain_info = rk3036_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3288_pmu = {
 	.pwr_offset = 0x08,
 	.status_offset = 0x0c,
@@ -843,6 +871,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 	{
+		.compatible = "rockchip,rk3036-power-controller",
+		.data = (void *)&rk3036_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3288-power-controller",
 		.data = (void *)&rk3288_pmu,
 	},
-- 
1.9.1
