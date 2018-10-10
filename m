Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC1C46463
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8814A21526
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/ZWwkRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8814A21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJKGhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeJKGhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:33 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E26920870;
        Wed, 10 Oct 2018 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213191;
        bh=16HZM3xmj3k75vePkaiRGPwlykP1aFYZNw+wOVgg0j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/ZWwkRNsuuEROu2t7vy4nWvi4B2R/loDYM6kefSCayLu1fKVwWn44Jhs0MTJfdZN
         CGERYGzN36JzdaPIAIFaHdP/NdO4TLKvgrdLekzIQ5CU39/qhpF624J93AxKZ7qIjk
         zc/xZ9xeQ3AuK1HqjtC1HHU89QiKGy7pCcum7JyM=
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
Subject: [RFC PATCH 13/30] net: Prepare tcp_get_md5sig_pool() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:00 +0200
Message-Id: <1539213137-13953-14-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of local_bh_disable() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		tcp_get_md5sig_pool(&bh2) {
			*bh2 = local_bh_disable(...)
		}
		...
		tcp_put_md5sig_pool(bh2) {
			local_bh_enable(bh2);
		}
	local_bh_enable(bh);

To prepare for that, make tcp_get_md5sig_pool() able to return a saved
vector enabled mask and pass it back to rcu_read_unlock_bh(). We'll plug
it to local_bh_disable() in a subsequent patch.

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
 include/net/tcp.h   |  4 ++--
 net/ipv4/tcp.c      |  5 ++++-
 net/ipv4/tcp_ipv4.c | 14 ++++++++------
 net/ipv6/tcp_ipv6.c | 14 ++++++++------
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 770917d..7fe357a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1553,8 +1553,8 @@ static inline struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
 
 bool tcp_alloc_md5sig_pool(void);
 
-struct tcp_md5sig_pool *tcp_get_md5sig_pool(void);
-static inline void tcp_put_md5sig_pool(void)
+struct tcp_md5sig_pool *tcp_get_md5sig_pool(unsigned int *bh);
+static inline void tcp_put_md5sig_pool(unsigned int bh)
 {
 	local_bh_enable();
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 10c6246..dfd9bae 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3665,16 +3665,19 @@ EXPORT_SYMBOL(tcp_alloc_md5sig_pool);
  *	and BH disabled, to make sure another thread or softirq handling
  *	wont try to get same context.
  */
-struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
+struct tcp_md5sig_pool *tcp_get_md5sig_pool(unsigned int *bh)
 {
 	local_bh_disable();
+	*bh = 0;
 
 	if (tcp_md5sig_pool_populated) {
 		/* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
 		smp_rmb();
 		return this_cpu_ptr(&tcp_md5sig_pool);
 	}
+
 	local_bh_enable();
+
 	return NULL;
 }
 EXPORT_SYMBOL(tcp_get_md5sig_pool);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 44c09ed..0378e77 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1194,8 +1194,9 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 {
 	struct tcp_md5sig_pool *hp;
 	struct ahash_request *req;
+	unsigned int bh;
 
-	hp = tcp_get_md5sig_pool();
+	hp = tcp_get_md5sig_pool(&bh);
 	if (!hp)
 		goto clear_hash_noput;
 	req = hp->md5_req;
@@ -1210,11 +1211,11 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 	if (crypto_ahash_final(req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 clear_hash_noput:
 	memset(md5_hash, 0, 16);
 	return 1;
@@ -1228,6 +1229,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 	struct ahash_request *req;
 	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 saddr, daddr;
+	unsigned int bh;
 
 	if (sk) { /* valid for establish/request sockets */
 		saddr = sk->sk_rcv_saddr;
@@ -1238,7 +1240,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 		daddr = iph->daddr;
 	}
 
-	hp = tcp_get_md5sig_pool();
+	hp = tcp_get_md5sig_pool(&bh);
 	if (!hp)
 		goto clear_hash_noput;
 	req = hp->md5_req;
@@ -1256,11 +1258,11 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 	if (crypto_ahash_final(req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 clear_hash_noput:
 	memset(md5_hash, 0, 16);
 	return 1;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 03e6b7a..360efc3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -610,8 +610,9 @@ static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 {
 	struct tcp_md5sig_pool *hp;
 	struct ahash_request *req;
+	unsigned int bh;
 
-	hp = tcp_get_md5sig_pool();
+	hp = tcp_get_md5sig_pool(&bh);
 	if (!hp)
 		goto clear_hash_noput;
 	req = hp->md5_req;
@@ -626,11 +627,11 @@ static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 	if (crypto_ahash_final(req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 clear_hash_noput:
 	memset(md5_hash, 0, 16);
 	return 1;
@@ -645,6 +646,7 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 	struct tcp_md5sig_pool *hp;
 	struct ahash_request *req;
 	const struct tcphdr *th = tcp_hdr(skb);
+	unsigned int bh;
 
 	if (sk) { /* valid for establish/request sockets */
 		saddr = &sk->sk_v6_rcv_saddr;
@@ -655,7 +657,7 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 		daddr = &ip6h->daddr;
 	}
 
-	hp = tcp_get_md5sig_pool();
+	hp = tcp_get_md5sig_pool(&bh);
 	if (!hp)
 		goto clear_hash_noput;
 	req = hp->md5_req;
@@ -673,11 +675,11 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 	if (crypto_ahash_final(req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
+	tcp_put_md5sig_pool(bh);
 clear_hash_noput:
 	memset(md5_hash, 0, 16);
 	return 1;
-- 
2.7.4

