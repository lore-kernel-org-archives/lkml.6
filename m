Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE402C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D3921655
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D3921655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbeHGLjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:39:05 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50103 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:39:05 -0400
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="17494846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Aug 2018 02:25:40 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Tue, 7 Aug 2018 02:25:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <jennifer.dahm@ni.com>,
        <nathan.sullivan@ni.com>, <rafalo@cadence.com>,
        <harinikatakamlinux@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] net: macb: move checksum clearing outside of spinlock
Date:   Tue, 7 Aug 2018 12:25:13 +0300
Message-ID: <1533633914-30264-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
References: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move checksum clearing outside of spinlock. The SKB is protected by
networking lock (HARD_TX_LOCK()).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 860436474c3e..1c12afe4a0ce 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1662,6 +1662,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool is_lso, is_udp = 0;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
+	if (macb_clear_csum(skb)) {
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
 	is_lso = (skb_shinfo(skb)->gso_size != 0);
 
 	if (is_lso) {
@@ -1717,11 +1722,6 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
-	if (macb_clear_csum(skb)) {
-		dev_kfree_skb_any(skb);
-		goto unlock;
-	}
-
 	/* Map socket buffer for DMA transfer */
 	if (!macb_tx_map(bp, queue, skb, hdrlen)) {
 		dev_kfree_skb_any(skb);
-- 
2.7.4

