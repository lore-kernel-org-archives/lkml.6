Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeCaHFk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:05:40 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:59866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751509AbeCaHFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:05:38 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1543:1711:1730:1747:1777:1792:1978:1981:2194:2198:2199:2200:2393:2559:2562:2902:3138:3139:3140:3141:3142:3354:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6261:7875:7904:10004:10848:11026:11473:11658:11914:12043:12296:12438:12555:12679:12895:12986:14181:14394:14721:21080:21451:21611:21627:30003:30054:30079,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: shoes05_883eb35d1033a
X-Filterd-Recvd-Size: 3823
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 01/12] ethernet: Add generic ether_<foo>_addr addresses
Date: Sat, 31 Mar 2018 00:05:16 -0700
Message-Id: <38edb6a91d0ee90f3d656ec2c0030eee440cf355.1522479607.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treewide there are ~60 declarations of Ethernet broadcast or zero address
use as a 6 byte array that are later used as either an output for vsprintf
extension %pM or as a source array to copy or compare.

Create const globals for these uses with EXPORT_SYMBOL for modules.

Miscellanea:

o Rename and move static const eth_reservd_addr_base from etherdevice.h
  to this new ether_addrs.c file so it is no longer oddly declared
  as static const in a .h file

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/etherdevice.h | 12 ++++++++----
 net/ethernet/Makefile       |  2 +-
 net/ethernet/ether_addrs.c  | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)
 create mode 100644 net/ethernet/ether_addrs.c

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 79563840c295..85d2486b2959 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -63,10 +63,14 @@ struct sk_buff **eth_gro_receive(struct sk_buff **head,
 				 struct sk_buff *skb);
 int eth_gro_complete(struct sk_buff *skb, int nhoff);
 
+/* Generic Ethernet addresses */
+extern const u8 ether_broadcast_addr[ETH_ALEN];	/* all 0xff */
+extern const u8 ether_zero_addr[ETH_ALEN];	/* all zeros */
+
 /* Reserved Ethernet Addresses per IEEE 802.1Q */
-static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
-{ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
-#define eth_stp_addr eth_reserved_addr_base
+extern const u8 ether_reserved_addr_base[ETH_ALEN];
+
+#define eth_stp_addr ether_reserved_addr_base
 
 /**
  * is_link_local_ether_addr - Determine if given Ethernet address is link-local
@@ -80,7 +84,7 @@ static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
 static inline bool is_link_local_ether_addr(const u8 *addr)
 {
 	__be16 *a = (__be16 *)addr;
-	static const __be16 *b = (const __be16 *)eth_reserved_addr_base;
+	static const __be16 *b = (const __be16 *)ether_reserved_addr_base;
 	static const __be16 m = cpu_to_be16(0xfff0);
 
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
diff --git a/net/ethernet/Makefile b/net/ethernet/Makefile
index 323177505404..fbbcfec2ba10 100644
--- a/net/ethernet/Makefile
+++ b/net/ethernet/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the Linux Ethernet layer.
 #
 
-obj-y					+= eth.o
+obj-y					+= eth.o ether_addrs.o
diff --git a/net/ethernet/ether_addrs.c b/net/ethernet/ether_addrs.c
new file mode 100644
index 000000000000..e0b7a57628e8
--- /dev/null
+++ b/net/ethernet/ether_addrs.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Various const global Ethernet addresses */
+
+#include <linux/etherdevice.h>
+
+const u8 ether_broadcast_addr[ETH_ALEN] __aligned(2) = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+};
+EXPORT_SYMBOL(ether_broadcast_addr);
+
+const u8 ether_zero_addr[ETH_ALEN] __aligned(2) = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+EXPORT_SYMBOL(ether_zero_addr);
+
+const u8 ether_reserved_addr_base[ETH_ALEN] __aligned(2) = {
+	0x01, 0x80, 0xc2, 0x00, 0x00, 0x00
+};
+EXPORT_SYMBOL(ether_reserved_addr_base);
-- 
2.15.0
