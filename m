Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032045AbeCAPZa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:25:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031977AbeCAPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:25:26 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: kishon@ti.com, heiko@sntech.de
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] phy: rockchip-typec: fall back to working in host-mode if extcon is missing.
Date: Thu,  1 Mar 2018 16:25:10 +0100
Message-Id: <20180301152515.20940-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301152515.20940-1-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the rockchip type-c phy does fail probing when no extcon is
detected. Some boards get the cable-state via the extcon interface and
have this supported, other boards seem to use the fusb302 chip or
another but the driver currently does not seem to utilize the extcon
interface to report the cable-state. And, other, just connect the type-c
to a standard USB-A port so use no controller at all. A missing extcon
shouldn't fail to probe, instead, should just fall back to working in
host-mode if it cannot get the extcon.

Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- [1/6] Keep the error handling of extcon (Heiko Stubner)

 drivers/phy/rockchip/phy-rockchip-typec.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 7492c8978217..e260067d2c98 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -782,6 +782,9 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 	u8 mode;
 	int ret;
 
+	if (!edev)
+		return MODE_DFP_USB;
+
 	ufp = extcon_get_state(edev, EXTCON_USB);
 	dp = extcon_get_state(edev, EXTCON_DISP_DP);
 
@@ -1115,9 +1118,13 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 
 	tcphy->extcon = extcon_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(tcphy->extcon)) {
-		if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
-			dev_err(dev, "Invalid or missing extcon\n");
-		return PTR_ERR(tcphy->extcon);
+		if (PTR_ERR(tcphy->extcon) == -ENODEV) {
+			tcphy->extcon = NULL;
+		} else {
+			if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
+				dev_err(dev, "Invalid or missing extcon\n");
+			return PTR_ERR(tcphy->extcon);
+		}
 	}
 
 	pm_runtime_enable(dev);
-- 
2.16.1
