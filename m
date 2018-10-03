Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B85C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26E721473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26E721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJDBiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:38:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDBiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77A2120264;
        Wed,  3 Oct 2018 18:48:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58B41106A78E;
        Wed,  3 Oct 2018 18:48:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] udp: Allow kernel service to avoid udp socket rx queue
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Oct 2018 19:48:22 +0100
Message-ID: <153859250219.15389.11970533498295122206.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 03 Oct 2018 18:48:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a problem somewhere skb_recv_udp() that doesn't decrease the
sk_rmem_alloc counter when a packet is extracted from the receive queue by
a kernel service.  This causes sk_buffs to take anything up to about *4s*
to get from the udp_rcv() function and into the rxrpc_data_ready() function
called by the udp ->data_ready() hook.

I *think* the cause is commit 7c13f97ffde6 which switches rxrpc to use
skb_recv_udp() and removes the skb_orphan() call that updated the buffer size.

Further, there doesn't seem any point in having the socket buffer being
added to the UDP socket's rx queue since the rxrpc's data_ready handler
takes it straight back out again (more or less, there seem to be occasional
hold ups there).

Fix (or at least work around) this by providing a hook in the udp socket
and setting it to point to __udp_enqueue_schedule_skb() by default.  The
calls to that function then call the hook instead and that function can be
made static.  A function is then provided that can set the hook.

Replacing the hook allows a kernel service to take the packet over much
earlier.


Putting in some tracepoints show a significant delay occurring between packets
coming in and thence being delivered to rxrpc:

<idle>-0  [001] ..s2    67.631844: net_rtl8169_napi_rx: enp3s0 skb=07db0a32
...
<idle>-0  [001] ..s4    68.292778: rxrpc_rx_packet: d5ce8d37:bdb93c60:00000002:09c7 00000006 00000000 02 20 ACK 660967981 skb=07db0a32

The "660967981" is the time difference in nanoseconds between the sk_buff
timestamp and the current time.  It seems to match the time elapsed between
the two trace lines reasonably well.  I've seen anything up to about 4s.

Doing an ls over AFS to a remote server without the patch results in packets
with the following elapsed times (sorted in order of duration):

	22846 26336 26679 30456 31934 32445 36108 36303 36434 40900 41466
	50301 57689 59236 59532 59642 63938 65210 66383 79459 79779 94046
	94247 94418 101293 104375 109538 161968 396268 450568 460531 478487
	795999 969810 1034399 1175103 1628151 1822520 2459426 2526902 3073868
	3489580 4798977 5449991 5893921 6182022 6381090 6388860 7538602
	8408790 9511088 11678676 11696086 16208221 16577161 21524253 36682196
	58310473 58587527 61149414 67585572 75295831 84904875 85160740
	85227487 85259103

Doing an ls with the patch results in packets with the following elapsed times

	4694 4750 4788 4921 5113 5462 5649 5765 5818 6509 6554 6594 6686 7197
	7392 7396 7928 7958 7983 8054 8139 8148 8670 8810 9477 9783 9903 9968
	10032 10243 10279 10376 10434 10544 10555 10614 10820 10875 10995
	11774 12912 12932 14068 14253 14273 14327 14553 14927 15321 15766
	17560 17655 17692 18146 18307 18608 19485 19547 19565 19575 19598
	19729 19740 19772 22466 23673 24186 24290 24311 24321 24321 24341
	24356 24371 24457 24477 24497 24502 24527 24541 24557 24587 24773
	24838 25168 26566 26812 26812 26842 26897 26912 27007 27013 27137
	27142 27148 27198 27428 27428 27464 27643 27714 27960

Fixes: 7c13f97ffde6 ("udp: do fwd memory scheduling on dequeue")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paolo Abeni <pabeni@redhat.com>
---

 include/linux/udp.h      |    3 +++
 include/net/udp.h        |    4 +++-
 net/ipv4/udp.c           |   28 +++++++++++++++++++++++++---
 net/ipv6/udp.c           |    3 ++-
 net/rxrpc/ar-internal.h  |    2 +-
 net/rxrpc/input.c        |   22 +++++++---------------
 net/rxrpc/local_object.c |    3 ++-
 7 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 320d49d85484..ea53a01dd10a 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -81,6 +81,9 @@ struct udp_sock {
 						struct sk_buff *skb,
 						int nhoff);
 
+	/* Packet diversion for in-kernel users. */
+	int (*rcv_enqueue_skb)(struct sock *sk, struct sk_buff *skb);
+
 	/* udp_recvmsg try to use this before splicing sk_receive_queue */
 	struct sk_buff_head	reader_queue ____cacheline_aligned_in_smp;
 
diff --git a/include/net/udp.h b/include/net/udp.h
index 8482a990b0bb..b083d3248f6e 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -255,7 +255,9 @@ static inline int udp_rqueue_get(struct sock *sk)
 /* net/ipv4/udp.c */
 void udp_destruct_sock(struct sock *sk);
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len);
-int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb);
+void udp_set_rcv_enqueue_skb(struct sock *sk,
+			     int (*rcv_enqueue_skb)(struct sock *sk,
+						    struct sk_buff *skb));
 void udp_skb_destructor(struct sock *sk, struct sk_buff *skb);
 struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 			       int noblock, int *peeked, int *off, int *err);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7d69dd6fa7e8..f93bc444f631 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1350,7 +1350,7 @@ static void busylock_release(spinlock_t *busy)
 		spin_unlock(busy);
 }
 
-int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
+static int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 	int rmem, delta, amt, err = -ENOMEM;
@@ -1422,7 +1422,25 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	busylock_release(busy);
 	return err;
 }
