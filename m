Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA14C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB782192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395375AbfBOPgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:36:48 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40897 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389824AbfBOPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:11 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DD0DCC0013;
        Fri, 15 Feb 2019 15:35:08 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 04/13] net: mvpp2: reconfiguring the port interface is PPv2.2 specific
Date:   Fri, 15 Feb 2019 16:32:32 +0100
Message-Id: <20190215153241.6857-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215153241.6857-1-antoine.tenart@bootlin.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a check not to disable/enable a port when an interface
is updated when using PPv2.1 as the functions called are PPv2.2
specific.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index d5a103dd1610..c8bab294f4c7 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4670,19 +4670,17 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 		return;
 	}
 
-	if (change_interface) {
+	if (port->priv->hw_version == MVPP22 && change_interface) {
 		/* Make sure the port is disabled when reconfiguring the mode */
 		mvpp2_port_disable(port);
 
 		mvpp22_gop_mask_irq(port);
 
-		if (port->priv->hw_version == MVPP22) {
-			port->phy_interface = state->interface;
+		port->phy_interface = state->interface;
 
-			/* Reconfigure the serdes lanes */
-			phy_power_off(port->comphy);
-			mvpp22_mode_reconfigure(port);
-		}
+		/* Reconfigure the serdes lanes */
+		phy_power_off(port->comphy);
+		mvpp22_mode_reconfigure(port);
 
 		mvpp2_port_enable(port);
 	}
@@ -4698,7 +4696,7 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 	if (port->priv->hw_version == MVPP21 && port->flags & MVPP2_F_LOOPBACK)
 		mvpp2_port_loopback_set(port, state);
 
-	if (change_interface)
+	if (port->priv->hw_version == MVPP22 && change_interface)
 		mvpp22_gop_unmask_irq(port);
 }
 
-- 
2.20.1

