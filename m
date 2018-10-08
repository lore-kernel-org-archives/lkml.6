Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93DEC6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E721476
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5E721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeJIGBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIGBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58D433082A23;
        Mon,  8 Oct 2018 22:47:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E39B55B0B3;
        Mon,  8 Oct 2018 22:47:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 03/10] rxrpc: Use the UDP encap_rcv hook
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:47:41 +0100
Message-ID: <153903886111.17944.12570133069838549331.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Oct 2018 22:47:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the UDP encap_rcv hook to cut the bit out of the rxrpc packet reception
in which a packet is placed onto the UDP receive queue and then immediately
removed again by rxrpc.  Going via the queue in this manner seems like it
should be unnecessary.

This does, however, require the invention of a value to place in encap_type
as that's one of the conditions to switch packets out to the encap_rcv
hook.  Possibly the value doesn't actually matter for anything other than
sockopts on the UDP socket, which aren't accessible outside of rxrpc
anyway.

This seems to cut a bit of time out of the time elapsed between each
sk_buff being timestamped and turning up in rxrpc (the final number in the
following trace excerpts).  I measured this by making the rxrpc_rx_packet
trace point print the time elapsed between the skb being timestamped and
the current time (in ns), e.g.:

	... 424.278721: rxrpc_rx_packet: ...  ACK 25026

So doing a 512MiB DIO read from my test server, with an unmodified kernel:

	N       min     max     sum		mean    stddev
	27605   2626    7581    7.83992e+07     2840.04 181.029

and with the patch applied:

	N       min     max     sum		mean    stddev
	27547   1895    12165   6.77461e+07     2459.29 255.02

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/udp.h |    1 +
 net/rxrpc/ar-internal.h  |    2 +-
 net/rxrpc/input.c        |   50 +++++++++++-----------------------------------
 net/rxrpc/local_object.c |   27 ++++++++++++++++++++-----
 4 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 09d00f8c442b..09502de447f5 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -40,5 +40,6 @@ struct udphdr {
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
 #define UDP_ENCAP_GTP0		4 /* GSM TS 09.60 */
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
+#define UDP_ENCAP_RXRPC		6
 
 #endif /* _UAPI_LINUX_UDP_H */
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 63c43b3a2096..ab60c0313fd4 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -966,7 +966,7 @@ void rxrpc_unpublish_service_conn(struct rxrpc_connection *);
 /*
  * input.c
  */
-void rxrpc_data_ready(struct sock *);
+int rxrpc_input_packet(struct sock *, struct sk_buff *);
 
 /*
  * insecure.c
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index c3114fa66c92..1866aeef2284 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1121,7 +1121,7 @@ int rxrpc_extract_header(struct rxrpc_skb_priv *sp, struct sk_buff *skb)
  * shut down and the local endpoint from going away, thus sk_user_data will not
  * be cleared until this function returns.
  */
-void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
+int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 {
 	struct rxrpc_connection *conn;
 	struct rxrpc_channel *chan;
@@ -1135,6 +1135,13 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 
 	_enter("%p", udp_sk);
 
+	if (skb->tstamp == 0)
+		skb->tstamp = ktime_get_real();
+
+	rxrpc_new_skb(skb, rxrpc_skb_rx_received);
+
+	skb_pull(skb, sizeof(struct udphdr));
+
 	/* The UDP protocol already released all skb resources;
 	 * we are free to add our own data there.
 	 */
@@ -1148,8 +1155,8 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 		static int lose;
 		if ((lose++ & 7) == 7) {
 			trace_rxrpc_rx_lose(sp);
-			rxrpc_lose_skb(skb, rxrpc_skb_rx_lost);
-			return;
+			rxrpc_free_skb(skb, rxrpc_skb_rx_lost);
+			return 0;
 		}
 	}
 
@@ -1332,7 +1339,7 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 	rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 out:
 	trace_rxrpc_rx_done(0, 0);
-	return;
+	return 0;
 
 out_unlock:
 	rcu_read_unlock();
@@ -1371,38 +1378,5 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 	trace_rxrpc_rx_done(skb->mark, skb->priority);
 	rxrpc_reject_packet(local, skb);
 	_leave(" [badmsg]");
-}
-
-void rxrpc_data_ready(struct sock *udp_sk)
-{
-	struct sk_buff *skb;
-	int ret;
-
-	for (;;) {
-		skb = skb_recv_udp(udp_sk, 0, 1, &ret);
-		if (!skb) {
-			if (ret == -EAGAIN)
-				return;
-
-			/* If there was a transmission failure, we get an error
-			 * here that we need to ignore.
-			 */
-			_debug("UDP socket error %d", ret);
-			continue;
-		}
-
-		rxrpc_new_skb(skb, rxrpc_skb_rx_received);
-
-		/* we'll probably need to checksum it (didn't call sock_recvmsg) */
-		if (skb_checksum_complete(skb)) {
-			rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
-			__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INERRORS, 0);
-			_debug("csum failed");
-			continue;
-		}
-
-		__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INDATAGRAMS, 0);
-
-		rxrpc_input_packet(udp_sk, skb);
-	}
+	return 0;
 }
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 30862f44c9f1..cad0691c2bb4 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -19,6 +19,7 @@
 #include <linux/ip.h>
 #include <linux/hashtable.h>
 #include <net/sock.h>
+#include <net/udp.h>
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
 
@@ -108,7 +109,7 @@ static struct rxrpc_local *rxrpc_alloc_local(struct rxrpc_net *rxnet,
  */
 static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 {
-	struct sock *sock;
+	struct sock *usk;
 	int ret, opt;
 
 	_enter("%p{%d,%d}",
@@ -123,10 +124,26 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	}
 
 	/* set the socket up */
-	sock = local->socket->sk;
-	sock->sk_user_data	= local;
-	sock->sk_data_ready	= rxrpc_data_ready;
-	sock->sk_error_report	= rxrpc_error_report;
+	usk = local->socket->sk;
+	inet_sk(usk)->mc_loop = 0;
+
+	/* Enable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
+	inet_inc_convert_csum(usk);
+
+	rcu_assign_sk_user_data(usk, local);
+
+	udp_sk(usk)->encap_type = UDP_ENCAP_RXRPC;
+	udp_sk(usk)->encap_rcv = rxrpc_input_packet;
+	udp_sk(usk)->encap_destroy = NULL;
+	udp_sk(usk)->gro_receive = NULL;
+	udp_sk(usk)->gro_complete = NULL;
+
+	udp_encap_enable();
+#if IS_ENABLED(CONFIG_IPV6)
+	if (local->srx.transport.family == AF_INET6)
+		udpv6_encap_enable();
+#endif
+	usk->sk_error_report = rxrpc_error_report;
 
 	/* if a local address was supplied then bind it */
 	if (local->srx.transport_len > sizeof(sa_family_t)) {

