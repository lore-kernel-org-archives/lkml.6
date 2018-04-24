Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDXQJM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:09:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58087 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeDXQJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:09:07 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] net: phy: allow scanning busses with missing phys
Date: Tue, 24 Apr 2018 18:09:04 +0200
Message-Id: <20180424160904.32457-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MDIO busses will error out when trying to read a phy address with no
phy present at that address. In that case, probing the bus will fail
because __mdiobus_register() is scanning the bus for all possible phys
addresses.

In case MII_PHYSID1 returns -EIO or -ENODEV, consider there is no phy at
this address and set the phy ID to 0xffffffff which is then properly
handled in get_phy_device().

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/phy/phy_device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ac23322a32e1..9e4ba8e80a18 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -535,8 +535,17 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
 
 	/* Grab the bits from PHYIR1, and put them in the upper half */
 	phy_reg = mdiobus_read(bus, addr, MII_PHYSID1);
-	if (phy_reg < 0)
+	if (phy_reg < 0) {
+		/* if there is no device, return without an error so scanning
+		 * the bus works properly
+		 */
+		if (phy_reg == -EIO || phy_reg == -ENODEV) {
+			*phy_id = 0xffffffff;
+			return 0;
+		}
+
 		return -EIO;
+	}
 
 	*phy_id = (phy_reg & 0xffff) << 16;
 
-- 
2.17.0
