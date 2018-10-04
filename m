Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BFFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D9213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419D9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJDOzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:55:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55767 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbeJDOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:55:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 51A29207C4; Thu,  4 Oct 2018 10:03:21 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 052CC20714;
        Thu,  4 Oct 2018 10:03:21 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net] net: mvpp2: Extract the correct ethtype from the skb for tx csum offload
Date:   Thu,  4 Oct 2018 10:03:08 +0200
Message-Id: <20181004080308.7687-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When offloading the L3 and L4 csum computation on TX, we need to extract
the l3_proto from the ethtype, independently of the presence of a vlan
tag.

The actual driver uses skb->protocol as-is, resulting in packets with
the wrong L4 checksum being sent when there's a vlan tag in the packet
header and checksum offloading is enabled.

This commit makes use of vlan_protocol_get() to get the correct ethtype
regardless the presence of a vlan tag.

Fixes: 3f51850 ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 38cc01beea79..4bd5b251e3c7 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1737,7 +1737,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, int l3_proto,
 	command |= (ip_hdr_len << MVPP2_TXD_IP_HLEN_SHIFT);
 	command |= MVPP2_TXD_IP_CSUM_DISABLE;
 
-	if (l3_proto == htons(ETH_P_IP)) {
+	if (l3_proto == ETH_P_IP) {
 		command &= ~MVPP2_TXD_IP_CSUM_DISABLE;	/* enable IPv4 csum */
 		command &= ~MVPP2_TXD_L3_IP6;		/* enable IPv4 */
 	} else {
@@ -2600,14 +2600,15 @@ static u32 mvpp2_skb_tx_csum(struct mvpp2_port *port, struct sk_buff *skb)
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int ip_hdr_len = 0;
 		u8 l4_proto;
+		int l3_proto = ntohs(vlan_get_protocol(skb));
 
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (l3_proto == ETH_P_IP) {
 			struct iphdr *ip4h = ip_hdr(skb);
 
 			/* Calculate IPv4 checksum and L4 checksum */
 			ip_hdr_len = ip4h->ihl;
 			l4_proto = ip4h->protocol;
-		} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		} else if (l3_proto == ETH_P_IPV6) {
 			struct ipv6hdr *ip6h = ipv6_hdr(skb);
 
 			/* Read l4_protocol from one of IPv6 extra headers */
@@ -2619,7 +2620,7 @@ static u32 mvpp2_skb_tx_csum(struct mvpp2_port *port, struct sk_buff *skb)
 		}
 
 		return mvpp2_txq_desc_csum(skb_network_offset(skb),
-				skb->protocol, ip_hdr_len, l4_proto);
+					   l3_proto, ip_hdr_len, l4_proto);
 	}
 
 	return MVPP2_TXD_L4_CSUM_NOT | MVPP2_TXD_IP_CSUM_DISABLE;
-- 
2.11.0

