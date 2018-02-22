Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeBVVk0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:40:26 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47090 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBVVkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:40:25 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Joachim Eastwood <manabian@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] phy: lpc18xx-usb-otg: error handling in lpc18xx_usb_otg_phy_power_on()
Date: Fri, 23 Feb 2018 00:40:11 +0300
Message-Id: <1519335611-28644-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If regmap_update_bits() fails in lpc18xx_usb_otg_phy_power_on(),
lpc->clk is left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/phy/phy-lpc18xx-usb-otg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-lpc18xx-usb-otg.c b/drivers/phy/phy-lpc18xx-usb-otg.c
index 3b7a71eb5b7e..7de280a45421 100644
--- a/drivers/phy/phy-lpc18xx-usb-otg.c
+++ b/drivers/phy/phy-lpc18xx-usb-otg.c
@@ -60,8 +60,14 @@ static int lpc18xx_usb_otg_phy_power_on(struct phy *phy)
 		return ret;
 
 	/* The bit in CREG is cleared to enable the PHY */
-	return regmap_update_bits(lpc->reg, LPC18XX_CREG_CREG0,
+	ret = regmap_update_bits(lpc->reg, LPC18XX_CREG_CREG0,
 				  LPC18XX_CREG_CREG0_USB0PHY, 0);
+	if (ret) {
+		clk_disable(lpc->clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int lpc18xx_usb_otg_phy_power_off(struct phy *phy)
-- 
2.7.4
