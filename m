Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A08BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED80E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cycruSSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED80E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJKGiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJKGiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:02 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CA52098A;
        Wed, 10 Oct 2018 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213220;
        bh=J32Vcu8w0O+q+nniXZLdRpIQODd2lArfnVlR9GBzVnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cycruSSrI8+21z8pCJ0777jxjw7G+a+0aIQfh2rKze5BLwb+X34/88gjpRKip14Xh
         Kv1sgnWF5Al59MzYbIimvXt5vauOBMS9ueRA3r7/yyvwsnO5xNw/vjChrRs6If18M6
         nY2tUsc2CWuYYRpYdf1TeYkjCC41K/cs4kJn/NXM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 22/30] seqlock: Prepare write_seq[un]lock_bh() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:09 +0200
Message-Id: <1539213137-13953-23-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

This pair of function is implemented on top of spin_[un]lock_bh() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh2 = write_seqlock_bh(...) {
			return spin_lock_bh(...);
		}
		...
		write_sequnlock_bh(..., bh2) {
			spin_unlock_bh(..., bh2);
		}
	local_bh_enable(bh);

To prepare for that, make write_seqlock_bh() able to return a saved
vector enabled mask and pass it back to write_sequnlock_bh(). Then plug
the whole with spin_[un]lock_bh().

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/seqlock.h    | 21 +++++++++++++--------
 net/core/neighbour.c       |  5 +++--
 net/ipv4/inetpeer.c        |  5 +++--
 net/ipv4/sysctl_net_ipv4.c |  5 +++--
 net/ipv4/tcp_metrics.c     |  5 +++--
 net/rxrpc/conn_service.c   |  4 ++--
 6 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index c22e19c..720e6e0 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -455,16 +455,19 @@ static inline void write_sequnlock(seqlock_t *sl)
 	spin_unlock(&sl->lock);
 }
 
-static inline void write_seqlock_bh(seqlock_t *sl)
+static inline unsigned int write_seqlock_bh(seqlock_t *sl, unsigned int mask)
 {
-	spin_lock_bh(&sl->lock, SOFTIRQ_ALL_MASK);
+	unsigned int bh;
+	bh = spin_lock_bh(&sl->lock, mask);
 	write_seqcount_begin(&sl->seqcount);
+	return bh;
 }
 
-static inline void write_sequnlock_bh(seqlock_t *sl)
+static inline void write_sequnlock_bh(seqlock_t *sl,
+				      unsigned int bh)
 {
 	write_seqcount_end(&sl->seqcount);
-	spin_unlock_bh(&sl->lock, 0);
+	spin_unlock_bh(&sl->lock, bh);
 }
 
 static inline void write_seqlock_irq(seqlock_t *sl)
@@ -542,14 +545,16 @@ static inline void done_seqretry(seqlock_t *lock, int seq)
 		read_sequnlock_excl(lock);
 }
 
-static inline void read_seqlock_excl_bh(seqlock_t *sl)
+static inline unsigned int read_seqlock_excl_bh(seqlock_t *sl,
+						unsigned int mask)
 {
-	spin_lock_bh(&sl->lock, SOFTIRQ_ALL_MASK);
+	return spin_lock_bh(&sl->lock, mask);
 }
 
-static inline void read_sequnlock_excl_bh(seqlock_t *sl)
+static inline void read_sequnlock_excl_bh(seqlock_t *sl,
+					  unsigned int bh)
 {
-	spin_unlock_bh(&sl->lock, 0);
+	spin_unlock_bh(&sl->lock, bh);
 }
 
 static inline void read_seqlock_excl_irq(seqlock_t *sl)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ec55470..733449e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1083,6 +1083,7 @@ EXPORT_SYMBOL(__neigh_event_send);
 static void neigh_update_hhs(struct neighbour *neigh)
 {
 	struct hh_cache *hh;
+	unsigned int bh;
 	void (*update)(struct hh_cache*, const struct net_device*, const unsigned char *)
 		= NULL;
 
@@ -1092,9 +1093,9 @@ static void neigh_update_hhs(struct neighbour *neigh)
 	if (update) {
 		hh = &neigh->hh;
 		if (hh->hh_len) {
-			write_seqlock_bh(&hh->hh_lock);
+			bh = write_seqlock_bh(&hh->hh_lock, SOFTIRQ_ALL_MASK);
 			update(hh, neigh->dev, neigh->ha);
-			write_sequnlock_bh(&hh->hh_lock);
+			write_sequnlock_bh(&hh->hh_lock, bh);
 		}
 	}
 }
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index d757b96..224d30e 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -182,6 +182,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	struct rb_node **pp, *parent;
 	unsigned int gc_cnt, seq;
 	int invalidated;
