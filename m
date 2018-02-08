Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBHPUu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:20:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47444 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:20:48 -0500
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
Subject: [PATCH 1/3] phy: rockchip-typec: enable usb3 host during usb3 phy power on
Date: Thu,  8 Feb 2018 16:20:26 +0100
Message-Id: <20180208152028.9997-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William wu <wulf@rock-chips.com>

We have forced usb3 to work in usb2 only mode in firmware by setting
usb3tousb2_en (bit3 of GRF_USB3PHY0/1_CON0) to 1, and setting
host_u3_port_disable (bit0 of GRF_USB3OTG0/1_CON1) to 1 and host_u3_port
(bit15~12 of GRF_USB3OTG0/1_CON1) to 0. So we need to re-enable usb3
host.

Note that the RK3399 TRM suggests that we should keep the whole usb3
controller in reset for the duration of the Type-C PHY initialization.
However, it's hard to assert the reset in the current framework of
reset. And according to the TRM, it doesn't require that we should
clear the usb3tousb2 bit before pipe ready. So let's enable the usb3
host after pipe ready to avoid the Type-C PHY initialization failure.

Signed-off-by: William wu <wulf@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi  |  4 ++++
 drivers/phy/rockchip/phy-rockchip-typec.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 2f2dee0e2f3c..6c72f8aca74c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1438,6 +1438,8 @@
 		rockchip,grf = <&grf>;
 		rockchip,typec-conn-dir = <0xe580 0 16>;
 		rockchip,usb3tousb2-en = <0xe580 3 19>;
+		rockchip,usb3-host-disable = <0x2434 0 16>;
+		rockchip,usb3-host-port = <0x2434 12 28>;
 		rockchip,external-psm = <0xe588 14 30>;
 		rockchip,pipe-status = <0xe5c0 0 0>;
 		rockchip,uphy-dp-sel = <0x6268 19 19>;
@@ -1468,6 +1470,8 @@
 		rockchip,grf = <&grf>;
 		rockchip,typec-conn-dir = <0xe58c 0 16>;
 		rockchip,usb3tousb2-en = <0xe58c 3 19>;
+		rockchip,usb3-host-disable = <0x2444 0 16>;
+		rockchip,usb3-host-port = <0x2444 12 28>;
 		rockchip,external-psm = <0xe594 14 30>;
 		rockchip,pipe-status = <0xe5c0 16 16>;
 		rockchip,uphy-dp-sel = <0x6268 3 19>;
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 3ed44bee0fdc..cc07f528cc48 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -358,6 +358,8 @@ struct usb3phy_reg {
 struct rockchip_usb3phy_port_cfg {
 	struct usb3phy_reg typec_conn_dir;
 	struct usb3phy_reg usb3tousb2_en;
+	struct usb3phy_reg usb3_host_disable;
+	struct usb3phy_reg usb3_host_port;
 	struct usb3phy_reg external_psm;
 	struct usb3phy_reg pipe_status;
 	struct usb3phy_reg uphy_dp_sel;
@@ -853,6 +855,9 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 		regmap_read(tcphy->grf_regs, reg->offset, &val);
 		if (!(val & BIT(reg->enable_bit))) {
 			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
+			/* enable usb3 host */
+			property_enable(tcphy, &cfg->usb3_host_disable, 0);
+			property_enable(tcphy, &cfg->usb3_host_port, 1);
 			goto unlock_ret;
 		}
 		usleep_range(10, 20);
@@ -1023,6 +1028,16 @@ static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
 	if (ret)
 		return ret;
 
+	ret = tcphy_get_param(dev, &cfg->usb3_host_disable,
+			      "rockchip,usb3-host-disable");
+	if (ret)
+		return ret;
+
+	ret = tcphy_get_param(dev, &cfg->usb3_host_port,
+			      "rockchip,usb3-host-port");
+	if (ret)
+		return ret;
+
 	ret = tcphy_get_param(dev, &cfg->external_psm,
 			      "rockchip,external-psm");
 	if (ret)
-- 
2.15.1
