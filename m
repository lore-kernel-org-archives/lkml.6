Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965910AbeBPMKH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:10:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32938 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965781AbeBPMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:10:06 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.
Date: Fri, 16 Feb 2018 13:09:51 +0100
Message-Id: <20180216120956.19034-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding properties for various register fields in the DT doesn't scale and
this information should be in the driver instead.

Before this patch these registers (description below) were specified in
the DT, every register node contained 3 sections: offset, enable bit,
write mask bit.

 - rockchip,typec-conn-dir : the register of type-c connector direction,
   for type-c phy0, it must be <0xe580 0 16>;
   for type-c phy1, it must be <0xe58c 0 16>;
 - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2 enable
   control.
   for type-c phy0, it must be <0xe580 3 19>;
   for type-c phy1, it must be <0xe58c 3 19>;
 - rockchip,external-psm : the register of type-c phy external psm clock
   selection.
   for type-c phy0, it must be <0xe588 14 30>;
   for type-c phy1, it must be <0xe594 14 30>;
 - rockchip,pipe-status : the register of type-c phy pipe status.
   for type-c phy0, it must be <0xe5c0 0 0>;
   for type-c phy1, it must be <0xe5c0 16 16>;

After this patch these register definitions are in the driver. So can be
removed from the DT. Note that there are 2 type-c phys for RK3399 with
different offsets, the driver checks the phy base address of the running
instance and applies the right offsets.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
- Suggested by Heiko Stuebner:
  - Prefix phy config struct with rk3399_ as is rk3399-specific.
  - Create a new struct similar to things like the inno-usb2-phy
  - Select phy config according to the compatible and remove the
    specific constants.
Changes since v1:
- This patch is new in this series to accomplish the purpose of get rid
  of some registers from the DT. Suggested by Rob Herring.

 drivers/phy/rockchip/phy-rockchip-typec.c | 112 +++++++++++++++++-------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 7492c8978217..5f660f6b9f95 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -355,7 +355,16 @@ struct usb3phy_reg {
 	u32 write_enable;
 };
 
