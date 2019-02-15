Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D4CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BE021924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbfBOPfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:12 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57365 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfBOPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:10 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AA56FC0018;
        Fri, 15 Feb 2019 15:35:06 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 03/13] net: mvpp2: do not disable the port if the mode hasn't changed
Date:   Fri, 15 Feb 2019 16:32:31 +0100
Message-Id: <20190215153241.6857-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215153241.6857-1-antoine.tenart@bootlin.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell PPv2 implementation of the Phylink mac_config helper
disables and enables the port, as the link mode can trigger
reconfiguration of the serdes lanes. This patch helps not disabling the
port every time mac_config is called but only when needed, which is an
improvement as the Phylink state machine does call the function every
second.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8faa842dc17c..d5a103dd1610 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4670,9 +4670,10 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 		return;
 	}
 
-	/* Make sure the port is disabled when reconfiguring the mode */
-	mvpp2_port_disable(port);
 	if (change_interface) {
+		/* Make sure the port is disabled when reconfiguring the mode */
+		mvpp2_port_disable(port);
+
 		mvpp22_gop_mask_irq(port);
 
 		if (port->priv->hw_version == MVPP22) {
@@ -4682,6 +4683,8 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 			phy_power_off(port->comphy);
 			mvpp22_mode_reconfigure(port);
 		}
+
+		mvpp2_port_enable(port);
 	}
 
 	/* mac (re)configuration */
@@ -4697,8 +4700,6 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 
 	if (change_interface)
 		mvpp22_gop_unmask_irq(port);
-
-	mvpp2_port_enable(port);
 }
 
 static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
-- 
2.20.1

