Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D3BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A55220652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A55220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933217AbeFTIzP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:55:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45543 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754601AbeFTIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:55:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7D36E20A4A; Wed, 20 Jun 2018 10:55:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 48C7220714;
        Wed, 20 Jun 2018 10:55:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, f.fainelli@gmail.com,
        andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microsemi.com
Subject: [PATCH net] net: mscc: fix the injection header
Date:   Wed, 20 Jun 2018 10:50:46 +0200
Message-Id: <20180620085046.2377-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When injecting frames in the Ocelot switch driver an injection header
(IFH) should be used to configure various parameters related to a given
frame, such as the port onto which the frame should be departed or its
vlan id. Other parameters in the switch configuration can led to an
injected frame being sent without an IFH but this led to various issues
as the per-frame parameters are then not used. This is especially true
when using multiple ports for injection.

The IFH was injected with the wrong endianness which led to the switch
not taking it into account as the IFH_INJ_BYPASS bit was then unset.
(The bit tells the switch to use the IFH over its internal
configuration). This patch fixes it.

In addition to the endianness fix, the IFH is also fixed. As it was
(unwillingly) unused, some of its fields were not configured the right
way.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index fb2c8f8071e6..52c57e0ff617 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -344,10 +344,9 @@ static int ocelot_port_stop(struct net_device *dev)
 static int ocelot_gen_ifh(u32 *ifh, struct frame_info *info)
 {
 	ifh[0] = IFH_INJ_BYPASS;
-	ifh[1] = (0xff00 & info->port) >> 8;
+	ifh[1] = (0xf00 & info->port) >> 8;
 	ifh[2] = (0xff & info->port) << 24;
-	ifh[3] = IFH_INJ_POP_CNT_DISABLE | (info->cpuq << 20) |
-		 (info->tag_type << 16) | info->vid;
+	ifh[3] = (info->tag_type << 16) | info->vid;
 
 	return 0;
 }
@@ -370,11 +369,12 @@ static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
 
 	info.port = BIT(port->chip_port);
-	info.cpuq = 0xff;
+	info.tag_type = IFH_TAG_TYPE_C;
+	info.vid = skb_vlan_tag_get(skb);
 	ocelot_gen_ifh(ifh, &info);
 
 	for (i = 0; i < IFH_LEN; i++)
-		ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
+		ocelot_write_rix(ocelot, cpu_to_be32(ifh[i]), QS_INJ_WR, grp);
 
 	count = (skb->len + 3) / 4;
 	last = skb->len % 4;
-- 
2.17.1

