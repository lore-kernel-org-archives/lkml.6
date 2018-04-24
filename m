Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDXSXb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:23:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44475 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeDXSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:23:25 -0400
X-Google-Smtp-Source: AIpwx48uXnmydaY8olawVRmKv2EYCeNeii9/oO/tQkzSQFVs0RCtOFHCnAiZgyB7dyFUfxd97Smv+Q==
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: davem@davemloft.net, dav.lebrun@gmail.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: [net-next v3] ipv6: sr: Compute flowlabel for outer IPv6 header of seg6 encap mode
Date: Tue, 24 Apr 2018 20:23:16 +0200
Message-Id: <1524594196-12383-1-git-send-email-amsalam20@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECMP (equal-cost multipath) hashes are typically computed on the packets'
5-tuple(src IP, dst IP, src port, dst port, L4 proto).

For encapsulated packets, the L4 data is not readily available and ECMP
hashing will often revert to (src IP, dst IP). This will lead to traffic
polarization on a single ECMP path, causing congestion and waste of network
capacity.

In IPv6, the 20-bit flow label field is also used as part of the ECMP hash.
In the lack of L4 data, the hashing will be on (src IP, dst IP, flow
label). Having a non-zero flow label is thus important for proper traffic
load balancing when L4 data is unavailable (i.e., when packets are
encapsulated).

Currently, the seg6_do_srh_encap() function extracts the original packet's
flow label and set it as the outer IPv6 flow label. There are two issues
with this behaviour:

a) There is no guarantee that the inner flow label is set by the source.
b) If the original packet is not IPv6, the flow label will be set to
zero (e.g., IPv4 or L2 encap).

This patch adds a function, named seg6_make_flowlabel(), that computes a
flow label from a given skb. It supports IPv6, IPv4 and L2 payloads, and
leverages the per namespace 'seg6_flowlabel" sysctl value.

The currently support behaviours are as follows:
-1 set flowlabel to zero.
0 copy flowlabel from Inner paceket in case of Inner IPv6
(Set flowlabel to 0 in case IPv4/L2)
1 Compute the flowlabel using seg6_make_flowlabel()

This patch has been tested for IPv6, IPv4, and L2 traffic.

Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
---
 include/net/netns/ipv6.h   |  1 +
 net/ipv6/seg6_iptunnel.c   | 24 ++++++++++++++++++++++--
 net/ipv6/sysctl_net_ipv6.c |  8 ++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 97b3a54..c978a31 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -43,6 +43,7 @@ struct netns_sysctl_ipv6 {
 	int max_hbh_opts_cnt;
 	int max_dst_opts_len;
 	int max_hbh_opts_len;
+	int seg6_flowlabel;
 };
 
 struct netns_ipv6 {
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 5fe1394..9898926 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -91,6 +91,24 @@ static void set_tun_src(struct net *net, struct net_device *dev,
 	rcu_read_unlock();
 }
 
+/* Compute flowlabel for outer IPv6 header */
+static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
+				  struct ipv6hdr *inner_hdr)
+{
+	int do_flowlabel = net->ipv6.sysctl.seg6_flowlabel;
+	__be32 flowlabel = 0;
+	u32 hash;
+
+	if (do_flowlabel > 0) {
+		hash = skb_get_hash(skb);
+		rol32(hash, 16);
+		flowlabel = (__force __be32)hash & IPV6_FLOWLABEL_MASK;
+	} else if (!do_flowlabel && skb->protocol == htons(ETH_P_IPV6)) {
+		flowlabel = ip6_flowlabel(inner_hdr);
+	}
+	return flowlabel;
+}
+
 /* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
 int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 {
@@ -99,6 +117,7 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	struct ipv6hdr *hdr, *inner_hdr;
 	struct ipv6_sr_hdr *isrh;
 	int hdrlen, tot_len, err;
+	__be32 flowlabel;
 
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
@@ -119,12 +138,13 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	 * decapsulation will overwrite inner hlim with outer hlim
 	 */
 
+	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
 	if (skb->protocol == htons(ETH_P_IPV6)) {
 		ip6_flow_hdr(hdr, ip6_tclass(ip6_flowinfo(inner_hdr)),
-			     ip6_flowlabel(inner_hdr));
+			     flowlabel);
 		hdr->hop_limit = inner_hdr->hop_limit;
 	} else {
-		ip6_flow_hdr(hdr, 0, 0);
+		ip6_flow_hdr(hdr, 0, flowlabel);
 		hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
 	}
 
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 6fbdef6..e15cd37 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -152,6 +152,13 @@ static struct ctl_table ipv6_table_template[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+	{
+		.procname	= "seg6_flowlabel",
+		.data		= &init_net.ipv6.sysctl.seg6_flowlabel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
 	{ }
 };
 
@@ -217,6 +224,7 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 	ipv6_table[12].data = &net->ipv6.sysctl.max_dst_opts_len;
 	ipv6_table[13].data = &net->ipv6.sysctl.max_hbh_opts_len;
 	ipv6_table[14].data = &net->ipv6.sysctl.multipath_hash_policy,
+	ipv6_table[15].data = &net->ipv6.sysctl.seg6_flowlabel;
 
 	ipv6_route_table = ipv6_route_sysctl_init(net);
 	if (!ipv6_route_table)
-- 
2.1.4
