Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B47ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999B821476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999B821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeINULe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:11:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46642 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeINULe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:11:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 073F020701; Fri, 14 Sep 2018 16:56:39 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id CD45220379;
        Fri, 14 Sep 2018 16:56:38 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net] net: mvpp2: let phylink manage the carrier state
Date:   Fri, 14 Sep 2018 16:56:35 +0200
Message-Id: <20180914145635.21813-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Net drivers using phylink shouldn't mess with the link carrier
themselves and should let phylink manage it. The mvpp2 driver wasn't
following this best practice as the mac_config() function made calls to
change the link carrier state. This led to wrongly reported carrier link
state which then triggered other issues. This patch fixes this
behaviour.

But the PPv2 driver relied on this misbehaviour in two cases: for fixed
links and when not using phylink (ACPI mode). The later was fixed by
adding an explicit call to link_up(), which when the ACPI mode will use
phylink should be removed.

The fixed link case was relying on the mac_config() function to set the
link up, as we found an issue in phylink_start() which assumes the
carrier is off. If not, the link_up() function is never called. To fix
this, a call to netif_carrier_off() is added just before phylink_start()
so that we do not introduce a regression in the driver.

Fixes: 4bb043262878 ("net: mvpp2: phylink support")
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---

Hi all,

The plan to fix this properly is to send this fix patch first, which can
go into the stable trees. Then once net will be merged into net-next,
I'll send other patches to fix the phylink_start() function directly and
to remove those explicit netif_carrier_off() calls in drivers using
phylink.

This way the stable trees can be fixed, and newer kernels will have a
proper solution.

Thanks,
Antoine

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 28500417843e..702fec82d806 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -58,6 +58,8 @@ static struct {
  */
 static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 			     const struct phylink_link_state *state);
+static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
+			      phy_interface_t interface, struct phy_device *phy);
 
 /* Queue modes */
 #define MVPP2_QDIST_SINGLE_MODE	0
@@ -3142,6 +3144,7 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 		mvpp22_mode_reconfigure(port);
 
 	if (port->phylink) {
+		netif_carrier_off(port->dev);
 		phylink_start(port->phylink);
 	} else {
 		/* Phylink isn't used as of now for ACPI, so the MAC has to be
@@ -3150,9 +3153,10 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 		 */
 		struct phylink_link_state state = {
 			.interface = port->phy_interface,
-			.link = 1,
 		};
 		mvpp2_mac_config(port->dev, MLO_AN_INBAND, &state);
+		mvpp2_mac_link_up(port->dev, MLO_AN_INBAND, port->phy_interface,
+				  NULL);
 	}
 
 	netif_tx_start_all_queues(port->dev);
@@ -4495,10 +4499,6 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 		return;
 	}
 
-	netif_tx_stop_all_queues(port->dev);
-	if (!port->has_phy)
-		netif_carrier_off(port->dev);
-
 	/* Make sure the port is disabled when reconfiguring the mode */
 	mvpp2_port_disable(port);
 
@@ -4523,16 +4523,7 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 	if (port->priv->hw_version == MVPP21 && port->flags & MVPP2_F_LOOPBACK)
 		mvpp2_port_loopback_set(port, state);
 
-	/* If the port already was up, make sure it's still in the same state */
-	if (state->link || !port->has_phy) {
-		mvpp2_port_enable(port);
-
-		mvpp2_egress_enable(port);
-		mvpp2_ingress_enable(port);
-		if (!port->has_phy)
-			netif_carrier_on(dev);
-		netif_tx_wake_all_queues(dev);
-	}
+	mvpp2_port_enable(port);
 }
 
 static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
-- 
2.17.1

