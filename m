Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBBC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D77520659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D77520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIEAUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:20:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39064 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeIEAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so5470246wmq.4;
        Tue, 04 Sep 2018 12:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vy8ns9zvpX2813wmWUJaZ2rxc1pOliIdpVZ5hi3E5Yo=;
        b=tAw7y8IKtYXlS2MFIQR163xWJWzEtLVmvphzpunAueIKWhj/bIenAb9n1ZdSWcX/kz
         nbVNhE/rHMP9jCRUJX003U8CqPnJU4+t0l6TYPNGgSuNJIgKnjEs2uA/q2IGnzR84Szr
         AneMoj/lyG9Eqc9aIdgziB53SFUtJL2cKt/9ZKipcmRI/JCh7ou7nRwnEdFoXBVnOGgF
         4xYVJZKpY2QZtk0Ae96QdX0qHPRYyB5UMDvm2vAgDQQwzNsds4bkb3lJsnxH7eB3MROy
         uoHV+cPjmNAm84RoCYgT0mrjSw81Mb04UcCvX9jZOXzv0AC8PWA1vqlQW8ABMV5K8K4z
         T4bg==
X-Gm-Message-State: APzg51BC9a4WrUMaRJWcInetSxtDD5WsWmby1dI2ZiLxDNrw21sthuh9
        bbaskGryYdB8jF5UjgMnRtQZvuUhe20u2A==
X-Google-Smtp-Source: ANB0VdarhcxJ2fSHR2XFaY48VA1olLeFnjbKfWTjh2jVPifCsp4lz8odH5qQvUtT9NjhtqI7qkndnQ==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr9351605wmi.28.1536090854164;
        Tue, 04 Sep 2018 12:54:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:13 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 4/9] ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR
Date:   Tue,  4 Sep 2018 21:53:50 +0200
Message-Id: <20180904195355.4695-5-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Backwards Compatibility:
  If userspace wants to determine whether ipv6 RTM_GETADDR requests
  support the new IFA_TARGET_NETNSID property it should verify that the
  reply includes the IFA_TARGET_NETNSID property. If it does not
  userspace should assume that IFA_TARGET_NETNSID is not supported for
  ipv6 RTM_GETADDR requests on this kernel.
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
v1->v2:
- rename from IFA_IF_NETNSID to IFA_TARGET_NETNSID

v0->v1:
- unchanged
---
 net/ipv6/addrconf.c | 73 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d51a8c0b3372..ebfeb64ac67b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4491,6 +4491,7 @@ static const struct nla_policy ifa_ipv6_policy[IFA_MAX+1] = {
 	[IFA_CACHEINFO]		= { .len = sizeof(struct ifa_cacheinfo) },
 	[IFA_FLAGS]		= { .len = sizeof(u32) },
 	[IFA_RT_PRIORITY]	= { .len = sizeof(u32) },
+	[IFA_TARGET_NETNSID]	= { .type = NLA_S32 },
 };
 
 static int
@@ -4794,7 +4795,8 @@ static inline int inet6_ifaddr_msgsize(void)
 }
 
 static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
-			     u32 portid, u32 seq, int event, unsigned int flags)
+			     u32 portid, u32 seq, int event, unsigned int flags,
+			     int netnsid)
 {
 	struct nlmsghdr  *nlh;
 	u32 preferred, valid;
@@ -4806,6 +4808,9 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 	put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->scope),
 		      ifa->idev->dev->ifindex);
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+		goto error;
+
 	if (!((ifa->flags&IFA_F_PERMANENT) &&
 	      (ifa->prefered_lft == INFINITY_LIFE_TIME))) {
 		preferred = ifa->prefered_lft;
@@ -4855,7 +4860,8 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 }
 
 static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
