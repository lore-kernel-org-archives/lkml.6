Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A622087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A622087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeH2DNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:13:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeH2DNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:13:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so1356045pff.6;
        Tue, 28 Aug 2018 16:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=affSbdIadKCqMraFz1PBio19p0NXAUbnhA5cEWtnD7s=;
        b=ougFqwC7X6jooQeXEPnGIZ6K/Jd43Zwu6AhDndIHzZn1mKJ0f5qooRRZHFFWN40HXC
         99XdI6JYl8VImugi6oNNIX3V8cJSuFTkmoSH6kc/ehsjR6LnFbFSUjmWPphsafNgrvlq
         iQ1qcOUClkbgSH+0Gam9m/tmSPDbUwJ+1OV+sH18L4CfIA2ICX11ZtOw3f65JylQvzV9
         TYWGACiXkMRJ65IZZvN04OvdFBr6EHump2hjJWXDm7u3R9iULRdvB8Iso/bB4Du0ajnB
         1tGqhJt0ZF2ZcGDMSPZu1oH+FTn19AdkXD19SG53H2XjTDqUcH2ljbCYWMBuo3brpP2c
         QYtw==
X-Gm-Message-State: APzg51AhwgyoZ8P5oghddcIXJnChPWprDPR6tNu4exEWa5M94ZADTgni
        j/L9dAJFD6jgSaVIuKujXdoz1olt9yIqqQ==
X-Google-Smtp-Source: ANB0VdYh36pnNA4ra2jKZaKZYTldwGptDu/Swm03S4GvPDymKwrM72l0j7g+58lw37C8/l9MqFqsGw==
X-Received: by 2002:a63:fa0c:: with SMTP id y12-v6mr1197235pgh.177.1535498392717;
        Tue, 28 Aug 2018 16:19:52 -0700 (PDT)
Received: from localhost.localdomain ([72.28.92.217])
        by smtp.gmail.com with ESMTPSA id q6-v6sm4217354pgq.19.2018.08.28.16.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:19:52 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 4/5] ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
Date:   Wed, 29 Aug 2018 01:18:58 +0200
Message-Id: <20180828231859.29758-5-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828231859.29758-1-christian@brauner.io>
References: <20180828231859.29758-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Backwards Compatibility:
  If userspace wants to determine whether ipv6 RTM_GETADDR requests support
  the new IFA_IF_NETNSID property they should verify that the reply after
  sending a request includes the IFA_IF_NETNSID property. If it does not
  userspace should assume that IFA_IF_NETNSID is not supported for ipv6
  RTM_GETADDR requests on this kernel.
- From what I gather from current userspace tools that make use of
  RTM_GETADDR requests some of them pass down struct ifinfomsg when they
  should actually pass down struct ifaddrmsg. To not break existing
  tools that pass down the wrong struct we will do the same as for
  RTM_GETLINK | NLM_F_DUMP requests and not error out when the
  nlmsg_parse() fails.

- Security:
  Callers must have CAP_NET_ADMIN in the owning user namespace of the
  target network namespace.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 net/ipv6/addrconf.c | 70 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f66a1cae3366..f48f3479b341 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4493,6 +4493,7 @@ static const struct nla_policy ifa_ipv6_policy[IFA_MAX+1] = {
 	[IFA_CACHEINFO]		= { .len = sizeof(struct ifa_cacheinfo) },
 	[IFA_FLAGS]		= { .len = sizeof(u32) },
 	[IFA_RT_PRIORITY]	= { .len = sizeof(u32) },
+	[IFA_IF_NETNSID]	= { .type = NLA_S32 },
 };
 
 static int
@@ -4796,7 +4797,8 @@ static inline int inet6_ifaddr_msgsize(void)
 }
 
 static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
-			     u32 portid, u32 seq, int event, unsigned int flags)
+			     u32 portid, u32 seq, int event, unsigned int flags,
+			     int netnsid)
 {
 	struct nlmsghdr  *nlh;
 	u32 preferred, valid;
@@ -4808,6 +4810,9 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 	put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->scope),
 		      ifa->idev->dev->ifindex);
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
+		goto error;
+
 	if (!((ifa->flags&IFA_F_PERMANENT) &&
 	      (ifa->prefered_lft == INFINITY_LIFE_TIME))) {
 		preferred = ifa->prefered_lft;
@@ -4857,7 +4862,8 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 }
 
 static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
-				u32 portid, u32 seq, int event, u16 flags)
+			       u32 portid, u32 seq, int event, u16 flags,
+			       int netnsid)
 {
 	struct nlmsghdr  *nlh;
 	u8 scope = RT_SCOPE_UNIVERSE;
@@ -4870,6 +4876,9 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 	if (!nlh)
 		return -EMSGSIZE;
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
+		return -EMSGSIZE;
+
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_MULTICAST, &ifmca->mca_addr) < 0 ||
 	    put_cacheinfo(skb, ifmca->mca_cstamp, ifmca->mca_tstamp,
@@ -4883,7 +4892,8 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 }
 
 static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
