Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeEJWpr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:45:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751649AbeEJWpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:45:43 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 4/5] rxrpc: Add a tracepoint to log ICMP/ICMP6 and error
 messages
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 23:45:41 +0100
Message-ID: <152599234168.26376.17970759155830952951.stgit@warthog.procyon.org.uk>
In-Reply-To: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
References: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint to log received ICMP/ICMP6 events and other error
messages.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |   30 +++++++++++++++++++++++++++
 net/rxrpc/peer_event.c       |   46 +++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 9e96c2fe2793..497d0b67f421 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -15,6 +15,7 @@
 #define _TRACE_RXRPC_H
 
 #include <linux/tracepoint.h>
+#include <linux/errqueue.h>
 
 /*
  * Define enums for tracing information.
@@ -1374,6 +1375,35 @@ TRACE_EVENT(rxrpc_resend,
 		      __entry->anno)
 	    );
 
+TRACE_EVENT(rxrpc_rx_icmp,
+	    TP_PROTO(struct rxrpc_peer *peer, struct sock_extended_err *ee,
+		     struct sockaddr_rxrpc *srx),
+
+	    TP_ARGS(peer, ee, srx),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			peer	)
+		    __field_struct(struct sock_extended_err,	ee	)
+		    __field_struct(struct sockaddr_rxrpc,	srx	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->peer = peer->debug_id;
+		    memcpy(&__entry->ee, ee, sizeof(__entry->ee));
+		    memcpy(&__entry->srx, srx, sizeof(__entry->srx));
+			   ),
+
+	    TP_printk("P=%08x o=%u t=%u c=%u i=%u d=%u e=%d %pISp",
+		      __entry->peer,
+		      __entry->ee.ee_origin,
+		      __entry->ee.ee_type,
+		      __entry->ee.ee_code,
+		      __entry->ee.ee_info,
+		      __entry->ee.ee_data,
+		      __entry->ee.ee_errno,
+		      &__entry->srx.transport)
+	    );
+
 #endif /* _TRACE_RXRPC_H */
 
 /* This part must be outside protection */
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 78c2f95d1f22..0ed8b651cec2 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -28,39 +28,39 @@ static void rxrpc_store_error(struct rxrpc_peer *, struct sock_exterr_skb *);
  * Find the peer associated with an ICMP packet.
  */
 static struct rxrpc_peer *rxrpc_lookup_peer_icmp_rcu(struct rxrpc_local *local,
-						     const struct sk_buff *skb)
+						     const struct sk_buff *skb,
+						     struct sockaddr_rxrpc *srx)
 {
 	struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
-	struct sockaddr_rxrpc srx;
 
 	_enter("");
 
-	memset(&srx, 0, sizeof(srx));
-	srx.transport_type = local->srx.transport_type;
-	srx.transport_len = local->srx.transport_len;
-	srx.transport.family = local->srx.transport.family;
+	memset(srx, 0, sizeof(*srx));
+	srx->transport_type = local->srx.transport_type;
+	srx->transport_len = local->srx.transport_len;
+	srx->transport.family = local->srx.transport.family;
 
 	/* Can we see an ICMP4 packet on an ICMP6 listening socket?  and vice
 	 * versa?
 	 */
-	switch (srx.transport.family) {
+	switch (srx->transport.family) {
 	case AF_INET:
-		srx.transport.sin.sin_port = serr->port;
+		srx->transport.sin.sin_port = serr->port;
 		switch (serr->ee.ee_origin) {
 		case SO_EE_ORIGIN_ICMP:
 			_net("Rx ICMP");
-			memcpy(&srx.transport.sin.sin_addr,
+			memcpy(&srx->transport.sin.sin_addr,
 			       skb_network_header(skb) + serr->addr_offset,
 			       sizeof(struct in_addr));
 			break;
 		case SO_EE_ORIGIN_ICMP6:
 			_net("Rx ICMP6 on v4 sock");
-			memcpy(&srx.transport.sin.sin_addr,
+			memcpy(&srx->transport.sin.sin_addr,
 			       skb_network_header(skb) + serr->addr_offset + 12,
 			       sizeof(struct in_addr));
 			break;
 		default:
-			memcpy(&srx.transport.sin.sin_addr, &ip_hdr(skb)->saddr,
+			memcpy(&srx->transport.sin.sin_addr, &ip_hdr(skb)->saddr,
 			       sizeof(struct in_addr));
 			break;
 		}
@@ -68,25 +68,25 @@ static struct rxrpc_peer *rxrpc_lookup_peer_icmp_rcu(struct rxrpc_local *local,
 
 #ifdef CONFIG_AF_RXRPC_IPV6
 	case AF_INET6:
-		srx.transport.sin6.sin6_port = serr->port;
+		srx->transport.sin6.sin6_port = serr->port;
 		switch (serr->ee.ee_origin) {
 		case SO_EE_ORIGIN_ICMP6:
 			_net("Rx ICMP6");
-			memcpy(&srx.transport.sin6.sin6_addr,
+			memcpy(&srx->transport.sin6.sin6_addr,
 			       skb_network_header(skb) + serr->addr_offset,
 			       sizeof(struct in6_addr));
 			break;
 		case SO_EE_ORIGIN_ICMP:
 			_net("Rx ICMP on v6 sock");
-			srx.transport.sin6.sin6_addr.s6_addr32[0] = 0;
-			srx.transport.sin6.sin6_addr.s6_addr32[1] = 0;
-			srx.transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
-			memcpy(srx.transport.sin6.sin6_addr.s6_addr + 12,
+			srx->transport.sin6.sin6_addr.s6_addr32[0] = 0;
+			srx->transport.sin6.sin6_addr.s6_addr32[1] = 0;
+			srx->transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
+			memcpy(srx->transport.sin6.sin6_addr.s6_addr + 12,
 			       skb_network_header(skb) + serr->addr_offset,
 			       sizeof(struct in_addr));
 			break;
 		default:
-			memcpy(&srx.transport.sin6.sin6_addr,
+			memcpy(&srx->transport.sin6.sin6_addr,
 			       &ipv6_hdr(skb)->saddr,
 			       sizeof(struct in6_addr));
 			break;
@@ -98,7 +98,7 @@ static struct rxrpc_peer *rxrpc_lookup_peer_icmp_rcu(struct rxrpc_local *local,
 		BUG();
 	}
 
-	return rxrpc_lookup_peer_rcu(local, &srx);
+	return rxrpc_lookup_peer_rcu(local, srx);
 }
 
 /*
@@ -146,6 +146,7 @@ static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, struct sock_exterr_skb *se
 void rxrpc_error_report(struct sock *sk)
 {
 	struct sock_exterr_skb *serr;
+	struct sockaddr_rxrpc srx;
 	struct rxrpc_local *local = sk->sk_user_data;
 	struct rxrpc_peer *peer;
 	struct sk_buff *skb;
@@ -166,7 +167,7 @@ void rxrpc_error_report(struct sock *sk)
 	}
 
 	rcu_read_lock();
-	peer = rxrpc_lookup_peer_icmp_rcu(local, skb);
+	peer = rxrpc_lookup_peer_icmp_rcu(local, skb, &srx);
 	if (peer && !rxrpc_get_peer_maybe(peer))
 		peer = NULL;
 	if (!peer) {
@@ -176,6 +177,8 @@ void rxrpc_error_report(struct sock *sk)
 		return;
 	}
 
+	trace_rxrpc_rx_icmp(peer, &serr->ee, &srx);
+
 	if ((serr->ee.ee_origin == SO_EE_ORIGIN_ICMP &&
 	     serr->ee.ee_type == ICMP_DEST_UNREACH &&
 	     serr->ee.ee_code == ICMP_FRAG_NEEDED)) {
@@ -209,9 +212,6 @@ static void rxrpc_store_error(struct rxrpc_peer *peer,
 
 	ee = &serr->ee;
 
-	_net("Rx Error o=%d t=%d c=%d e=%d",
-	     ee->ee_origin, ee->ee_type, ee->ee_code, ee->ee_errno);
-
 	err = ee->ee_errno;
 
 	switch (ee->ee_origin) {
