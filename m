Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB21C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973E620823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="tSFX5bJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfAUHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:22:15 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:41874 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfAUHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:22:14 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1548052013; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYa1I6A9mAqiy2mVxfLKMpD05GmkBCsXsZIcZEc578Q=;
        b=tSFX5bJh5mbcWky0HVrLoAG3QUpW25oOVlQ+dZDGUKgCVznxRcjkpjiBPMPQEBnmNs3K+u
        szvpbxnt8YOGgkg1I/8NAelFxnN+E/36ZK8pR1cf8vyfU+rRAvI3nOQlB4Zqay9eNrQA4N
        dKWteFSy6M8aDCt3snSqTkbSW5NDtxBC8yPc/yHtRsV0soLsM5KmX7vgOGS/Ja47gnMiX+
        tshsoKQt0/UJueEFDr7l09F3zgiLJmTYB3FDECnUqu6ZhCAysUwEBmca9vcJikSi6Icv9J
        Z2x3lBI6qbufmz3il0yfWi8DB5ZoFriXj7bPCfYZwiEHosFTzdUNHgZkqu5lBQ==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 4/4] bridge: Snoop Multicast Router Advertisements
Date:   Mon, 21 Jan 2019 07:26:28 +0100
Message-Id: <20190121062628.2710-5-linus.luessing@c0d3.blue>
In-Reply-To: <20190121062628.2710-1-linus.luessing@c0d3.blue>
References: <20190121062628.2710-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1548052013; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYa1I6A9mAqiy2mVxfLKMpD05GmkBCsXsZIcZEc578Q=;
        b=FKnCaKM+V6E4oboqX26GRd7+Yp9i/G/HYtxltm9u4KdC/xiMJ5QGiS3zN7UOyo3mLfX0TL
        1cteE+qzuBTzTOnm0+eWypEZqfXOlTcokgRNDSRzTNbFSDHurLWv0dL1XEh9ZtoCEzuh1R
        /5HXlI9QK/U01UCctbBxPa0+mBxeNgeP/0kv0Ebqel3AAoP7fVI/9eiulrWoq6UmG+PjyB
        Ga/lMg2M6hb+xXg4TTnrqOO0gcUmZcBqOuxKarfGklny1Iy95jdHeaYTfEyLcrMnn2gv/+
        xm/R7acV5ntb2BOGqNAH0LO+q/IV/4HqzBWpNGGjA7nUCO3CYyaBdsurAbw77Q==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1548052013; a=rsa-sha256; cv=none;
        b=KLJhKlFaHyrTWh7OUeEQr8VjXRAgesWpSeYLOkyZmUYIJ624X9wFpPj5k0xTif2+42/9N0
        VYLlBvk5NF0H5a2I/gCR3kx+nvgPu+7UobEDpNmx5vD45lb2WFKI9DMmi5HYoevA0zNlwk
        9fnnrgWoa4pu+VVM6OeTwQOqAEabGy9v3gnY1y0h0Kz/gyMpdbiVI54DtGk3AwILsoM3/w
        CjwWEBUEDXYLFZl19EPbdk3T1/+WoKcPHHD1fqVCm8iIaFfac9OyFeOQbw7CoybE940jvs
        glnwFZIy64nkunc03k3RjEUQnFtSnynIR7TmxL8/jk/kQ7IMtE/VebKMmEZ4Fw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple multicast routers are present in a broadcast domain then
only one of them will be detectable via IGMP/MLD query snooping. The
multicast router with the lowest IP address will become the selected and
active querier while all other multicast routers will then refrain from
sending queries.

To detect such rather silent multicast routers, too, RFC4286
("Multicast Router Discovery") provides a standardized protocol to
detect multicast routers for multicast snooping switches.