-				u32 portid, u32 seq, int event, u16 flags)
+			       u32 portid, u32 seq, int event, u16 flags,
+			       int netnsid)
 {
 	struct nlmsghdr  *nlh;
 	u8 scope = RT_SCOPE_UNIVERSE;
@@ -4868,6 +4874,9 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 	if (!nlh)
 		return -EMSGSIZE;
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+		return -EMSGSIZE;
+
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_MULTICAST, &ifmca->mca_addr) < 0 ||
 	    put_cacheinfo(skb, ifmca->mca_cstamp, ifmca->mca_tstamp,
@@ -4881,7 +4890,8 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 }
 
 static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
-				u32 portid, u32 seq, int event, unsigned int flags)
+			       u32 portid, u32 seq, int event,
+			       unsigned int flags, int netnsid)
 {
 	struct net_device *dev = fib6_info_nh_dev(ifaca->aca_rt);
 	int ifindex = dev ? dev->ifindex : 1;
@@ -4895,6 +4905,9 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
 	if (!nlh)
 		return -EMSGSIZE;
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+		return -EMSGSIZE;
+
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_ANYCAST, &ifaca->aca_addr) < 0 ||
 	    put_cacheinfo(skb, ifaca->aca_cstamp, ifaca->aca_tstamp,
@@ -4916,7 +4929,7 @@ enum addr_type_t {
 /* called with rcu_read_lock() */
 static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 			  struct netlink_callback *cb, enum addr_type_t type,
-			  int s_ip_idx, int *p_ip_idx)
+			  int s_ip_idx, int *p_ip_idx, int netnsid)
 {
 	struct ifmcaddr6 *ifmca;
 	struct ifacaddr6 *ifaca;
@@ -4936,7 +4949,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
 						RTM_NEWADDR,
-						NLM_F_MULTI);
+						NLM_F_MULTI, netnsid);
 			if (err < 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
@@ -4953,7 +4966,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 						  NETLINK_CB(cb->skb).portid,
 						  cb->nlh->nlmsg_seq,
 						  RTM_GETMULTICAST,
-						  NLM_F_MULTI);
+						  NLM_F_MULTI, netnsid);
 			if (err < 0)
 				break;
 		}
@@ -4968,7 +4981,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 						  NETLINK_CB(cb->skb).portid,
 						  cb->nlh->nlmsg_seq,
 						  RTM_GETANYCAST,
-						  NLM_F_MULTI);
+						  NLM_F_MULTI, netnsid);
 			if (err < 0)
 				break;
 		}
@@ -4985,6 +4998,9 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 			   enum addr_type_t type)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[IFA_MAX+1];
+	struct net *tgt_net = net;
+	int netnsid = -1;
 	int h, s_h;
 	int idx, ip_idx;
 	int s_idx, s_ip_idx;
@@ -4996,11 +5012,22 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	s_idx = idx = cb->args[1];
 	s_ip_idx = ip_idx = cb->args[2];
 
+	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
+			ifa_ipv6_policy, NULL) >= 0) {
+		if (tb[IFA_TARGET_NETNSID]) {
+			netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
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
@@ -5012,7 +5039,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 				goto cont;
 
 			if (in6_dump_addrs(idev, skb, cb, type,
-					   s_ip_idx, &ip_idx) < 0)
+					   s_ip_idx, &ip_idx, netnsid) < 0)
 				goto done;
 cont:
 			idx++;
@@ -5023,6 +5050,8 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	cb->args[0] = h;
 	cb->args[1] = idx;
 	cb->args[2] = ip_idx;
+	if (netnsid >= 0)
+		put_net(tgt_net);
 
 	return skb->len;
 }
@@ -5053,12 +5082,14 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
@@ -5066,15 +5097,24 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	if (tb[IFA_TARGET_NETNSID]) {
+		netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
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
@@ -5087,19 +5127,22 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
 	if (dev)
 		dev_put(dev);
+	if (netnsid >= 0)
+		put_net(tgt_net);
+
 	return err;
 }
 
@@ -5113,7 +5156,7 @@ static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
 	if (!skb)
 		goto errout;
 
-	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0);
+	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0, -1);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
 		WARN_ON(err == -EMSGSIZE);
-- 
2.17.1

