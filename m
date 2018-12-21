Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B144BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6458821917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="oAP0Jy6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbeLUPP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:15:27 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:38514 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403895AbeLUPP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:15:26 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1545405324; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ge3erLHWv6t5AcpZfzoDeJnIeayZVkRQgnWp3enG+7I=;
        b=oAP0Jy6cKXR4MRyuYxK3mUmaHBm/XqNbKKIGkktEbfIZ7EKKhnmULUroe+TyxjGIdRl65u
        03SlZG9W1oRCWGOsxMjm6xtIv9LHJ6qoRdcAokDFjW9Zib45Fo3V2vZBf3O9DeB1M2kUja
        NdZESHvJfCLGvzQzWVGkc0C2LdZTJK+neUHcRuA13a21fQT53yfWR/68OGzV5fCq77ttTw
        xoIQm8ONdlr9bRnD2x2ghnp+KzCBxlGmpL9hWAm00jDdhHkH7x2WOgXkeHQ8FtywiHEIZR
        0dhmuZ7xIKbyQRt0wYMj0wzdRkvXtIRmjr6piuBR7ijy5Q2sktW4YRS1PFyvvQ==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next 1/4] bridge: simplify ip_mc_check_igmp() and ipv6_mc_check_mld() calls
Date:   Fri, 21 Dec 2018 16:15:08 +0100
Message-Id: <20181221151511.14923-2-linus.luessing@c0d3.blue>
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1545405324; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ge3erLHWv6t5AcpZfzoDeJnIeayZVkRQgnWp3enG+7I=;
        b=ekXM3co9lXG9r/+hU9yqoDynHuaJKUHQ5yayJgzMdJIjK6FLBUhFZ8+i/JsaQPQou5HdSh
        9WzPIaFRq5AGj1agVvJ9OSADMGipokqEal54K9a1SjIIKa7TGqcOiFEbkFTBRKmTJ8NMpw
        pYNrnQao9N1/urWXh3kE++3WlnfTtH3rCKsykZQcJ5f5wj++RxuVvfMlVtDf5Cksry7ndZ
        /CNPUmVgFzBsUdtAQPkOxUec2T/5uZFIO3nV7uCofvNq8uwflnPmL/8RKHH3eRPNMUWdIi
        kaacnVt/XtC32f694Ob+Qde72NUEAfWzrRvXSmzsOKhJsa2nhU4YcGHU3BiHJA==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1545405324; a=rsa-sha256; cv=none;
        b=VHTlRJp8WMBO7s19BKj1688TuMFn+jiH7g/c8D246pdW15aGiTLmlGrAKPp/1DvMfJdpPq
        GCx9hdYIodbEYoLnFpoKKULEcE6iEJULbPDkdrmkH4q4eX3JoTU5K1n4ET/S14JQdV3F9N
        40GRiRlSKBwW5FBFJ2/sw261zBeJ+BYvJbvnxONeWLdufUTVHnoZPS8/4fUN1ASWvlzKJO
        WiMC40SHgM4FMyo/16/IR6vqPysm+d1oL2HCtSMRgiWgAL6uCRGB/aj71fsJnZOQN3qkc9
        s8UZHnXFJlTUN/sHsrCYhdundQTmSwKqy67XkHnQ84AiF4kBxwIMtrfcbMrtZg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors ip_mc_check_igmp(), ipv6_mc_check_mld() and
their callers (more precisely, the Linux bridge) to not rely on
the skb_trimmed parameter anymore.

An skb with its tail trimmed to the IP packet length was initially
introduced for the following three reasons:

1) To be able to verify the ICMPv6 checksum.
2) To be able to distinguish the version of an IGMP or MLD query.
   They are distinguishable only by their size.
3) To avoid parsing data for an IGMPv3 or MLDv2 report that is
   beyond the IP packet but still within the skb.

The first case still uses a cloned and potentially trimmed skb to
verfiy. However, there is no need to propagate it to the caller.
For the second and third case explicit IP packet length checks were
added.