This patch implements the necessary MRD Advertisement message parsing
and after successful processing adds such routers to the internal
multicast router list.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/linux/in.h          |  5 +++++
 include/net/addrconf.h      | 15 +++++++++++++
 include/uapi/linux/icmpv6.h |  2 ++
 include/uapi/linux/igmp.h   |  1 +
 net/bridge/br_multicast.c   | 55 +++++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/mcast_snoop.c      |  5 ++++-
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/linux/in.h b/include/linux/in.h
index 31b493734763..435e7f2a513a 100644
--- a/include/linux/in.h
+++ b/include/linux/in.h
@@ -60,6 +60,11 @@ static inline bool ipv4_is_lbcast(__be32 addr)
 	return addr == htonl(INADDR_BROADCAST);
 }
 
+static inline bool ipv4_is_all_snoopers(__be32 addr)
+{
+	return addr == htonl(INADDR_ALLSNOOPERS_GROUP);
+}
+
 static inline bool ipv4_is_zeronet(__be32 addr)
 {
 	return (addr & htonl(0xff000000)) == htonl(0x00000000);
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index daf11dcb0f70..20d523ee2fec 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -229,6 +229,7 @@ void ipv6_mc_unmap(struct inet6_dev *idev);
 void ipv6_mc_remap(struct inet6_dev *idev);
 void ipv6_mc_init_dev(struct inet6_dev *idev);
 void ipv6_mc_destroy_dev(struct inet6_dev *idev);
+int ipv6_mc_check_icmpv6(struct sk_buff *skb);
 int ipv6_mc_check_mld(struct sk_buff *skb);
 void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp);
 
@@ -499,6 +500,20 @@ static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
 #endif
 }
 
+static inline bool ipv6_addr_is_all_snoopers(const struct in6_addr *addr)
+{
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
+	__be64 *p = (__be64 *)addr;
+
+	return ((p[0] ^ cpu_to_be64(0xff02000000000000UL)) |
+		(p[1] ^ cpu_to_be64(0x6a))) == 0UL;
+#else
+	return ((addr->s6_addr32[0] ^ htonl(0xff020000)) |
+		addr->s6_addr32[1] | addr->s6_addr32[2] |
+		(addr->s6_addr32[3] ^ htonl(0x0000006a))) == 0;
+#endif
+}
+
 #ifdef CONFIG_PROC_FS
 int if6_proc_init(void);
 void if6_proc_exit(void);
