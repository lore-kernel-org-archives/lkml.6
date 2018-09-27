Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75682C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1D2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UjTu3nIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1D2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeI1ATC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38409 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbeI1ATB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id x8-v6so5867731eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r8s+hMtRCFiHF8UTr+Vfz9PSgRGWsmuR5zLQAqOls3M=;
        b=UjTu3nIc/7btaPWoHETV7jAM4+Uf6QRJurgajGDJkcYnekW0HQ7bhbjMa+EDmQGrwr
         9dJJiGce3sIHDxpy5iTT2reo39X6Yw5LkzdGnDhsHnJ5Mxe13VoT7kWl74z6xZvvPw+C
         4fn8qEQNkVTC1GPVfC8BlwFI5EThz0JHtjZsDciHR4lf+FtN19+WmjvlwB5cbAOvTQ7i
         XRY88LVB6NSdyWrfEswkKfeLbPk56zY5LHgjgtzM8tUgLwqkLYsS8x+5D27JJXF7Smi5
         H6Xt9HOaj3FPwmyk3T1znbVvhQE7cA+mpGtdqlxvxdZ9y9INUByuNVYdu3IvbBuv7yrj
         U8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r8s+hMtRCFiHF8UTr+Vfz9PSgRGWsmuR5zLQAqOls3M=;
        b=Iux0oTCCXlUzBOkqsYB2hNtliMPT8znZyKzizqw/UOM/mD/iglKICtGtoOBqwart3p
         SYz09NlKME3ia//fZ/TgMwyOi53DJA+6qinFWxA3nLGT84b3dlwEEGVn3M8HjA3mJpRN
         /ErmCu4ezVYJffePhqjY5O5L5yMOorP1zNkiFu7JD0Pz7BgTrWjc0eWv887aKoKYvwnR
         rW/0hvIlyM3qjUY7KY5vqPe5VknVrmMJVay4Lr5EWbWzariXOUVrsOI7Rat8UTStBbOY
         FZDQyzFiSAGZaSADOklSYXfW/aab1pcSxJmrBRj08oNEMLSg8dTEE9MdjhKWE33dc7Gc
         987Q==
X-Gm-Message-State: ABuFfojVM2aAbas9Ggls9vOZ1flES4/+dPnsQePt2fyhurqMCVfCrHB0
        O4zePR8SSzOqviKT0PZ1Qn6CJA==
X-Google-Smtp-Source: ACcGV62pR3/e85N26b+4kx2e3ciZbnG3iU7m33B0rFESKuqclNcRq+fuXoihUkIU+tVsqNW/zrTxCA==
X-Received: by 2002:a50:ac76:: with SMTP id w51-v6mr19421250edc.211.1538071173722;
        Thu, 27 Sep 2018 10:59:33 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:32 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 2/7] ipv4: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:52 +0200
Message-Id: <20180927175857.3511-3-christian@brauner.io>
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
 net/ipv4/devinet.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 44d931a3cd50..3ac004ba67b0 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1659,7 +1659,8 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	return -EMSGSIZE;
 }
 
-static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
+static int inet_dump_ifaddr_common(struct sk_buff *skb,
+				   struct netlink_callback *cb, int rtm_type)
 {
 	struct inet_fill_args fillargs = {
 		.portid = NETLINK_CB(cb->skb).portid,
@@ -1683,8 +1684,14 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	s_idx = idx = cb->args[1];
 	s_ip_idx = ip_idx = cb->args[2];
 
-	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
-			ifa_ipv4_policy, NULL) >= 0) {
+	if (rtm_type == RTM_GETADDR2) {
+		int err;
+
+		err = nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb,
+				  IFA_MAX, ifa_ipv4_policy, NULL);
+		if (err < 0)
+			return err;
+
 		if (tb[IFA_TARGET_NETNSID]) {
 			fillargs.netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
 
@@ -1736,6 +1743,16 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return inet_dump_ifaddr_common(skb, cb, RTM_GETADDR);
+}
+
+static int inet_dump_ifaddr2(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return inet_dump_ifaddr_common(skb, cb, RTM_GETADDR2);
+}
+
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 		      u32 portid)
 {
@@ -2564,6 +2581,7 @@ void __init devinet_init(void)
 	rtnl_register(PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0);
 	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
 	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr, 0);
+	rtnl_register(PF_INET, RTM_GETADDR2, NULL, inet_dump_ifaddr2, 0);
 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
 		      inet_netconf_dump_devconf, 0);
 }
-- 
2.17.1

