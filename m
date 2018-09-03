Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C88C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176320856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C176320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeICI5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:57:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:57:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so16358813wre.10;
        Sun, 02 Sep 2018 21:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rIaWy0Qzq+GWnOEkPXKykLc5Az4Yb54NGxuSXnl9lzU=;
        b=lQvEOYAeWGude0lKv6oswoJzSDA/1i+nc9+vSwL0R1nrDk91wiZWSlCEk5PpkgPifb
         4QtH4P+uUQ+aXXR/F2SUxqHxvSYBOMCviqEWCxPmpuweIce8Tcxg4pRidxXay+8sY9YJ
         bK+JMMf0pL4qrJgFXcqZh6U3t2LnokhcKqM4o6FfpxNxfLyKD9Ym4dlw8qSm4NEtm7pm
         nrATTYSLLU+yCknDobx7VaSBN8w44+RCh6kD82I3Q256ydFJ4Ulo5GiJQtc7o1j/gHiV
         AUwzQg3/X93b5v9uKKqUc32QbB9LrFNfDyTwMOkCAhaD8TBo+MwMWZ2Sca5DOKxtQjsj
         6Vcw==
X-Gm-Message-State: APzg51BatRGuAiXbP89p20Fre0VL5SI2w7bjLqeK1liIOG6F+L/DAtFT
        zfuhvZLi6XN6BRgV1h+nNy2Vpo70IclxxA==
X-Google-Smtp-Source: ANB0VdZDDSKF+fCbQ5ABnQxzS/hyxak0eUjoNcF/2XuzxNKsLwkzNrvrIS8aNI7cmxGIQ1WaCjsFsQ==
X-Received: by 2002:adf:e30e:: with SMTP id b14-v6mr17410441wrj.158.1535949539451;
        Sun, 02 Sep 2018 21:38:59 -0700 (PDT)
Received: from localhost.localdomain ([88.128.81.0])
        by smtp.gmail.com with ESMTPSA id j66-v6sm22453364wrj.28.2018.09.02.21.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 21:38:58 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v1 1/5] rtnetlink: add rtnl_get_net_ns_capable()
Date:   Mon,  3 Sep 2018 06:37:13 +0200
Message-Id: <20180903043717.20136-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903043717.20136-1-christian@brauner.io>
References: <20180903043717.20136-1-christian@brauner.io>
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

