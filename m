Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952B5214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952B5214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeIREef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbeIREed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:33 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42C2EC7D;
        Mon, 17 Sep 2018 23:05:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 101/126] inet: frags: remove some helpers
Date:   Tue, 18 Sep 2018 00:42:29 +0200
Message-Id: <20180917211710.560505893@linuxfoundation.org>
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
@@ -141,11 +141,6 @@ static inline void add_frag_mem_limit(st
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
@@ -570,7 +570,6 @@ static inline struct sk_buff *ip_check_d
 	return skb;
 }
 #endif
-int ip_frag_mem(struct net *net);
 
 /*
  *	Functions provided by ip_forward.c
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -331,13 +331,6 @@ static inline bool ipv6_accept_ra(struct
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
@@ -83,11 +83,6 @@ static u8 ip4_frag_ecn(u8 tos)
 
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
 
 	orphans = percpu_counter_sum_positive(&tcp_orphan_count);
@@ -72,8 +71,9 @@ static int sockstat_seq_show(struct seq_
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
 


