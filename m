Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeDFOFw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:05:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41776 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeDFOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:05:48 -0400
X-Google-Smtp-Source: AIpwx483zy0fMVoQPQ6TFu9i3jJDskMYKW7aLDu8UP5wccv9ILfi4esZ4Rj3QiwiyfwyqtqixjUKtg==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: netdev@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dp83640: Ensure against premature access to PHY registers after reset
Date: Fri,  6 Apr 2018 16:05:40 +0200
Message-Id: <20180406140540.13511-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/net/phy/dp83640.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 654f42d00092..48403170096a 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1207,6 +1207,22 @@ static void dp83640_remove(struct phy_device *phydev)
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
+	 * operations with the DP83640." */
+	udelay(3);
+
+	return 0;
+}
+
 static int dp83640_config_init(struct phy_device *phydev)
 {
 	struct dp83640_private *dp83640 = phydev->priv;
@@ -1501,6 +1517,7 @@ static struct phy_driver dp83640_driver = {
 	.flags		= PHY_HAS_INTERRUPT,
 	.probe		= dp83640_probe,
 	.remove		= dp83640_remove,
+	.soft_reset	= dp83640_soft_reset,
 	.config_init	= dp83640_config_init,
 	.ack_interrupt  = dp83640_ack_interrupt,
 	.config_intr    = dp83640_config_intr,
-- 
2.16.3