diff --git a/include/uapi/linux/icmpv6.h b/include/uapi/linux/icmpv6.h
index caf8dc019250..325395f56bfa 100644
--- a/include/uapi/linux/icmpv6.h
+++ b/include/uapi/linux/icmpv6.h
@@ -108,6 +108,8 @@ struct icmp6hdr {
 #define ICMPV6_MOBILE_PREFIX_SOL	146
 #define ICMPV6_MOBILE_PREFIX_ADV	147
 
+#define ICMPV6_MRDISC_ADV		151
+
 /*
  *	Codes for Destination Unreachable
  */
diff --git a/include/uapi/linux/igmp.h b/include/uapi/linux/igmp.h
index 7e44ac02ca18..90c28bc466c6 100644
--- a/include/uapi/linux/igmp.h
+++ b/include/uapi/linux/igmp.h
@@ -93,6 +93,7 @@ struct igmpv3_query {
 #define IGMP_MTRACE_RESP		0x1e
 #define IGMP_MTRACE			0x1f
 
+#define IGMP_MRDISC_ADV			0x30	/* From RFC4286 */
 
 /*
  *	Use the BSD names for these for compatibility
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2366f4a2780e..2c46c7aca571 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/if_ether.h>
 #include <linux/igmp.h>
+#include <linux/in.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -29,10 +30,12 @@
 #include <net/ip.h>
 #include <net/switchdev.h>
 #if IS_ENABLED(CONFIG_IPV6)
+#include <linux/icmpv6.h>
 #include <net/ipv6.h>
 #include <net/mld.h>
 #include <net/ip6_checksum.h>
 #include <net/addrconf.h>
+#include <net/ipv6.h>
 #endif
 
 #include "br_private.h"
@@ -1583,6 +1586,19 @@ static void br_multicast_pim(struct net_bridge *br,
 	br_multicast_mark_router(br, port);
 }
 
+static int br_ip4_multicast_mrd_rcv(struct net_bridge *br,
+				    struct net_bridge_port *port,
+				    struct sk_buff *skb)
+{
+	if (ip_hdr(skb)->protocol != IPPROTO_IGMP ||
+	    igmp_hdr(skb)->type != IGMP_MRDISC_ADV)
+		return -ENOMSG;
+
+	br_multicast_mark_router(br, port);
+
+	return 0;
+}
+
 static int br_multicast_ipv4_rcv(struct net_bridge *br,
 				 struct net_bridge_port *port,
 				 struct sk_buff *skb,
@@ -1600,7 +1616,15 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 		} else if (pim_ipv4_all_pim_routers(ip_hdr(skb)->daddr)) {
 			if (ip_hdr(skb)->protocol == IPPROTO_PIM)
 				br_multicast_pim(br, port, skb);
+		} else if (ipv4_is_all_snoopers(ip_hdr(skb)->daddr)) {
+			err = br_ip4_multicast_mrd_rcv(br, port, skb);
+
+			if (err < 0 && err != -ENOMSG) {
+				br_multicast_err_count(br, port, skb->protocol);
+				return err;
+			}
 		}
+
 		return 0;
 	} else if (err < 0) {
 		br_multicast_err_count(br, port, skb->protocol);
@@ -1635,6 +1659,27 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+static int br_ip6_multicast_mrd_rcv(struct net_bridge *br,
+				    struct net_bridge_port *port,
+				    struct sk_buff *skb)
+{
+	int ret;
+
+	if (ipv6_hdr(skb)->nexthdr != IPPROTO_ICMPV6)
+		return -ENOMSG;
+
+	ret = ipv6_mc_check_icmpv6(skb);
+	if (ret < 0)
+		return ret;
+
+	if (icmp6_hdr(skb)->icmp6_type != ICMPV6_MRDISC_ADV)
+		return -ENOMSG;
+
+	br_multicast_mark_router(br, port);
+
+	return 0;
+}
+
 static int br_multicast_ipv6_rcv(struct net_bridge *br,
 				 struct net_bridge_port *port,
 				 struct sk_buff *skb,
@@ -1649,6 +1694,16 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 	if (err == -ENOMSG) {
 		if (!ipv6_addr_is_ll_all_nodes(&ipv6_hdr(skb)->daddr))
 			BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
+
+		if (ipv6_addr_is_all_snoopers(&ipv6_hdr(skb)->daddr)) {
+			err = br_ip6_multicast_mrd_rcv(br, port, skb);
+
+			if (err < 0 && err != -ENOMSG) {
+				br_multicast_err_count(br, port, skb->protocol);
+				return err;
+			}
+		}
+
 		return 0;
 	} else if (err < 0) {
 		br_multicast_err_count(br, port, skb->protocol);
diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
index a72ddfc40eb3..55e2ac179f28 100644
--- a/net/ipv6/mcast_snoop.c
+++ b/net/ipv6/mcast_snoop.c
@@ -41,6 +41,8 @@ static int ipv6_mc_check_ip6hdr(struct sk_buff *skb)
 	if (skb->len < len || len <= offset)
 		return -EINVAL;
 
+	skb_set_transport_header(skb, offset);
+
 	return 0;
 }
 
@@ -142,7 +144,7 @@ static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
 }
 
-static int ipv6_mc_check_icmpv6(struct sk_buff *skb)
+int ipv6_mc_check_icmpv6(struct sk_buff *skb)
 {
 	unsigned int len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
 	unsigned int transport_len = ipv6_transport_len(skb);
@@ -161,6 +163,7 @@ static int ipv6_mc_check_icmpv6(struct sk_buff *skb)
 
 	return 0;
 }
+EXPORT_SYMBOL(ipv6_mc_check_icmpv6);
 
 /**
  * ipv6_mc_check_mld - checks whether this is a sane MLD packet
-- 
2.11.0

