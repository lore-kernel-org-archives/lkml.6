Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38DF2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GnMpJu2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38DF2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeI1ATj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeI1ATE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id q19-v6so5888247edr.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N3HBINMsThJvaGsXZVmuviY1doyzzZiK7DaUmpkTdJg=;
        b=GnMpJu2azb+KThJX8c21RCJcJM4B1JfDRQYbRGqxFCmZdHFXOqkHCZ7fqqHjoAjDjW
         MXYFh7dFwtw9vBheSjLxte67PPkWclnCmgMkg6geqQa646JheT+eCHnnP/4y5JnnccSA
         WdwpqYihiCXzPxmYw72G6PXsIATFfkTALILkPloL1Z7y7mbdMqfJq4ZFHDgf1j57/y5M
         Nia/s5j8+/CkXm9nHWCvs6VcctTAqBrDnkw5lHjVlPtqtTDErprJREMfWY4pcX53PCSW
         tKuQUypEc5/sTCrS72bj0dxZkTZp+EzLuxEkCKdQHL1ku7j0KLhBWO9CX1jP8fq3qd92
         Fjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N3HBINMsThJvaGsXZVmuviY1doyzzZiK7DaUmpkTdJg=;
        b=RnziZMS/PRJ2DEo404mA4xooBatwiA5TWNSMI8H/N4IWJ0Yw+2rzBkS1hVWra+F2Wg
         dLxFmwxrOcA3WLdMZ+G3cgDQYmxcjAThUfqYo85f6EFS151RXaMjfFIE99qFKm+UkdIG
         z7cwVRQ9ZKnQImm8vLgrVLyIRzHLjT1TgoCDrvUwtcg47HJpU2JrfE+k+6DcYGB0JVLc
         Gycn5F2eLlvjoOb12KtyVyzw/i5zWwyAdqNRSmMkuMBBTA0TCj/Poqmw3B0TRQgvqo0X
         1IBOQghXkoP65imxNF9GlxoD7FNQBmnSeT/N+6VifN6B8MKCDIaDGLij+1PavhgYY+T5
         AlCg==
X-Gm-Message-State: ABuFfoj0HZxQaAwV+S0cvNCWNO75CpgURtv0cAYG1IpsO10J5v3aGdRH
        p6Lu8rBcKjz1jt/9kConBLvrkQ==
X-Google-Smtp-Source: ACcGV63/DU5jGBVX4lkJfJn98sNJkGkCEXWVLKy70GniZcMXdX2jeXwwWK8QcHjo2ZlZHtvngKqwwQ==
X-Received: by 2002:a50:a705:: with SMTP id h5-v6mr19831560edc.162.1538071176974;
        Thu, 27 Sep 2018 10:59:36 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:36 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 4/7] decnet: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:54 +0200
Message-Id: <20180927175857.3511-5-christian@brauner.io>
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
 net/decnet/dn_dev.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
index d0b3e69c6b39..8da6ca154c08 100644
--- a/net/decnet/dn_dev.c
+++ b/net/decnet/dn_dev.c
@@ -738,10 +738,12 @@ static void dn_ifaddr_notify(int event, struct dn_ifaddr *ifa)
 		rtnl_set_sk_err(&init_net, RTNLGRP_DECnet_IFADDR, err);
 }
 
-static int dn_nl_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
+static int dn_nl_dump_ifaddr_common(struct sk_buff *skb,
+				    struct netlink_callback *cb, int rtm_type)
 {
 	struct net *net = sock_net(skb->sk);
-	int idx, dn_idx = 0, skip_ndevs, skip_naddr;
+	int err, idx, dn_idx = 0, skip_ndevs, skip_naddr;
+	struct nlattr *tb[IFA_MAX+1];
 	struct net_device *dev;
 	struct dn_dev *dn_db;
 	struct dn_ifaddr *ifa;
@@ -749,6 +751,13 @@ static int dn_nl_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!net_eq(net, &init_net))
 		return 0;
 
+	if (rtm_type == RTM_GETADDR2) {
+		err = nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
+				dn_ifa_policy, NULL);
+		if (err < 0)
+			return err;
+	}
+
 	skip_ndevs = cb->args[0];
 	skip_naddr = cb->args[1];
 
@@ -787,6 +796,16 @@ static int dn_nl_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int dn_nl_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return dn_nl_dump_ifaddr_common(skb, cb, RTM_GETADDR);
+}
+
+static int dn_nl_dump_ifaddr2(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return dn_nl_dump_ifaddr_common(skb, cb, RTM_GETADDR2);
+}
+
 static int dn_dev_get_first(struct net_device *dev, __le16 *addr)
 {
 	struct dn_dev *dn_db;
@@ -1410,6 +1429,8 @@ void __init dn_dev_init(void)
 			     dn_nl_deladdr, NULL, 0);
 	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_GETADDR,
 			     NULL, dn_nl_dump_ifaddr, 0);
+	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_GETADDR2,
+			     NULL, dn_nl_dump_ifaddr2, 0);
 
 	proc_create_seq("decnet_dev", 0444, init_net.proc_net, &dn_dev_seq_ops);
 
-- 
2.17.1

