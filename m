Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2367ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C99F2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C99F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeGMQfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:35:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38919 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeGMQfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:35:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1403C2091A; Fri, 13 Jul 2018 18:20:18 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D5FB7207AB;
        Fri, 13 Jul 2018 18:20:07 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v2 1/7] net: ethernet: mvneta: Fix napi structure mixup on armada 3700
Date:   Fri, 13 Jul 2018 18:18:35 +0200
Message-Id: <20180713161841.11202-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713161841.11202-1-gregory.clement@bootlin.com>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

The mvneta Ethernet driver is used on a few different Marvell SoCs.
Some SoCs have per cpu interrupts for Ethernet events. Some SoCs have
a single interrupt, independent of the CPU. The driver handles this by
having a per CPU napi structure when there are per CPU interrupts, and
a global napi structure when there is a single interrupt.

When the napi core calls mvneta_poll(), it passes the napi
instance. This was not being propagated through the call chain, and
instead the per-cpu napi instance was passed to napi_gro_receive()
call. This breaks when there is a single global napi instance.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ad2f3f7da85..ec84db47d82d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1901,10 +1901,10 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 }
 
 /* Main rx processing when using software buffer management */
-static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
+static int mvneta_rx_swbm(struct napi_struct *napi,
+			  struct mvneta_port *pp, int rx_todo,
 			  struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -1959,7 +1959,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2001,7 +2001,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2020,10 +2020,10 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 }
 
 /* Main rx processing when using hardware buffer management */
-static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
+static int mvneta_rx_hwbm(struct napi_struct *napi,
+			  struct mvneta_port *pp, int rx_todo,
 			  struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -2085,7 +2085,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2129,7 +2129,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2722,9 +2722,11 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
 	if (rx_queue) {
 		rx_queue = rx_queue - 1;
 		if (pp->bm_priv)
-			rx_done = mvneta_rx_hwbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_hwbm(napi, pp, budget,
+						 &pp->rxqs[rx_queue]);
 		else
-			rx_done = mvneta_rx_swbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_swbm(napi, pp, budget,
+						 &pp->rxqs[rx_queue]);
 	}
 
 	if (rx_done < budget) {
-- 
2.18.0

