Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B207208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B207208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeHUJoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:44:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55428 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeHUJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:44:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B2A77ACC;
        Tue, 21 Aug 2018 06:25:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 41/42] net: ethernet: mvneta: Fix napi structure mixup on armada 3700
Date:   Tue, 21 Aug 2018 08:21:13 +0200
Message-Id: <20180821055019.620485672@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 7a86f05faf112463cfbbdfd222012e247de461a1 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1901,10 +1901,10 @@ static void mvneta_rxq_drop_pkts(struct
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
@@ -1959,7 +1959,7 @@ err_drop_frame:
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2001,7 +2001,7 @@ err_drop_frame:
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2020,10 +2020,10 @@ err_drop_frame:
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
@@ -2085,7 +2085,7 @@ err_drop_frame:
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2129,7 +2129,7 @@ err_drop_frame:
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2722,9 +2722,11 @@ static int mvneta_poll(struct napi_struc
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