This hopefully makes ip_mc_check_igmp() and ipv6_mc_check_mld() easier
to read and verfiy, as well as easier to use.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/linux/igmp.h       | 11 ++++++++-
 include/linux/ip.h         |  5 ++++
 include/linux/ipv6.h       |  6 +++++
 include/net/addrconf.h     | 12 +++++++++-
 net/batman-adv/multicast.c |  4 ++--
 net/bridge/br_multicast.c  | 57 +++++++++++++++++++++++-----------------------
 net/ipv4/igmp.c            | 23 ++++---------------
 net/ipv6/mcast_snoop.c     | 24 ++++---------------
 8 files changed, 70 insertions(+), 72 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 119f53941c12..8b4348f69bc5 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -18,6 +18,7 @@
 #include <linux/skbuff.h>
 #include <linux/timer.h>
 #include <linux/in.h>
+#include <linux/ip.h>
 #include <linux/refcount.h>
 #include <uapi/linux/igmp.h>
 
@@ -106,6 +107,14 @@ struct ip_mc_list {
 #define IGMPV3_QQIC(value) IGMPV3_EXP(0x80, 4, 3, value)
 #define IGMPV3_MRC(value) IGMPV3_EXP(0x80, 4, 3, value)
 
+static inline int ip_mc_may_pull(struct sk_buff *skb, unsigned int len)
+{
+	if (skb_transport_offset(skb) + ip_transport_len(skb) < len)
+		return -EINVAL;
+
+	return pskb_may_pull(skb, len);
+}
+
 extern int ip_check_mc_rcu(struct in_device *dev, __be32 mc_addr, __be32 src_addr, u8 proto);
 extern int igmp_rcv(struct sk_buff *);
 extern int ip_mc_join_group(struct sock *sk, struct ip_mreqn *imr);
@@ -130,6 +139,6 @@ extern void ip_mc_unmap(struct in_device *);
 extern void ip_mc_remap(struct in_device *);
 extern void ip_mc_dec_group(struct in_device *in_dev, __be32 addr);
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
-int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed);
+int ip_mc_check_igmp(struct sk_buff *skb);
 
 #endif
diff --git a/include/linux/ip.h b/include/linux/ip.h
index 492bc6513533..482b7b7c9f30 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -34,4 +34,9 @@ static inline struct iphdr *ipip_hdr(const struct sk_buff *skb)
 {
 	return (struct iphdr *)skb_transport_header(skb);
 }
+
+static inline unsigned int ip_transport_len(const struct sk_buff *skb)
+{
+	return ntohs(ip_hdr(skb)->tot_len) - skb_network_header_len(skb);
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 495e834c1367..6d45ce784bea 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -104,6 +104,12 @@ static inline struct ipv6hdr *ipipv6_hdr(const struct sk_buff *skb)
 	return (struct ipv6hdr *)skb_transport_header(skb);
 }
 
+static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
+{
+	return ntohs(ipv6_hdr(skb)->payload_len) + sizeof(struct ipv6hdr) -
+	       skb_network_header_len(skb);
+}
+
 /* 
    This structure contains results of exthdrs parsing
    as offsets from skb->nh.
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 1656c5978498..daf11dcb0f70 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -49,6 +49,7 @@ struct prefix_info {
 	struct in6_addr		prefix;
 };
 
+#include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <net/if_inet6.h>
 #include <net/ipv6.h>
@@ -201,6 +202,15 @@ u32 ipv6_addr_label(struct net *net, const struct in6_addr *addr,
 /*
  *	multicast prototypes (mcast.c)
  */
