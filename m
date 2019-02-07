Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2916C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB812190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539751;
	bh=voYghfDWK3zOmsLaBiOY/384Shx3baxqwZ6Al2fDdOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PX2nFJ8vYdTbxj7JGohXeHThjh+hEWqpWe4G5EEK0otp2QID/rkp1Xp/bsb9SUiwG
	 RhGNWnBV6zQK5D/tQU6Q2Oher0YpL0OF7H/0cyHnthZrjYSPm8KANhJU687LkE0m5d
	 AMgr+1lW+O+X7VSHK9kCFpMFm4uCmLdPqX1kpemc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGLma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGLm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B446221907;
        Thu,  7 Feb 2019 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539748;
        bh=voYghfDWK3zOmsLaBiOY/384Shx3baxqwZ6Al2fDdOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaVae5218YPDDtw7R+MKwX4aU7AXOM9X1DCU18qWk4pgebOEGssUu7Ioo09Q2Z2RZ
         2O1c5GeT8/iG+bCfXz4EjnLY5ON83n7K1/8GGftebAr59uCtWvn7rnmH8ad5GIyXk+
         gBuSvsWB2PFm+4f4cORBpkJ30ZH70EbJezjFn8yI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 01/34] inet: frags: change inet_frags_init_net() return value
Date:   Thu,  7 Feb 2019 12:41:43 +0100
Message-Id: <20190207113025.610460985@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 787bea7748a76130566f881c2342a0be4127d182 upstream.

We will soon initialize one rhashtable per struct netns_frags
in inet_frags_init_net().

This patch changes the return value to eventually propagate an
error.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h                 |    3 ++-
 net/ieee802154/6lowpan/reassembly.c     |   11 ++++++++---
 net/ipv4/ip_fragment.c                  |   12 +++++++++---
 net/ipv6/netfilter/nf_conntrack_reasm.c |   12 +++++++++---
 net/ipv6/reassembly.c                   |   11 +++++++++--
 5 files changed, 37 insertions(+), 12 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -103,9 +103,10 @@ struct inet_frags {
 int inet_frags_init(struct inet_frags *);
 void inet_frags_fini(struct inet_frags *);
 
-static inline void inet_frags_init_net(struct netns_frags *nf)
+static inline int inet_frags_init_net(struct netns_frags *nf)
 {
 	atomic_set(&nf->mem, 0);
+	return 0;
 }
 void inet_frags_exit_net(struct netns_frags *nf, struct inet_frags *f);
 
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -580,14 +580,19 @@ static int __net_init lowpan_frags_init_
 {
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
+	int res;
 
 	ieee802154_lowpan->frags.high_thresh = IPV6_FRAG_HIGH_THRESH;
 	ieee802154_lowpan->frags.low_thresh = IPV6_FRAG_LOW_THRESH;
 	ieee802154_lowpan->frags.timeout = IPV6_FRAG_TIMEOUT;
 
-	inet_frags_init_net(&ieee802154_lowpan->frags);
-
-	return lowpan_frags_ns_sysctl_register(net);
+	res = inet_frags_init_net(&ieee802154_lowpan->frags);
+	if (res < 0)
+		return res;
+	res = lowpan_frags_ns_sysctl_register(net);
+	if (res < 0)
+		inet_frags_exit_net(&ieee802154_lowpan->frags, &lowpan_frags);
+	return res;
 }
 
 static void __net_exit lowpan_frags_exit_net(struct net *net)
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -853,6 +853,8 @@ static void __init ip4_frags_ctl_registe
 
 static int __net_init ipv4_frags_init_net(struct net *net)
 {
+	int res;
+
 	/* Fragment cache limits.
 	 *
 	 * The fragment memory accounting code, (tries to) account for
@@ -876,9 +878,13 @@ static int __net_init ipv4_frags_init_ne
 	 */
 	net->ipv4.frags.timeout = IP_FRAG_TIME;
 
-	inet_frags_init_net(&net->ipv4.frags);
-
-	return ip4_frags_ns_ctl_register(net);
+	res = inet_frags_init_net(&net->ipv4.frags);
+	if (res < 0)
+		return res;
+	res = ip4_frags_ns_ctl_register(net);
+	if (res < 0)
+		inet_frags_exit_net(&net->ipv4.frags, &ip4_frags);
+	return res;
 }
 
 static void __net_exit ipv4_frags_exit_net(struct net *net)
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -650,12 +650,18 @@ EXPORT_SYMBOL_GPL(nf_ct_frag6_consume_or
 
 static int nf_ct_net_init(struct net *net)
 {
+	int res;
+
 	net->nf_frag.frags.high_thresh = IPV6_FRAG_HIGH_THRESH;
 	net->nf_frag.frags.low_thresh = IPV6_FRAG_LOW_THRESH;
 	net->nf_frag.frags.timeout = IPV6_FRAG_TIMEOUT;
-	inet_frags_init_net(&net->nf_frag.frags);
-
-	return nf_ct_frag6_sysctl_register(net);
+	res = inet_frags_init_net(&net->nf_frag.frags);
+	if (res < 0)
+		return res;
+	res = nf_ct_frag6_sysctl_register(net);
+	if (res < 0)
+		inet_frags_exit_net(&net->nf_frag.frags, &nf_frags);
+	return res;
 }
 
 static void nf_ct_net_exit(struct net *net)
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -708,13 +708,20 @@ static void ip6_frags_sysctl_unregister(
 
 static int __net_init ipv6_frags_init_net(struct net *net)
 {
+	int res;
+
 	net->ipv6.frags.high_thresh = IPV6_FRAG_HIGH_THRESH;
 	net->ipv6.frags.low_thresh = IPV6_FRAG_LOW_THRESH;
 	net->ipv6.frags.timeout = IPV6_FRAG_TIMEOUT;
 
-	inet_frags_init_net(&net->ipv6.frags);
+	res = inet_frags_init_net(&net->ipv6.frags);
+	if (res < 0)
+		return res;
 
-	return ip6_frags_ns_sysctl_register(net);
+	res = ip6_frags_ns_sysctl_register(net);
+	if (res < 0)
+		inet_frags_exit_net(&net->ipv6.frags, &ip6_frags);
+	return res;
 }
 
 static void __net_exit ipv6_frags_exit_net(struct net *net)


