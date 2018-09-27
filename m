Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB141C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A59D2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OCDuvR0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A59D2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeI1ATD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38982 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbeI1ATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so5850250edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ZxZ6GmgbBvekGI3np6+PbuOz+YR16wGAjG+yoq1uZk=;
        b=OCDuvR0JCHxbs0pidAPtFr+mT8UkgCBm74TqW0FHRdQnhEu2zrbmfCNcffUHjfsiHl
         hxnJHo/NZjcnCUWtAvGxo2f8UdyZrISLgWduN+Jtuyi4IzhNNP4Z9RfXqO5Anrrm7rQb
         x6vnNClhShCaNoj+PAzZHRmKC7cmzhh+FA15H64uJ8wcn6GJp3jDfxOSFIN5aAMBoGNC
         Cwqy1ZD90e41wvcCcs2s0RMNjqESJQhdcLEBUk+9XRvIie7Yzc5DUmnbdx/tJl93eQND
         vkIyHovYwkkm9lK96xLiLnjkvyobSGEmpzhBxEa6ulu0uU/KXFDHEnFfV0i2gRMYxfTu
         jvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZxZ6GmgbBvekGI3np6+PbuOz+YR16wGAjG+yoq1uZk=;
        b=mHx7HXS4GPzI0cB/r/fITr/L4b57edHBFpBwqO8OGN1dep2eO5TthRX6CuETIrrfXw
         7NmmWI5ZekHtUlq3sKUrP+JixHZjCJnp4FShGJmuYD8GnyxYmiIp8jgpYbQ/k6pIvGRv
         X9K2EAmOzmYdsLDBST7Em69ksM/LE0Aczqq+zxOr/ejwG+3jsfVY7VKrpcfCuaDxqMkD
         oW8Xr7XyZ4h4FZTMFeyYG2KaLt4Mf2M+KzeD6UODiAv41psHapTY8AL3LOFaU2Dx25/o
         cvxgu6zmCR5YtARS1b/4pbhTE7ACJ0mCc1LtyjU4/eYQN3yGOLfdR0ftCLIzKI1RrR+S
         yEEQ==
X-Gm-Message-State: ABuFfohLo29stqOM+cT7IGmxHxgZsbjkAWM8cPqKsh75EvXyXrxpCyGS
        j+5Nx728k76gtvuGP7e5cZkpWg==
X-Google-Smtp-Source: ACcGV62w1TcgsWnjv2vD003hvLRz5V1VCKCXuIycvIGLXJqWEUNNJgEvzSushXBXsPl8ObfgDma3WQ==
X-Received: by 2002:a50:d58f:: with SMTP id v15-v6mr2788499edi.226.1538071175444;
        Thu, 27 Sep 2018 10:59:35 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:34 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 3/7] ipv6: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:53 +0200
Message-Id: <20180927175857.3511-4-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927175857.3511-1-christian@brauner.io>
References: <20180927175857.3511-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various userspace programs (e.g. iproute2) have sent RTM_GETADDR
requests with struct ifinfomsg. This is wrong and should have been
struct ifaddrmsg all along as mandated by the manpages. However, dump
requests so far didn't parse the netlink message that was sent and
succeeded even when a wrong struct was passed along.

Currently, the message is parsed under the assumption that the correct
struct ifaddrmsg is sent down. If the parsing fails the kernel will
still fulfill the request to preserve backwards compatability but a
rate-limited message that there were leftover bytes after parsing the
message is recorded in dmesg. It has been argued that this is
unacceptable [1].

But various new features that got and will get added to RTM_GETADDR make
it necessary to definitely know what header was passed along.
This is currently not possible without resorting to (likely unreliable)
hacks such as introducing a nested attribute that ensures that
RTM_GETADDR which pass along properties such as IFA_TARGET_NETNSID
always exceed RTM_GETADDR requests that send down the wrong struct
ifinfomsg [2]. Basically, multiple approaches to solve this have been
shut down. Furthermore, the API expressed via RTM_GETADDR is apparently
frozen [3] so the wiggle room at this point seems very much zero.

The correct solution at this point seems to me to introduce a new
RTM_GETADDR2 request. This way we can parse the message and fail hard if
the struct is not struct ifaddrmsg and can safely extend it in the
future. Userspace tools that rely on the buggy RTM_GETADDR API will
still keep working without even having to see any log messages and new
userspace tools that want to make user of new features can make use of
the new RTM_GETADDR2 requests.

[1]: https://lists.openwall.net/netdev/2018/09/25/59
[2]: https://lists.openwall.net/netdev/2018/09/25/75
[3]: https://lists.openwall.net/netdev/2018/09/26/166

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
---
 net/ipv6/addrconf.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index a9a317322388..6e76e5cc76c4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5003,7 +5003,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 }
 
 static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
-			   enum addr_type_t type)
+			   enum addr_type_t type, int rtm_version)
 {
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFA_MAX+1];
@@ -5020,8 +5020,14 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	s_idx = idx = cb->args[1];
 	s_ip_idx = ip_idx = cb->args[2];
 
-	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
-			ifa_ipv6_policy, NULL) >= 0) {
+	if (rtm_version == RTM_GETADDR2) {
+		int err;
+
+		err = nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb,
+				  IFA_MAX, ifa_ipv6_policy, NULL);
+		if (err < 0)
+			return err;
+
 		if (tb[IFA_TARGET_NETNSID]) {
 			netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
 
@@ -5068,14 +5074,21 @@ static int inet6_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	enum addr_type_t type = UNICAST_ADDR;
 
-	return inet6_dump_addr(skb, cb, type);
+	return inet6_dump_addr(skb, cb, type, RTM_GETADDR);
+}
+
+static int inet6_dump_ifaddr2(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	enum addr_type_t type = UNICAST_ADDR;
+
+	return inet6_dump_addr(skb, cb, type, RTM_GETADDR2);
 }
 
 static int inet6_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	enum addr_type_t type = MULTICAST_ADDR;
 
-	return inet6_dump_addr(skb, cb, type);
+	return inet6_dump_addr(skb, cb, type, RTM_GETMULTICAST);
 }
 
 
@@ -5083,7 +5096,7 @@ static int inet6_dump_ifacaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	enum addr_type_t type = ANYCAST_ADDR;
 
-	return inet6_dump_addr(skb, cb, type);
+	return inet6_dump_addr(skb, cb, type, RTM_GETANYCAST);
 }
 
 static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
@@ -6833,6 +6846,11 @@ int __init addrconf_init(void)
 				   RTNL_FLAG_DOIT_UNLOCKED);
 	if (err < 0)
 		goto errout;
+	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDR2,
+				   inet6_rtm_getaddr, inet6_dump_ifaddr2,
+				   RTNL_FLAG_DOIT_UNLOCKED);
+	if (err < 0)
+		goto errout;
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETMULTICAST,
 				   NULL, inet6_dump_ifmcaddr, 0);
 	if (err < 0)
-- 
2.17.1

