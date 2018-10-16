Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA9621477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7IcnLb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA9621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbeJQBRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbeJQBRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE21521477;
        Tue, 16 Oct 2018 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710748;
        bh=EK/kRPcNE0SK6KHOrU7UoN+woW1sQU3xKzDeY0T5Nx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7IcnLb5eW3pYqcvGsgmUf4Nx/fktowqY8Q+5NGT7fJ1KbEFW2PN+yXQ/mt8F44SJ
         SXUPmXZe0F+Ab6y9WvCjlq28oXiSm6OP+Be5BW9rEotJLjNpKCiWhUq2gTli2sBOig
         vc/j3qne3JqkTuE224i7yuZogv05DN/TsThZ48lI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 51/71] inet: frags: remove some helpers
Date:   Tue, 16 Oct 2018 19:09:48 +0200
Message-Id: <20181016170541.925602774@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

Remove sum_frag_mem_limit(), ip_frag_mem() & ip6_frag_mem()

Also since we use rhashtable we can bring back the number of fragments
in "grep FRAG /proc/net/sockstat /proc/net/sockstat6" that was
removed in commit 434d305405ab ("inet: frag: don't account number
of fragment queues")

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 6befe4a78b1553edb6eed3a78b4bcd9748526672)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h |    5 -----
 include/net/ip.h        |    1 -
 include/net/ipv6.h      |    7 -------
 net/ipv4/ip_fragment.c  |    5 -----
 net/ipv4/proc.c         |    6 +++---
 net/ipv6/proc.c         |    5 +++--
 6 files changed, 6 insertions(+), 23 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -140,11 +140,6 @@ static inline void add_frag_mem_limit(st
 	atomic_add(i, &nf->mem);
 }
 
-static inline int sum_frag_mem_limit(struct netns_frags *nf)
-{
-	return atomic_read(&nf->mem);
-}
-
 /* RFC 3168 support :
  * We want to check ECN values of all fragments, do detect invalid combinations.
  * In ipq->ecn, we store the OR value of each ip4_frag_ecn() fragment value.
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -548,7 +548,6 @@ static inline struct sk_buff *ip_check_d
 	return skb;
 }
 #endif
-int ip_frag_mem(struct net *net);
 
 /*
  *	Functions provided by ip_forward.c
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -330,13 +330,6 @@ static inline bool ipv6_accept_ra(struct
 	    idev->cnf.accept_ra;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static inline int ip6_frag_mem(struct net *net)
-{
-	return sum_frag_mem_limit(&net->ipv6.frags);
-}
-#endif
-
 #define IPV6_FRAG_HIGH_THRESH	(4 * 1024*1024)	/* 4194304 */
 #define IPV6_FRAG_LOW_THRESH	(3 * 1024*1024)	/* 3145728 */
 #define IPV6_FRAG_TIMEOUT	(60 * HZ)	/* 60 seconds */
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -82,11 +82,6 @@ static u8 ip4_frag_ecn(u8 tos)
 
 static struct inet_frags ip4_frags;
 
-int ip_frag_mem(struct net *net)
-{
-	return sum_frag_mem_limit(&net->ipv4.frags);
-}
-
 static int ip_frag_reasm(struct ipq *qp, struct sk_buff *prev,
 			 struct net_device *dev);
 
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -54,7 +54,6 @@
 static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
 	struct net *net = seq->private;
-	unsigned int frag_mem;
 	int orphans, sockets;
 
 	local_bh_disable();
@@ -74,8 +73,9 @@ static int sockstat_seq_show(struct seq_
 		   sock_prot_inuse_get(net, &udplite_prot));
 	seq_printf(seq, "RAW: inuse %d\n",
 		   sock_prot_inuse_get(net, &raw_prot));
-	frag_mem = ip_frag_mem(net);
-	seq_printf(seq,  "FRAG: inuse %u memory %u\n", !!frag_mem, frag_mem);
+	seq_printf(seq,  "FRAG: inuse %u memory %u\n",
+		   atomic_read(&net->ipv4.frags.rhashtable.nelems),
+		   frag_mem_limit(&net->ipv4.frags));
 	return 0;
 }
 
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -38,7 +38,6 @@
 static int sockstat6_seq_show(struct seq_file *seq, void *v)
 {
 	struct net *net = seq->private;
-	unsigned int frag_mem = ip6_frag_mem(net);
 
 	seq_printf(seq, "TCP6: inuse %d\n",
 		       sock_prot_inuse_get(net, &tcpv6_prot));
@@ -48,7 +47,9 @@ static int sockstat6_seq_show(struct seq
 			sock_prot_inuse_get(net, &udplitev6_prot));
 	seq_printf(seq, "RAW6: inuse %d\n",
 		       sock_prot_inuse_get(net, &rawv6_prot));
-	seq_printf(seq, "FRAG6: inuse %u memory %u\n", !!frag_mem, frag_mem);
+	seq_printf(seq, "FRAG6: inuse %u memory %u\n",
+		   atomic_read(&net->ipv6.frags.rhashtable.nelems),
+		   frag_mem_limit(&net->ipv6.frags));
 	return 0;
 }
 


