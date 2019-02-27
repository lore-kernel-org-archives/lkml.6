Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE8620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfB0MN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:13:29 -0500
Received: from mail.landisgyr.com ([213.95.165.69]:33448 "EHLO
        mail.landisgyr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbfB0MN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:13:28 -0500
Received: from indelpc523.ap.bm.net (unknown [10.49.130.40])
        by mail.landisgyr.com (Postfix) with ESMTP id 481ED32D702;
        Wed, 27 Feb 2019 13:13:23 +0100 (CET)
From:   Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
Cc:     t.rajasingh@landisgyr.com,
        Rajasingh Thavamani <T.Rajasingh@landisgyr.com>,
        Alexander Onnasch <alexander.onnasch@landisgyr.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] net: phy: Micrel KSZ8061: link failure after cable connect
Date:   Wed, 27 Feb 2019 17:43:19 +0530
Message-Id: <20190227121319.4106-1-T.Rajasingh@landisgyr.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Micrel KSZ8061 PHY, the link may occasionally not come up after
Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
sheet 80000688A.pdf descripes the problem and possible workarounds in
detail, see below.
The batch implements workaround 1, which permanently fixes the issue.

DESCRIPTION
Link-up may not occur properly when the Ethernet cable is initially
connected. This issue occurs more commonly when the cable is connected
slowly, but it may occur any time a cable is connected. This issue occurs
in the auto-negotiation circuit, and will not occur if auto-negotiation
is disabled (which requires that the two link partners be set to the
same speed and duplex).

END USER IMPLICATIONS
When this issue occurs, link is not established. Subsequent cable
plug/unplaug cycle will not correct the issue.

WORk AROUND
There are four approaches to work around this issue:
1. This issue can be prevented by setting bit 15 in MMD device address 1,
   register 2, prior to connecting the cable or prior to setting the
   Restart Auto-negotiation bit in register 0h. The MMD registers are
   accessed via the indirect access registers Dh and Eh, or via the Micrel
   EthUtil utility as shown here:
   . if using the EthUtil utility (usually with a Micrel KSZ8061
     Evaluation Board), type the following commands:
     > address 1
     > mmd 1
     > iw 2 b61a
   . Alternatively, write the following registers to write to the
     indirect MMD register:
     Write register Dh, data 0001h
     Write register Eh, data 0002h
     Write register Dh, data 4001h
     Write register Eh, data B61Ah
2. The issue can be avoided by disabling auto-negotiation in the KSZ8061,
   either by the strapping option, or by clearing bit 12 in register 0h.
   Care must be taken to ensure that the KSZ8061 and the link partner
   will link with the same speed and duplex. Note that the KSZ8061
   defaults to full-duplex when auto-negotiation is off, but other
   devices may default to half-duplex in the event of failed
   auto-negotiation.
3. The issue can be avoided by connecting the cable prior to powering-up
   or resetting the KSZ8061, and leaving it plugged in thereafter.
4. If the above measures are not taken and the problem occurs, link can
   be recovered by setting the Restart Auto-Negotiation bit in
   register 0h, or by resetting or power cycling the device. Reset may
   be either hardware reset or software reset (register 0h, bit 15).

PLAN
This errata will not be corrected in the future revision.

Fixes: 7ab59dc15e2f ("drivers/net/phy/micrel_phy: Add support for new PHYs")
Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Signed-off-by: Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/micrel.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index b1f959935f50..b7df0295a3ca 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -344,6 +344,17 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
 }
 
+static int ksz8061_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
+	if (ret)
+		return ret;
+
+	return kszphy_config_init(phydev);
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -1040,7 +1051,7 @@ static struct phy_driver ksphy_driver[] = {
 	.name		= "Micrel KSZ8061",
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.features	= PHY_BASIC_FEATURES,
-	.config_init	= kszphy_config_init,
+	.config_init	= ksz8061_config_init,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
 	.suspend	= genphy_suspend,
-- 
2.17.1

