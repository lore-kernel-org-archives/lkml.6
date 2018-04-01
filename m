Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeDASb1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 14:31:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33065 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753799AbeDASbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 14:31:24 -0400
X-Google-Smtp-Source: AIpwx4+DBA9zdyHNrvOL3fnI99Yj4jY/XI0NgVrbJEGMJX8z1GP3HXj9g0RMKvU7duCDaFfRfC2WTA==
From: Anton Gary Ceph <agaceph@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: improve ipv4 performances
Date: Sun,  1 Apr 2018 20:31:21 +0200
Message-Id: <20180401183121.13022-1-agaceph@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the Linux networking stack is growing, more and more protocols are
added, increasing the complexity of stack itself.
Modern processors, contrary to common belief, are very bad in branch
prediction, so it's our task to give hints to the compiler when possible.

After a few profiling and analysis, turned out that the ethertype field
of the packets has the following distribution:

    92.1% ETH_P_IP
     3.2% ETH_P_ARP
     2.7% ETH_P_8021Q
     1.4% ETH_P_PPP_SES
     0.6% don't know/no opinion

>From a projection on statistics collected by Google about IPv6 adoption[1],
IPv6 should peak at 25% usage at the beginning of 2030. Hence, we should
give proper hints to the compiler about the low IPv6 usage.

Here is an iperf3 run before and after the patch:

Before:
[ ID]  Interval           Transfer    Bandwidth       Retr
[  4]  0.00-100.00 sec    100 GBytes  8.60 Gbits/sec  0       sender
[  4]  0.00-100.00 sec    100 GBytes  8.60 Gbits/sec          receiver

After
[ ID]  Interval           Transfer    Bandwidth       Retr
[  4]  0.00-100.00 sec    109 GBytes  9.35 Gbits/sec  0       sender
[  4]  0.00-100.00 sec    109 GBytes  9.35 Gbits/sec          receiver

[1] https://www.google.com/intl/en/ipv6/statistics.html

Signed-off-by: Anton Gary Ceph <agaceph@gmail.com>
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/ipvlan/ipvlan_core.c   |  2 +-
 drivers/net/vxlan.c                |  6 +++---
 include/linux/netdevice.h          |  2 +-
 include/net/ip_tunnels.h           |  2 +-
 include/net/netfilter/nf_queue.h   |  4 ++--
 net/bridge/br_device.c             |  2 +-
 net/bridge/br_input.c              |  2 +-
 net/bridge/br_mdb.c                |  5 +++--
 net/bridge/br_multicast.c          | 18 +++++++++---------
 net/bridge/br_netfilter_hooks.c    |  9 +++++----
 net/bridge/br_private.h            |  2 +-
 net/core/dev.c                     |  2 +-
 net/core/filter.c                  |  8 ++++----
 net/core/skbuff.c                  |  2 +-
 net/core/tso.c                     |  2 +-
 net/ipv4/ip_gre.c                  |  6 +++---
 net/ipv4/ip_tunnel.c               | 12 ++++++------
 net/ipv4/ping.c                    | 10 +++++-----
 net/ipv6/datagram.c                |  6 +++---
 net/netfilter/nf_flow_table_inet.c |  2 +-
 net/netfilter/nf_tables_netdev.c   |  2 +-
 net/netfilter/nfnetlink_queue.c    |  2 +-
 net/openvswitch/actions.c          |  2 +-
 net/openvswitch/conntrack.c        | 16 ++++++++--------
 net/openvswitch/flow.c             |  4 ++--
 net/openvswitch/flow.h             |  2 +-
 net/openvswitch/flow_netlink.c     | 18 +++++++++---------
 net/xfrm/xfrm_output.c             |  2 +-
 29 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b7b113018853..b3ad2a8c1a08 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3222,7 +3222,7 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb,
 		noff += iph->ihl << 2;
 		if (!ip_is_fragment(iph))
 			proto = iph->protocol;
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	} else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 		if (unlikely(!pskb_may_pull(skb, noff + sizeof(*iph6))))
 			return false;
 		iph6 = ipv6_hdr(skb);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index c1f008fe4e1d..7344e2402003 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -480,7 +480,7 @@ static int ipvlan_process_outbound(struct sk_buff *skb)
 		skb_reset_network_header(skb);
 	}
 
-	if (skb->protocol == htons(ETH_P_IPV6))
+	if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 		ret = ipvlan_process_v6_outbound(skb);
 	else if (skb->protocol == htons(ETH_P_IP))
 		ret = ipvlan_process_v4_outbound(skb);
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index fab7a4db249e..8143b99e098f 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1694,7 +1694,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 		return false;
 
 	n = NULL;
