Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8558C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8217720874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbeLQPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:00:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57899 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733240AbeLQPAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:00:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6716E20510; Mon, 17 Dec 2018 16:00:12 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3368720711;
        Mon, 17 Dec 2018 16:00:02 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net v3 1/2] net: mvpp2: 10G modes aren't supported on all ports
Date:   Mon, 17 Dec 2018 15:56:05 +0100
Message-Id: <20181217145606.13847-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217145606.13847-1-antoine.tenart@bootlin.com>
References: <20181217145606.13847-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvpp2_phylink_validate() function sets all modes that are
supported by a given PPv2 port. A recent change made all ports to
advertise they support 10G modes in certain cases. This is not true,
as only the port #0 can do so. This patch fixes it.

Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 125ea99418df..88aa488054a8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4405,12 +4405,14 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_NA:
-		phylink_set(mask, 10000baseCR_Full);
-		phylink_set(mask, 10000baseSR_Full);
-		phylink_set(mask, 10000baseLR_Full);
-		phylink_set(mask, 10000baseLRM_Full);
-		phylink_set(mask, 10000baseER_Full);
-		phylink_set(mask, 10000baseKR_Full);
+		if (port->gop_id == 0) {
+			phylink_set(mask, 10000baseCR_Full);
+			phylink_set(mask, 10000baseSR_Full);
+			phylink_set(mask, 10000baseLR_Full);
+			phylink_set(mask, 10000baseLRM_Full);
+			phylink_set(mask, 10000baseER_Full);
+			phylink_set(mask, 10000baseKR_Full);
+		}
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-- 
2.19.2

