Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71192ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B6C214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B6C214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeIREel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbeIREek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:40 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 859F0C7D;
        Mon, 17 Sep 2018 23:05:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 103/126] inet: frags: remove inet_frag_maybe_warn_overflow()
Date:   Tue, 18 Sep 2018 00:42:31 +0200
Message-Id: <20180917211710.723255577@linuxfoundation.org>
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

This function is obsolete, after rhashtable addition to inet defrag.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 2d44ed22e607f9a285b049de2263e3840673a260)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h                 |    2 --
 net/ieee802154/6lowpan/reassembly.c     |    5 ++---
 net/ipv4/inet_fragment.c                |   11 -----------
 net/ipv4/ip_fragment.c                  |    5 ++---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    5 ++---
 net/ipv6/reassembly.c                   |    5 ++---
 6 files changed, 8 insertions(+), 25 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -110,8 +110,6 @@ void inet_frags_exit_net(struct netns_fr
 void inet_frag_kill(struct inet_frag_queue *q);
 void inet_frag_destroy(struct inet_frag_queue *q);
 struct inet_frag_queue *inet_frag_find(struct netns_frags *nf, void *key);
-void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
-				   const char *prefix);
 
 static inline void inet_frag_put(struct inet_frag_queue *q)
 {
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -84,10 +84,9 @@ fq_find(struct net *net, const struct lo
 	struct inet_frag_queue *q;
 
 	q = inet_frag_find(&ieee802154_lowpan->frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct lowpan_frag_queue, q);
 }
 
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -218,14 +218,3 @@ struct inet_frag_queue *inet_frag_find(s
 	return inet_frag_create(nf, key);
 }
 EXPORT_SYMBOL(inet_frag_find);
-
-void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
-				   const char *prefix)
-{
-	static const char msg[] = "inet_frag_find: Fragment hash bucket"
-		" list length grew over limit. Dropping fragment.\n";
-
-	if (PTR_ERR(q) == -ENOBUFS)
-		net_dbg_ratelimited("%s%s", prefix, msg);
-}
-EXPORT_SYMBOL(inet_frag_maybe_warn_overflow);
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -221,10 +221,9 @@ static struct ipq *ip_find(struct net *n
 	struct inet_frag_queue *q;
 
 	q = inet_frag_find(&net->ipv4.frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct ipq, q);
 }
 
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -178,10 +178,9 @@ static struct frag_queue *fq_find(struct
 	struct inet_frag_queue *q;
 
 	q = inet_frag_find(&net->nf_frag.frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct frag_queue, q);
 }
 
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -155,10 +155,9 @@ fq_find(struct net *net, __be32 id, cons
 		key.iif = 0;
 
 	q = inet_frag_find(&net->ipv6.frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct frag_queue, q);
 }
 


