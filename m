Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965961AbeBPMKK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:10:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32968 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965864AbeBPMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:10:07 -0500
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
Subject: [PATCH v3 3/6] phy: rockchip-typec: enable usb3 host during usb3 phy power on
Date: Fri, 16 Feb 2018 13:09:53 +0100
Message-Id: <20180216120956.19034-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216120956.19034-1-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
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
Changes since v2:
- None.
Changes since v1:
- Use the registers offsets from the driver not the DT.

 drivers/phy/rockchip/phy-rockchip-typec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 5f660f6b9f95..54dc52a948ef 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -362,6 +362,8 @@ struct usb3phy_reg {
  * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
  * @external_psm: the register of type-c phy external psm clock.
  * @pipe_status: the register of type-c phy pipe status.
+ * @usb3_host_disable: the register of type-c usb3 host disable.
+ * @usb3_host_port: the register of type-c usb3 host port.
  */
 struct rockchip_usb3phy_port_cfg {
 	unsigned int reg;
@@ -369,6 +371,8 @@ struct rockchip_usb3phy_port_cfg {
 	struct usb3phy_reg usb3tousb2_en;
 	struct usb3phy_reg external_psm;
 	struct usb3phy_reg pipe_status;
+	struct usb3phy_reg usb3_host_disable;
+	struct usb3phy_reg usb3_host_port;
 };
 
 struct rockchip_typec_phy {
@@ -440,6 +444,8 @@ static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
 		.usb3tousb2_en	= { 0xe580, 3, 19 },
 		.external_psm	= { 0xe588, 14, 30 },
 		.pipe_status	= { 0xe5c0, 0, 0 },
+		.usb3_host_disable = { 0x2434, 0, 16 },
+		.usb3_host_port = { 0x2434, 12, 28 },
 	},
 	{
 		.reg = 0xff800000,
@@ -447,6 +453,8 @@ static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
 		.usb3tousb2_en	= { 0xe58c, 3, 19 },
 		.external_psm	= { 0xe594, 14, 30 },
 		.pipe_status	= { 0xe5c0, 16, 16 },
+		.usb3_host_disable = { 0x2444, 0, 16 },
+		.usb3_host_port = { 0x2444, 12, 28 },
 	},
 	{ /* sentinel */ }
 };
@@ -879,6 +887,9 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 		regmap_read(tcphy->grf_regs, reg->offset, &val);
 		if (!(val & BIT(reg->enable_bit))) {
 			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
+			/* enable usb3 host */
+			property_enable(tcphy, &cfg->usb3_host_disable, 0);
+			property_enable(tcphy, &cfg->usb3_host_port, 1);
 			goto unlock_ret;
 		}
 		usleep_range(10, 20);
-- 
2.15.1
