Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118ADC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKkrwue4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA6A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJKGhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeJKGhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:39 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2887B2151D;
        Wed, 10 Oct 2018 23:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213197;
        bh=/y6rjuESR9/1NFGpG+cWY1tsZd1Yqz9EOGSiAg3O0Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKkrwue4wjPgxCgZ4rdv/Q0TjKQUhxyIF30naY2VMovkkSrZDal8Lx+rKXnnFDOb0
         f8xwiI7UrodVc8S9MAvOCR1yaWPXAVRCRfjULaPIHMFJEPg3V8DMcK4VVTmA8uiDea
         442ciZ1DsUNUhyw4UGCMTtZdmZpEk8IMPlcCOg50=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 15/30] net: Prepare [un]lock_sock_fast() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:02 +0200
Message-Id: <1539213137-13953-16-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of spin_lock_bh() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		lock_sock_fast(&bh2) {
			*bh2 = spin_lock_bh(...)
		}
		...
		unlock_sock_fast(bh2) {
			spin_unlock_bh(bh2, ...);
		}
	local_bh_enable(bh);

To prepare for that, make lock_sock_fast() able to return a saved vector
enabled mask and pass it back to unlock_sock_fast(). We'll plug it to
spin_lock_bh() in a subsequent patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/net/sock.h  |  5 +++--
 net/core/datagram.c |  5 +++--
 net/core/sock.c     |  2 +-
 net/ipv4/tcp.c      | 10 ++++++----
 net/ipv4/udp.c      | 11 +++++++----
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 433f45f..7bba619 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1500,7 +1500,7 @@ void release_sock(struct sock *sk);
 				SINGLE_DEPTH_NESTING)
 #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
 
-bool lock_sock_fast(struct sock *sk);
+bool lock_sock_fast(struct sock *sk, unsigned int *bh);
 /**
  * unlock_sock_fast - complement of lock_sock_fast
  * @sk: socket
@@ -1509,7 +1509,8 @@ bool lock_sock_fast(struct sock *sk);
  * fast unlock socket for user context.
  * If slow mode is on, we call regular release_sock()
  */
-static inline void unlock_sock_fast(struct sock *sk, bool slow)
+static inline void unlock_sock_fast(struct sock *sk, bool slow,
+				    unsigned int bh)
 {
 	if (slow)
 		release_sock(sk);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 9aac0d6..0cdee87 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -334,17 +334,18 @@ EXPORT_SYMBOL(skb_free_datagram);
 void __skb_free_datagram_locked(struct sock *sk, struct sk_buff *skb, int len)
 {
 	bool slow;
+	unsigned int bh;
 
 	if (!skb_unref(skb)) {
 		sk_peek_offset_bwd(sk, len);
 		return;
 	}
 
-	slow = lock_sock_fast(sk);
+	slow = lock_sock_fast(sk, &bh);
 	sk_peek_offset_bwd(sk, len);
 	skb_orphan(skb);
 	sk_mem_reclaim_partial(sk);
-	unlock_sock_fast(sk, slow);
+	unlock_sock_fast(sk, slow, bh);
 
 	/* skb is now orphaned, can be freed outside of locked section */
 	__kfree_skb(skb);
diff --git a/net/core/sock.c b/net/core/sock.c
index 3730eb8..b886b86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2874,7 +2874,7 @@ EXPORT_SYMBOL(release_sock);
  *
  *   sk_lock.slock unlocked, owned = 1, BH enabled
  */
-bool lock_sock_fast(struct sock *sk)
+bool lock_sock_fast(struct sock *sk, unsigned int *bh)
 {
 	might_sleep();
 	spin_lock_bh(&sk->sk_lock.slock);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index dfd9bae..31b391a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -605,6 +605,7 @@ EXPORT_SYMBOL(tcp_poll);
 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	unsigned int bh;
 	int answ;
 	bool slow;
 
@@ -613,9 +614,9 @@ int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 		if (sk->sk_state == TCP_LISTEN)
 			return -EINVAL;
 
-		slow = lock_sock_fast(sk);
+		slow = lock_sock_fast(sk, &bh);
 		answ = tcp_inq(sk);
-		unlock_sock_fast(sk, slow);
+		unlock_sock_fast(sk, slow, bh);
 		break;
 	case SIOCATMARK:
 		answ = tp->urg_data && tp->urg_seq == tp->copied_seq;
@@ -3101,6 +3102,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 {
 	const struct tcp_sock *tp = tcp_sk(sk); /* iff sk_type == SOCK_STREAM */
 	const struct inet_connection_sock *icsk = inet_csk(sk);
+	unsigned int bh;
 	u32 now;
 	u64 rate64;
 	bool slow;
@@ -3134,7 +3136,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		return;
 	}
 
-	slow = lock_sock_fast(sk);
+	slow = lock_sock_fast(sk, &bh);
 
 	info->tcpi_ca_state = icsk->icsk_ca_state;
 	info->tcpi_retransmits = icsk->icsk_retransmits;
@@ -3208,7 +3210,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	info->tcpi_bytes_retrans = tp->bytes_retrans;
 	info->tcpi_dsack_dups = tp->dsack_dups;
 	info->tcpi_reord_seen = tp->reord_seen;
-	unlock_sock_fast(sk, slow);
+	unlock_sock_fast(sk, slow, bh);
 }
 EXPORT_SYMBOL_GPL(tcp_get_info);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7d69dd6..8148896 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1452,11 +1452,13 @@ EXPORT_SYMBOL_GPL(udp_init_sock);
 
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 {
+	unsigned int bh;
+
 	if (unlikely(READ_ONCE(sk->sk_peek_off) >= 0)) {
-		bool slow = lock_sock_fast(sk);
+		bool slow = lock_sock_fast(sk, &bh);
 
 		sk_peek_offset_bwd(sk, len);
-		unlock_sock_fast(sk, slow);
+		unlock_sock_fast(sk, slow, bh);
 	}
 
 	if (!skb_unref(skb))
@@ -2378,10 +2380,11 @@ int udp_rcv(struct sk_buff *skb)
 
 void udp_destroy_sock(struct sock *sk)
 {
+	unsigned int bh;
 	struct udp_sock *up = udp_sk(sk);
-	bool slow = lock_sock_fast(sk);
+	bool slow = lock_sock_fast(sk, &bh);
 	udp_flush_pending_frames(sk);
-	unlock_sock_fast(sk, slow);
+	unlock_sock_fast(sk, slow, bh);
 	if (static_branch_unlikely(&udp_encap_needed_key) && up->encap_type) {
 		void (*encap_destroy)(struct sock *sk);
 		encap_destroy = READ_ONCE(up->encap_destroy);
-- 
2.7.4

