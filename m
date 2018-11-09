Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDE4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8220883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB8220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeKIR6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:58:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35738 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeKIR6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:58:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 89B5E207B0; Fri,  9 Nov 2018 09:18:38 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4162B2039F;
        Fri,  9 Nov 2018 09:18:38 +0100 (CET)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net] net: mvneta: Don't advertise 2.5G modes
Date:   Fri,  9 Nov 2018 09:17:33 +0100
Message-Id: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.5G speed relies on the SerDes lanes being configured
accordingly. The lanes have to be reconfigured to switch between
1G and 2.5G, and for now only the bootloader does this configuration.

In the case we add a Comphy driver to handle switching the lanes
dynamically, it's better for now to stick with supporting only 1G and
add advertisement for 2.5G once we really are capable of handling both
speeds without problem.

Since the interface mode is initialy taken from the DT, we want to make
sure that adding comphy support won't break boards that don't update
their dtb.

Fixes: da58a931f248 ("net: mvneta: Add support for 2500Mbps SGMII")
Reported-by: Andrew Lunn <andrew@lunn.ch>
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5bfd349bf41a..c19ecd153499 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3343,7 +3343,6 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 	if (state->interface != PHY_INTERFACE_MODE_NA &&
 	    state->interface != PHY_INTERFACE_MODE_QSGMII &&
 	    state->interface != PHY_INTERFACE_MODE_SGMII &&
-	    state->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    !phy_interface_mode_is_8023z(state->interface) &&
 	    !phy_interface_mode_is_rgmii(state->interface)) {
 		bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
@@ -3357,14 +3356,9 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 	/* Asymmetric pause is unsupported */
 	phylink_set(mask, Pause);
 
-	/* We cannot use 1Gbps when using the 2.5G interface. */
-	if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
-		phylink_set(mask, 2500baseT_Full);
-		phylink_set(mask, 2500baseX_Full);
-	} else {
-		phylink_set(mask, 1000baseT_Full);
-		phylink_set(mask, 1000baseX_Full);
-	}
+	/* Half-duplex at speeds higher than 100Mbit is unsupported */
+	phylink_set(mask, 1000baseT_Full);
+	phylink_set(mask, 1000baseX_Full);
 
 	if (!phy_interface_mode_is_8023z(state->interface)) {
 		/* 10M and 100M are only supported in non-802.3z mode */
-- 
2.11.0