+	unsigned int bh;
 
 	/* Attempt a lockless lookup first.
 	 * Because of a concurrent writer, we might not find an existing entry.
@@ -203,7 +204,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	 * At least, nodes should be hot in our cache.
 	 */
 	parent = NULL;
-	write_seqlock_bh(&base->lock);
+	bh = write_seqlock_bh(&base->lock, SOFTIRQ_ALL_MASK);
 
 	gc_cnt = 0;
 	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
@@ -228,7 +229,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	}
 	if (gc_cnt)
 		inet_peer_gc(base, gc_stack, gc_cnt);
-	write_sequnlock_bh(&base->lock);
+	write_sequnlock_bh(&base->lock, bh);
 
 	return p;
 }
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index b92f422..b6d1d52 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -56,15 +56,16 @@ static int sysctl_tcp_low_latency __read_mostly;
 static void set_local_port_range(struct net *net, int range[2])
 {
 	bool same_parity = !((range[0] ^ range[1]) & 1);
+	unsigned int bh;
 
-	write_seqlock_bh(&net->ipv4.ip_local_ports.lock);
+	bh = write_seqlock_bh(&net->ipv4.ip_local_ports.lock, SOFTIRQ_ALL_MASK);
 	if (same_parity && !net->ipv4.ip_local_ports.warned) {
 		net->ipv4.ip_local_ports.warned = true;
 		pr_err_ratelimited("ip_local_port_range: prefer different parity for start/end values.\n");
 	}
 	net->ipv4.ip_local_ports.range[0] = range[0];
 	net->ipv4.ip_local_ports.range[1] = range[1];
-	write_sequnlock_bh(&net->ipv4.ip_local_ports.lock);
+	write_sequnlock_bh(&net->ipv4.ip_local_ports.lock, bh);
 }
 
 /* Validate changes from /proc interface. */
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index fd6ba88..c65d499 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -574,6 +574,7 @@ void tcp_fastopen_cache_set(struct sock *sk, u16 mss,
 			    u16 try_exp)
 {
 	struct dst_entry *dst = __sk_dst_get(sk);
+	unsigned int bh;
 	struct tcp_metrics_block *tm;
 
 	if (!dst)
@@ -583,7 +584,7 @@ void tcp_fastopen_cache_set(struct sock *sk, u16 mss,
 	if (tm) {
 		struct tcp_fastopen_metrics *tfom = &tm->tcpm_fastopen;
 
-		write_seqlock_bh(&fastopen_seqlock);
+		bh = write_seqlock_bh(&fastopen_seqlock, SOFTIRQ_ALL_MASK);
 		if (mss)
 			tfom->mss = mss;
 		if (cookie && cookie->len > 0)
@@ -596,7 +597,7 @@ void tcp_fastopen_cache_set(struct sock *sk, u16 mss,
 			tfom->last_syn_loss = jiffies;
 		} else
 			tfom->syn_loss = 0;
-		write_sequnlock_bh(&fastopen_seqlock);
+		write_sequnlock_bh(&fastopen_seqlock, bh);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 80773a5..e253cd9 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -71,7 +71,7 @@ static void rxrpc_publish_service_conn(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k = conn->proto;
 	struct rb_node **pp, *parent;
 
-	write_seqlock_bh(&peer->service_conn_lock);
+	write_seqlock_bh(&peer->service_conn_lock, SOFTIRQ_ALL_MASK);
 
 	pp = &peer->service_conns.rb_node;
 	parent = NULL;
@@ -191,7 +191,7 @@ void rxrpc_unpublish_service_conn(struct rxrpc_connection *conn)
 {
 	struct rxrpc_peer *peer = conn->params.peer;
 
-	write_seqlock_bh(&peer->service_conn_lock);
+	write_seqlock_bh(&peer->service_conn_lock, SOFTIRQ_ALL_MASK);
 	if (test_and_clear_bit(RXRPC_CONN_IN_SERVICE_CONNS, &conn->flags))
 		rb_erase(&conn->service_node, &peer->service_conns);
 	write_sequnlock_bh(&peer->service_conn_lock);
-- 
2.7.4

