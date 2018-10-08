Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA581C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF69214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMzfVQec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF69214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeJIB5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeJIB5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A9F2064A;
        Mon,  8 Oct 2018 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024235;
        bh=X2M3bZdz7niHdOtli2AwivK2oLJd0zsyUn0U1mLF9Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMzfVQecdKOhUamU+4hb/tDtr+M3H/QbGPAxFABhSpKOotwUi3ZyHsyKmWK5umW3f
         emIJ7dX9hlqdbgh8f8ViF7ubJlOgl70HfPDAvXVzNh4oZOPHqkyZGHALDFpvWUw5Wp
         2XJ4k6NfZyUMVqEC+ZEbrgNd4alvXp483K9rNa18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 67/94] netfilter: conntrack: timeout interface depend on CONFIG_NF_CONNTRACK_TIMEOUT
Date:   Mon,  8 Oct 2018 20:31:48 +0200
Message-Id: <20181008175609.702158438@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a874752a10da113f513980e28f562d946d3f829d ]

Now that cttimeout support for nft_ct is in place, these should depend
on CONFIG_NF_CONNTRACK_TIMEOUT otherwise we can crash when dumping the
policy if this option is not enabled.

[   71.600121] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[...]
[   71.600141] CPU: 3 PID: 7612 Comm: nft Not tainted 4.18.0+ #246
[...]
[   71.600188] Call Trace:
[   71.600201]  ? nft_ct_timeout_obj_dump+0xc6/0xf0 [nft_ct]

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/netfilter/nf_conntrack_proto_icmp.c   |    8 ++++----
 net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c |    8 ++++----
 net/netfilter/nf_conntrack_proto_dccp.c        |   12 ++++++------
 net/netfilter/nf_conntrack_proto_generic.c     |    8 ++++----
 net/netfilter/nf_conntrack_proto_gre.c         |    8 ++++----
 net/netfilter/nf_conntrack_proto_sctp.c        |   14 +++++++-------
 net/netfilter/nf_conntrack_proto_tcp.c         |   12 ++++++------
 net/netfilter/nf_conntrack_proto_udp.c         |   20 ++++++++++----------
 8 files changed, 45 insertions(+), 45 deletions(-)

--- a/net/ipv4/netfilter/nf_conntrack_proto_icmp.c
+++ b/net/ipv4/netfilter/nf_conntrack_proto_icmp.c
@@ -265,7 +265,7 @@ static int icmp_nlattr_tuple_size(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -303,7 +303,7 @@ static const struct nla_policy
 icmp_timeout_nla_policy[CTA_TIMEOUT_ICMP_MAX+1] = {
 	[CTA_TIMEOUT_ICMP_TIMEOUT]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table icmp_sysctl_table[] = {
@@ -365,7 +365,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_to_tuple	= icmp_nlattr_to_tuple,
 	.nla_policy		= icmp_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= icmp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= icmp_timeout_obj_to_nlattr,
@@ -373,7 +373,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int),
 		.nla_policy	= icmp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= icmp_init_net,
 	.get_net_proto		= icmp_get_net_proto,
 };
--- a/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
@@ -264,7 +264,7 @@ static int icmpv6_nlattr_tuple_size(void
 }
 #endif
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -302,7 +302,7 @@ static const struct nla_policy
 icmpv6_timeout_nla_policy[CTA_TIMEOUT_ICMPV6_MAX+1] = {
 	[CTA_TIMEOUT_ICMPV6_TIMEOUT]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table icmpv6_sysctl_table[] = {
@@ -362,7 +362,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_to_tuple	= icmpv6_nlattr_to_tuple,
 	.nla_policy		= icmpv6_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= icmpv6_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= icmpv6_timeout_obj_to_nlattr,
@@ -370,7 +370,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int),
 		.nla_policy	= icmpv6_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= icmpv6_init_net,
 	.get_net_proto		= icmpv6_get_net_proto,
 };
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -709,7 +709,7 @@ static int dccp_nlattr_size(void)
 
 #endif
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -760,7 +760,7 @@ dccp_timeout_nla_policy[CTA_TIMEOUT_DCCP
 	[CTA_TIMEOUT_DCCP_CLOSING]	= { .type = NLA_U32 },
 	[CTA_TIMEOUT_DCCP_TIMEWAIT]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_SYSCTL
 /* template, data assigned later */
@@ -893,7 +893,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_to_tuple	= nf_ct_port_nlattr_to_tuple,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= dccp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= dccp_timeout_obj_to_nlattr,
@@ -901,7 +901,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * CT_DCCP_MAX,
 		.nla_policy	= dccp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= dccp_init_net,
 	.get_net_proto		= dccp_get_net_proto,
 };
@@ -929,7 +929,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_to_tuple	= nf_ct_port_nlattr_to_tuple,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= dccp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= dccp_timeout_obj_to_nlattr,
@@ -937,7 +937,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * CT_DCCP_MAX,
 		.nla_policy	= dccp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= dccp_init_net,
 	.get_net_proto		= dccp_get_net_proto,
 };
