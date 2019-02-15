Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88794C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED0621924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395217AbfBOPf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:29 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55365 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390466AbfBOPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:27 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8E35540008;
        Fri, 15 Feb 2019 15:35:23 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 10/13] net: mvpp2: reset the XPCS while reconfiguring the serdes lanes
Date:   Fri, 15 Feb 2019 16:32:38 +0100
Message-Id: <20190215153241.6857-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215153241.6857-1-antoine.tenart@bootlin.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation advises to set the XPCS in reset while reconfiguring
the serdes lanes. This seems to be a good thing to do, but the PPv2
driver wasn't doing it. This patch fixes it.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 21ddcac1ceea..7380bddc53b8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -481,6 +481,7 @@
 /* XPCS registers. PPv2.2 only */
 #define MVPP22_XPCS_BASE(port)			(0x7400 + (port) * 0x1000)
 #define MVPP22_XPCS_CFG0			0x0
+#define     MVPP22_XPCS_CFG0_RESET_DIS		BIT(0)
 #define     MVPP22_XPCS_CFG0_PCS_MODE(n)	((n) << 3)
 #define     MVPP22_XPCS_CFG0_ACTIVE_LANE(n)	((n) << 5)
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 4a18f8e54c90..5d05306e79a8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1016,13 +1016,19 @@ static void mvpp22_gop_init_10gkr(struct mvpp2_port *port)
 	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
 	u32 val;
 
-	/* XPCS */
+	/* XPCS : Reset the XPCS when reconfiguring the lanes */
+	val = readl(xpcs + MVPP22_XPCS_CFG0);
+	writel(val & ~MVPP22_XPCS_CFG0_RESET_DIS, xpcs + MVPP22_XPCS_CFG0);
+
 	val = readl(xpcs + MVPP22_XPCS_CFG0);
 	val &= ~(MVPP22_XPCS_CFG0_PCS_MODE(0x3) |
 		 MVPP22_XPCS_CFG0_ACTIVE_LANE(0x3));
 	val |= MVPP22_XPCS_CFG0_ACTIVE_LANE(2);
 	writel(val, xpcs + MVPP22_XPCS_CFG0);
 
+	val = readl(xpcs + MVPP22_XPCS_CFG0);
+	writel(val | MVPP22_XPCS_CFG0_RESET_DIS, xpcs + MVPP22_XPCS_CFG0);
+
 	/* MPCS */
 	val = readl(mpcs + MVPP22_MPCS_CTRL);
 	val &= ~MVPP22_MPCS_CTRL_FWD_ERR_CONN;
-- 
2.20.1

