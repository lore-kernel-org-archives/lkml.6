Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeCUJDq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:03:46 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:36188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751731AbeCUJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:03:43 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1543:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2902:3138:3139:3140:3141:3142:3354:3865:3866:3867:3868:3871:3872:4321:4605:5007:6120:6261:7807:7875:7904:9108:10004:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12679:12895:12986:13161:13229:13255:14181:14721:21080:21451:21611:21627:30003:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: watch90_2e61dadcb71f
X-Filterd-Recvd-Size: 3951
From: Joe Perches <joe@perches.com>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [RFC PATCH] etherdevice.h: net/core: Add ether_addrs.c and global ether_<foo>_addr
Date: Wed, 21 Mar 2018 02:03:37 -0700
Message-Id: <1358caea6069381c231ae9bf6ffb7126cca04321.1521622752.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <bd247d15-4b10-3a57-16fe-7ba6908e8bfe@gmail.com>
References: <bd247d15-4b10-3a57-16fe-7ba6908e8bfe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances of static const arrays for broadcast
and zero ethernet addresses used for various purposes.

Add const u8 ether_<foo>_addr[ETH_ALEN] globals to consolidate these uses.

Miscellanea:

o Move and rename the eth_reserved_addr_base declaration to this file
  and declare it extern to avoid possible multiple static definitions
o Add compilation to the Makefile

Signed-off-by: Joe Perches <joe@perches.com>
---

Not sure this is the best place for this.  Better ideas welcomed.

 include/linux/etherdevice.h | 12 ++++++++----
 net/core/Makefile           |  3 ++-
 net/core/ether_addrs.c      | 16 ++++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100644 net/core/ether_addrs.c

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
diff --git a/net/core/Makefile b/net/core/Makefile
index 6dbbba8c57ae..7fb941243cc3 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -4,7 +4,8 @@
 #
 
 obj-y := sock.o request_sock.o skbuff.o datagram.o stream.o scm.o \
-	 gen_stats.o gen_estimator.o net_namespace.o secure_seq.o flow_dissector.o
+	 gen_stats.o gen_estimator.o net_namespace.o secure_seq.o \
+	 flow_dissector.o ether_addrs.o
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
diff --git a/net/core/ether_addrs.c b/net/core/ether_addrs.c
new file mode 100644
index 000000000000..18eedabe73fa
--- /dev/null
+++ b/net/core/ether_addrs.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Various const global Ethernet addresses */
+
+#include <linux/etherdevice.h>
+
+const u8 ether_broadcast_addr[ETH_ALEN] __aligned(2) = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+};
+
+const u8 ether_zero_addr[ETH_ALEN] __aligned(2) = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+const u8 ether_reserved_addr_base[ETH_ALEN] __aligned(2) = {
+	0x01, 0x80, 0xc2, 0x00, 0x00, 0x00
+};
-- 
2.15.0
