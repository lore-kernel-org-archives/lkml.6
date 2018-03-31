Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeCaHIO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:08:14 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:39961 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752855AbeCaHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:05:49 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3874:4321:4605:5007:6119:6261:8603:9040:9592:10004:10848:11026:11473:11658:11914:12043:12114:12296:12438:12555:12895:12986:14181:14394:14721:21080:21451:21627:30003:30012:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: toe88_89eaf947e964d
X-Filterd-Recvd-Size: 3150
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 05/12] net: atm: Use ether_broadcast_addr
Date: Sat, 31 Mar 2018 00:05:20 -0700
Message-Id: <bb4b0a9c7649ea3db2d78673b092de5daed3a930.1522479607.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new global instead of a local static to reduce object code size
a tiny bit.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/atm/lec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index 01d5d20a6eb1..ec47b45bd836 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -116,8 +116,6 @@ static struct lane2_ops lane2_ops = {
 	.associate_indicator = NULL             /* spec 3.1.5 */
 };
 
-static unsigned char bus_mac[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
-
 /* Device structures */
 static struct net_device *dev_lec[MAX_LEC_ITF];
 
@@ -1726,7 +1724,7 @@ static struct atm_vcc *lec_arp_resolve(struct lec_priv *priv,
 		case 1:
 			return priv->mcast_vcc;
 		case 2:	/* LANE2 wants arp for multicast addresses */
-			if (ether_addr_equal(mac_to_find, bus_mac))
+			if (ether_addr_equal(mac_to_find, ether_broadcast_addr))
 				return priv->mcast_vcc;
 			break;
 		default:
@@ -1954,7 +1952,7 @@ lec_vcc_added(struct lec_priv *priv, const struct atmlec_ioc *ioc_data,
 	if (ioc_data->receive == 2) {
 		pr_debug("LEC_ARP: Attaching mcast forward\n");
 #if 0
-		entry = lec_arp_find(priv, bus_mac);
+		entry = lec_arp_find(priv, ether_broadcast_addr);
 		if (!entry) {
 			pr_info("LEC_ARP: Multicast entry not found!\n");
 			goto out;
@@ -1963,7 +1961,7 @@ lec_vcc_added(struct lec_priv *priv, const struct atmlec_ioc *ioc_data,
 		entry->recv_vcc = vcc;
 		entry->old_recv_push = old_push;
 #endif
-		entry = make_entry(priv, bus_mac);
+		entry = make_entry(priv, ether_broadcast_addr);
 		if (entry == NULL)
 			goto out;
 		del_timer(&entry->timer);
@@ -1988,7 +1986,7 @@ lec_vcc_added(struct lec_priv *priv, const struct atmlec_ioc *ioc_data,
 			 ioc_data->atm_addr[14], ioc_data->atm_addr[15],
 			 ioc_data->atm_addr[16], ioc_data->atm_addr[17],
 			 ioc_data->atm_addr[18], ioc_data->atm_addr[19]);
-		entry = make_entry(priv, bus_mac);
+		entry = make_entry(priv, ether_broadcast_addr);
 		if (entry == NULL)
 			goto out;
 		memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
@@ -2071,7 +2069,7 @@ lec_vcc_added(struct lec_priv *priv, const struct atmlec_ioc *ioc_data,
 	 * Not found, snatch address from first data packet that arrives
 	 * from this vcc
 	 */
-	entry = make_entry(priv, bus_mac);
+	entry = make_entry(priv, ether_broadcast_addr);
 	if (!entry)
 		goto out;
 	entry->vcc = vcc;
-- 
2.15.0
