Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314952075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wekQE4i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314952075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbeGQMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbeGQMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:07 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FE820C0E;
        Tue, 17 Jul 2018 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829206;
        bh=quC4BD0vv+6pvGDdPgGDjibkpobxwUjAlxe5wOTdAf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wekQE4i7lLgFy0HJK6lOzZfYh4KSgZIDLeCT5yg+2xj/SrO3Wktid+Ymr+JQyZDlV
         LvS7X0VLDL/Ql06mME5LGj0Qu+hYAz1+2EghshCamcim1lYZEV+Cx84KlLKwGShGEM
         VuZs0tUdzo4BOujk7Fp0eVzciGcrwfL/o/6yis/Y=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 04/17] net/ipv4: Remove open coded use of arp table
Date:   Tue, 17 Jul 2018 05:06:38 -0700
Message-Id: <20180717120651.15748-5-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Convert existing uses for arp_tbl to the helpers introduced in the previous
patch.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 net/bridge/br_arp_nd_proxy.c |  2 +-
 net/ipv4/arp.c               | 36 ++++++++++++++++++++----------------
 net/ipv4/devinet.c           |  8 ++++----
 net/ipv4/fib_semantics.c     |  2 +-
 net/ipv4/ip_output.c         |  2 +-
 net/ipv4/route.c             |  4 ++--
 6 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 2cf7716254be..29a1e25fc169 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -183,7 +183,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(&arp_tbl, &tip, vlandev);
+	n = ipv4_neigh_lookup(vlandev, &tip);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index e90c89ef8c08..fd4a380da9bb 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -678,6 +678,7 @@ static bool arp_is_garp(struct net *net, struct net_device *dev,
 
 static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	struct neigh_table *tbl = ipv4_neigh_table(net);
 	struct net_device *dev = skb->dev;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct arphdr *arp;
@@ -827,7 +828,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			if (!dont_send && IN_DEV_ARPFILTER(in_dev))
 				dont_send = arp_filter(sip, tip, dev);
 			if (!dont_send) {
-				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
+				n = neigh_event_ns(tbl, sha, &sip, dev);
 				if (n) {
 					arp_send_dst(ARPOP_REPLY, ETH_P_ARP,
 						     sip, dev, tip, sha,
@@ -842,8 +843,8 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			    (arp_fwd_proxy(in_dev, dev, rt) ||
 			     arp_fwd_pvlan(in_dev, dev, rt, sip, tip) ||
 			     (rt->dst.dev != dev &&
-			      pneigh_lookup(&arp_tbl, net, &tip, dev, 0)))) {
-				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
+			      pneigh_lookup(tbl, net, &tip, dev, 0)))) {
+				n = neigh_event_ns(tbl, sha, &sip, dev);
 				if (n)
 					neigh_release(n);
 
@@ -855,7 +856,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 						     dev->dev_addr, sha,
 						     reply_dst);
 				} else {
-					pneigh_enqueue(&arp_tbl,
+					pneigh_enqueue(tbl,
 						       in_dev->arp_parms, skb);
 					goto out_free_dst;
 				}
@@ -866,7 +867,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	/* Update our ARP tables */
 
-	n = __neigh_lookup(&arp_tbl, &sip, dev, 0);
+	n = __neigh_lookup(tbl, &sip, dev, 0);
 
 	addr_type = -1;
 	if (n || IN_DEV_ARP_ACCEPT(in_dev)) {
@@ -887,7 +888,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			/* postpone calculation to as late as possible */
 			inet_addr_type_dev_table(net, dev, sip) ==
 				RTN_UNICAST)))))
-			n = __neigh_lookup(&arp_tbl, &sip, dev, 1);
+			n = __neigh_lookup(tbl, &sip, dev, 1);
 	}
 
 	if (n) {
@@ -1011,7 +1012,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 			return -ENODEV;
 	}
 	if (mask) {
-		if (!pneigh_lookup(&arp_tbl, net, &ip, dev, 1))
+		if (!pneigh_lookup(ipv4_neigh_table(net), net, &ip, dev, 1))
 			return -ENOBUFS;
 		return 0;
 	}
@@ -1063,7 +1064,7 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 		break;
 	}
 
