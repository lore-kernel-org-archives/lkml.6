Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F72C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A64920834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A64920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeJEVRE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbeJEVRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:17:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B395D30001D8;
        Fri,  5 Oct 2018 14:18:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2036369574;
        Fri,  5 Oct 2018 14:18:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <bf1d0734-d73a-83e9-c8e5-0fa4d447bc51@gmail.com>
References: <bf1d0734-d73a-83e9-c8e5-0fa4d447bc51@gmail.com> <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk> <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/2] rxrpc: Fix the data_ready handler
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15183.1538749081.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 05 Oct 2018 15:18:01 +0100
Message-ID: <15184.1538749081@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 05 Oct 2018 14:18:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <eric.dumazet@gmail.com> wrote:

> This looks a potential infinite loop to me ?

I assume that you're talking about the case where the packets are coming in so
fast that rxrpc is processing them as fast as they're coming in - or failing
to keep up.  I'm not sure what's the best thing to do in that case.

If you're not talking about that case, shouldn't skb_recv_udp() eventually
empty the queue and return -EAGAIN, thereby ending the loop?

I have another patch (see attached) which I was going to submit to net-next,
but maybe I need to merge into this one, in which I take the packets from the
encap_rcv hook.

Paolo has a couple of technical points on it that I need to look at dealing
with, but it speeds things up a bit and gets rid of the loop entirely.

David
---
commit 3784732a15631345c6d33b58985a9c2f30a2047f
Author: David Howells <dhowells@redhat.com>
Date:   Thu Oct 4 11:10:51 2018 +0100

    rxrpc: Use the UDP encap_rcv hook
    
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
    
            N       min     max     sum             mean    stddev
            27605   2626    7581    7.83992e+07     2840.04 181.029
    
    and with the patch applied:
    
            N       min     max     sum             mean    stddev
            27547   1895    12165   6.77461e+07     2459.29 255.02
    
    Signed-off-by: David Howells <dhowells@redhat.com>

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
index b79d0413b5ed..b94f3bdc66ac 100644
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
index ab90e60a5237..c0af023b77f4 100644
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
@@ -1136,6 +1136,24 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 
 	_enter("%p", udp_sk);
 
+	if (skb->tstamp == 0)
+		skb->tstamp = ktime_get_real();
+
+	rxrpc_new_skb(skb, rxrpc_skb_rx_received);
+
+	_net("recv skb %p", skb);
+
+	if (sk_filter_trim_cap(udp_sk, skb, sizeof(struct udphdr))) {
+		__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INERRORS, IS_UDPLITE(udp_sk));
+		atomic_inc(&udp_sk->sk_drops);
+		rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
+		_leave(" [filtered]");
+		return 0;
+	}
+
+	udp_csum_pull_header(skb);
+	skb_orphan(skb);
+
 	/* The UDP protocol already released all skb resources;
 	 * we are free to add our own data there.
 	 */
@@ -1150,7 +1168,7 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 		if ((lose++ & 7) == 7) {
 			trace_rxrpc_rx_lose(sp);
 			rxrpc_free_skb(skb, rxrpc_skb_rx_lost);
-			return;
+			return 0;
 		}
 	}
 
@@ -1334,7 +1352,7 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 	rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 out:
 	trace_rxrpc_rx_done(0, 0);
-	return;
+	return 0;
 
 out_unlock:
 	rcu_read_unlock();
@@ -1373,38 +1391,5 @@ void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
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
