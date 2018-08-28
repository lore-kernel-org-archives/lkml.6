Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3221C2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3221C2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeH2DNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:13:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43984 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeH2DNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:13:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so1395600plv.10;
        Tue, 28 Aug 2018 16:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xjvQ5JHXADHQ707i5zH8d6ltCg7wJu3ZloFnrlMojEY=;
        b=RR3CUKneZHdRZquohegQsul8lqnhnVf+WQi/VVDylSpfD6uDvWaNOvqkOXkitn/wjV
         YS4nIzG8w/CitDB+lTGOxobOh1sD5mh4zWJmBVQGqEcAz2I5B8u98e5OIJi7x3UjoI4Y
         USYGJ97C5Ur/jqSYz+GW47PzfRHpdPdK0nJYUHdYo3hFXWu8LeNgsNvUeceNjxQklNtU
         ahLUmG3roOr1i9WxHkJgBWCvTyRyzPWSzprsq84yOhMZerdXUUXQUFHjX4IfXiNgIxuh
         RmIaPTaLf/5L8o0W3nCJ94mVzUOERRVo5sfR/jmbflp4K6A7alVwFXBi/BXQ2lP6je/+
         TSmg==
X-Gm-Message-State: APzg51CvCcPUJic6b1RRi7FlFAkrgeH8oJeYiUmU3GkKYD1Rsavjy7CW
        0seePKlALl29d/4Aa9Olbz4+Hz7jnD6mTA==
X-Google-Smtp-Source: ANB0VdYYxaUvIhbLGKzmuLsmjP+ljWbsbreLdGY65yPTY8CSc8cU/MVe3fK0WXVmm4eMUpBGt4gaYw==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr3497462pld.294.1535498389849;
        Tue, 28 Aug 2018 16:19:49 -0700 (PDT)
Received: from localhost.localdomain ([72.28.92.217])
        by smtp.gmail.com with ESMTPSA id q6-v6sm4217354pgq.19.2018.08.28.16.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:19:49 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 1/5] rtnetlink: add rtnl_get_net_ns_capable()
Date:   Wed, 29 Aug 2018 01:18:55 +0200
Message-Id: <20180828231859.29758-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828231859.29758-1-christian@brauner.io>
References: <20180828231859.29758-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_target_net() will be used in follow-up patches in ipv{4,6} codepaths to
retrieve network namespaces based on network namespace identifiers. So
remove the static declaration and export in the rtnetlink header. Also,
rename it to rtnl_get_net_ns_capable() to make it obvious what this
function is doing.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 include/net/rtnetlink.h |  1 +
 net/core/rtnetlink.c    | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 0bbaa5488423..cf26e5aacac4 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -165,6 +165,7 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm);
 
 int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
 			struct netlink_ext_ack *exterr);
+struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e3f743c141b3..c6c6f93cd195 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1795,7 +1795,12 @@ static bool link_dump_filtered(struct net_device *dev,
 	return false;
 }
 
-static struct net *get_target_net(struct sock *sk, int netnsid)
+/**
+ * rtnl_get_net_ns_capable - Get a network namespace based on a netnsid.
+ *
+ * Returns the network namespace on success or a error pointer on failure.
+ */
+struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
 {
 	struct net *net;
 
@@ -1847,7 +1852,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 			ifla_policy, NULL) >= 0) {
 		if (tb[IFLA_IF_NETNSID]) {
 			netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
-			tgt_net = get_target_net(skb->sk, netnsid);
+			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
 			if (IS_ERR(tgt_net)) {
 				tgt_net = net;
 				netnsid = -1;
@@ -2715,7 +2720,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
-		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
 	}
@@ -3125,7 +3130,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
-		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
 	}
-- 
2.17.1

