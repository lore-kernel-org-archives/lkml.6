Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033064AbeBNQy5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:54:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50706 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbeBNQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:54:55 -0500
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
Subject: [PATCH v2 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.
Date: Wed, 14 Feb 2018 17:54:42 +0100
Message-Id: <20180214165447.12181-1-enric.balletbo@collabora.com>
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
Changes since v1:
- This patch is new in this series to accomplish the purpose of get rid
  of some registers from the DT. Suggested by Rob Herring.

 drivers/phy/rockchip/phy-rockchip-typec.c | 74 ++++++++++++-------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 7492c8978217..291493d9e9b6 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -349,6 +349,9 @@
 #define MODE_DFP_USB			BIT(1)
 #define MODE_DFP_DP			BIT(2)
 
+#define TYPEC_PHY0_BASE_ADDRESS		0xff7c0000
+#define TYPEC_PHY1_BASE_ADDRESS		0xff800000
+
 struct usb3phy_reg {
 	u32 offset;
 	u32 enable_bit;
@@ -362,6 +365,20 @@ struct rockchip_usb3phy_port_cfg {
 	struct usb3phy_reg pipe_status;
 };
 
+static const struct rockchip_usb3phy_port_cfg tcphy0_port_cfg = {
+	.typec_conn_dir	= { 0xe580, 0, 16 },
+	.usb3tousb2_en	= { 0xe580, 3, 19 },
+	.external_psm	= { 0xe588, 14, 30 },
+	.pipe_status	= { 0xe5c0, 0, 0 },
+};
+
+static const struct rockchip_usb3phy_port_cfg tcphy1_port_cfg = {
+	.typec_conn_dir	= { 0xe58c, 0, 16 },
+	.usb3tousb2_en	= { 0xe58c, 3, 19 },
+	.external_psm	= { 0xe594, 14, 30 },
+	.pipe_status	= { 0xe5c0, 16, 16 },
+};
+
 struct rockchip_typec_phy {
 	struct device *dev;
 	void __iomem *base;
@@ -372,7 +389,7 @@ struct rockchip_typec_phy {
 	struct reset_control *uphy_rst;
 	struct reset_control *pipe_rst;
 	struct reset_control *tcphy_rst;
-	struct rockchip_usb3phy_port_cfg port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *port_cfgs;
 	/* mutex to protect access to individual PHYs */
 	struct mutex lock;
 
@@ -691,7 +708,7 @@ static void tcphy_dp_aux_calibration(struct rockchip_typec_phy *tcphy)
 
 static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 	int ret, i;
 	u32 val;
 
@@ -821,7 +838,7 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 static int rockchip_usb3_phy_power_on(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 	const struct usb3phy_reg *reg = &cfg->pipe_status;
 	int timeout, new_mode, ret = 0;
 	u32 val;
@@ -984,51 +1001,9 @@ static const struct phy_ops rockchip_dp_phy_ops = {
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
@@ -1071,7 +1046,7 @@ static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
 
 static void typec_phy_pre_init(struct rockchip_typec_phy *tcphy)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 
 	reset_control_assert(tcphy->tcphy_rst);
 	reset_control_assert(tcphy->uphy_rst);
@@ -1103,6 +1078,13 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(tcphy->base))
 		return PTR_ERR(tcphy->base);
 
+	if (res->start == TYPEC_PHY0_BASE_ADDRESS)
+		tcphy->port_cfgs = &tcphy0_port_cfg;
+	else if (res->start == TYPEC_PHY1_BASE_ADDRESS)
+		tcphy->port_cfgs = &tcphy1_port_cfg;
+	else
+		return -EINVAL;
+
 	ret = tcphy_parse_dt(tcphy, dev);
 	if (ret)
 		return ret;
-- 
2.15.1
