Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeBAK02 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:26:28 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:37584 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeBAK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:26:26 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] inet: Avoid unitialized variable warning in inet_unhash()
Date: Thu,  1 Feb 2018 11:26:23 +0100
Message-Id: <1517480783-5692-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2:

    net/ipv4/inet_hashtables.c: In function ‘inet_unhash’:
    net/ipv4/inet_hashtables.c:628: warning: ‘ilb’ may be used uninitialized in this function

While this is a false positive, it can easily be avoided by using the
pointer itself as the canary variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/ipv4/inet_hashtables.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 37b7da0b975dc297..31ff46daae974645 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -625,9 +625,8 @@ EXPORT_SYMBOL_GPL(inet_hash);
 void inet_unhash(struct sock *sk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-	struct inet_listen_hashbucket *ilb;
+	struct inet_listen_hashbucket *ilb = NULL;
 	spinlock_t *lock;
-	bool listener = false;
 
 	if (sk_unhashed(sk))
 		return;
@@ -635,7 +634,6 @@ void inet_unhash(struct sock *sk)
 	if (sk->sk_state == TCP_LISTEN) {
 		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
 		lock = &ilb->lock;
-		listener = true;
 	} else {
 		lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 	}
@@ -645,7 +643,7 @@ void inet_unhash(struct sock *sk)
 
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
-	if (listener) {
+	if (ilb) {
 		inet_unhash2(hashinfo, sk);
 		 __sk_del_node_init(sk);
 		 ilb->count--;
-- 
2.7.4
