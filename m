Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47699C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F520216FA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F520216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeHZK12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:27:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHZK12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:27:28 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6FEB9D2;
        Sun, 26 Aug 2018 06:45:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 16/56] netfilter: ipv6: nf_defrag: reduce struct net memory waste
Date:   Sun, 26 Aug 2018 08:44:37 +0200
Message-Id: <20180826064233.149416654@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9ce7bc036ae4cfe3393232c86e9e1fea2153c237 ]

It is a waste of memory to use a full "struct netns_sysctl_ipv6"
while only one pointer is really used, considering netns_sysctl_ipv6
keeps growing.

Also, since "struct netns_frags" has cache line alignment,
it is better to move the frags_hdr pointer outside, otherwise
we spend a full cache line for this pointer.

This saves 192 bytes of memory per netns.

Fixes: c038a767cd69 ("ipv6: add a new namespace for nf_conntrack_reasm")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/net_namespace.h             |    1 +
 include/net/netns/ipv6.h                |    1 -
 net/ipv6/netfilter/nf_conntrack_reasm.c |    6 +++---
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -112,6 +112,7 @@ struct net {
 #endif
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 	struct netns_nf_frag	nf_frag;
+	struct ctl_table_header *nf_frag_frags_hdr;
 #endif
 	struct sock		*nfnl;
 	struct sock		*nfnl_stash;
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -81,7 +81,6 @@ struct netns_ipv6 {
 
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 struct netns_nf_frag {
-	struct netns_sysctl_ipv6 sysctl;
 	struct netns_frags	frags;
 };
 #endif
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -118,7 +118,7 @@ static int nf_ct_frag6_sysctl_register(s
 	if (hdr == NULL)
 		goto err_reg;
 
-	net->nf_frag.sysctl.frags_hdr = hdr;
+	net->nf_frag_frags_hdr = hdr;
 	return 0;
 
 err_reg:
@@ -132,8 +132,8 @@ static void __net_exit nf_ct_frags6_sysc
 {
 	struct ctl_table *table;
 
-	table = net->nf_frag.sysctl.frags_hdr->ctl_table_arg;
-	unregister_net_sysctl_table(net->nf_frag.sysctl.frags_hdr);
+	table = net->nf_frag_frags_hdr->ctl_table_arg;
+	unregister_net_sysctl_table(net->nf_frag_frags_hdr);
 	if (!net_eq(net, &init_net))
 		kfree(table);
 }


