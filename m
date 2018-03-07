Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934366AbeCGWnh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:43:37 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41582 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754498AbeCGWnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:43:35 -0500
From: Brad Mouring <brad.mouring@ni.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>
CC: Mark Rutland <mark.rutland@arm.com>, <netdev@vger.kernel.org>,
        "Julia Cartwright" <julia@ni.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Brad Mouring <brad.mouring@ni.com>
Subject: [PATCH 1/2] net: macb: Add phy-handle DT support
Date: Wed, 7 Mar 2018 16:42:56 -0600
Message-ID: <20180307224257.1959-1-brad.mouring@ni.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This optional binding (as described in the ethernet DT bindings doc)
directs the netdev to the phydev to use. This is useful for a phy
chip that has >1 phy in it, and two netdevs are using the same phy
chip (i.e. the second mac's phy lives on the first mac's MDIO bus)

The devicetree snippet would look something like this:

ethernet@feedf00d {
	...
	phy-handle = <&phy0> // the first netdev is physically wired to phy0
	...
	phy0: phy@0 {
		...
		reg = <0x0> // MDIO address 0
		...
	}
	phy1: phy@1 {
		...
		reg = <0x1> // MDIO address 1
		...
	}
...
}

ethernet@deadbeef {
	...
	phy-handle = <&phy1> // tells the driver to use phy1 on the
						 // first mac's mdio bus (it's wired thusly)
	...
}

The work done to add the phy_node in the first place (dacdbb4dfc1a1:
"net: macb: add fixed-link node support") will consume the
device_node (if found).

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e84afcf1ecb5..cc5b9e6e3526 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -567,6 +567,9 @@ static int macb_mii_init(struct macb *bp)
 
 			err = mdiobus_register(bp->mii_bus);
 		} else {
+			/* attempt to find a phy-handle */
+			bp->phy_node = of_parse_phandle(np, "phy-handle", 0);
+
 			/* try dt phy registration */
 			err = of_mdiobus_register(bp->mii_bus, np);
 
-- 
2.16.2