-				u32 portid, u32 seq, int event, unsigned int flags)
+			       u32 portid, u32 seq, int event,
+			       unsigned int flags, int netnsid)
 {
 	struct net_device *dev = fib6_info_nh_dev(ifaca->aca_rt);
 	int ifindex = dev ? dev->ifindex : 1;
@@ -4897,6 +4907,9 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
 	if (!nlh)
 		return -EMSGSIZE;
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
+		return -EMSGSIZE;
+
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_ANYCAST, &ifaca->aca_addr) < 0 ||
 	    put_cacheinfo(skb, ifaca->aca_cstamp, ifaca->aca_tstamp,
@@ -4918,7 +4931,7 @@ enum addr_type_t {
 /* called with rcu_read_lock() */
 static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 			  struct netlink_callback *cb, enum addr_type_t type,
-			  int s_ip_idx, int *p_ip_idx)
+			  int s_ip_idx, int *p_ip_idx, int netnsid)
 {
 	struct ifmcaddr6 *ifmca;
 	struct ifacaddr6 *ifaca;
@@ -4938,7 +4951,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
 						RTM_NEWADDR,
-						NLM_F_MULTI);
+						NLM_F_MULTI, netnsid);
 			if (err < 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
@@ -4955,7 +4968,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 						  NETLINK_CB(cb->skb).portid,
 						  cb->nlh->nlmsg_seq,
 						  RTM_GETMULTICAST,
-						  NLM_F_MULTI);
+						  NLM_F_MULTI, netnsid);
 			if (err < 0)
 				break;
 		}
@@ -4970,7 +4983,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 						  NETLINK_CB(cb->skb).portid,
 						  cb->nlh->nlmsg_seq,
 						  RTM_GETANYCAST,
-						  NLM_F_MULTI);
+						  NLM_F_MULTI, netnsid);
 			if (err < 0)
 				break;
 		}
@@ -4987,6 +5000,9 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 			   enum addr_type_t type)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[IFA_MAX+1];
+	struct net *tgt_net = net;
+	int netnsid = -1;
 	int h, s_h;
 	int idx, ip_idx;
 	int s_idx, s_ip_idx;
@@ -4998,11 +5014,22 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	s_idx = idx = cb->args[1];
 	s_ip_idx = ip_idx = cb->args[2];
 
+	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
+			ifa_ipv6_policy, NULL) >= 0) {
+		if (tb[IFA_IF_NETNSID]) {
+			netnsid = nla_get_s32(tb[IFA_IF_NETNSID]);
+
+			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
+			if (IS_ERR(tgt_net))
+				return PTR_ERR(tgt_net);
+		}
+	}
+
 	rcu_read_lock();
-	cb->seq = atomic_read(&net->ipv6.dev_addr_genid) ^ net->dev_base_seq;
+	cb->seq = atomic_read(&tgt_net->ipv6.dev_addr_genid) ^ tgt_net->dev_base_seq;
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
-		head = &net->dev_index_head[h];
+		head = &tgt_net->dev_index_head[h];
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -5014,7 +5041,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 				goto cont;
 
 			if (in6_dump_addrs(idev, skb, cb, type,
-					   s_ip_idx, &ip_idx) < 0)
+					   s_ip_idx, &ip_idx, netnsid) < 0)
 				goto done;
 cont:
 			idx++;
@@ -5025,6 +5052,8 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	cb->args[0] = h;
 	cb->args[1] = idx;
 	cb->args[2] = ip_idx;
+	if (netnsid >= 0)
+		put_net(tgt_net);
 
 	return skb->len;
 }
@@ -5055,12 +5084,14 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	struct net *tgt_net = net;
 	struct ifaddrmsg *ifm;
 	struct nlattr *tb[IFA_MAX+1];
 	struct in6_addr *addr = NULL, *peer;
 	struct net_device *dev = NULL;
 	struct inet6_ifaddr *ifa;
 	struct sk_buff *skb;
+	int netnsid = -1;
 	int err;
 
 	err = nlmsg_parse(nlh, sizeof(*ifm), tb, IFA_MAX, ifa_ipv6_policy,
@@ -5068,15 +5099,24 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	if (tb[IFA_IF_NETNSID]) {
+		netnsid = nla_get_s32(tb[IFA_IF_NETNSID]);
+
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(in_skb).sk,
+						  netnsid);
+		if (IS_ERR(tgt_net))
+			return PTR_ERR(tgt_net);
+	}
+
 	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
 	if (!addr)
 		return -EINVAL;
 
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_index)
-		dev = dev_get_by_index(net, ifm->ifa_index);
+		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
 
-	ifa = ipv6_get_ifaddr(net, addr, dev, 1);
+	ifa = ipv6_get_ifaddr(tgt_net, addr, dev, 1);
 	if (!ifa) {
 		err = -EADDRNOTAVAIL;
 		goto errout;
@@ -5089,14 +5129,14 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 	err = inet6_fill_ifaddr(skb, ifa, NETLINK_CB(in_skb).portid,
-				nlh->nlmsg_seq, RTM_NEWADDR, 0);
+				nlh->nlmsg_seq, RTM_NEWADDR, 0, netnsid);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout_ifa;
 	}
-	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+	err = rtnl_unicast(skb, tgt_net, NETLINK_CB(in_skb).portid);
 errout_ifa:
 	in6_ifa_put(ifa);
 errout:
@@ -5115,7 +5155,7 @@ static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
 	if (!skb)
 		goto errout;
 
-	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0);
+	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0, -1);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
 		WARN_ON(err == -EMSGSIZE);
-- 
2.17.1

