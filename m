Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033116AbeBNQzn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:55:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50746 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbeBNQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:54:58 -0500
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
Subject: [PATCH v2 4/6] phy: rockchip-typec: force to USB2 if DP at 4 lanes mode
Date: Wed, 14 Feb 2018 17:54:45 +0100
Message-Id: <20180214165447.12181-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214165447.12181-1-enric.balletbo@collabora.com>
References: <20180214165447.12181-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Zhong <zyw@rock-chips.com>

The usb3tousb2_en BIT will be clear to 0 in probe(), it make USB
controller work at USB3 mode, and if the USB phy is turned on with DP
only mode(4 lanes DP), the rockchip_usb3_phy_power_on() will return
directly, so usb3_host_disable and usb3_host_port these 2 BIT will keep
a same value as coreboot. In coreboot, these 3 BITs are set as USB2
mode, but now one of the bits is changed to USB3, it make USB controller
work at a unknown status.

These 3 BITs should be changed to USB2, if the Type-C works at 4 lanes
mode, and then switch it back to USB3 mode, when USB disconnect.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- Use the registers offsets from the driver not the DT.

 drivers/phy/rockchip/phy-rockchip-typec.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 40c5e7d6b5cb..95cd5db5c910 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -841,6 +841,18 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 	return mode;
 }
 
+static int tcphy_cfg_usb3_to_usb2_only(struct rockchip_typec_phy *tcphy,
+				       bool value)
+{
+	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+
+	property_enable(tcphy, &cfg->usb3tousb2_en, value);
+	property_enable(tcphy, &cfg->usb3_host_disable, value);
+	property_enable(tcphy, &cfg->usb3_host_port, !value);
+
+	return 0;
+}
+
 static int rockchip_usb3_phy_power_on(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
@@ -858,8 +870,10 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 	}
 
 	/* DP-only mode; fall back to USB2 */
-	if (!(new_mode & (MODE_DFP_USB | MODE_UFP_USB)))
+	if (!(new_mode & (MODE_DFP_USB | MODE_UFP_USB))) {
+		tcphy_cfg_usb3_to_usb2_only(tcphy, true);
 		goto unlock_ret;
+	}
 
 	if (tcphy->mode == new_mode)
 		goto unlock_ret;
@@ -875,9 +889,9 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 		regmap_read(tcphy->grf_regs, reg->offset, &val);
 		if (!(val & BIT(reg->enable_bit))) {
 			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
+
 			/* enable usb3 host */
-			property_enable(tcphy, &cfg->usb3_host_disable, 0);
-			property_enable(tcphy, &cfg->usb3_host_port, 1);
+			tcphy_cfg_usb3_to_usb2_only(tcphy, false);
 			goto unlock_ret;
 		}
 		usleep_range(10, 20);
@@ -898,6 +912,7 @@ static int rockchip_usb3_phy_power_off(struct phy *phy)
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
 
 	mutex_lock(&tcphy->lock);
+	tcphy_cfg_usb3_to_usb2_only(tcphy, false);
 
 	if (tcphy->mode == MODE_DISCONNECT)
 		goto unlock;
-- 
2.15.1
