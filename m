Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEDPVc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:21:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35947 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDPVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:21:30 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next] net: phy: sfp: handle cases where neither BR,min nor BR,max is given
Date: Fri,  4 May 2018 17:21:03 +0200
Message-Id: <20180504152103.18152-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When computing the bitrate using values read from an SFP module EEPROM,
we use the nominal BR plus BR,min and BR,max to determine the
boundaries. But in some cases BR,min and BR,max aren't provided, which
led the SFP code to end up having the nominal value for both the minimum
and maximum bitrate values. When using a passive cable, the nominal
value should be used as the maximum one, and there is no minimum one
so we should use 0.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---

Hi Russell,

I'm not completely sure about this patch as this case is not really
specified in the specification. But the issue is there, and I've discuss
this with others. It seemed logical (at least to us :)) to use the
BR,nominal values as br_max and 0 as br_min when using a passive cable
which only provides BR,nominal as this would be the highest rate at
which the cable could work. And because it's passive, there should be no
issues using it at a lower rate.

I've tested this with one passive cable which only reports its
BR,nominal (which was 10300) while it could be used when using 1000baseX
or 2500baseX modes.

Thanks,
Antoine

 drivers/net/phy/sfp-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index fd6c23f69c2f..d437f4f5ed52 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -132,6 +132,13 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 			br_max = br_nom + br_nom * id->ext.br_min / 100;
 			br_min = br_nom - br_nom * id->ext.br_min / 100;
 		}
+
+		/* When using passive cables, in case neither BR,min nor BR,max
+		 * are specified, set br_min to 0 as the nominal value is then
+		 * used as the maximum.
+		 */
+		if (br_min == br_max && id->base.sfp_ct_passive)
+			br_min = 0;
 	}
 
 	/* Set ethtool support from the compliance fields. */
-- 
2.17.0
