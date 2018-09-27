Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339BCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E980A21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E980A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeI0PZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:25:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0PZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:25:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5A6310A4;
        Thu, 27 Sep 2018 09:08:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 21/88] net: mvpp2: let phylink manage the carrier state
Date:   Thu, 27 Sep 2018 11:03:02 +0200
Message-Id: <20180927090303.089120453@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 41948ccb4a856dddacfbd4d789d4fa8663fe41bb ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -61,6 +61,8 @@ static struct {
  */
 static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 			     const struct phylink_link_state *state);
+static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
+			      phy_interface_t interface, struct phy_device *phy);
 
 /* Queue modes */
 #define MVPP2_QDIST_SINGLE_MODE	0
@@ -3142,6 +3144,7 @@ static void mvpp2_start_dev(struct mvpp2
 		mvpp22_mode_reconfigure(port);
 
 	if (port->phylink) {
+		netif_carrier_off(port->dev);
 		phylink_start(port->phylink);
 	} else {
 		/* Phylink isn't used as of now for ACPI, so the MAC has to be
@@ -3150,9 +3153,10 @@ static void mvpp2_start_dev(struct mvpp2
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
@@ -4389,10 +4393,6 @@ static void mvpp2_mac_config(struct net_
 		return;
 	}
 
-	netif_tx_stop_all_queues(port->dev);
-	if (!port->has_phy)
-		netif_carrier_off(port->dev);
-
 	/* Make sure the port is disabled when reconfiguring the mode */
 	mvpp2_port_disable(port);
 
@@ -4417,16 +4417,7 @@ static void mvpp2_mac_config(struct net_
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


