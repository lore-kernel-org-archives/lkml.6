Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeEHQWf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:22:35 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:54004 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755530AbeEHQVz (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 8 May 2018 12:21:55 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 6/6] net/udp: Update udp_encap_needed static key to modern api
Date: Tue,  8 May 2018 09:07:03 -0700
Message-Id: <20180508160703.8125-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180508160703.8125-1-dave@stgolabs.net>
References: <20180508160703.8125-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_enable         with   static_branch_enable
static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to udp and udpv6 encap_needed, for better
self documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/ipv4/udp.c | 8 ++++----
 net/ipv6/udp.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dd3102a37ef9..ea86d8832340 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1873,10 +1873,10 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static struct static_key udp_encap_needed __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
 void udp_encap_enable(void)
 {
-	static_key_enable(&udp_encap_needed);
+	static_branch_enable(&udp_encap_needed_key);
 }
 EXPORT_SYMBOL(udp_encap_enable);
 
@@ -1900,7 +1900,7 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	nf_reset(skb);
 
-	if (static_key_false(&udp_encap_needed) && up->encap_type) {
+	if (static_branch_unlikely(&udp_encap_needed_key) && up->encap_type) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
@@ -2363,7 +2363,7 @@ void udp_destroy_sock(struct sock *sk)
 	bool slow = lock_sock_fast(sk);
 	udp_flush_pending_frames(sk);
 	unlock_sock_fast(sk, slow);
-	if (static_key_false(&udp_encap_needed) && up->encap_type) {
+	if (static_branch_unlikely(&udp_encap_needed_key) && up->encap_type) {
 		void (*encap_destroy)(struct sock *sk);
 		encap_destroy = READ_ONCE(up->encap_destroy);
 		if (encap_destroy)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index a34e28ac03a7..0056ae766d93 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -546,10 +546,10 @@ static __inline__ void udpv6_err(struct sk_buff *skb,
 	__udp6_lib_err(skb, opt, type, code, offset, info, &udp_table);
 }
 
-static struct static_key udpv6_encap_needed __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
 void udpv6_encap_enable(void)
 {
-	static_key_enable(&udpv6_encap_needed);
+	static_branch_enable(&udpv6_encap_needed_key);
 }
 EXPORT_SYMBOL(udpv6_encap_enable);
 
@@ -561,7 +561,7 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto drop;
 
-	if (static_key_false(&udpv6_encap_needed) && up->encap_type) {
+	if (static_branch_unlikely(&udpv6_encap_needed_key) && up->encap_type) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
@@ -1427,7 +1427,7 @@ void udpv6_destroy_sock(struct sock *sk)
 	udp_v6_flush_pending_frames(sk);
 	release_sock(sk);
 
-	if (static_key_false(&udpv6_encap_needed) && up->encap_type) {
+	if (static_branch_unlikely(&udpv6_encap_needed_key) && up->encap_type) {
 		void (*encap_destroy)(struct sock *sk);
 		encap_destroy = READ_ONCE(up->encap_destroy);
 		if (encap_destroy)
-- 
2.13.6
