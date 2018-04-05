Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeDEOBB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:01:01 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13435 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeDEOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:00:59 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 05 Apr 2018 07:00:50 -0700
From: Bhadram Varka <vbhadram@nvidia.com>
To: Esben Haabendal <esben.haabendal@gmail.com>
CC: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net: phy: marvell: Enable interrupt function on LED2 pin
Thread-Topic: [PATCH] net: phy: marvell: Enable interrupt function on LED2 pin
Thread-Index: AQHTzOMZopkF1giP8Ue0qxO7VwjMg6PyMPug
Date: Thu, 5 Apr 2018 14:00:53 +0000
Message-ID: <4d9e0665abf7408988fc4ce20c26a08f@bgmail102.nvidia.com>
References: <20180405133504.12257-1-esben.haabendal@gmail.com>
In-Reply-To: <20180405133504.12257-1-esben.haabendal@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.25.73.182]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esben,

-----Original Message-----
From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On Behalf Of Esben Haabendal
Sent: Thursday, April 05, 2018 7:05 PM
To: netdev@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>; Rasmus Villemoes <rasmus.villemoes@prevas.dk>; Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>; open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: phy: marvell: Enable interrupt function on LED2 pin

From: Esben Haabendal <eha@deif.com>

The LED2[2]/INTn pin on Marvell 88E1318S as well as 88E1510/12/14/18 needs to be configured to be usable as interrupt not only when WOL is enabled, but whenever we rely on interrupts from the PHY.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/phy/marvell.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c index 0e0978d8a0eb..f03a510f1247 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -457,6 +457,21 @@ static int marvell_of_reg_init(struct phy_device *phydev)  }  #endif /* CONFIG_OF_MDIO */
 
+static int m88e1318_config_intr(struct phy_device *phydev) {
+	int err;
+
+	err = marvell_config_intr(phydev);
+	if (err)
+		return err;
+
+	/* Setup LED[2] as interrupt pin (active low) */
+	return phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
+			  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
+			  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+			  MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);

Can we move this part of the code to m88e1121_config_init() ?

Every time whether we disable or enable the interrupts this part of code will execute.

Thanks!
