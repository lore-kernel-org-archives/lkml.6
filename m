Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeCaHGY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:06:24 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:52191 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753123AbeCaHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:06:03 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3872:4321:4385:4605:5007:6261:10004:10848:11026:11473:11657:11658:11914:12043:12296:12438:12555:12679:12895:12986:13869:14181:14394:14721:21080:21524:21627:30005:30012:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: self04_8bf831cd1bc0b
X-Filterd-Recvd-Size: 2890
From: Joe Perches <joe@perches.com>
To: Michael Chan <michael.chan@broadcom.com>,
        Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] ethernet: Use ether_zero_addr instead of local statics
Date: Sat, 31 Mar 2018 00:05:27 -0700
Message-Id: <d4de4e8a51546af7e0a139e1b24d889383940027.1522479609.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This saves a small amount of object code.

Miscellanea:

o __b44_cam_write now use const u8 *data instead of unsigned char *
  to avoid compiler warnings as it doesn't modify data

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/broadcom/b44.c      | 5 ++---
 drivers/net/ethernet/freescale/gianfar.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index e445ab724827..30879ff7de19 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -220,7 +220,7 @@ static inline void __b44_cam_read(struct b44 *bp, unsigned char *data, int index
 	data[1] = (val >> 0) & 0xFF;
 }
 
-static inline void __b44_cam_write(struct b44 *bp, unsigned char *data, int index)
+static inline void __b44_cam_write(struct b44 *bp, const u8 *data, int index)
 {
 	u32 val;
 
@@ -1744,7 +1744,6 @@ static void __b44_set_rx_mode(struct net_device *dev)
 		val |= RXCONFIG_PROMISC;
 		bw32(bp, B44_RXCONFIG, val);
 	} else {
-		unsigned char zero[6] = {0, 0, 0, 0, 0, 0};
 		int i = 1;
 
 		__b44_set_mac_addr(bp);
@@ -1756,7 +1755,7 @@ static void __b44_set_rx_mode(struct net_device *dev)
 			i = __b44_load_mcast(bp, dev);
 
 		for (; i < 64; i++)
-			__b44_cam_write(bp, zero, i);
+			__b44_cam_write(bp, ether_zero_addr, i);
 
 		bw32(bp, B44_RXCONFIG, val);
         	val = br32(bp, B44_CAM_CTRL);
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index f27f9bae1a4a..24d8c85f8f4e 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3501,10 +3501,9 @@ static void gfar_set_multi(struct net_device *dev)
 static void gfar_clear_exact_match(struct net_device *dev)
 {
 	int idx;
-	static const u8 zero_arr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
 	for (idx = 1; idx < GFAR_EM_NUM + 1; idx++)
-		gfar_set_mac_for_addr(dev, idx, zero_arr);
+		gfar_set_mac_for_addr(dev, idx, ether_zero_addr);
 }
 
 /* Set the appropriate hash bit for the given addr */
-- 
2.15.0
