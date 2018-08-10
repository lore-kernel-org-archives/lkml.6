Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3824E223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3824E223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acceis.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeHJROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:14:12 -0400
Received: from smtpout13.r2.mail-out.ovh.net ([54.36.141.13]:48739 "EHLO
        smtpout13.r2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727635AbeHJROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:14:12 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Aug 2018 13:14:12 EDT
Received: from ex.mail.ovh.net (unknown [10.109.160.219])
        by mo512.mail-out.ovh.net (Postfix) with SMTP id A036A3E07F3E;
        Fri, 10 Aug 2018 16:36:35 +0200 (CEST)
Date:   Fri, 10 Aug 2018 16:36:33 +0200
From:   Virgile Jarry <virgile@acceis.fr>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ICMPv6: Add icmp_echo_ignore_all support for ICMPv6
Message-ID: <20180810143633.GA14235@_>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [85.170.142.139]
X-ClientProxiedBy: CAS04.indiv.local (172.16.1.4) To MBX005.indiv.local
 (172.16.2.5)
X-Ovh-Tracer-Id: 11742010130889670815
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrtdeigdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preventing the kernel from responding to ICMP Echo Requests messages
can be useful in several ways. The sysctl parameter
'icmp_echo_ignore_all' can be used to prevent the kernel from
responding to IPv4 ICMP echo requests. For IPv6 pings, such
a sysctl kernel parameter did not exist.

Add the ability to prevent the kernel from responding to IPv6
ICMP echo requests through the use of the following sysctl
parameter : /proc/sys/net/ipv6/icmp/echo_ignore_all.
Update the documentation to reflect this change.

Signed-off-by: Virgile Jarry <virgile@acceis.fr>
---
 Documentation/networking/ip-sysctl.txt |  5 +++++
 include/net/netns/ipv6.h               |  1 +
 net/ipv6/af_inet6.c                    |  1 +
 net/ipv6/icmp.c                        | 16 +++++++++++++---
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
index ce8fbf5..5042a13 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -1863,6 +1863,11 @@ ratelimit - INTEGER
 	otherwise the minimal space between responses in milliseconds.
 	Default: 1000
 
+echo_ignore_all - BOOLEAN
+	If set non-zero, then the kernel will ignore all ICMP ECHO
+	requests sent to it over the IPv6 protocol.
+	Default: 0
+
 xfrm6_gc_thresh - INTEGER
 	The threshold at which we will start garbage collecting for IPv6
 	destination cache entries.  At twice this value the system will
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 762ac99..f0e396a 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -32,6 +32,7 @@ struct netns_sysctl_ipv6 {
 	int flowlabel_consistency;
 	int auto_flowlabels;
 	int icmpv6_time;
+	int icmpv6_echo_ignore_all;
 	int anycast_src_echo_reply;
 	int ip_nonlocal_bind;
 	int fwmark_reflect;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 9ed0eae..d0033b3 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -833,6 +833,7 @@ static int __net_init inet6_net_init(struct net *net)
 
 	net->ipv6.sysctl.bindv6only = 0;
 	net->ipv6.sysctl.icmpv6_time = 1*HZ;
+	net->ipv6.sysctl.icmpv6_echo_ignore_all = 0;
 	net->ipv6.sysctl.flowlabel_consistency = 1;
 	net->ipv6.sysctl.auto_flowlabels = IP6_DEFAULT_AUTO_FLOW_LABELS;
 	net->ipv6.sysctl.idgen_retries = 3;
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index ef2505a..1d869f1 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -800,6 +800,7 @@ void icmpv6_notify(struct sk_buff *skb, u8 type, u8 code, __be32 info)
 
 static int icmpv6_rcv(struct sk_buff *skb)
 {
+	struct net *net = dev_net(skb->dev);
 	struct net_device *dev = skb->dev;
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
@@ -849,7 +850,8 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
-		icmpv6_echo_reply(skb);
+		if (!net->ipv6.sysctl.icmpv6_echo_ignore_all)
+			icmpv6_echo_reply(skb);
 		break;
 
 	case ICMPV6_ECHO_REPLY:
@@ -1110,6 +1112,13 @@ static struct ctl_table ipv6_icmp_table_template[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_ms_jiffies,
 	},
+	{
+		.procname	= "echo_ignore_all",
+		.data		= &init_net.ipv6.sysctl.icmpv6_echo_ignore_all,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler = proc_dointvec,
+	},
 	{ },
 };
 
@@ -1121,9 +1130,10 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
 			sizeof(ipv6_icmp_table_template),
 			GFP_KERNEL);
 
-	if (table)
+	if (table) {
 		table[0].data = &net->ipv6.sysctl.icmpv6_time;
-
+		table[1].data = &net->ipv6.sysctl.icmpv6_echo_ignore_all;
+	}
 	return table;
 }
 #endif
-- 
2.7.4