+static inline int ipv6_mc_may_pull(struct sk_buff *skb,
+				   unsigned int len)
+{
+	if (skb_transport_offset(skb) + ipv6_transport_len(skb) < len)
+		return -EINVAL;
+
+	return pskb_may_pull(skb, len);
+}
+
 int ipv6_sock_mc_join(struct sock *sk, int ifindex,
 		      const struct in6_addr *addr);
 int ipv6_sock_mc_drop(struct sock *sk, int ifindex,
@@ -219,7 +229,7 @@ void ipv6_mc_unmap(struct inet6_dev *idev);
 void ipv6_mc_remap(struct inet6_dev *idev);
 void ipv6_mc_init_dev(struct inet6_dev *idev);
 void ipv6_mc_destroy_dev(struct inet6_dev *idev);
-int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed);
+int ipv6_mc_check_mld(struct sk_buff *skb);
 void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp);
 
 bool ipv6_chk_mcast_addr(struct net_device *dev, const struct in6_addr *group,
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 69244e4598f5..1dd70f048e7b 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -674,7 +674,7 @@ static void batadv_mcast_mla_update(struct work_struct *work)
  */
 static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
 {
-	if (ip_mc_check_igmp(skb, NULL) < 0)
+	if (ip_mc_check_igmp(skb) < 0)
 		return false;
 
 	switch (igmp_hdr(skb)->type) {
@@ -741,7 +741,7 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  */
 static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
 {
-	if (ipv6_mc_check_mld(skb, NULL) < 0)
+	if (ipv6_mc_check_mld(skb) < 0)
 		return false;
 
 	switch (icmp6_hdr(skb)->icmp6_type) {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3aeff0895669..156c4905639e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -938,7 +938,7 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge *br,
 
 	for (i = 0; i < num; i++) {
 		len += sizeof(*grec);
-		if (!pskb_may_pull(skb, len))
+		if (!ip_mc_may_pull(skb, len))
 			return -EINVAL;
 
 		grec = (void *)(skb->data + len - sizeof(*grec));
@@ -946,7 +946,7 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge *br,
 		type = grec->grec_type;
 
 		len += ntohs(grec->grec_nsrcs) * 4;
-		if (!pskb_may_pull(skb, len))
+		if (!ip_mc_may_pull(skb, len))
 			return -EINVAL;
 
 		/* We treat this as an IGMPv2 report for now. */
@@ -985,15 +985,17 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 					struct sk_buff *skb,
 					u16 vid)
 {
+	unsigned int nsrcs_offset;
 	const unsigned char *src;
 	struct icmp6hdr *icmp6h;
 	struct mld2_grec *grec;
+	unsigned int grec_len;
 	int i;
 	int len;
 	int num;
 	int err = 0;
 
-	if (!pskb_may_pull(skb, sizeof(*icmp6h)))
+	if (!ipv6_mc_may_pull(skb, sizeof(*icmp6h)))
 		return -EINVAL;
 
 	icmp6h = icmp6_hdr(skb);
@@ -1003,21 +1005,25 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 	for (i = 0; i < num; i++) {
 		__be16 *nsrcs, _nsrcs;
 
-		nsrcs = skb_header_pointer(skb,
-					   len + offsetof(struct mld2_grec,
-							  grec_nsrcs),
+		nsrcs_offset = len + offsetof(struct mld2_grec, grec_nsrcs);
+
+		if (skb_transport_offset(skb) + ipv6_transport_len(skb) <
+		    nsrcs_offset + sizeof(_nsrcs))
+			return -EINVAL;
+
+		nsrcs = skb_header_pointer(skb, nsrcs_offset,
 					   sizeof(_nsrcs), &_nsrcs);
 		if (!nsrcs)
 			return -EINVAL;
 
-		if (!pskb_may_pull(skb,
-				   len + sizeof(*grec) +
-				   sizeof(struct in6_addr) * ntohs(*nsrcs)))
+		grec_len = sizeof(*grec) +
+			   sizeof(struct in6_addr) * ntohs(*nsrcs);
+
+		if (!ipv6_mc_may_pull(skb, len + grec_len))
 			return -EINVAL;
 
 		grec = (struct mld2_grec *)(skb->data + len);
-		len += sizeof(*grec) +
-		       sizeof(struct in6_addr) * ntohs(*nsrcs);
+		len += grec_len;
 
 		/* We treat these as MLDv1 reports for now. */
 		switch (grec->grec_type) {
@@ -1219,6 +1225,7 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 				   struct sk_buff *skb,
 				   u16 vid)
 {
+	unsigned int transport_len = ip_transport_len(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct igmphdr *ih = igmp_hdr(skb);
 	struct net_bridge_mdb_entry *mp;
@@ -1228,7 +1235,6 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 	struct br_ip saddr;
 	unsigned long max_delay;
 	unsigned long now = jiffies;
-	unsigned int offset = skb_transport_offset(skb);
 	__be32 group;
 
 	spin_lock(&br->multicast_lock);
@@ -1238,14 +1244,14 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 
 	group = ih->group;
 
-	if (skb->len == offset + sizeof(*ih)) {
+	if (transport_len == sizeof(*ih)) {
 		max_delay = ih->code * (HZ / IGMP_TIMER_SCALE);
 
 		if (!max_delay) {
 			max_delay = 10 * HZ;
 			group = 0;
 		}
-	} else if (skb->len >= offset + sizeof(*ih3)) {
+	} else if (transport_len >= sizeof(*ih3)) {
 		ih3 = igmpv3_query_hdr(skb);
 		if (ih3->nsrcs)
 			goto out;
@@ -1296,6 +1302,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 				  struct sk_buff *skb,
 				  u16 vid)
 {
+	unsigned int transport_len = ipv6_transport_len(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct mld_msg *mld;
 	struct net_bridge_mdb_entry *mp;
@@ -1315,7 +1322,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 	    (port && port->state == BR_STATE_DISABLED))
 		goto out;
 
-	if (skb->len == offset + sizeof(*mld)) {
+	if (transport_len == sizeof(*mld)) {
 		if (!pskb_may_pull(skb, offset + sizeof(*mld))) {
 			err = -EINVAL;
 			goto out;
@@ -1581,12 +1588,11 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 				 struct sk_buff *skb,
 				 u16 vid)
 {
-	struct sk_buff *skb_trimmed = NULL;
 	const unsigned char *src;
 	struct igmphdr *ih;
 	int err;
 
-	err = ip_mc_check_igmp(skb, &skb_trimmed);
+	err = ip_mc_check_igmp(skb);
 
 	if (err == -ENOMSG) {
 		if (!ipv4_is_local_multicast(ip_hdr(skb)->daddr)) {
@@ -1612,19 +1618,16 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 		err = br_ip4_multicast_add_group(br, port, ih->group, vid, src);
 		break;
 	case IGMPV3_HOST_MEMBERSHIP_REPORT:
-		err = br_ip4_multicast_igmp3_report(br, port, skb_trimmed, vid);
+		err = br_ip4_multicast_igmp3_report(br, port, skb, vid);
 		break;
 	case IGMP_HOST_MEMBERSHIP_QUERY:
-		br_ip4_multicast_query(br, port, skb_trimmed, vid);
+		br_ip4_multicast_query(br, port, skb, vid);
 		break;
 	case IGMP_HOST_LEAVE_MESSAGE:
 		br_ip4_multicast_leave_group(br, port, ih->group, vid, src);
 		break;
 	}
 
-	if (skb_trimmed && skb_trimmed != skb)
-		kfree_skb(skb_trimmed);
-
 	br_multicast_count(br, port, skb, BR_INPUT_SKB_CB(skb)->igmp,
 			   BR_MCAST_DIR_RX);
 
@@ -1637,12 +1640,11 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 				 struct sk_buff *skb,
 				 u16 vid)
 {
-	struct sk_buff *skb_trimmed = NULL;
 	const unsigned char *src;
 	struct mld_msg *mld;
 	int err;
 
-	err = ipv6_mc_check_mld(skb, &skb_trimmed);
+	err = ipv6_mc_check_mld(skb);
 
 	if (err == -ENOMSG) {
 		if (!ipv6_addr_is_ll_all_nodes(&ipv6_hdr(skb)->daddr))
@@ -1664,10 +1666,10 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 						 src);
 		break;
 	case ICMPV6_MLD2_REPORT:
-		err = br_ip6_multicast_mld2_report(br, port, skb_trimmed, vid);
+		err = br_ip6_multicast_mld2_report(br, port, skb, vid);
 		break;
 	case ICMPV6_MGM_QUERY:
-		err = br_ip6_multicast_query(br, port, skb_trimmed, vid);
+		err = br_ip6_multicast_query(br, port, skb, vid);
 		break;
 	case ICMPV6_MGM_REDUCTION:
 		src = eth_hdr(skb)->h_source;
@@ -1675,9 +1677,6 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 		break;
 	}
 
-	if (skb_trimmed && skb_trimmed != skb)
-		kfree_skb(skb_trimmed);
-
 	br_multicast_count(br, port, skb, BR_INPUT_SKB_CB(skb)->igmp,
 			   BR_MCAST_DIR_RX);
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 765b2b32c4a4..b1f6d93282d7 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1544,7 +1544,7 @@ static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_simple_validate(skb);
 }
 
-static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+static int __ip_mc_check_igmp(struct sk_buff *skb)
 
 {
 	struct sk_buff *skb_chk;
@@ -1566,16 +1566,10 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 	if (ret)
 		goto err;
 
-	if (skb_trimmed)
-		*skb_trimmed = skb_chk;
-	/* free now unneeded clone */
-	else if (skb_chk != skb)
-		kfree_skb(skb_chk);
-
 	ret = 0;
 
 err:
-	if (ret && skb_chk && skb_chk != skb)
+	if (skb_chk && skb_chk != skb)
 		kfree_skb(skb_chk);
 
 	return ret;
@@ -1584,7 +1578,6 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 /**
  * ip_mc_check_igmp - checks whether this is a sane IGMP packet
  * @skb: the skb to validate
- * @skb_trimmed: to store an skb pointer trimmed to IPv4 packet tail (optional)
  *
  * Checks whether an IPv4 packet is a valid IGMP packet. If so sets
  * skb transport header accordingly and returns zero.
@@ -1594,18 +1587,10 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
  * -ENOMSG: IP header validation succeeded but it is not an IGMP packet.
  * -ENOMEM: A memory allocation failure happened.
  *
- * Optionally, an skb pointer might be provided via skb_trimmed (or set it
- * to NULL): After parsing an IGMP packet successfully it will point to
- * an skb which has its tail aligned to the IP packet end. This might
- * either be the originally provided skb or a trimmed, cloned version if
- * the skb frame had data beyond the IP packet. A cloned skb allows us
- * to leave the original skb and its full frame unchanged (which might be
- * desirable for layer 2 frame jugglers).
- *
  * Caller needs to set the skb network header and free any returned skb if it
  * differs from the provided skb.
  */
-int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+int ip_mc_check_igmp(struct sk_buff *skb)
 {
 	int ret = ip_mc_check_iphdr(skb);
 
@@ -1615,7 +1600,7 @@ int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
 		return -ENOMSG;
 
-	return __ip_mc_check_igmp(skb, skb_trimmed);
+	return __ip_mc_check_igmp(skb);
 }
 EXPORT_SYMBOL(ip_mc_check_igmp);
 
diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
index 9405b04eecc6..1a917dc80d5e 100644
--- a/net/ipv6/mcast_snoop.c
+++ b/net/ipv6/mcast_snoop.c
@@ -136,8 +136,7 @@ static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
 }
 
-static int __ipv6_mc_check_mld(struct sk_buff *skb,
-			       struct sk_buff **skb_trimmed)
+static int __ipv6_mc_check_mld(struct sk_buff *skb)
 
 {
 	struct sk_buff *skb_chk = NULL;
@@ -160,16 +159,10 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
 	if (ret)
 		goto err;
 
-	if (skb_trimmed)
-		*skb_trimmed = skb_chk;
-	/* free now unneeded clone */
-	else if (skb_chk != skb)
-		kfree_skb(skb_chk);
-
 	ret = 0;
 
 err:
-	if (ret && skb_chk && skb_chk != skb)
+	if (skb_chk && skb_chk != skb)
 		kfree_skb(skb_chk);
 
 	return ret;
@@ -178,7 +171,6 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
 /**
  * ipv6_mc_check_mld - checks whether this is a sane MLD packet
  * @skb: the skb to validate
- * @skb_trimmed: to store an skb pointer trimmed to IPv6 packet tail (optional)
  *
  * Checks whether an IPv6 packet is a valid MLD packet. If so sets
  * skb transport header accordingly and returns zero.
@@ -188,18 +180,10 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
  * -ENOMSG: IP header validation succeeded but it is not an MLD packet.
  * -ENOMEM: A memory allocation failure happened.
  *
- * Optionally, an skb pointer might be provided via skb_trimmed (or set it
- * to NULL): After parsing an MLD packet successfully it will point to
- * an skb which has its tail aligned to the IP packet end. This might
- * either be the originally provided skb or a trimmed, cloned version if
- * the skb frame had data beyond the IP packet. A cloned skb allows us
- * to leave the original skb and its full frame unchanged (which might be
- * desirable for layer 2 frame jugglers).
- *
  * Caller needs to set the skb network header and free any returned skb if it
  * differs from the provided skb.
  */
-int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+int ipv6_mc_check_mld(struct sk_buff *skb)
 {
 	int ret;
 
@@ -211,6 +195,6 @@ int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 	if (ret < 0)
 		return ret;
 
-	return __ipv6_mc_check_mld(skb, skb_trimmed);
+	return __ipv6_mc_check_mld(skb);
 }
 EXPORT_SYMBOL(ipv6_mc_check_mld);
-- 
2.11.0

