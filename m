Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E31C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2BA20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2BA20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeJKOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:41:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43594 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:41:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7DFA20726; Thu, 11 Oct 2018 09:15:00 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78E1A20379;
        Thu, 11 Oct 2018 09:15:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com,
        f.fainelli@gmail.com, andrew@lunn.ch
Subject: [PATCH net-next v2] net: mscc: allow extracting the FCS into the skb
Date:   Thu, 11 Oct 2018 09:12:24 +0200
Message-Id: <20181011071224.28646-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the NETIF_F_RXFCS feature in the Mscc
Ethernet driver. This feature is disabled by default and allow a user
to request the driver not to drop the FCS and to extract it into the skb
for debugging purposes.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Since v1:
  - Rebased on top of the latest net-next.

 drivers/net/ethernet/mscc/ocelot.c       | 2 +-
 drivers/net/ethernet/mscc/ocelot_board.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 8f11fdba8d0e..9b8a17ee3cb3 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1620,7 +1620,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 	dev->ethtool_ops = &ocelot_ethtool_ops;
 	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
-	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 0cf0b0935b3b..4c23d18bbf44 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -128,11 +128,16 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 			len += sz;
 		} while (len < buf_len);
 
-		/* Read the FCS and discard it */
+		/* Read the FCS */
 		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
 		/* Update the statistics if part of the FCS was read before */
 		len -= ETH_FCS_LEN - sz;
 
+		if (unlikely(dev->features & NETIF_F_RXFCS)) {
+			buf = (u32 *)skb_put(skb, ETH_FCS_LEN);
+			*buf = val;
+		}
+
 		if (sz < 0) {
 			err = sz;
 			break;
-- 
2.17.1

