Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeECOIX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:08:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51756 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:08:20 -0400
X-Google-Smtp-Source: AB8JxZot8BzR/5Ju9+AjZ6b1xAmzk188RRmPGtHPusAHU6DKI5pEZJB0cZ8HDHUWuPMHHeKIaBGEDw==
From: Kristian Evensen <kristian.evensen@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Kristian Evensen <kristian.evensen@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: nf_queue: Replace conntrack entry
Date: Thu,  3 May 2018 16:07:45 +0200
Message-Id: <20180503140745.26588-1-kristian.evensen@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SKBs are assigned a conntrack entry before being passed to any NFQUEUEs,
and if no entry is found then a new one is created. This behavior causes
problems for some traffic patterns. For example, if two UDP packets
to/from the same host (using the same ports) arrive at the "same" time,
both are assigned a new conntrack entry. After the first packet have
traversed all chains, the conntrack entry will be inserted into the
global table. The second packet will then be dropped during the
insertion step, as an entry for the same flow already exists. One type
of application that frequently generates this traffic pattern, is DNS
resolvers.

This commit introduces a new function that checks, and potentially
replaces, the conntrack entry for any additional "new" SKBs mapping to
an existing flow. While not a perfect solution, there are still
situations where to-be-dropped SKBs can slip through, the situations is
improved considerably. On the routers I have used for testing, packets
belonging to the same UDP flow are let through (when generating the
traffic pattern described above). Without the change in this commit, all
packets except the first one was dropped.

With the change in this commit, a user can implement "perfect" solutions
in user-space. An application can for example keep track of seen UDP
flows, and then only release packets belonging to one flow when the
entry has been created. Without the change, and SKB is stuck with the
original conntrack entry.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
---
 net/netfilter/nfnetlink_queue.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index c97966298..150c11ff4 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -43,6 +43,9 @@
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <net/netfilter/nf_conntrack.h>
+#include <net/netfilter/nf_conntrack_core.h>
+#include <net/netfilter/nf_conntrack_l3proto.h>
+#include <net/netfilter/nf_conntrack_l4proto.h>
 #endif
 
 #define NFQNL_QMAX_DEFAULT 1024
@@ -1046,6 +1049,53 @@ static int nfq_id_after(unsigned int id, unsigned int max)
 	return (int)(id - max) > 0;
 }
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+static void nfqnl_update_ct(struct net *net, struct sk_buff *skb)
+{
+	const struct nf_conntrack_l3proto *l3proto;
+	const struct nf_conntrack_l4proto *l4proto;
+	struct nf_conntrack_tuple_hash *h;
+	struct nf_conntrack_tuple tuple;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct = NULL;
+	unsigned int dataoff;
+	u16 l3num;
+	u8 l4num;
+
+	ct = nf_ct_get(skb, &ctinfo);
+	l3num = nf_ct_l3num(ct);
+	l3proto = nf_ct_l3proto_find_get(l3num);
+
+	if (l3proto->get_l4proto(skb, skb_network_offset(skb), &dataoff,
+				 &l4num) <= 0) {
+		return;
+	}
+
+	l4proto = nf_ct_l4proto_find_get(l3num, l4num);
+
+	if (!nf_ct_get_tuple(skb, skb_network_offset(skb), dataoff, l3num,
+			     l4num, net, &tuple, l3proto, l4proto)) {
+		return;
+	}
+
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_ZONES)
+	h = nf_conntrack_find_get(net, &ct->zone, &tuple);
+#else
+	h = nf_conntrack_find_get(net, NULL, &tuple);
+#endif
+
+	if (h) {
+		pr_debug("%s: tuple %u %pI4:%hu -> %pI4:%hu\n", __func__,
+			 tuple.dst.protonum, &tuple.src.u3.ip,
+			 ntohs(tuple.src.u.all), &tuple.dst.u3.ip,
+			 ntohs(tuple.dst.u.all));
+		nf_ct_put(ct);
+		ct = nf_ct_tuplehash_to_ctrack(h);
+		nf_ct_set(skb, ct, IP_CT_NEW);
+	}
+}
+#endif
+
 static int nfqnl_recv_verdict_batch(struct net *net, struct sock *ctnl,
 				    struct sk_buff *skb,
 				    const struct nlmsghdr *nlh,
@@ -1060,6 +1110,7 @@ static int nfqnl_recv_verdict_batch(struct net *net, struct sock *ctnl,
 	LIST_HEAD(batch_list);
 	u16 queue_num = ntohs(nfmsg->res_id);
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
+	enum ip_conntrack_info ctinfo;
 
 	queue = verdict_instance_lookup(q, queue_num,
 					NETLINK_CB(skb).portid);
@@ -1090,6 +1141,16 @@ static int nfqnl_recv_verdict_batch(struct net *net, struct sock *ctnl,
 	list_for_each_entry_safe(entry, tmp, &batch_list, list) {
 		if (nfqa[NFQA_MARK])
 			entry->skb->mark = ntohl(nla_get_be32(nfqa[NFQA_MARK]));
+
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+			nf_ct_get(entry->skb, &ctinfo);
+
+			if (ctinfo == IP_CT_NEW && verdict != NF_STOLEN &&
+			    verdict != NF_DROP) {
+				nfqnl_update_ct(net, entry->skb);
+			}
+#endif
+
 		nf_reinject(entry, verdict);
 	}
 	return 0;
@@ -1213,6 +1274,13 @@ static int nfqnl_recv_verdict(struct net *net, struct sock *ctnl,
 	if (nfqa[NFQA_MARK])
 		entry->skb->mark = ntohl(nla_get_be32(nfqa[NFQA_MARK]));
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	nf_ct_get(entry->skb, &ctinfo);
+
+	if (ctinfo == IP_CT_NEW && verdict != NF_STOLEN && verdict != NF_DROP)
+		nfqnl_update_ct(net, entry->skb);
+#endif
+
 	nf_reinject(entry, verdict);
 	return 0;
 }
-- 
2.14.1