-	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	switch (__builtin_expect(ntohs(eth_hdr(skb)->h_proto), ETH_P_IP)) {
 	case ETH_P_IP:
 	{
 		struct iphdr *pip;
@@ -2274,7 +2274,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (ntohs(eth->h_proto) == ETH_P_ARP)
 			return arp_reduce(dev, skb, vni);
 #if IS_ENABLED(CONFIG_IPV6)
-		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
+		else if (unlikely(ntohs(eth->h_proto) == ETH_P_IPV6) &&
 			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 					    sizeof(struct nd_msg)) &&
 			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
@@ -2293,7 +2293,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
 	    (ntohs(eth->h_proto) == ETH_P_IP ||
-	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
+	     unlikely(ntohs(eth->h_proto) == ETH_P_IPV6))) {
 		did_rsc = route_shortcircuit(dev, skb);
 		if (did_rsc)
 			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5eef6c8e2741..c1a4820622f9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4031,7 +4031,7 @@ static inline bool can_checksum_protocol(netdev_features_t features,
 		return true;
 	}
 
-	switch (protocol) {
+	switch (__builtin_expect(protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return !!(features & NETIF_F_IP_CSUM);
 	case htons(ETH_P_IPV6):
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1f16773cfd76..f837867ff3b7 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -355,7 +355,7 @@ static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
 {
 	if (skb->protocol == htons(ETH_P_IP))
 		return iph->tos;
-	else if (skb->protocol == htons(ETH_P_IPV6))
+	else if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 		return ipv6_get_dsfield((const struct ipv6hdr *)iph);
 	else
 		return 0;
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index a50a69f5334c..c97b6a7719f4 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -79,7 +79,7 @@ static inline u32 hash_bridge(const struct sk_buff *skb, u32 initval)
 	struct ipv6hdr *ip6h, _ip6h;
 	struct iphdr *iph, _iph;
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (__builtin_expect(eth_hdr(skb)->h_proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		iph = skb_header_pointer(skb, skb_network_offset(skb),
 					 sizeof(*iph), &_iph);
@@ -101,7 +101,7 @@ static inline u32
 nfqueue_hash(const struct sk_buff *skb, u16 queue, u16 queues_total, u8 family,
 	     u32 initval)
 {
-	switch (family) {
+	switch (__builtin_expect(family, NFPROTO_IPV4)) {
 	case NFPROTO_IPV4:
 		queue += reciprocal_scale(hash_v4(ip_hdr(skb), initval),
 					  queues_total);
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 1285ca30ab0a..881c4bc794b9 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -70,7 +70,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	    br->neigh_suppress_enabled) {
 		br_do_proxy_suppress_arp(skb, br, vid, NULL);
 	} else if (IS_ENABLED(CONFIG_IPV6) &&
-		   skb->protocol == htons(ETH_P_IPV6) &&
+		   unlikely(skb->protocol == htons(ETH_P_IPV6)) &&
 		   br->neigh_suppress_enabled &&
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 				 sizeof(struct nd_msg)) &&
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 7f98a7d25866..6b8e4d808424 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -120,7 +120,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	     skb->protocol == htons(ETH_P_RARP))) {
 		br_do_proxy_suppress_arp(skb, br, vid, p);
 	} else if (IS_ENABLED(CONFIG_IPV6) &&
-		   skb->protocol == htons(ETH_P_IPV6) &&
+		   unlikely(skb->protocol == htons(ETH_P_IPV6)) &&
 		   br->neigh_suppress_enabled &&
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 				 sizeof(struct nd_msg)) &&
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 6d9f48bd374a..4c019c8d6e22 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -128,7 +128,8 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 				if (p->addr.proto == htons(ETH_P_IP))
 					e.addr.u.ip4 = p->addr.u.ip4;
 #if IS_ENABLED(CONFIG_IPV6)
-				if (p->addr.proto == htons(ETH_P_IPV6))
+				if (unlikely(p->addr.proto ==
+					     htons(ETH_P_IPV6)))
 					e.addr.u.ip6 = p->addr.u.ip6;
 #endif
 				e.addr.proto = p->addr.proto;
@@ -488,7 +489,7 @@ static bool is_valid_mdb_entry(struct br_mdb_entry *entry)
 		if (ipv4_is_local_multicast(entry->addr.u.ip4))
 			return false;
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (entry->addr.proto == htons(ETH_P_IPV6)) {
+	} else if (unlikely(entry->addr.proto == htons(ETH_P_IPV6))) {
 		if (ipv6_addr_is_ll_all_nodes(&entry->addr.u.ip6))
 			return false;
 #endif
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index cb4729539b82..1c978838b81a 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -62,7 +62,7 @@ static inline int br_ip_equal(const struct br_ip *a, const struct br_ip *b)
 		return 0;
 	if (a->vid != b->vid)
 		return 0;
-	switch (a->proto) {
+	switch (__builtin_expect(a->proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return a->u.ip4 == b->u.ip4;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -92,7 +92,7 @@ static inline int __br_ip6_hash(struct net_bridge_mdb_htable *mdb,
 static inline int br_ip_hash(struct net_bridge_mdb_htable *mdb,
 			     struct br_ip *ip)
 {
-	switch (ip->proto) {
+	switch (__builtin_expect(ip->proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return __br_ip4_hash(mdb, ip->u.ip4, ip->vid);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -167,7 +167,7 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 	ip.proto = skb->protocol;
 	ip.vid = vid;
 
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		ip.u.ip4 = ip_hdr(skb)->daddr;
 		break;
@@ -577,7 +577,7 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge *br,
 						struct br_ip *addr,
 						u8 *igmp_type)
 {
-	switch (addr->proto) {
+	switch (__builtin_expect(addr->proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return br_ip4_multicast_alloc_query(br, addr->u.ip4, igmp_type);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1321,7 +1321,7 @@ static bool br_multicast_select_querier(struct net_bridge *br,
 					struct net_bridge_port *port,
 					struct br_ip *saddr)
 {
-	switch (saddr->proto) {
+	switch (__builtin_expect(saddr->proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return br_ip4_multicast_select_querier(br, port, saddr->u.ip4);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1761,7 +1761,7 @@ static void br_multicast_err_count(const struct net_bridge *br,
 	pstats = this_cpu_ptr(stats);
 
 	u64_stats_update_begin(&pstats->syncp);
-	switch (proto) {
+	switch (__builtin_expect(proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		pstats->mstats.igmp_parse_errors++;
 		break;
@@ -1909,7 +1909,7 @@ int br_multicast_rcv(struct net_bridge *br, struct net_bridge_port *port,
 	if (br->multicast_disabled)
 		return 0;
 
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		ret = br_multicast_ipv4_rcv(br, port, skb, vid);
 		break;
@@ -2461,7 +2461,7 @@ bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
 
 	br = port->br;
 
-	switch (proto) {
+	switch (__builtin_expect(proto, ETH_P_IP)) {
 	case ETH_P_IP:
 		if (!timer_pending(&br->ip4_other_query.timer) ||
 		    rcu_dereference(br->ip4_querier.port) == port)
@@ -2493,7 +2493,7 @@ static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
 	unsigned int t_len;
 
 	u64_stats_update_begin(&pstats->syncp);
-	switch (proto) {
+	switch (__builtin_expect(proto, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		t_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
 		switch (type) {
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 9b16eaf33819..c622781eaa47 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -73,7 +73,8 @@ static int brnf_pass_vlan_indev __read_mostly;
 	(!skb_vlan_tag_present(skb) && skb->protocol == htons(ETH_P_IP))
 
 #define IS_IPV6(skb) \
-	(!skb_vlan_tag_present(skb) && skb->protocol == htons(ETH_P_IPV6))
+	(!skb_vlan_tag_present(skb) && \
+	 unlikely(skb->protocol == htons(ETH_P_IPV6)))
 
 #define IS_ARP(skb) \
 	(!skb_vlan_tag_present(skb) && skb->protocol == htons(ETH_P_ARP))
@@ -93,7 +94,7 @@ static inline __be16 vlan_proto(const struct sk_buff *skb)
 	 brnf_filter_vlan_tagged)
 
 #define IS_VLAN_IPV6(skb) \
-	(vlan_proto(skb) == htons(ETH_P_IPV6) && \
+	 unlikely(vlan_proto(skb) == htons(ETH_P_IPV6) && \
 	 brnf_filter_vlan_tagged)
 
 #define IS_VLAN_ARP(skb) \
@@ -534,7 +535,7 @@ static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff
 		if (skb->protocol == htons(ETH_P_IP))
 			nf_bridge->frag_max_size = IPCB(skb)->frag_max_size;
 
-		if (skb->protocol == htons(ETH_P_IPV6))
+		if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 			nf_bridge->frag_max_size = IP6CB(skb)->frag_max_size;
 
 		in = nf_bridge->physindev;
@@ -749,7 +750,7 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 		return br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
 	}
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV6) &&
-	    skb->protocol == htons(ETH_P_IPV6)) {
+	    unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 		const struct nf_ipv6_ops *v6ops = nf_get_ipv6_ops();
 		struct brnf_frag_data *data;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8e13a64d8c99..a208cc627662 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -686,7 +686,7 @@ __br_multicast_querier_exists(struct net_bridge *br,
 static inline bool br_multicast_querier_exists(struct net_bridge *br,
 					       struct ethhdr *eth)
 {
-	switch (eth->h_proto) {
+	switch (__builtin_expect(eth->h_proto, ETH_P_IP)) {
 	case (htons(ETH_P_IP)):
 		return __br_multicast_querier_exists(br,
 			&br->ip4_other_query, false);
diff --git a/net/core/dev.c b/net/core/dev.c
index ef0cc6ea5f8d..f829f0a68a94 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4395,7 +4395,7 @@ EXPORT_SYMBOL_GPL(netdev_rx_handler_unregister);
  */
 static bool skb_pfmemalloc_protocol(struct sk_buff *skb)
 {
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_ARP):
 	case htons(ETH_P_IP):
 	case htons(ETH_P_IPV6):
diff --git a/net/core/filter.c b/net/core/filter.c
index 48aa7c7320db..6b7ab16505aa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2170,11 +2170,11 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb, __be16 to_proto)
 	__be16 from_proto = skb->protocol;
 
 	if (from_proto == htons(ETH_P_IP) &&
-	      to_proto == htons(ETH_P_IPV6))
+	      unlikely(to_proto == htons(ETH_P_IPV6)))
 		return bpf_skb_proto_4_to_6(skb);
 
-	if (from_proto == htons(ETH_P_IPV6) &&
-	      to_proto == htons(ETH_P_IP))
+	if (unlikely(from_proto == htons(ETH_P_IPV6)) &&
+	    to_proto == htons(ETH_P_IP))
 		return bpf_skb_proto_6_to_4(skb);
 
 	return -ENOTSUPP;
@@ -2240,7 +2240,7 @@ static const struct bpf_func_proto bpf_skb_change_type_proto = {
 
 static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 {
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return sizeof(struct iphdr);
 	case htons(ETH_P_IPV6):
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 857e4e6f751a..6236c7c18740 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4642,7 +4642,7 @@ int skb_checksum_setup(struct sk_buff *skb, bool recalculate)
 {
 	int err;
 
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		err = skb_checksum_setup_ipv4(skb, recalculate);
 		break;
diff --git a/net/core/tso.c b/net/core/tso.c
index 43f4eba61933..85da3c3b498b 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -21,7 +21,7 @@ void tso_build_hdr(struct sk_buff *skb, char *hdr, struct tso_t *tso,
 	int mac_hdr_len = skb_network_offset(skb);
 
 	memcpy(hdr, skb->data, hdr_len);
-	if (!tso->ipv6) {
+	if (likely(!tso->ipv6)) {
 		struct iphdr *iph = (void *)(hdr + mac_hdr_len);
 
 		iph->id = htons(tso->ip_id);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 0901de42ed85..6cf3e3e4cca3 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -189,9 +189,9 @@ static void ipgre_err(struct sk_buff *skb, u32 info,
 		return;
 
 #if IS_ENABLED(CONFIG_IPV6)
-       if (tpi->proto == htons(ETH_P_IPV6) &&
-           !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
-				       type, data_len))
+	if (unlikely(tpi->proto == htons(ETH_P_IPV6)) &&
+	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
+					type, data_len))
                return;
 #endif
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index a7fd1c5a2a14..74ac2caff5a5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -541,7 +541,7 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 		}
 	}
 #if IS_ENABLED(CONFIG_IPV6)
-	else if (skb->protocol == htons(ETH_P_IPV6)) {
+	else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 		struct rt6_info *rt6 = (struct rt6_info *)skb_dst(skb);
 
 		if (rt6 && mtu < dst_mtu(skb_dst(skb)) &&
@@ -587,7 +587,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev, u8 proto)
 	if (tos == 1) {
 		if (skb->protocol == htons(ETH_P_IP))
 			tos = inner_iph->tos;
-		else if (skb->protocol == htons(ETH_P_IPV6))
+		else if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 			tos = ipv6_get_dsfield((const struct ipv6hdr *)inner_iph);
 	}
 	init_tunnel_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src, 0,
@@ -609,7 +609,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev, u8 proto)
 	if (ttl == 0) {
 		if (skb->protocol == htons(ETH_P_IP))
 			ttl = inner_iph->ttl;
-		else if (skb->protocol == htons(ETH_P_IPV6))
+		else if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 			ttl = ((const struct ipv6hdr *)inner_iph)->hop_limit;
 		else
 			ttl = ip4_dst_hoplimit(&rt->dst);
@@ -671,7 +671,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			dst = rt_nexthop(rt, inner_iph->daddr);
 		}
 #if IS_ENABLED(CONFIG_IPV6)
-		else if (skb->protocol == htons(ETH_P_IPV6)) {
+		else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 			const struct in6_addr *addr6;
 			struct neighbour *neigh;
 			bool do_tx_error_icmp;
@@ -713,7 +713,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		if (skb->protocol == htons(ETH_P_IP)) {
 			tos = inner_iph->tos;
 			connected = false;
-		} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		} else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 			tos = ipv6_get_dsfield((const struct ipv6hdr *)inner_iph);
 			connected = false;
 		}
@@ -768,7 +768,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		if (skb->protocol == htons(ETH_P_IP))
 			ttl = inner_iph->ttl;
 #if IS_ENABLED(CONFIG_IPV6)
-		else if (skb->protocol == htons(ETH_P_IPV6))
+		else if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 			ttl = ((const struct ipv6hdr *)inner_iph)->hop_limit;
 #endif
 		else
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index b8f0db54b197..64b3eaa84974 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -183,7 +183,7 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
 		pr_debug("try to find: num = %d, daddr = %pI4, dif = %d\n",
 			 (int)ident, &ip_hdr(skb)->daddr, dif);
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	} else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 		pr_debug("try to find: num = %d, daddr = %pI6c, dif = %d\n",
 			 (int)ident, &ipv6_hdr(skb)->daddr, dif);
 #endif
@@ -208,7 +208,7 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
 			    isk->inet_rcv_saddr != ip_hdr(skb)->daddr)
 				continue;
 #if IS_ENABLED(CONFIG_IPV6)
-		} else if (skb->protocol == htons(ETH_P_IPV6) &&
+		} else if (unlikely(skb->protocol == htons(ETH_P_IPV6)) &&
 			   sk->sk_family == AF_INET6) {
 
 			pr_debug("found: %p: num=%d, daddr=%pI6c, dif=%d\n", sk,
@@ -497,7 +497,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 		type = icmp_hdr(skb)->type;
 		code = icmp_hdr(skb)->code;
 		icmph = (struct icmphdr *)(skb->data + offset);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	} else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 		family = AF_INET6;
 		type = icmp6_hdr(skb)->icmp6_type;
 		code = icmp6_hdr(skb)->icmp6_code;
@@ -565,7 +565,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 			break;
 		}
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	} else if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 		harderr = pingv6_ops.icmpv6_err_convert(type, code, &err);
 #endif
 	}
@@ -929,7 +929,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int noblock,
 
 		if (inet6_sk(sk)->rxopt.all)
 			pingv6_ops.ip6_datagram_recv_common_ctl(sk, msg, skb);
-		if (skb->protocol == htons(ETH_P_IPV6) &&
+		if (unlikely(skb->protocol == htons(ETH_P_IPV6)) &&
 		    inet6_sk(sk)->rxopt.all)
 			pingv6_ops.ip6_datagram_recv_specific_ctl(sk, msg, skb);
 		else if (skb->protocol == htons(ETH_P_IP) && isk->cmsg_flags)
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index a9f7eca0b6a3..230249917ffc 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -474,7 +474,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 		sin->sin6_family = AF_INET6;
 		sin->sin6_flowinfo = 0;
 		sin->sin6_port = serr->port;
-		if (skb->protocol == htons(ETH_P_IPV6)) {
+		if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 			const struct ipv6hdr *ip6h = container_of((struct in6_addr *)(nh + serr->addr_offset),
 								  struct ipv6hdr, daddr);
 			sin->sin6_addr = ip6h->daddr;
@@ -499,7 +499,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 		sin->sin6_family = AF_INET6;
 		if (np->rxopt.all)
 			ip6_datagram_recv_common_ctl(sk, msg, skb);
-		if (skb->protocol == htons(ETH_P_IPV6)) {
+		if (unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 			sin->sin6_addr = ipv6_hdr(skb)->saddr;
 			if (np->rxopt.all)
 				ip6_datagram_recv_specific_ctl(sk, msg, skb);
@@ -587,7 +587,7 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
 	if (np->rxopt.bits.rxinfo) {
 		struct in6_pktinfo src_info;
 
-		if (is_ipv6) {
+		if (unlikely(is_ipv6)) {
 			src_info.ipi6_ifindex = IP6CB(skb)->iif;
 			src_info.ipi6_addr = ipv6_hdr(skb)->daddr;
 		} else {
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 375a1881d93d..17c89edcde70 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -10,7 +10,7 @@ static unsigned int
 nf_flow_offload_inet_hook(void *priv, struct sk_buff *skb,
 			  const struct nf_hook_state *state)
 {
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		return nf_flow_offload_ip_hook(priv, skb, state);
 	case htons(ETH_P_IPV6):
diff --git a/net/netfilter/nf_tables_netdev.c b/net/netfilter/nf_tables_netdev.c
index 4041fafca934..0fc5cc45d238 100644
--- a/net/netfilter/nf_tables_netdev.c
+++ b/net/netfilter/nf_tables_netdev.c
@@ -23,7 +23,7 @@ nft_do_chain_netdev(void *priv, struct sk_buff *skb,
 
 	nft_set_pktinfo(&pkt, skb, state);
 
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt, skb);
 		break;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 8bba23160a68..9db1303a3c9f 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -774,7 +774,7 @@ nfqnl_enqueue_packet(struct nf_queue_entry *entry, unsigned int queuenum)
 
 	skb = entry->skb;
 
-	switch (entry->state.pf) {
+	switch (__builtin_expect(entry->state.pf, NFPROTO_IPV4)) {
 	case NFPROTO_IPV4:
 		skb->protocol = htons(ETH_P_IP);
 		break;
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 30a5df27116e..ae7ddba3232b 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -909,7 +909,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 
 		ip_do_fragment(net, skb->sk, skb, ovs_vport_output);
 		refdst_drop(orig_dst);
-	} else if (key->eth.type == htons(ETH_P_IPV6)) {
+	} else if (unlikely(key->eth.type == htons(ETH_P_IPV6))) {
 		const struct nf_ipv6_ops *v6ops = nf_get_ipv6_ops();
 		unsigned long orig_dst;
 		struct rt6_info ovs_rt;
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index c5904f629091..aeebcb46af8e 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -82,7 +82,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info);
 
 static u16 key_to_nfproto(const struct sw_flow_key *key)
 {
-	switch (ntohs(key->eth.type)) {
+	switch (__builtin_expect(ntohs(key->eth.type), ETH_P_IP)) {
 	case ETH_P_IP:
 		return NFPROTO_IPV4;
 	case ETH_P_IPV6:
@@ -188,7 +188,7 @@ static void __ovs_ct_update_key(struct sw_flow_key *key, u8 state,
 			key->ipv4.ct_orig.dst = orig->dst.u3.ip;
 			__ovs_ct_update_key_orig_tp(key, orig, IPPROTO_ICMP);
 			return;
-		} else if (key->eth.type == htons(ETH_P_IPV6) &&
+		} else if (unlikely(key->eth.type == htons(ETH_P_IPV6)) &&
 			   !sw_flow_key_is_nd(key) &&
 			   nf_ct_l3num(ct) == NFPROTO_IPV6) {
 			key->ipv6.ct_orig.src = orig->src.u3.in6;
@@ -289,7 +289,7 @@ int ovs_ct_put_key(const struct sw_flow_key *swkey,
 			if (nla_put(skb, OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV4,
 				    sizeof(orig), &orig))
 				return -EMSGSIZE;
-		} else if (swkey->eth.type == htons(ETH_P_IPV6)) {
+		} else if (unlikely(swkey->eth.type == htons(ETH_P_IPV6))) {
 			struct ovs_key_ct_tuple_ipv6 orig = {
 				IN6_ADDR_INITIALIZER(output->ipv6.ct_orig.src),
 				IN6_ADDR_INITIALIZER(output->ipv6.ct_orig.dst),
@@ -484,7 +484,7 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
 
 		ovs_cb.mru = IPCB(skb)->frag_max_size;
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
-	} else if (key->eth.type == htons(ETH_P_IPV6)) {
+	} else if (unlikely(key->eth.type == htons(ETH_P_IPV6))) {
 		enum ip6_defrag_users user = IP6_DEFRAG_CONNTRACK_IN + zone;
 
 		memset(IP6CB(skb), 0, sizeof(struct inet6_skb_parm));
@@ -735,7 +735,7 @@ static int ovs_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
 				err = NF_DROP;
 			goto push;
 		} else if (IS_ENABLED(CONFIG_NF_NAT_IPV6) &&
-			   skb->protocol == htons(ETH_P_IPV6)) {
+			   unlikely(skb->protocol == htons(ETH_P_IPV6))) {
 			__be16 frag_off;
 			u8 nexthdr = ipv6_hdr(skb)->nexthdr;
 			int hdrlen = ipv6_skip_exthdr(skb,
@@ -797,7 +797,7 @@ static void ovs_nat_update_key(struct sw_flow_key *key,
 		key->ct_state |= OVS_CS_F_SRC_NAT;
 		if (key->eth.type == htons(ETH_P_IP))
 			key->ipv4.addr.src = ip_hdr(skb)->saddr;
-		else if (key->eth.type == htons(ETH_P_IPV6))
+		else if (unlikely(key->eth.type == htons(ETH_P_IPV6)))
 			memcpy(&key->ipv6.addr.src, &ipv6_hdr(skb)->saddr,
 			       sizeof(key->ipv6.addr.src));
 		else
@@ -819,7 +819,7 @@ static void ovs_nat_update_key(struct sw_flow_key *key,
 		key->ct_state |= OVS_CS_F_DST_NAT;
 		if (key->eth.type == htons(ETH_P_IP))
 			key->ipv4.addr.dst = ip_hdr(skb)->daddr;
-		else if (key->eth.type == htons(ETH_P_IPV6))
+		else if (unlikely(key->eth.type == htons(ETH_P_IPV6)))
 			memcpy(&key->ipv6.addr.dst, &ipv6_hdr(skb)->daddr,
 			       sizeof(key->ipv6.addr.dst));
 		else
@@ -1109,7 +1109,7 @@ static int ovs_skb_network_trim(struct sk_buff *skb)
 	unsigned int len;
 	int err;
 
-	switch (skb->protocol) {
+	switch (__builtin_expect(skb->protocol, ETH_P_IP)) {
 	case htons(ETH_P_IP):
 		len = ntohs(ip_hdr(skb)->tot_len);
 		break;
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 56b8e7167790..f959364c29e8 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -735,7 +735,7 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 
 			stack_len += MPLS_HLEN;
 		}
-	} else if (key->eth.type == htons(ETH_P_IPV6)) {
+	} else if (unlikely(key->eth.type == htons(ETH_P_IPV6))) {
 		int nh_len;             /* IPv6 Header + Extensions */
 
 		nh_len = parse_ipv6hdr(skb, key);
@@ -910,7 +910,7 @@ int ovs_flow_key_extract_userspace(struct net *net, const struct nlattr *attr,
 	    key->eth.type != htons(ETH_P_IP))
 		return -EINVAL;
 	if (attrs & (1 << OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV6) &&
-	    (key->eth.type != htons(ETH_P_IPV6) ||
+	    (likely(key->eth.type != htons(ETH_P_IPV6)) ||
 	     sw_flow_key_is_nd(key)))
 		return -EINVAL;
 
diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index c670dd24b8b7..63d280c42f10 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -165,7 +165,7 @@ struct sw_flow_key {
 
 static inline bool sw_flow_key_is_nd(const struct sw_flow_key *key)
 {
-	return key->eth.type == htons(ETH_P_IPV6) &&
+	return unlikely(key->eth.type == htons(ETH_P_IPV6)) &&
 		key->ip.proto == NEXTHDR_ICMP &&
 		key->tp.dst == 0 &&
 		(key->tp.src == htons(NDISC_NEIGHBOUR_SOLICITATION) ||
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 7322aa1e382e..33ba451efbf6 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -238,7 +238,7 @@ static bool match_validate(const struct sw_flow_match *match,
 		}
 	}
 
-	if (match->key->eth.type == htons(ETH_P_IPV6)) {
+	if (unlikely(match->key->eth.type == htons(ETH_P_IPV6))) {
 		key_expected |= 1 << OVS_KEY_ATTR_IPV6;
 		if (match->mask && match->mask->key.eth.type == htons(0xffff)) {
 			mask_allowed |= 1 << OVS_KEY_ATTR_IPV6;
@@ -2070,7 +2070,7 @@ static int __ovs_nla_put_key(const struct sw_flow_key *swkey,
 		ipv4_key->ipv4_tos = output->ip.tos;
 		ipv4_key->ipv4_ttl = output->ip.ttl;
 		ipv4_key->ipv4_frag = output->ip.frag;
-	} else if (swkey->eth.type == htons(ETH_P_IPV6)) {
+	} else if (unlikely(swkey->eth.type == htons(ETH_P_IPV6))) {
 		struct ovs_key_ipv6 *ipv6_key;
 
 		nla = nla_reserve(skb, OVS_KEY_ATTR_IPV6, sizeof(*ipv6_key));
@@ -2114,7 +2114,7 @@ static int __ovs_nla_put_key(const struct sw_flow_key *swkey,
 	}
 
 	if ((swkey->eth.type == htons(ETH_P_IP) ||
-	     swkey->eth.type == htons(ETH_P_IPV6)) &&
+	     unlikely(swkey->eth.type == htons(ETH_P_IPV6))) &&
 	     swkey->ip.frag != OVS_FRAG_TYPE_LATER) {
 
 		if (swkey->ip.proto == IPPROTO_TCP) {
@@ -2157,7 +2157,7 @@ static int __ovs_nla_put_key(const struct sw_flow_key *swkey,
 			icmp_key = nla_data(nla);
 			icmp_key->icmp_type = ntohs(output->tp.src);
 			icmp_key->icmp_code = ntohs(output->tp.dst);
-		} else if (swkey->eth.type == htons(ETH_P_IPV6) &&
+		} else if (unlikely(swkey->eth.type == htons(ETH_P_IPV6)) &&
 			   swkey->ip.proto == IPPROTO_ICMPV6) {
 			struct ovs_key_icmpv6 *icmpv6_key;
 
@@ -2682,7 +2682,7 @@ static int validate_set(const struct nlattr *a,
 		break;
 
 	case OVS_KEY_ATTR_IPV6:
-		if (eth_type != htons(ETH_P_IPV6))
+		if (likely(eth_type != htons(ETH_P_IPV6)))
 			return -EINVAL;
 
 		ipv6_key = nla_data(ovs_key);
@@ -2711,7 +2711,7 @@ static int validate_set(const struct nlattr *a,
 
 	case OVS_KEY_ATTR_TCP:
 		if ((eth_type != htons(ETH_P_IP) &&
-		     eth_type != htons(ETH_P_IPV6)) ||
+		     likely(eth_type != htons(ETH_P_IPV6))) ||
 		    flow_key->ip.proto != IPPROTO_TCP)
 			return -EINVAL;
 
@@ -2719,7 +2719,7 @@ static int validate_set(const struct nlattr *a,
 
 	case OVS_KEY_ATTR_UDP:
 		if ((eth_type != htons(ETH_P_IP) &&
-		     eth_type != htons(ETH_P_IPV6)) ||
+		     likely(eth_type != htons(ETH_P_IPV6))) ||
 		    flow_key->ip.proto != IPPROTO_UDP)
 			return -EINVAL;
 
@@ -2732,7 +2732,7 @@ static int validate_set(const struct nlattr *a,
 
 	case OVS_KEY_ATTR_SCTP:
 		if ((eth_type != htons(ETH_P_IP) &&
-		     eth_type != htons(ETH_P_IPV6)) ||
+		     likely(eth_type != htons(ETH_P_IPV6))) ||
 		    flow_key->ip.proto != IPPROTO_SCTP)
 			return -EINVAL;
 
@@ -2924,7 +2924,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			 */
 			if (vlan_tci & htons(VLAN_TAG_PRESENT) ||
 			    (eth_type != htons(ETH_P_IP) &&
-			     eth_type != htons(ETH_P_IPV6) &&
+			     likely(eth_type != htons(ETH_P_IPV6)) &&
 			     eth_type != htons(ETH_P_ARP) &&
 			     eth_type != htons(ETH_P_RARP) &&
 			     !eth_p_mpls(eth_type)))
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 89b178a78dc7..870cd06adbef 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -279,7 +279,7 @@ void xfrm_local_error(struct sk_buff *skb, int mtu)
 
 	if (skb->protocol == htons(ETH_P_IP))
 		proto = AF_INET;
-	else if (skb->protocol == htons(ETH_P_IPV6))
+	else if (unlikely(skb->protocol == htons(ETH_P_IPV6)))
 		proto = AF_INET6;
 	else
 		return;
-- 
2.14.3
