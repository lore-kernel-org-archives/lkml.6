Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033079AbeBNQy7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:54:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50734 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033056AbeBNQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:54:57 -0500
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
Subject: [PATCH v2 3/6] phy: rockchip-typec: enable usb3 host during usb3 phy power on
Date: Wed, 14 Feb 2018 17:54:44 +0100
Message-Id: <20180214165447.12181-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214165447.12181-1-enric.balletbo@collabora.com>
References: <20180214165447.12181-1-enric.balletbo@collabora.com>
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
Changes since v1:
- Use the registers offsets from the driver not the DT.

 drivers/phy/rockchip/phy-rockchip-typec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 291493d9e9b6..40c5e7d6b5cb 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -363,6 +363,8 @@ struct rockchip_usb3phy_port_cfg {
 	struct usb3phy_reg usb3tousb2_en;
 	struct usb3phy_reg external_psm;
 	struct usb3phy_reg pipe_status;
+	struct usb3phy_reg usb3_host_disable;
+	struct usb3phy_reg usb3_host_port;
 };
 
 static const struct rockchip_usb3phy_port_cfg tcphy0_port_cfg = {
@@ -370,6 +372,8 @@ static const struct rockchip_usb3phy_port_cfg tcphy0_port_cfg = {
 	.usb3tousb2_en	= { 0xe580, 3, 19 },
 	.external_psm	= { 0xe588, 14, 30 },
 	.pipe_status	= { 0xe5c0, 0, 0 },
+	.usb3_host_disable = { 0x2434, 0, 16 },
+	.usb3_host_port = { 0x2434, 12, 28 },
 };
 
 static const struct rockchip_usb3phy_port_cfg tcphy1_port_cfg = {
@@ -377,6 +381,8 @@ static const struct rockchip_usb3phy_port_cfg tcphy1_port_cfg = {
 	.usb3tousb2_en	= { 0xe58c, 3, 19 },
 	.external_psm	= { 0xe594, 14, 30 },
 	.pipe_status	= { 0xe5c0, 16, 16 },
+	.usb3_host_disable = { 0x2444, 0, 16 },
+	.usb3_host_port = { 0x2444, 12, 28 },
 };
 
 struct rockchip_typec_phy {
@@ -869,6 +875,9 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
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