+/**
+ * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
+ * @reg: the base address for usb3-phy config.
+ * @typec_conn_dir: the register of type-c connector direction.
+ * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
+ * @external_psm: the register of type-c phy external psm clock.
+ * @pipe_status: the register of type-c phy pipe status.
+ */
 struct rockchip_usb3phy_port_cfg {
+	unsigned int reg;
 	struct usb3phy_reg typec_conn_dir;
 	struct usb3phy_reg usb3tousb2_en;
 	struct usb3phy_reg external_psm;
@@ -372,7 +381,7 @@ struct rockchip_typec_phy {
 	struct reset_control *uphy_rst;
 	struct reset_control *pipe_rst;
 	struct reset_control *tcphy_rst;
-	struct rockchip_usb3phy_port_cfg port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *port_cfgs;
 	/* mutex to protect access to individual PHYs */
 	struct mutex lock;
 
@@ -424,6 +433,24 @@ struct phy_reg dp_pll_cfg[] = {
 	{ 0x4,		CMN_DIAG_PLL1_INCLK_CTRL },
 };
 
+static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
+	{
+		.reg = 0xff7c0000,
+		.typec_conn_dir	= { 0xe580, 0, 16 },
+		.usb3tousb2_en	= { 0xe580, 3, 19 },
+		.external_psm	= { 0xe588, 14, 30 },
+		.pipe_status	= { 0xe5c0, 0, 0 },
+	},
+	{
+		.reg = 0xff800000,
+		.typec_conn_dir	= { 0xe58c, 0, 16 },
+		.usb3tousb2_en	= { 0xe58c, 3, 19 },
+		.external_psm	= { 0xe594, 14, 30 },
+		.pipe_status	= { 0xe5c0, 16, 16 },
+	},
+	{ /* sentinel */ }
+};
+
 static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy)
 {
 	u32 i, rdata;
@@ -691,7 +718,7 @@ static void tcphy_dp_aux_calibration(struct rockchip_typec_phy *tcphy)
 
 static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 	int ret, i;
 	u32 val;
 
@@ -821,7 +848,7 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 static int rockchip_usb3_phy_power_on(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 	const struct usb3phy_reg *reg = &cfg->pipe_status;
 	int timeout, new_mode, ret = 0;
 	u32 val;
@@ -984,51 +1011,9 @@ static const struct phy_ops rockchip_dp_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int tcphy_get_param(struct device *dev,
-			   struct usb3phy_reg *reg,
-			   const char *name)
-{
-	u32 buffer[3];
-	int ret;
-
-	ret = of_property_read_u32_array(dev->of_node, name, buffer, 3);
-	if (ret) {
-		dev_err(dev, "Can not parse %s\n", name);
-		return ret;
-	}
-
-	reg->offset = buffer[0];
-	reg->enable_bit = buffer[1];
-	reg->write_enable = buffer[2];
-	return 0;
-}
-
 static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
 			  struct device *dev)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
-	int ret;
-
-	ret = tcphy_get_param(dev, &cfg->typec_conn_dir,
-			      "rockchip,typec-conn-dir");
-	if (ret)
-		return ret;
-
-	ret = tcphy_get_param(dev, &cfg->usb3tousb2_en,
-			      "rockchip,usb3tousb2-en");
-	if (ret)
-		return ret;
-
-	ret = tcphy_get_param(dev, &cfg->external_psm,
-			      "rockchip,external-psm");
-	if (ret)
-		return ret;
-
-	ret = tcphy_get_param(dev, &cfg->pipe_status,
-			      "rockchip,pipe-status");
-	if (ret)
-		return ret;
-
 	tcphy->grf_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
 							  "rockchip,grf");
 	if (IS_ERR(tcphy->grf_regs)) {
@@ -1071,7 +1056,7 @@ static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
 
 static void typec_phy_pre_init(struct rockchip_typec_phy *tcphy)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 
 	reset_control_assert(tcphy->tcphy_rst);
 	reset_control_assert(tcphy->uphy_rst);
@@ -1092,17 +1077,43 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	struct rockchip_typec_phy *tcphy;
 	struct phy_provider *phy_provider;
 	struct resource *res;
-	int ret;
+	const struct rockchip_usb3phy_port_cfg *phy_cfgs;
+	const struct of_device_id *match;
+	int index, ret;
 
 	tcphy = devm_kzalloc(dev, sizeof(*tcphy), GFP_KERNEL);
 	if (!tcphy)
 		return -ENOMEM;
 
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match || !match->data) {
+		dev_err(dev, "phy configs are not assigned!\n");
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tcphy->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(tcphy->base))
 		return PTR_ERR(tcphy->base);
 
+	phy_cfgs = match->data;
+	/* find out a proper config which can be matched with dt. */
+	index = 0;
+	while (phy_cfgs[index].reg) {
+		if (phy_cfgs[index].reg == res->start) {
+			tcphy->port_cfgs = &phy_cfgs[index];
+			break;
+		}
+
+		++index;
+	}
+
+	if (!tcphy->port_cfgs) {
+		dev_err(dev, "no phy-config can be matched with %s node\n",
+			np->name);
+		return -EINVAL;
+	}
+
 	ret = tcphy_parse_dt(tcphy, dev);
 	if (ret)
 		return ret;
@@ -1162,8 +1173,11 @@ static int rockchip_typec_phy_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rockchip_typec_phy_dt_ids[] = {
-	{ .compatible = "rockchip,rk3399-typec-phy" },
-	{}
+	{
+		.compatible = "rockchip,rk3399-typec-phy",
+		.data = &rk3399_usb3phy_port_cfgs
+	},
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, rockchip_typec_phy_dt_ids);
-- 
2.15.1
