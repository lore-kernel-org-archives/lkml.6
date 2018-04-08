Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDHURO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:17:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDHURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:17:12 -0400
X-Google-Smtp-Source: AIpwx4+zrPOjcpVd4Ft1i3qY4cGXe3cbOcNaejmvLyG1kog4kCHw8pXMJpJdA69kc14OkhDg51qJfg==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: netdev@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dp83640: Ensure against premature access to PHY registers after reset
Date: Sun,  8 Apr 2018 22:17:01 +0200
Message-Id: <20180408201702.23299-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180406170844.4248-1-esben.haabendal@gmail.com>
References: <20180406170844.4248-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

The datasheet specifies a 3uS pause after performing a software
reset. The default implementation of genphy_soft_reset() does not
provide this, so implement soft_reset with the needed pause.

Signed-off-by: Esben Haabendal <eha@deif.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/dp83640.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 654f42d00092..a6c87793d899 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1207,6 +1207,23 @@ static void dp83640_remove(struct phy_device *phydev)
 	kfree(dp83640);
 }
 
+static int dp83640_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_soft_reset(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* From DP83640 datasheet: "Software driver code must wait 3 us
+	 * following a software reset before allowing further serial MII
+	 * operations with the DP83640."
+	 */
+	udelay(10);		/* Taking udelay inaccuracy into account */
+
+	return 0;
+}
+
 static int dp83640_config_init(struct phy_device *phydev)
 {
 	struct dp83640_private *dp83640 = phydev->priv;
@@ -1501,6 +1518,7 @@ static struct phy_driver dp83640_driver = {
 	.flags		= PHY_HAS_INTERRUPT,
 	.probe		= dp83640_probe,
 	.remove		= dp83640_remove,
+	.soft_reset	= dp83640_soft_reset,
 	.config_init	= dp83640_config_init,
 	.ack_interrupt  = dp83640_ack_interrupt,
 	.config_intr    = dp83640_config_intr,
-- 
2.16.3