-	neigh = __neigh_lookup_errno(&arp_tbl, &ip, dev);
+	neigh = __neigh_lookup_errno(ipv4_neigh_table(net), &ip, dev);
 	err = PTR_ERR(neigh);
 	if (!IS_ERR(neigh)) {
 		unsigned int state = NUD_STALE;
@@ -1098,7 +1099,7 @@ static int arp_req_get(struct arpreq *r, struct net_device *dev)
 	struct neighbour *neigh;
 	int err = -ENXIO;
 
-	neigh = neigh_lookup(&arp_tbl, &ip, dev);
+	neigh = ipv4_neigh_lookup(dev, &ip);
 	if (neigh) {
 		if (!(neigh->nud_state & NUD_NOARP)) {
 			read_lock_bh(&neigh->lock);
@@ -1116,9 +1117,9 @@ static int arp_req_get(struct arpreq *r, struct net_device *dev)
 
 static int arp_invalidate(struct net_device *dev, __be32 ip)
 {
-	struct neighbour *neigh = neigh_lookup(&arp_tbl, &ip, dev);
+	struct neigh_table *tbl = ipv4_neigh_table(dev_net(dev));
+	struct neighbour *neigh = neigh_lookup(tbl, &ip, dev);
 	int err = -ENXIO;
-	struct neigh_table *tbl = &arp_tbl;
 
 	if (neigh) {
 		if (neigh->nud_state & ~NUD_NOARP)
@@ -1141,7 +1142,7 @@ static int arp_req_delete_public(struct net *net, struct arpreq *r,
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
 	if (mask == htonl(0xFFFFFFFF))
-		return pneigh_delete(&arp_tbl, net, &ip, dev);
+		return pneigh_delete(ipv4_neigh_table(net), net, &ip, dev);
 
 	if (mask)
 		return -EINVAL;
@@ -1248,13 +1249,13 @@ static int arp_netdev_event(struct notifier_block *this, unsigned long event,
 
 	switch (event) {
 	case NETDEV_CHANGEADDR:
-		neigh_changeaddr(&arp_tbl, dev);
+		neigh_changeaddr(ipv4_neigh_table(dev_net(dev)), dev);
 		rt_cache_flush(dev_net(dev));
 		break;
 	case NETDEV_CHANGE:
 		change_info = ptr;
 		if (change_info->flags_changed & IFF_NOARP)
-			neigh_changeaddr(&arp_tbl, dev);
+			neigh_changeaddr(ipv4_neigh_table(dev_net(dev)), dev);
 		break;
 	default:
 		break;
@@ -1273,7 +1274,7 @@ static struct notifier_block arp_netdev_notifier = {
  */
 void arp_ifdown(struct net_device *dev)
 {
-	neigh_ifdown(&arp_tbl, dev);
+	neigh_ifdown(ipv4_neigh_table(dev_net(dev)), dev);
 }
 
 
@@ -1403,10 +1404,13 @@ static int arp_seq_show(struct seq_file *seq, void *v)
 
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
+	struct net *net = seq_file_net(seq);
+
 	/* Don't want to confuse "arp -a" w/ magic entries,
 	 * so we tell the generic iterator to skip NUD_NOARP.
 	 */
-	return neigh_seq_start(seq, pos, &arp_tbl, NEIGH_SEQ_SKIP_NOARP);
+	return neigh_seq_start(seq, pos, ipv4_neigh_table(net),
+			       NEIGH_SEQ_SKIP_NOARP);
 }
 
 /* ------------------------------------------------------------------------ */
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index d7585ab1a77a..07a57fd1a343 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -239,6 +239,7 @@ EXPORT_SYMBOL(in_dev_finish_destroy);
 
 static struct in_device *inetdev_init(struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
 	struct in_device *in_dev;
 	int err = -ENOMEM;
 
@@ -247,11 +248,10 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	in_dev = kzalloc(sizeof(*in_dev), GFP_KERNEL);
 	if (!in_dev)
 		goto out;
-	memcpy(&in_dev->cnf, dev_net(dev)->ipv4.devconf_dflt,
-			sizeof(in_dev->cnf));
+	memcpy(&in_dev->cnf, net->ipv4.devconf_dflt, sizeof(in_dev->cnf));
 	in_dev->cnf.sysctl = NULL;
 	in_dev->dev = dev;
-	in_dev->arp_parms = neigh_parms_alloc(dev, &arp_tbl);
+	in_dev->arp_parms = neigh_parms_alloc(dev, ipv4_neigh_table(net));
 	if (!in_dev->arp_parms)
 		goto out_kfree;
 	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
@@ -309,7 +309,7 @@ static void inetdev_destroy(struct in_device *in_dev)
 	RCU_INIT_POINTER(dev->ip_ptr, NULL);
 
 	devinet_sysctl_unregister(in_dev);
-	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+	neigh_parms_release(ipv4_neigh_table(dev_net(dev)), in_dev->arp_parms);
 	arp_ifdown(dev);
 
 	call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f3c89ccf14c5..d91cf61e044e 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -440,7 +440,7 @@ static int fib_detect_death(struct fib_info *fi, int order,
 	struct neighbour *n;
 	int state = NUD_NONE;
 
-	n = neigh_lookup(&arp_tbl, &fi->fib_nh[0].nh_gw, fi->fib_dev);
+	n = ipv4_neigh_lookup(fi->fib_dev, &fi->fib_nh[0].nh_gw);
 	if (n) {
 		state = n->nud_state;
 		neigh_release(n);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e2b6bd478afb..0e880d4b859e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -221,7 +221,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	nexthop = (__force u32) rt_nexthop(rt, ip_hdr(skb)->daddr);
 	neigh = __ipv4_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(&arp_tbl, &nexthop, dev, false);
+		neigh = ipv4_neigh_create_noref(dev, &nexthop);
 	if (!IS_ERR(neigh)) {
 		int res;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 74e1df60ab7f..56dfa77c19ab 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -448,7 +448,7 @@ static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
 	n = __ipv4_neigh_lookup(dev, *(__force u32 *)pkey);
 	if (n)
 		return n;
-	return neigh_create(&arp_tbl, pkey, dev);
+	return ipv4_neigh_create(dev, pkey);
 }
 
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
@@ -770,7 +770,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 
 	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
 	if (!n)
-		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
+		n = ipv4_neigh_create(rt->dst.dev, &new_gw);
 	if (!IS_ERR(n)) {
 		if (!(n->nud_state & NUD_VALID)) {
 			neigh_event_send(n, NULL);
-- 
2.11.0