-EXPORT_SYMBOL_GPL(__udp_enqueue_schedule_skb);
+
+/**
+ * udp_set_rcv_enqueue_skb - Set function to divert received UDP packets
+ * @sk: The socket to access
+ * @rcv_enqueue_skb: The function to interpose
+ *
+ * This overrides the function that adds packets to the UDP socket's receive
+ * queue, enabling them to be diverted without the need for them to go through
+ * the receive queue or be accounted against the UDP socket's read capacity.
+ */
+void udp_set_rcv_enqueue_skb(struct sock *sk,
+			     int (*rcv_enqueue_skb)(struct sock *sk,
+						    struct sk_buff *skb))
+{
+	struct udp_sock *up = udp_sk(sk);
+
+	up->rcv_enqueue_skb = rcv_enqueue_skb;
+}
+EXPORT_SYMBOL_GPL(udp_set_rcv_enqueue_skb);
 
 void udp_destruct_sock(struct sock *sk)
 {
@@ -1444,8 +1462,11 @@ EXPORT_SYMBOL_GPL(udp_destruct_sock);
 
 int udp_init_sock(struct sock *sk)
 {
+	struct udp_sock *up = udp_sk(sk);
+
 	skb_queue_head_init(&udp_sk(sk)->reader_queue);
 	sk->sk_destruct = udp_destruct_sock;
+	up->rcv_enqueue_skb = __udp_enqueue_schedule_skb;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_init_sock);
@@ -1862,6 +1883,7 @@ static void udp_v4_rehash(struct sock *sk)
 
 static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	struct udp_sock *up = udp_sk(sk);
 	int rc;
 
 	if (inet_sk(sk)->inet_daddr) {
@@ -1872,7 +1894,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		sk_mark_napi_id_once(sk, skb);
 	}
 
-	rc = __udp_enqueue_schedule_skb(sk, skb);
+	rc = up->rcv_enqueue_skb(sk, skb);
 	if (rc < 0) {
 		int is_udplite = IS_UDPLITE(sk);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 28c4aa5078fc..4421fbf0a7a4 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -515,6 +515,7 @@ void __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	struct udp_sock *up = udp_sk(sk);
 	int rc;
 
 	if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
@@ -525,7 +526,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		sk_mark_napi_id_once(sk, skb);
 	}
 
-	rc = __udp_enqueue_schedule_skb(sk, skb);
+	rc = up->rcv_enqueue_skb(sk, skb);
 	if (rc < 0) {
 		int is_udplite = IS_UDPLITE(sk);
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ef9554131434..32f0ecc0eae0 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -965,7 +965,7 @@ void rxrpc_unpublish_service_conn(struct rxrpc_connection *);
 /*
  * input.c
  */
-void rxrpc_data_ready(struct sock *);
+int rxrpc_rcv_enqueue_skb(struct sock *, struct sk_buff *);
 
 /*
  * insecure.c
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 800f5b8a1baa..9b1d146162f6 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1121,7 +1121,7 @@ int rxrpc_extract_header(struct rxrpc_skb_priv *sp, struct sk_buff *skb)
  * shut down and the local endpoint from going away, thus sk_user_data will not
  * be cleared until this function returns.
  */
-void rxrpc_data_ready(struct sock *udp_sk)
+int rxrpc_rcv_enqueue_skb(struct sock *udp_sk, struct sk_buff *skb)
 {
 	struct rxrpc_connection *conn;
 	struct rxrpc_channel *chan;
@@ -1130,21 +1130,12 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	struct rxrpc_local *local = udp_sk->sk_user_data;
 	struct rxrpc_peer *peer = NULL;
 	struct rxrpc_sock *rx = NULL;
-	struct sk_buff *skb;
 	unsigned int channel;
-	int ret, skew = 0;
+	int skew = 0;
 
 	_enter("%p", udp_sk);
 
-	ASSERT(!irqs_disabled());
-
-	skb = skb_recv_udp(udp_sk, 0, 1, &ret);
-	if (!skb) {
-		if (ret == -EAGAIN)
-			return;
-		_debug("UDP socket error %d", ret);
-		return;
-	}
+	skb_orphan(skb);
 
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
@@ -1158,7 +1149,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 		__UDP_INC_STATS(&init_net, UDP_MIB_INERRORS, 0);
 		_leave(" [CSUM failed]");
-		return;
+		return 0;
 	}
 
 	__UDP_INC_STATS(&init_net, UDP_MIB_INDATAGRAMS, 0);
@@ -1177,7 +1168,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		if ((lose++ & 7) == 7) {
 			trace_rxrpc_rx_lose(sp);
 			rxrpc_lose_skb(skb, rxrpc_skb_rx_lost);
-			return;
+			return 0;
 		}
 	}
 
@@ -1358,7 +1349,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 out:
 	trace_rxrpc_rx_done(0, 0);
-	return;
+	return 0;
 
 out_unlock:
 	rcu_read_unlock();
@@ -1397,4 +1388,5 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	trace_rxrpc_rx_done(skb->mark, skb->priority);
 	rxrpc_reject_packet(local, skb);
 	_leave(" [badmsg]");
+	return 0;
 }
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 94d234e9c685..2eb444e2b80d 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -19,6 +19,7 @@
 #include <linux/ip.h>
 #include <linux/hashtable.h>
 #include <net/sock.h>
+#include <net/udp.h>
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
 
@@ -194,8 +195,8 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	/* set the socket up */
 	sock = local->socket->sk;
 	sock->sk_user_data	= local;
-	sock->sk_data_ready	= rxrpc_data_ready;
 	sock->sk_error_report	= rxrpc_error_report;
+	udp_set_rcv_enqueue_skb(sock, rxrpc_rcv_enqueue_skb);
 	_leave(" = 0");
 	return 0;
 

