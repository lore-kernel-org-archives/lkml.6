Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A62C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E2E21655
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E2E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbeHGLjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:39:10 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:45728 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGLjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:39:09 -0400
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="18255365"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Aug 2018 02:25:43 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Tue, 7 Aug 2018 02:25:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <jennifer.dahm@ni.com>,
        <nathan.sullivan@ni.com>, <rafalo@cadence.com>,
        <harinikatakamlinux@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] net: macb: add support for padding and fcs computation
Date:   Tue, 7 Aug 2018 12:25:14 +0300
Message-ID: <1533633914-30264-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
References: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For packets with computed IP/TCP/UDP checksum there is no need to tell
hardware to recompute it. For such kind of packets hardware expects the
packet to be at least 64 bytes and FCS to be computed.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1c12afe4a0ce..c16a4b947688 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/clk.h>
+#include <linux/crc32.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -1565,6 +1566,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 		if (i == queue->tx_head) {
 			ctrl |= MACB_BF(TX_LSO, lso_ctrl);
 			ctrl |= MACB_BF(TX_TCP_SEQ_SRC, seq_ctrl);
+			if ((bp->dev->features & NETIF_F_HW_CSUM) &&
+			    skb->ip_summed != CHECKSUM_PARTIAL && !lso_ctrl)
+				ctrl |= MACB_BIT(TX_NOCRC);
 		} else
 			/* Only set MSS/MFS on payload descriptors
 			 * (second or later descriptor)
@@ -1651,6 +1655,67 @@ static inline int macb_clear_csum(struct sk_buff *skb)
 	return 0;
 }
 
+static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
+{
+	bool cloned = skb_cloned(*skb) || skb_header_cloned(*skb);
+	int padlen = ETH_ZLEN - (*skb)->len;
+	int headroom = skb_headroom(*skb);
+	int tailroom = skb_tailroom(*skb);
+	struct sk_buff *nskb;
+	u32 fcs;
+
+	if (!(ndev->features & NETIF_F_HW_CSUM) ||
+	    !((*skb)->ip_summed != CHECKSUM_PARTIAL) ||
+	    skb_shinfo(*skb)->gso_size)	/* Not available for GSO */
+		return 0;
+
+	if (padlen <= 0) {
+		/* FCS could be appeded to tailroom. */
+		if (tailroom >= ETH_FCS_LEN)
+			goto add_fcs;
+		/* FCS could be appeded by moving data to headroom. */
+		else if (!cloned && headroom + tailroom >= ETH_FCS_LEN)
+			padlen = 0;
+		/* No room for FCS, need to reallocate skb. */
+		else
+			padlen = ETH_FCS_LEN - tailroom;
+	} else {
+		/* Add room for FCS. */
+		padlen += ETH_FCS_LEN;
+	}
+
+	if (!cloned && headroom + tailroom >= padlen) {
+		(*skb)->data = memmove((*skb)->head, (*skb)->data, (*skb)->len);
+		skb_set_tail_pointer(*skb, (*skb)->len);
+	} else {
+		nskb = skb_copy_expand(*skb, 0, padlen, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		dev_kfree_skb_any(*skb);
+		*skb = nskb;
+	}
+
+	if (padlen) {
+		if (padlen >= ETH_FCS_LEN)
+			skb_put_zero(*skb, padlen - ETH_FCS_LEN);
+		else
+			skb_trim(*skb, ETH_FCS_LEN - padlen);
+	}
+
+add_fcs:
+	/* set FCS to packet */
+	fcs = crc32_le(~0, (*skb)->data, (*skb)->len);
+	fcs = ~fcs;
+
+	skb_put_u8(*skb, fcs		& 0xff);
+	skb_put_u8(*skb, (fcs >> 8)	& 0xff);
+	skb_put_u8(*skb, (fcs >> 16)	& 0xff);
+	skb_put_u8(*skb, (fcs >> 24)	& 0xff);
+
+	return 0;
+}
+
 static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	u16 queue_index = skb_get_queue_mapping(skb);
@@ -1667,6 +1732,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return ret;
 	}
 
+	if (macb_pad_and_fcs(&skb, dev)) {
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
 	is_lso = (skb_shinfo(skb)->gso_size != 0);
 
 	if (is_lso) {
-- 
2.7.4

