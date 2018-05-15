Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEOJXx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:23:53 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:34957 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:23:51 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: khilman@baylibre.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <6dd99d25389c257f3b77926f8c016ae8>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: David Wu <david.wu@rock-chips.com>
To: khilman@baylibre.com, heiko@sntech.de
Cc: rafael.j.wysocki@intel.com, nm@ti.com, huangtao@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for PX30
Date: Tue, 15 May 2018 17:23:37 +0800
Message-Id: <1526376217-3833-1-git-send-email-david.wu@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary data for handling io voltage domains on PX30.
As interesting tidbit, the PX30 contains two separate iodomain areas.
One in the regular General Register Files (GRF) and one in PMUGRF in the
pmu power domain.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../bindings/power/rockchip-io-domain.txt          |  2 +
 drivers/power/avs/rockchip-io-domain.c             | 68 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index 4a4766e..c2595ba 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -31,6 +31,8 @@ SoC is on the same page.
 
 Required properties:
 - compatible: should be one of:
+  - "rockchip,px30-io-voltage-domain" for px30
+  - "rockchip,px30-pmu-io-voltage-domain" for px30 pmu-domains
   - "rockchip,rk3188-io-voltage-domain" for rk3188
   - "rockchip,rk3228-io-voltage-domain" for rk3228
   - "rockchip,rk3288-io-voltage-domain" for rk3288
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index ed2b109..41c2b83 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -39,6 +39,10 @@
 #define MAX_VOLTAGE_1_8		1980000
 #define MAX_VOLTAGE_3_3		3600000
 
+#define PX30_IO_VSEL			0x180
+#define PX30_IO_VSEL_VCCIO6_SRC		BIT(0)
+#define PX30_IO_VSEL_VCCIO6_SUPPLY_NUM	1
+
 #define RK3288_SOC_CON2			0x24c
 #define RK3288_SOC_CON2_FLASH0		BIT(7)
 #define RK3288_SOC_FLASH_SUPPLY_NUM	2
@@ -151,6 +155,25 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void px30_iodomain_init(struct rockchip_iodomain *iod)
+{
+	int ret;
+	u32 val;
+
+	/* if no VCCIO0 supply we should leave things alone */
+	if (!iod->supplies[PX30_IO_VSEL_VCCIO6_SUPPLY_NUM].reg)
+		return;
+
+	/*
+	 * set vccio0 iodomain to also use this framework
+	 * instead of a special gpio.
+	 */
+	val = PX30_IO_VSEL_VCCIO6_SRC | (PX30_IO_VSEL_VCCIO6_SRC << 16);
+	ret = regmap_write(iod->grf, PX30_IO_VSEL, val);
+	if (ret < 0)
+		dev_warn(iod->dev, "couldn't update vccio0 ctrl\n");
+}
+
 static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
 {
 	int ret;
@@ -227,6 +250,43 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 		dev_warn(iod->dev, "couldn't update pmu io iodomain ctrl\n");
 }
 
+static const struct rockchip_iodomain_soc_data soc_data_px30 = {
+	.grf_offset = 0x180,
+	.supply_names = {
+		NULL,
+		"vccio6",
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio4",
+		"vccio5",
+		"vccio_oscgpi",
+	},
+	.init = px30_iodomain_init,
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_px30_pmu = {
+	.grf_offset = 0x100,
+	.supply_names = {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"pmuio1",
+		"pmuio2",
+	},
+};
+
 /*
  * On the rk3188 the io-domains are handled by a shared register with the
  * lower 8 bits being still being continuing drive-strength settings.
@@ -381,6 +441,14 @@ static const struct rockchip_iodomain_soc_data soc_data_rv1108_pmu = {
 
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
+		.compatible = "rockchip,px30-io-voltage-domain",
+		.data = (void *)&soc_data_px30
+	},
+	{
+		.compatible = "rockchip,px30-pmu-io-voltage-domain",
+		.data = (void *)&soc_data_px30_pmu
+	},
+	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
 		.data = &soc_data_rk3188
 	},
-- 
2.7.4
