Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeDBW7L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:59:11 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40257 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbeDBW7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:59:08 -0400
X-Google-Smtp-Source: AIpwx4+9NECXjglU71mxkyckhvlANRa0bebtxtOnH76ZcRHXS2h4v2VyEWl8IEYJN5Cy7AResY3i8w==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 1/2] net: bcmgenet: Fix sparse warnings in bcmgenet_put_tx_csum()
Date: Mon,  2 Apr 2018 15:58:55 -0700
Message-Id: <20180402225856.4351-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402225856.4351-1-f.fainelli@gmail.com>
References: <20180402225856.4351-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb->protocol is a __be16 which we would be calling htons() against,
while this is not wrong per-se as it correctly results in swapping the
value on LE hosts, this still upsets sparse. Adopt a similar pattern to
what other drivers do and just assign ip_ver to skb->protocol, and then
use htons() against the different constants such that the compiler can
resolve the values at build time.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1e35a9accf1..aeb329690f78 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1460,7 +1460,7 @@ static struct sk_buff *bcmgenet_put_tx_csum(struct net_device *dev,
 	struct sk_buff *new_skb;
 	u16 offset;
 	u8 ip_proto;
-	u16 ip_ver;
+	__be16 ip_ver;
 	u32 tx_csum_info;
 
 	if (unlikely(skb_headroom(skb) < sizeof(*status))) {
@@ -1480,12 +1480,12 @@ static struct sk_buff *bcmgenet_put_tx_csum(struct net_device *dev,
 	status = (struct status_64 *)skb->data;
 
 	if (skb->ip_summed  == CHECKSUM_PARTIAL) {
-		ip_ver = htons(skb->protocol);
+		ip_ver = skb->protocol;
 		switch (ip_ver) {
-		case ETH_P_IP:
+		case htons(ETH_P_IP):
 			ip_proto = ip_hdr(skb)->protocol;
 			break;
-		case ETH_P_IPV6:
+		case htons(ETH_P_IPV6):
 			ip_proto = ipv6_hdr(skb)->nexthdr;
 			break;
 		default:
@@ -1501,7 +1501,8 @@ static struct sk_buff *bcmgenet_put_tx_csum(struct net_device *dev,
 		 */
 		if (ip_proto == IPPROTO_TCP || ip_proto == IPPROTO_UDP) {
 			tx_csum_info |= STATUS_TX_CSUM_LV;
-			if (ip_proto == IPPROTO_UDP && ip_ver == ETH_P_IP)
+			if (ip_proto == IPPROTO_UDP &&
+			    ip_ver == htons(ETH_P_IP))
 				tx_csum_info |= STATUS_TX_CSUM_PROTO_UDP;
 		} else {
 			tx_csum_info = 0;
-- 
2.14.1
