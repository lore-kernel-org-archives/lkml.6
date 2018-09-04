Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA461C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9BC2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9BC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeIEAUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:20:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35862 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIEAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so5230678wrf.3;
        Tue, 04 Sep 2018 12:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LVMT0gXz7imMhLCYKBue/ajWbsFlebg4JaSGxDwiec=;
        b=jK02s/hLwHbKK4fE2jC3tqr6zxQlxvotKLLCQc9hw6XBglw6oYEF0FjAILpGZUZTOS
         BPo8yePjm6V5ZeaH8vICda/rpQW3bjjg0eJ0jWwfUbtrg8N2El+YvfWS4cUHQB2ujkR6
         EDvqwfp4pTEynpmh1bqC1wTRzz80CAp49kcuq7F77uhvU5NqIg2ael3rtmqdjSIn9HTG
         NfmSgCqJREKTghY3BO+NYBy/DIsJ3ljd7CsJLn/8Yip0ZCoXT3CT6ORxp/4xxR542jAL
         5ClWrtavqChwCmYljfOd/KLmLMyXjApO9WRHCytKPNeLKIh/DyCJIDzReVgGjbPmfesF
         CDog==
X-Gm-Message-State: APzg51CdhIzqXbcu8zEoyceLHDmnzTcgFUJDkSaDxgUc/0DDfk1dz9T4
        hnpxEfr+MrsPNdZbsgWUBZwpOuo0ZnQQhw==
X-Google-Smtp-Source: ANB0VdY+U8jeQOeL5ggWIqAec3owDJ35WTpJh2RZp11v12kYOvPg7QQbHgCjx8s/ryM4sB9ykvJMcA==
X-Received: by 2002:a5d:470d:: with SMTP id y13-v6mr24754256wrq.229.1536090849887;
        Tue, 04 Sep 2018 12:54:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:09 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 1/9] rtnetlink: add rtnl_get_net_ns_capable()
Date:   Tue,  4 Sep 2018 21:53:47 +0200
Message-Id: <20180904195355.4695-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_target_net() will be used in follow-up patches in ipv{4,6} codepaths to
retrieve network namespaces based on network namespace identifiers. So
remove the static declaration and export in the rtnetlink header. Also,
rename it to rtnl_get_net_ns_capable() to make it obvious what this
function is doing.
Export rtnl_get_net_ns_capable() so it can be used when ipv6 is built as
a module.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
- unchanged

v0->v1:
- export rtnl_get_net_ns_capable().
  Kbuild reported a build failure when ipv6 is built as a module. This was
  caused by rtnl_get_net_ns_capable() not being exported. Fix this by
  exporting it.
---
 include/net/rtnetlink.h |  1 +
 net/core/rtnetlink.c    | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

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
index 24431e578310..30645d9a9801 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1841,7 +1841,15 @@ static bool link_dump_filtered(struct net_device *dev,
 	return false;
 }
 
-static struct net *get_target_net(struct sock *sk, int netnsid)
+/**
+ * rtnl_get_net_ns_capable - Get netns if sufficiently privileged.
+ * @sk: netlink socket
+ * @netnsid: network namespace identifier
+ *
+ * Returns the network namespace identified by netnsid on success or an error
+ * pointer on failure.
+ */
+struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
 {
 	struct net *net;
 
@@ -1858,6 +1866,7 @@ static struct net *get_target_net(struct sock *sk, int netnsid)
 	}
 	return net;
 }
+EXPORT_SYMBOL_GPL(rtnl_get_net_ns_capable);
 
 static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
@@ -1893,7 +1902,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 			ifla_policy, NULL) >= 0) {
 		if (tb[IFLA_IF_NETNSID]) {
 			netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
-			tgt_net = get_target_net(skb->sk, netnsid);
+			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
 			if (IS_ERR(tgt_net)) {
 				tgt_net = net;
 				netnsid = -1;
@@ -2761,7 +2770,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
-		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
 	}
@@ -3171,7 +3180,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
-		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
 	}
-- 
2.17.1

