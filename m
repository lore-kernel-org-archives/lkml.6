Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD146C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BCD20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BCD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIEAVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:21:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35649 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeIEAU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so5483470wmc.0;
        Tue, 04 Sep 2018 12:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSEXyMFk6XZ/Or28TAg3HTgPmm5X8aOQsZSTrwg6yc4=;
        b=LAH5tMO9z/fBHhnfeWlFh6qaSkOonY1y5F/ErSLvUxWF70HUydEKDvjkIIxdaTyciM
         9O1kKed0yTrlp+L10QpqYq/oED/q1g3EKh1BMd1/kFiuWY91U4vqlbFjz4rbjuZSqZeo
         BAMFNVVuEHPa26JevYXB2XYrMBTyKCR9dJz+N6a5+bI57G/4acx/fb4BoKbJGjSrBVGC
         I6FBW7Q8A0fcF+8LL9B7iuLrZCjWqLVxClipJ/rdwB2PPsCrf+bJfHbddTaTSlllvrup
         FHH1EY+0cCeqt2//W6pPvyE58i4V4inynUqRfi45/Y3ISMwsP1gGqv7jze4Fdo8KndxV
         k6TA==
X-Gm-Message-State: APzg51B1yyfZbe09aTXKlz4Dys8JdGaeAdQBpkjZbKovzIF+N1BLzktK
        1ZdhkiVg3sQ1OYtP9EaOm8Ui9b5Ev0+sqQ==
X-Google-Smtp-Source: ANB0Vdb7/o/cEM0sDFh1lRuXXztsd1zZ3uedM5x/bLGUuJr0PHLBpU9E/dkYSnDI2DfcvaBOpqmGRQ==
X-Received: by 2002:a1c:1f48:: with SMTP id f69-v6mr3557589wmf.152.1536090859649;
        Tue, 04 Sep 2018 12:54:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:19 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 8/9] ipv4: add inet_fill_args
Date:   Tue,  4 Sep 2018 21:53:54 +0200
Message-Id: <20180904195355.4695-9-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inet_fill_ifaddr() already took 6 arguments which meant the 7th argument
would need to be pushed onto the stack on x86.
Add a new struct inet_fill_args which holds common information passed
to inet_fill_ifaddr() and shortens the function to three pointer arguments.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
---
v1->v2:
- patch added

v0->v1:
- patch not present
---
 net/ipv4/devinet.c | 48 +++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5cb849300b81..44d931a3cd50 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -103,6 +103,14 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX+1] = {
 	[IFA_TARGET_NETNSID]	= { .type = NLA_S32 },
 };
 
+struct inet_fill_args {
+	u32 portid;
+	u32 seq;
+	int event;
+	unsigned int flags;
+	int netnsid;
+};
+
 #define IN4_ADDR_HSIZE_SHIFT	8
 #define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
 
@@ -1585,14 +1593,14 @@ static int put_cacheinfo(struct sk_buff *skb, unsigned long cstamp,
 }
 
 static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
-			    u32 portid, u32 seq, int event, unsigned int flags,
-			    int netnsid)
+			    struct inet_fill_args *args)
 {
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr  *nlh;
 	u32 preferred, valid;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*ifm), flags);
+	nlh = nlmsg_put(skb, args->portid, args->seq, args->event, sizeof(*ifm),
+			args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
@@ -1603,7 +1611,8 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	ifm->ifa_scope = ifa->ifa_scope;
 	ifm->ifa_index = ifa->ifa_dev->dev->ifindex;
 
-	if (netnsid >= 0 && nla_put_s32(skb, IFA_TARGET_NETNSID, netnsid))
+	if (args->netnsid >= 0 &&
+	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid))
 		goto nla_put_failure;
 
 	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
@@ -1652,10 +1661,16 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 
 static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct inet_fill_args fillargs = {
+		.portid = NETLINK_CB(cb->skb).portid,
+		.seq = cb->nlh->nlmsg_seq,
+		.event = RTM_NEWADDR,
+		.flags = NLM_F_MULTI,
+		.netnsid = -1,
+	};
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFA_MAX+1];
 	struct net *tgt_net = net;
-	int netnsid = -1;
 	int h, s_h;
 	int idx, s_idx;
 	int ip_idx, s_ip_idx;
@@ -1671,9 +1686,10 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
 			ifa_ipv4_policy, NULL) >= 0) {
 		if (tb[IFA_TARGET_NETNSID]) {
-			netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
+			fillargs.netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
 
-			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
+			tgt_net = rtnl_get_net_ns_capable(skb->sk,
+							  fillargs.netnsid);
 			if (IS_ERR(tgt_net))
 				return PTR_ERR(tgt_net);
 		}
@@ -1698,11 +1714,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 			     ifa = ifa->ifa_next, ip_idx++) {
 				if (ip_idx < s_ip_idx)
 					continue;
-				if (inet_fill_ifaddr(skb, ifa,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWADDR, NLM_F_MULTI,
-						     netnsid) < 0) {
+				if (inet_fill_ifaddr(skb, ifa, &fillargs) < 0) {
 					rcu_read_unlock();
 					goto done;
 				}
@@ -1718,7 +1730,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[0] = h;
 	cb->args[1] = idx;
 	cb->args[2] = ip_idx;
-	if (netnsid >= 0)
+	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
 	return skb->len;
@@ -1727,8 +1739,14 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 		      u32 portid)
 {
+	struct inet_fill_args fillargs = {
+		.portid = portid,
+		.seq = nlh ? nlh->nlmsg_seq : 0,
+		.event = event,
+		.flags = 0,
+		.netnsid = -1,
+	};
 	struct sk_buff *skb;
-	u32 seq = nlh ? nlh->nlmsg_seq : 0;
 	int err = -ENOBUFS;
 	struct net *net;
 
@@ -1737,7 +1755,7 @@ static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 	if (!skb)
 		goto errout;
 
-	err = inet_fill_ifaddr(skb, ifa, portid, seq, event, 0, -1);
+	err = inet_fill_ifaddr(skb, ifa, &fillargs);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
-- 
2.17.1

