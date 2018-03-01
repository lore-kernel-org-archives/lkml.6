Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966931AbeCAJ17 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:27:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966894AbeCAJYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:24:36 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: kishon@ti.com, heiko@sntech.de
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] phy: rockchip-typec: fall back to working in host-mode if extcon is missing.
Date: Thu,  1 Mar 2018 10:24:15 +0100
Message-Id: <20180301092420.1191-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301092420.1191-1-enric.balletbo@collabora.com>
References: <20180301092420.1191-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the rockchip typec-phy does fail probing when no extcon is
detected. Some boards get the cable-state via the extcon interface and
have this supported, other boards seem to use the fusb302 chip or
another but the driver currently does not seem to utilize the extcon
interface to report the cable-state. That's required to detect
cable-state changes but a missing extcon shouldn't fail to probe,
instead, should just fall back to working in host-mode if it cannot get
the extcon.

Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/phy/rockchip/phy-rockchip-typec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 7492c8978217..3741afab5cd2 100644
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
 
@@ -1115,9 +1118,9 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 
 	tcphy->extcon = extcon_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(tcphy->extcon)) {
-		if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
-			dev_err(dev, "Invalid or missing extcon\n");
-		return PTR_ERR(tcphy->extcon);
+		if (PTR_ERR(tcphy->extcon) == -EPROBE_DEFER)
+			return PTR_ERR(tcphy->extcon);
+		tcphy->extcon = NULL;
 	}
 
 	pm_runtime_enable(dev);
-- 
2.16.1
