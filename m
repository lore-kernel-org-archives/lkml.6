Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10E721655
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10E721655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbeHGLjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:39:02 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50103 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:39:01 -0400
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="17494830"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Aug 2018 02:25:36 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Tue, 7 Aug 2018 02:25:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <jennifer.dahm@ni.com>,
        <nathan.sullivan@ni.com>, <rafalo@cadence.com>,
        <harinikatakamlinux@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] net: macb: use netdev_tx_t return type for ndo_start_xmit functions
Date:   Tue, 7 Aug 2018 12:25:12 +0300
Message-ID: <1533633914-30264-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
References: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use netdev_tx_t return type for ndo_start_xmit function of macb driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 96cc03a6d942..860436474c3e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1651,7 +1651,7 @@ static inline int macb_clear_csum(struct sk_buff *skb)
 	return 0;
 }
 
-static int macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	u16 queue_index = skb_get_queue_mapping(skb);
 	struct macb *bp = netdev_priv(dev);
@@ -1660,6 +1660,7 @@ static int macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
 	bool is_lso, is_udp = 0;
+	netdev_tx_t ret = NETDEV_TX_OK;
 
 	is_lso = (skb_shinfo(skb)->gso_size != 0);
 
@@ -1739,7 +1740,7 @@ static int macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 unlock:
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
@@ -3547,7 +3548,8 @@ static int at91ether_close(struct net_device *dev)
 }
 
 /* Transmit packet */
-static int at91ether_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
+					struct net_device *dev)
 {
 	struct macb *lp = netdev_priv(dev);
 
-- 
2.7.4

