Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79450C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B721924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395294AbfBOPfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:36 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41667 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390594AbfBOPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:33 -0500
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 56B63100007;
        Fri, 15 Feb 2019 15:35:30 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 13/13] net: mvpp2: some AN fields require the link to be down when updated
Date:   Fri, 15 Feb 2019 16:32:41 +0100
Message-Id: <20190215153241.6857-14-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215153241.6857-1-antoine.tenart@bootlin.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMAC configuration helper modifies values in the auto-negotiation
register. Some of its values require the port to be forced down when
modifying their values. This patches fixes the check made on the bit to
be updated in this register, so that the port is forced down when
needed. This fix cases where some of those parameters were updated, but
not taken into account, such as when using RGMII interfaces.

Fixes: d14e078f23cc ("net: marvell: mvpp2: only reprogram what is necessary on mac_config")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 80406195a255..0419a18f0a28 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4641,9 +4641,19 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 		}
 	}
 
+/* Some fields of the auto-negotiation register require the port to be down when
+ * their value is updated.
+ */
+#define MVPP2_GMAC_AN_PORT_DOWN_MASK	\
+		(MVPP2_GMAC_IN_BAND_AUTONEG | \
+		 MVPP2_GMAC_IN_BAND_AUTONEG_BYPASS | \
+		 MVPP2_GMAC_CONFIG_MII_SPEED | MVPP2_GMAC_CONFIG_GMII_SPEED | \
+		 MVPP2_GMAC_AN_SPEED_EN | MVPP2_GMAC_CONFIG_FULL_DUPLEX | \
+		 MVPP2_GMAC_AN_DUPLEX_EN)
+
 	if ((old_ctrl0 ^ ctrl0) & MVPP2_GMAC_PORT_TYPE_MASK ||
 	    (old_ctrl2 ^ ctrl2) & MVPP2_GMAC_INBAND_AN_MASK ||
-	    (old_an ^ an) & MVPP2_GMAC_IN_BAND_AUTONEG) {
+	    (old_an ^ an) & MVPP2_GMAC_AN_PORT_DOWN_MASK) {
 		/* Force link down */
 		old_an &= ~MVPP2_GMAC_FORCE_LINK_PASS;
 		old_an |= MVPP2_GMAC_FORCE_LINK_DOWN;
-- 
2.20.1

