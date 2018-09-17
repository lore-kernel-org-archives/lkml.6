Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF6BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E8C2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E8C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeIREeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIREeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:10 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 596CDC49;
        Mon, 17 Sep 2018 23:04:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 095/126] inet: frags: Convert timers to use timer_setup()
Date:   Tue, 18 Sep 2018 00:42:23 +0200
Message-Id: <20180917211710.179209058@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Florian Westphal <fw@strlen.de>
Cc: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com> # for ieee802154
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 78802011fbe34331bdef6f2dfb1634011f0e4c32)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h                 |    2 +-
 net/ieee802154/6lowpan/reassembly.c     |    5 +++--
 net/ipv4/inet_fragment.c                |    4 ++--
 net/ipv4/ip_fragment.c                  |    5 +++--
 net/ipv6/netfilter/nf_conntrack_reasm.c |    5 +++--
 net/ipv6/reassembly.c                   |    5 +++--
 6 files changed, 15 insertions(+), 11 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -97,7 +97,7 @@ struct inet_frags {
 	void			(*constructor)(struct inet_frag_queue *q,
 					       const void *arg);
 	void			(*destructor)(struct inet_frag_queue *);
-	void			(*frag_expire)(unsigned long data);
+	void			(*frag_expire)(struct timer_list *t);
 	struct kmem_cache	*frags_cachep;
 	const char		*frags_cache_name;
 };
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -80,12 +80,13 @@ static void lowpan_frag_init(struct inet
 	fq->daddr = *arg->dst;
 }
 
-static void lowpan_frag_expire(unsigned long data)
+static void lowpan_frag_expire(struct timer_list *t)
 {
+	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
 	struct net *net;
 
-	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
+	fq = container_of(frag, struct frag_queue, q);
 	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
 
 	spin_lock(&fq->q.lock);
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -150,7 +150,7 @@ inet_evict_bucket(struct inet_frags *f,
 	spin_unlock(&hb->chain_lock);
 
 	hlist_for_each_entry_safe(fq, n, &expired, list_evictor)
-		f->frag_expire((unsigned long) fq);
+		f->frag_expire(&fq->timer);
 
 	return evicted;
 }
@@ -367,7 +367,7 @@ static struct inet_frag_queue *inet_frag
 	f->constructor(q, arg);
 	add_frag_mem_limit(nf, f->qsize);
 
-	setup_timer(&q->timer, f->frag_expire, (unsigned long)q);
+	timer_setup(&q->timer, f->frag_expire, 0);
 	spin_lock_init(&q->lock);
 	refcount_set(&q->refcnt, 1);
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -191,12 +191,13 @@ static bool frag_expire_skip_icmp(u32 us
 /*
  * Oops, a fragment queue timed out.  Kill it and send an ICMP reply.
  */
-static void ip_expire(unsigned long arg)
+static void ip_expire(struct timer_list *t)
 {
+	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct ipq *qp;
 	struct net *net;
 
-	qp = container_of((struct inet_frag_queue *) arg, struct ipq, q);
+	qp = container_of(frag, struct ipq, q);
 	net = container_of(qp->q.net, struct net, ipv4.frags);
 
 	rcu_read_lock();
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -169,12 +169,13 @@ static unsigned int nf_hashfn(const stru
 	return nf_hash_frag(nq->id, &nq->saddr, &nq->daddr);
 }
 
-static void nf_ct_frag6_expire(unsigned long data)
+static void nf_ct_frag6_expire(struct timer_list *t)
 {
+	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
 	struct net *net;
 
-	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
+	fq = container_of(frag, struct frag_queue, q);
 	net = container_of(fq->q.net, struct net, nf_frag.frags);
 
 	ip6_expire_frag_queue(net, fq);
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -169,12 +169,13 @@ out:
 }
 EXPORT_SYMBOL(ip6_expire_frag_queue);
 
-static void ip6_frag_expire(unsigned long data)
+static void ip6_frag_expire(struct timer_list *t)
 {
+	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
 	struct net *net;
 
-	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
+	fq = container_of(frag, struct frag_queue, q);
 	net = container_of(fq->q.net, struct net, ipv6.frags);
 
 	ip6_expire_frag_queue(net, fq);


