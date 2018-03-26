Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeCZVWO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:22:14 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:44260 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeCZVWL (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:22:11 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 6/6] net/sock: Update memalloc_socks static key to modern api
Date: Mon, 26 Mar 2018 14:09:29 -0700
Message-Id: <20180326210929.5244-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to memalloc_socks, for better self
documentation.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/net/sock.h | 4 ++--
 net/core/sock.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8c428c6847af..15d676365743 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -803,10 +803,10 @@ static inline bool sock_flag(const struct sock *sk, enum sock_flags flag)
 }
 
 #ifdef CONFIG_NET
-extern struct static_key memalloc_socks;
+DECLARE_STATIC_KEY_FALSE(memalloc_socks_key);
 static inline int sk_memalloc_socks(void)
 {
-	return static_key_false(&memalloc_socks);
+	return static_branch_unlikely(&memalloc_socks_key);
 }
 #else
 
diff --git a/net/core/sock.c b/net/core/sock.c
index e689496dfd8a..670f35803411 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -323,8 +323,8 @@ EXPORT_SYMBOL(sysctl_optmem_max);
 
 int sysctl_tstamp_allow_data __read_mostly = 1;
 
-struct static_key memalloc_socks = STATIC_KEY_INIT_FALSE;
-EXPORT_SYMBOL_GPL(memalloc_socks);
+DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
+EXPORT_SYMBOL_GPL(memalloc_socks_key);
 
 /**
  * sk_set_memalloc - sets %SOCK_MEMALLOC
@@ -338,7 +338,7 @@ void sk_set_memalloc(struct sock *sk)
 {
 	sock_set_flag(sk, SOCK_MEMALLOC);
 	sk->sk_allocation |= __GFP_MEMALLOC;
-	static_key_slow_inc(&memalloc_socks);
+	static_branch_inc(&memalloc_socks_key);
 }
 EXPORT_SYMBOL_GPL(sk_set_memalloc);
 
@@ -346,7 +346,7 @@ void sk_clear_memalloc(struct sock *sk)
 {
 	sock_reset_flag(sk, SOCK_MEMALLOC);
 	sk->sk_allocation &= ~__GFP_MEMALLOC;
-	static_key_slow_dec(&memalloc_socks);
+	static_branch_dec(&memalloc_socks_key);
 
 	/*
 	 * SOCK_MEMALLOC is allowed to ignore rmem limits to ensure forward
-- 
2.13.6
