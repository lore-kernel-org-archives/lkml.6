Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADF32077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADF32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeIEAVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:21:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeIEAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:21:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so5231614wre.2;
        Tue, 04 Sep 2018 12:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HIDSdrnJnj8ycEFp/t25e6cNpRUBoIqUto71gso0lU=;
        b=X0j0CkB98fHoA5bEKUA1LCsc8o1/OnoQI2tJbIi26f8yXhOMtC9enI/gb2Zye9BKac
         8+IoodZly3Ntp54IW5ek/3zKxh378PesCMcKqZuL+IY2phxpzUxOy/tk0JkNk6f9YdbU
         ubr3OMh4UEAmCxZ0Wge639pybBxP9Ww2nWeaVqbcm8xVo0qOv2GJ0B2itbwa/qxoz4VX
         ICkwM+YPFN9w7oswYpqssRYGRhUfGEMTbzZW80/kY4sYTM75lML3rkC6b4hCK3jZUKDW
         9hk7uANi5TTvU8R2tI2fmZlHTtr2yhmS+kgLXKtk/Lie9wABnk/kB6jcBbMOupU+1ISC
         MIYQ==
X-Gm-Message-State: APzg51CU2If73cboAACazwyXKah2wauohiT2B9Kg6rouYkFeon2JVJ3q
        6UrD12mOCR1bcLJLd8alIxFB9CvS1f+A0g==
X-Google-Smtp-Source: ANB0VdYO4PjoFxB71MwLVL9SLMOrL4nOtmcczvUsSvX8X0aGt9FbJHgDK6cJuDl719OZg1mb5gkKoA==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr17202369wrp.202.1536090861031;
        Tue, 04 Sep 2018 12:54:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:20 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 9/9] ipv6: add inet6_fill_args
Date:   Tue,  4 Sep 2018 21:53:55 +0200
Message-Id: <20180904195355.4695-10-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inet6_fill_if{addr,mcaddr, acaddr}() already took 6 arguments which
meant the 7th argument would need to be pushed onto the stack on x86.
Add a new struct inet6_fill_args which holds common information passed
to inet6_fill_if{addr,mcaddr, acaddr}() and shortens the functions to
three pointer arguments.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
---
v1->v2:
- patch added

v0->v1:
- patch not present
---
 net/ipv6/addrconf.c | 89 ++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ebfeb64ac67b..d4733160e6b7 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4794,21 +4794,30 @@ static inline int inet6_ifaddr_msgsize(void)
 	       + nla_total_size(4)  /* IFA_RT_PRIORITY */;
 }
 
+struct inet6_fill_args {
+	u32 portid;
+	u32 seq;
+	int event;
+	unsigned int flags;
+	int netnsid;
+};
+
 static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
-			     u32 portid, u32 seq, int event, unsigned int flags,
-			     int netnsid)
+			     struct inet6_fill_args *args)
 {
 	struct nlmsghdr  *nlh;
 	u32 preferred, valid;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct ifaddrmsg), flags);
+	nlh = nlmsg_put(skb, args->portid, args->seq, args->event,
+			sizeof(struct ifaddrmsg), args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
 	put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->scope),
 		      ifa->idev->dev->ifindex);
 
-	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+	if (args->netnsid >= 0 &&
+	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid))
 		goto error;
 
 	if (!((ifa->flags&IFA_F_PERMANENT) &&
@@ -4860,8 +4869,7 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 }
 
 static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
-			       u32 portid, u32 seq, int event, u16 flags,
-			       int netnsid)
+			       struct inet6_fill_args *args)
 {
 	struct nlmsghdr  *nlh;
 	u8 scope = RT_SCOPE_UNIVERSE;
@@ -4870,11 +4878,13 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 	if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
 		scope = RT_SCOPE_SITE;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct ifaddrmsg), flags);
+	nlh = nlmsg_put(skb, args->portid, args->seq, args->event,
+			sizeof(struct ifaddrmsg), args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
-	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+	if (args->netnsid >= 0 &&
+	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid))
 		return -EMSGSIZE;
 
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
@@ -4890,8 +4900,7 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 }
 
 static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
-			       u32 portid, u32 seq, int event,
-			       unsigned int flags, int netnsid)
+			       struct inet6_fill_args *args)
 {
 	struct net_device *dev = fib6_info_nh_dev(ifaca->aca_rt);
 	int ifindex = dev ? dev->ifindex : 1;
@@ -4901,11 +4910,13 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
 	if (ipv6_addr_scope(&ifaca->aca_addr) & IFA_SITE)
 		scope = RT_SCOPE_SITE;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct ifaddrmsg), flags);
