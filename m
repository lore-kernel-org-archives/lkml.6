Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F4C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7C2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC7C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbeKLGFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53068 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731042AbeKLGFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:17 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt0-0000lF-2h; Sun, 11 Nov 2018 19:59:10 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Yy-N5; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.780526574@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 150/366] netfilter: ipv6: nf_defrag: reduce struct
 net memory waste
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 9ce7bc036ae4cfe3393232c86e9e1fea2153c237 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/net_namespace.h             | 1 +
 include/net/netns/ipv6.h                | 1 -
 net/ipv6/netfilter/nf_conntrack_reasm.c | 6 +++---
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
@@ -80,7 +80,6 @@ struct netns_ipv6 {
 
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 struct netns_nf_frag {
-	struct netns_sysctl_ipv6 sysctl;
 	struct netns_frags	frags;
 };
 #endif
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -109,7 +109,7 @@ static int nf_ct_frag6_sysctl_register(s
 	if (hdr == NULL)
 		goto err_reg;
 
-	net->nf_frag.sysctl.frags_hdr = hdr;
+	net->nf_frag_frags_hdr = hdr;
 	return 0;
 
 err_reg:
@@ -123,8 +123,8 @@ static void __net_exit nf_ct_frags6_sysc
 {
 	struct ctl_table *table;
 
-	table = net->nf_frag.sysctl.frags_hdr->ctl_table_arg;
-	unregister_net_sysctl_table(net->nf_frag.sysctl.frags_hdr);
+	table = net->nf_frag_frags_hdr->ctl_table_arg;
+	unregister_net_sysctl_table(net->nf_frag_frags_hdr);
 	if (!net_eq(net, &init_net))
 		kfree(table);
 }

