Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1798EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A2321924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395257AbfBOPfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:32 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:51883 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390594AbfBOPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:29 -0500
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 065EC10000B;
        Fri, 15 Feb 2019 15:35:25 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 11/13] net: mvpp2: reset the XLG MAC in port_reset
Date:   Fri, 15 Feb 2019 16:32:39 +0100
Message-Id: <20190215153241.6857-12-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215153241.6857-1-antoine.tenart@bootlin.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvpp2_port_reset helper resets the GMAC but not the XLG MAC, which
is used on PPv2.2 when using the port 0. This patch fixes it, so that
the two MAC are set in reset when needed. In addition, the XLG
configuration function sets the XLG MAC out of reset when called.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 5d05306e79a8..80406195a255 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1384,6 +1384,17 @@ static void mvpp2_port_reset(struct mvpp2_port *port)
 	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG) |
 	      MVPP2_GMAC_PORT_RESET_MASK;
 	writel(val, port->base + MVPP2_GMAC_CTRL_2_REG);
+
+	if (port->priv->hw_version == MVPP22 && port->gop_id == 0) {
+		/* Set the XLG MAC in reset */
+		val = readl(port->base + MVPP22_XLG_CTRL0_REG) &
+		      ~MVPP22_XLG_CTRL0_MAC_RESET_DIS;
+		writel(val, port->base + MVPP22_XLG_CTRL0_REG);
+
+		while (readl(port->base + MVPP22_XLG_CTRL0_REG) &
+		       MVPP22_XLG_CTRL0_MAC_RESET_DIS)
+			continue;
+	}
 }
 
 /* Change maximum receive size of the port */
@@ -4512,6 +4523,8 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 	ctrl0 = readl(port->base + MVPP22_XLG_CTRL0_REG);
 	ctrl4 = readl(port->base + MVPP22_XLG_CTRL4_REG);
 
+	ctrl0 |= MVPP22_XLG_CTRL0_MAC_RESET_DIS;
+
 	if (state->pause & MLO_PAUSE_TX)
 		ctrl0 |= MVPP22_XLG_CTRL0_TX_FLOW_CTRL_EN;
 	else
-- 
2.20.1

