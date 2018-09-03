Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F318FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CBC20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CBC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeICI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:58:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38444 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:58:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so10282309wmi.3;
        Sun, 02 Sep 2018 21:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dJXWSCd4fmiiHfYP6yfe9UO53WTG2hatFTZtZm98iw4=;
        b=JYgYz9H8YGO/+A5h+B1z0GBsJZzDkutV0koBKhGKgFxBZYNjkyqUP+ybwUTgPKwIlU
         bfO+GokEw0B21GZUjLJiecy8YLAnGfXni3EQ6Sgm5ijjfpeSvGsNtXAwg0m0WOcHZ51+
         5qUYSjy+VnR56KJj1EkgSZ1fudipzVsbz7is2mfLPkBM88JTUqm814q8cph+kQZ0mWh8
         dvBXMk3N2gNpn5LYCH8SbvK7vPe6IQwRwgd4HjRKoDerqcIPOjbN6IJnwqMytHqn4W4E
         22pTj0rdvWYKjiLi5hS3tjMVXVou4dlM0uyXjXw27DOOgR1q0XMBU7fYgsG0qK47TpJ5
         LuEA==
X-Gm-Message-State: APzg51CPIDowG2NvuRgxBhEJepBzd5IFl669CGEzGQmrFWLjCtqOyOJr
        C7H+khzAt0unhozlflLWSFYbOm8o1uOtJw==
X-Google-Smtp-Source: ANB0VdYNJ/3Z82wC/jOWXSwK1hcLmyv+sh3KINjSKq1onAbDLIIPlm32WnADi9BKfVz+8ybBYLVDuA==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr4195213wmd.79.1535949578628;
        Sun, 02 Sep 2018 21:39:38 -0700 (PDT)
Received: from localhost.localdomain ([88.128.81.0])
        by smtp.gmail.com with ESMTPSA id j66-v6sm22453364wrj.28.2018.09.02.21.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 21:39:38 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v1 3/5] ipv4: enable IFA_IF_NETNSID for RTM_GETADDR
Date:   Mon,  3 Sep 2018 06:37:15 +0200
Message-Id: <20180903043717.20136-4-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903043717.20136-1-christian@brauner.io>
References: <20180903043717.20136-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Backwards Compatibility:
  If userspace wants to determine whether ipv4 RTM_GETADDR requests support
  the new IFA_IF_NETNSID property they should verify that the reply after
  sending a request includes the IFA_IF_NETNSID property. If it does not
  userspace should assume that IFA_IF_NETNSID is not supported for ipv4
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
v0->v1:
- unchanged
---
 net/ipv4/devinet.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ea4bd8a52422..c52271309a1f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -100,6 +100,7 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX+1] = {
 	[IFA_CACHEINFO]		= { .len = sizeof(struct ifa_cacheinfo) },
 	[IFA_FLAGS]		= { .type = NLA_U32 },
 	[IFA_RT_PRIORITY]	= { .type = NLA_U32 },
+	[IFA_IF_NETNSID]	= { .type = NLA_S32 },
 };
 
 #define IN4_ADDR_HSIZE_SHIFT	8
@@ -1584,7 +1585,8 @@ static int put_cacheinfo(struct sk_buff *skb, unsigned long cstamp,
 }
 
 static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
-			    u32 portid, u32 seq, int event, unsigned int flags)
+			    u32 portid, u32 seq, int event, unsigned int flags,
+			    int netnsid)
 {
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr  *nlh;
@@ -1601,6 +1603,9 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	ifm->ifa_scope = ifa->ifa_scope;
 	ifm->ifa_index = ifa->ifa_dev->dev->ifindex;
 
+	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
+		goto nla_put_failure;
+
 	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
 		preferred = ifa->ifa_preferred_lft;
 		valid = ifa->ifa_valid_lft;
@@ -1648,6 +1653,9 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[IFA_MAX+1];
+	struct net *tgt_net = net;
+	int netnsid = -1;
 	int h, s_h;
 	int idx, s_idx;
 	int ip_idx, s_ip_idx;
@@ -1660,12 +1668,23 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	s_idx = idx = cb->args[1];
 	s_ip_idx = ip_idx = cb->args[2];
 
+	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
+			ifa_ipv4_policy, NULL) >= 0) {
+		if (tb[IFA_IF_NETNSID]) {
+			netnsid = nla_get_s32(tb[IFA_IF_NETNSID]);
+
+			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
+			if (IS_ERR(tgt_net))
+				return PTR_ERR(tgt_net);
+		}
+	}
+
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
-		head = &net->dev_index_head[h];
+		head = &tgt_net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv4.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = atomic_read(&tgt_net->ipv4.dev_addr_genid) ^
+			  tgt_net->dev_base_seq;
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -1680,9 +1699,10 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 				if (ip_idx < s_ip_idx)
 					continue;
 				if (inet_fill_ifaddr(skb, ifa,
-					     NETLINK_CB(cb->skb).portid,
-					     cb->nlh->nlmsg_seq,
-					     RTM_NEWADDR, NLM_F_MULTI) < 0) {
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     RTM_NEWADDR, NLM_F_MULTI,
+						     netnsid) < 0) {
 					rcu_read_unlock();
 					goto done;
 				}
@@ -1698,6 +1718,8 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[0] = h;
 	cb->args[1] = idx;
 	cb->args[2] = ip_idx;
+	if (netnsid >= 0)
+		put_net(tgt_net);
 
 	return skb->len;
 }
@@ -1715,7 +1737,7 @@ static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 	if (!skb)
 		goto errout;
 
-	err = inet_fill_ifaddr(skb, ifa, portid, seq, event, 0);
+	err = inet_fill_ifaddr(skb, ifa, portid, seq, event, 0, -1);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
-- 
2.17.1