--- a/net/netfilter/nf_conntrack_proto_generic.c
+++ b/net/netfilter/nf_conntrack_proto_generic.c
@@ -80,7 +80,7 @@ static bool generic_new(struct nf_conn *
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -120,7 +120,7 @@ static const struct nla_policy
 generic_timeout_nla_policy[CTA_TIMEOUT_GENERIC_MAX+1] = {
 	[CTA_TIMEOUT_GENERIC_TIMEOUT]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table generic_sysctl_table[] = {
@@ -173,7 +173,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.packet			= generic_packet,
 	.get_timeouts		= generic_get_timeouts,
 	.new			= generic_new,
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= generic_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= generic_timeout_obj_to_nlattr,
@@ -181,7 +181,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int),
 		.nla_policy	= generic_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= generic_init_net,
 	.get_net_proto		= generic_get_net_proto,
 };
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -290,7 +290,7 @@ static void gre_destroy(struct nf_conn *
 		nf_ct_gre_keymap_destroy(master);
 }
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -337,7 +337,7 @@ gre_timeout_nla_policy[CTA_TIMEOUT_GRE_M
 	[CTA_TIMEOUT_GRE_UNREPLIED]	= { .type = NLA_U32 },
 	[CTA_TIMEOUT_GRE_REPLIED]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 static int gre_init_net(struct net *net, u_int16_t proto)
 {
@@ -372,7 +372,7 @@ static struct nf_conntrack_l4proto nf_co
 	.nlattr_to_tuple = nf_ct_port_nlattr_to_tuple,
 	.nla_policy	 = nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout    = {
 		.nlattr_to_obj	= gre_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= gre_timeout_obj_to_nlattr,
@@ -380,7 +380,7 @@ static struct nf_conntrack_l4proto nf_co
 		.obj_size	= sizeof(unsigned int) * GRE_CT_MAX,
 		.nla_policy	= gre_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.net_id		= &proto_gre_net_id,
 	.init_net	= gre_init_net,
 };
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -618,7 +618,7 @@ static int sctp_nlattr_size(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -671,7 +671,7 @@ sctp_timeout_nla_policy[CTA_TIMEOUT_SCTP
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_SENT]	= { .type = NLA_U32 },
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_ACKED]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 
 #ifdef CONFIG_SYSCTL
@@ -803,7 +803,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_to_tuple	= nf_ct_port_nlattr_to_tuple,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= sctp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= sctp_timeout_obj_to_nlattr,
@@ -811,7 +811,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * SCTP_CONNTRACK_MAX,
 		.nla_policy	= sctp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= sctp_init_net,
 	.get_net_proto		= sctp_get_net_proto,
 };
@@ -839,7 +839,8 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= nf_ct_port_nlattr_tuple_size,
 	.nlattr_to_tuple	= nf_ct_port_nlattr_to_tuple,
 	.nla_policy		= nf_ct_port_nla_policy,
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#endif
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= sctp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= sctp_timeout_obj_to_nlattr,
@@ -847,8 +848,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * SCTP_CONNTRACK_MAX,
 		.nla_policy	= sctp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
-#endif
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= sctp_init_net,
 	.get_net_proto		= sctp_get_net_proto,
 };
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1294,7 +1294,7 @@ static int tcp_nlattr_tuple_size(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -1404,7 +1404,7 @@ static const struct nla_policy tcp_timeo
 	[CTA_TIMEOUT_TCP_RETRANS]	= { .type = NLA_U32 },
 	[CTA_TIMEOUT_TCP_UNACK]		= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table tcp_sysctl_table[] = {
@@ -1567,7 +1567,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= tcp_nlattr_tuple_size,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= tcp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= tcp_timeout_obj_to_nlattr,
@@ -1576,7 +1576,7 @@ struct nf_conntrack_l4proto nf_conntrack
 					TCP_CONNTRACK_TIMEOUT_MAX,
 		.nla_policy	= tcp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= tcp_init_net,
 	.get_net_proto		= tcp_get_net_proto,
 };
@@ -1605,7 +1605,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= tcp_nlattr_tuple_size,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= tcp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= tcp_timeout_obj_to_nlattr,
@@ -1614,7 +1614,7 @@ struct nf_conntrack_l4proto nf_conntrack
 					TCP_CONNTRACK_TIMEOUT_MAX,
 		.nla_policy	= tcp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= tcp_init_net,
 	.get_net_proto		= tcp_get_net_proto,
 };
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -195,7 +195,7 @@ static int udp_error(struct net *net, st
 	return NF_ACCEPT;
 }
 
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -242,7 +242,7 @@ udp_timeout_nla_policy[CTA_TIMEOUT_UDP_M
        [CTA_TIMEOUT_UDP_UNREPLIED]	= { .type = NLA_U32 },
        [CTA_TIMEOUT_UDP_REPLIED]	= { .type = NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table udp_sysctl_table[] = {
@@ -316,7 +316,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= nf_ct_port_nlattr_tuple_size,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= udp_timeout_obj_to_nlattr,
@@ -324,7 +324,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	= udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= udp_init_net,
 	.get_net_proto		= udp_get_net_proto,
 };
@@ -348,7 +348,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= nf_ct_port_nlattr_tuple_size,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= udp_timeout_obj_to_nlattr,
@@ -356,7 +356,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	= udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= udp_init_net,
 	.get_net_proto		= udp_get_net_proto,
 };
@@ -380,7 +380,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= nf_ct_port_nlattr_tuple_size,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= udp_timeout_obj_to_nlattr,
@@ -388,7 +388,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	= udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= udp_init_net,
 	.get_net_proto		= udp_get_net_proto,
 };
@@ -412,7 +412,7 @@ struct nf_conntrack_l4proto nf_conntrack
 	.nlattr_tuple_size	= nf_ct_port_nlattr_tuple_size,
 	.nla_policy		= nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	= udp_timeout_obj_to_nlattr,
@@ -420,7 +420,7 @@ struct nf_conntrack_l4proto nf_conntrack
 		.obj_size	= sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	= udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		= udp_init_net,
 	.get_net_proto		= udp_get_net_proto,
 };