+	nlh = nlmsg_put(skb, args->portid, args->seq, args->event,
+			sizeof(struct ifaddrmsg), args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
-	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+	if (args->netnsid >= 0 &&
+	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid))
 		return -EMSGSIZE;
 
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
@@ -4931,6 +4942,12 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 			  struct netlink_callback *cb, enum addr_type_t type,
 			  int s_ip_idx, int *p_ip_idx, int netnsid)
 {
+	struct inet6_fill_args fillargs = {
+		.portid = NETLINK_CB(cb->skb).portid,
+		.seq = cb->nlh->nlmsg_seq,
+		.flags = NLM_F_MULTI,
+		.netnsid = netnsid,
+	};
 	struct ifmcaddr6 *ifmca;
 	struct ifacaddr6 *ifaca;
 	int err = 1;
@@ -4940,16 +4957,13 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 	switch (type) {
 	case UNICAST_ADDR: {
 		struct inet6_ifaddr *ifa;
+		fillargs.event = RTM_NEWADDR;
 
 		/* unicast address incl. temp addr */
 		list_for_each_entry(ifa, &idev->addr_list, if_list) {
 			if (++ip_idx < s_ip_idx)
 				continue;
-			err = inet6_fill_ifaddr(skb, ifa,
-						NETLINK_CB(cb->skb).portid,
-						cb->nlh->nlmsg_seq,
-						RTM_NEWADDR,
-						NLM_F_MULTI, netnsid);
+			err = inet6_fill_ifaddr(skb, ifa, &fillargs);
 			if (err < 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
@@ -4957,31 +4971,26 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 		break;
 	}
 	case MULTICAST_ADDR:
+		fillargs.event = RTM_GETMULTICAST;
+
 		/* multicast address */
 		for (ifmca = idev->mc_list; ifmca;
 		     ifmca = ifmca->next, ip_idx++) {
 			if (ip_idx < s_ip_idx)
 				continue;
-			err = inet6_fill_ifmcaddr(skb, ifmca,
-						  NETLINK_CB(cb->skb).portid,
-						  cb->nlh->nlmsg_seq,
-						  RTM_GETMULTICAST,
-						  NLM_F_MULTI, netnsid);
+			err = inet6_fill_ifmcaddr(skb, ifmca, &fillargs);
 			if (err < 0)
 				break;
 		}
 		break;
 	case ANYCAST_ADDR:
+		fillargs.event = RTM_GETANYCAST;
 		/* anycast address */
 		for (ifaca = idev->ac_list; ifaca;
 		     ifaca = ifaca->aca_next, ip_idx++) {
 			if (ip_idx < s_ip_idx)
 				continue;
-			err = inet6_fill_ifacaddr(skb, ifaca,
-						  NETLINK_CB(cb->skb).portid,
-						  cb->nlh->nlmsg_seq,
-						  RTM_GETANYCAST,
-						  NLM_F_MULTI, netnsid);
+			err = inet6_fill_ifacaddr(skb, ifaca, &fillargs);
 			if (err < 0)
 				break;
 		}
@@ -5082,6 +5091,13 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	struct inet6_fill_args fillargs = {
+		.portid = NETLINK_CB(in_skb).portid,
+		.seq = nlh->nlmsg_seq,
+		.event = RTM_NEWADDR,
+		.flags = 0,
+		.netnsid = -1,
+	};
 	struct net *tgt_net = net;
 	struct ifaddrmsg *ifm;
 	struct nlattr *tb[IFA_MAX+1];
@@ -5089,7 +5105,6 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct net_device *dev = NULL;
 	struct inet6_ifaddr *ifa;
 	struct sk_buff *skb;
-	int netnsid = -1;
 	int err;
 
 	err = nlmsg_parse(nlh, sizeof(*ifm), tb, IFA_MAX, ifa_ipv6_policy,
@@ -5098,10 +5113,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return err;
 
 	if (tb[IFA_TARGET_NETNSID]) {
-		netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
+		fillargs.netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
 
 		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(in_skb).sk,
-						  netnsid);
+						  fillargs.netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
 	}
@@ -5126,8 +5141,7 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_ifa;
 	}
 
-	err = inet6_fill_ifaddr(skb, ifa, NETLINK_CB(in_skb).portid,
-				nlh->nlmsg_seq, RTM_NEWADDR, 0, netnsid);
+	err = inet6_fill_ifaddr(skb, ifa, &fillargs);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
 		WARN_ON(err == -EMSGSIZE);
@@ -5140,7 +5154,7 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 errout:
 	if (dev)
 		dev_put(dev);
-	if (netnsid >= 0)
+	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
 	return err;
@@ -5150,13 +5164,20 @@ static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
 {
 	struct sk_buff *skb;
 	struct net *net = dev_net(ifa->idev->dev);
+	struct inet6_fill_args fillargs = {
+		.portid = 0,
+		.seq = 0,
+		.event = event,
+		.flags = 0,
+		.netnsid = -1,
+	};
 	int err = -ENOBUFS;
 
 	skb = nlmsg_new(inet6_ifaddr_msgsize(), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
-	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0, -1);
+	err = inet6_fill_ifaddr(skb, ifa, &fillargs);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
 		WARN_ON(err == -EMSGSIZE);
-- 
2.17.1

