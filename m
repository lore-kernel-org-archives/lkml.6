Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033106AbeBNQzX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:55:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50734 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032978AbeBNQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:54:59 -0500
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
Subject: [PATCH v2 5/6] phy: rockchip-typec: support DP phy switch
Date: Wed, 14 Feb 2018 17:54:46 +0100
Message-Id: <20180214165447.12181-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214165447.12181-1-enric.balletbo@collabora.com>
References: <20180214165447.12181-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Zhong <zyw@rock-chips.com>

There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
only one PHY can connect to DP controller at one time, the other should
be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
set this bit means enable PHY 1, clear this bit means enable PHY 0.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- This patch is new on these series but as a consequence of the work
  done need to be reworked. The patch was send some time ago [1] but
  got stuck, so it's also and attempt to revive it.

[1] https://lkml.org/lkml/2017/2/10/74 

 drivers/phy/rockchip/phy-rockchip-typec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 95cd5db5c910..e68bcc93e359 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -365,6 +365,7 @@ struct rockchip_usb3phy_port_cfg {
 	struct usb3phy_reg pipe_status;
 	struct usb3phy_reg usb3_host_disable;
 	struct usb3phy_reg usb3_host_port;
+	struct usb3phy_reg uphy_dp_sel;
 };
 
 static const struct rockchip_usb3phy_port_cfg tcphy0_port_cfg = {
@@ -374,6 +375,7 @@ static const struct rockchip_usb3phy_port_cfg tcphy0_port_cfg = {
 	.pipe_status	= { 0xe5c0, 0, 0 },
 	.usb3_host_disable = { 0x2434, 0, 16 },
 	.usb3_host_port = { 0x2434, 12, 28 },
+	.uphy_dp_sel	= { 0x6268, 19, 19 },
 };
 
 static const struct rockchip_usb3phy_port_cfg tcphy1_port_cfg = {
@@ -383,6 +385,7 @@ static const struct rockchip_usb3phy_port_cfg tcphy1_port_cfg = {
 	.pipe_status	= { 0xe5c0, 16, 16 },
 	.usb3_host_disable = { 0x2444, 0, 16 },
 	.usb3_host_port = { 0x2444, 12, 28 },
+	.uphy_dp_sel	= { 0x6268, 3, 19 },
 };
 
 struct rockchip_typec_phy {
@@ -844,7 +847,7 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 static int tcphy_cfg_usb3_to_usb2_only(struct rockchip_typec_phy *tcphy,
 				       bool value)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 
 	property_enable(tcphy, &cfg->usb3tousb2_en, value);
 	property_enable(tcphy, &cfg->usb3_host_disable, value);
@@ -935,6 +938,7 @@ static const struct phy_ops rockchip_usb3_phy_ops = {
 static int rockchip_dp_phy_power_on(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 	int new_mode, ret = 0;
 	u32 val;
 
@@ -967,6 +971,8 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
 	if (ret)
 		goto unlock_ret;
 
+	property_enable(tcphy, &cfg->uphy_dp_sel, 1);
+
 	ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
 				 val, val & DP_MODE_A2, 1000,
 				 PHY_MODE_SET_TIMEOUT);
-- 
2.15.1
