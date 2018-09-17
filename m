Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74248ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A52146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373A52146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbeIREeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIREeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:00 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BD6CC03;
        Mon, 17 Sep 2018 23:04:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 092/126] inet: frags: change inet_frags_init_net() return value
Date:   Tue, 18 Sep 2018 00:42:20 +0200
Message-Id: <20180917211710.018517713@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

We will soon initialize one rhashtable per struct netns_frags
in inet_frags_init_net().

This patch changes the return value to eventually propagate an
error.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 787bea7748a76130566f881c2342a0be4127d182)
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
@@ -104,9 +104,10 @@ struct inet_frags {
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
@@ -850,6 +850,8 @@ static void __init ip4_frags_ctl_registe
 
 static int __net_init ipv4_frags_init_net(struct net *net)
 {
+	int res;
+
 	/* Fragment cache limits.
 	 *
 	 * The fragment memory accounting code, (tries to) account for
@@ -875,9 +877,13 @@ static int __net_init ipv4_frags_init_ne
 
 	net->ipv4.frags.max_dist = 64;
 
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
@@ -630,12 +630,18 @@ EXPORT_SYMBOL_GPL(nf_ct_frag6_gather);
 
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
@@ -714,13 +714,20 @@ static void ip6_frags_sysctl_unregister(
 
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


