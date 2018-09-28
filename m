Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108252172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108252172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeI1Qdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1Qdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A557F308214B;
        Fri, 28 Sep 2018 10:10:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A01B965F5A;
        Fri, 28 Sep 2018 10:10:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 5/8] rxrpc: Improve up-front incoming packet checking
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:28 +0100
Message-ID: <153812942886.10469.13663153754559997324.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 28 Sep 2018 10:10:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do more up-front checking on incoming packets to weed out invalid ones and
also ones aimed at services that we don't support.

Whilst we're at it, replace the clearing of call and skew if we don't find
a connection with just initialising the variables to zero at the top of the
function.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c    |   63 ++++++++++++++++++++++++++++++++++++++++----------
 net/rxrpc/protocol.h |   15 ------------
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index b0f12471f5e7..a569e9e010d1 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1125,12 +1125,13 @@ void rxrpc_data_ready(struct sock *udp_sk)
 {
 	struct rxrpc_connection *conn;
 	struct rxrpc_channel *chan;
-	struct rxrpc_call *call;
+	struct rxrpc_call *call = NULL;
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_local *local = udp_sk->sk_user_data;
+	struct rxrpc_sock *rx;
 	struct sk_buff *skb;
 	unsigned int channel;
-	int ret, skew;
+	int ret, skew = 0;
 
 	_enter("%p", udp_sk);
 
@@ -1181,12 +1182,6 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
 	trace_rxrpc_rx_packet(sp);
 
-	if (sp->hdr.type >= RXRPC_N_PACKET_TYPES ||
-	    !((RXRPC_SUPPORTED_PACKET_TYPES >> sp->hdr.type) & 1)) {
-		_proto("Rx Bad Packet Type %u", sp->hdr.type);
-		goto bad_message;
-	}
-
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_VERSION:
 		if (rxrpc_to_client(sp))
@@ -1198,24 +1193,63 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		if (rxrpc_to_server(sp))
 			goto discard;
 		/* Fall through */
+	case RXRPC_PACKET_TYPE_ACK:
+	case RXRPC_PACKET_TYPE_ACKALL:
+		if (sp->hdr.callNumber == 0)
+			goto bad_message;
+		/* Fall through */
+	case RXRPC_PACKET_TYPE_ABORT:
+		break;
 
 	case RXRPC_PACKET_TYPE_DATA:
-		if (sp->hdr.callNumber == 0)
+		if (sp->hdr.callNumber == 0 ||
+		    sp->hdr.seq == 0)
 			goto bad_message;
 		if (sp->hdr.flags & RXRPC_JUMBO_PACKET &&
 		    !rxrpc_validate_jumbo(skb))
 			goto bad_message;
 		break;
 
+	case RXRPC_PACKET_TYPE_CHALLENGE:
+		if (rxrpc_to_server(sp))
+			goto discard;
+		break;
+	case RXRPC_PACKET_TYPE_RESPONSE:
+		if (rxrpc_to_client(sp))
+			goto discard;
+		break;
+
 		/* Packet types 9-11 should just be ignored. */
 	case RXRPC_PACKET_TYPE_PARAMS:
 	case RXRPC_PACKET_TYPE_10:
 	case RXRPC_PACKET_TYPE_11:
 		goto discard;
+
+	default:
+		_proto("Rx Bad Packet Type %u", sp->hdr.type);
+		goto bad_message;
 	}
 
+	if (sp->hdr.serviceId == 0)
+		goto bad_message;
+
 	rcu_read_lock();
 
+	if (rxrpc_to_server(sp)) {
+		/* Weed out packets to services we're not offering.  Packets
+		 * that would begin a call are explicitly rejected and the rest
+		 * are just discarded.
+		 */
+		rx = rcu_dereference(local->service);
+		if (!rx || (sp->hdr.serviceId != rx->srx.srx_service &&
+			    sp->hdr.serviceId != rx->second_service)) {
+			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
+			    sp->hdr.seq == 1)
+				goto unsupported_service;
+			goto discard_unlock;
+		}
+	}
+
 	conn = rxrpc_find_connection_rcu(local, skb);
 	if (conn) {
 		if (sp->hdr.securityIndex != conn->security_ix)
@@ -1297,14 +1331,10 @@ void rxrpc_data_ready(struct sock *udp_sk)
 			if (!test_bit(RXRPC_CALL_RX_HEARD, &call->flags))
 				set_bit(RXRPC_CALL_RX_HEARD, &call->flags);
 		}
-	} else {
-		skew = 0;
-		call = NULL;
 	}
 
 	if (!call || atomic_read(&call->usage) == 0) {
 		if (rxrpc_to_client(sp) ||
-		    sp->hdr.callNumber == 0 ||
 		    sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
 			goto bad_message_unlock;
 		if (sp->hdr.seq != 1)
@@ -1340,6 +1370,13 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	skb->priority = RXKADINCONSISTENCY;
 	goto post_abort;
 
+unsupported_service:
+	rcu_read_unlock();
+	trace_rxrpc_abort(0, "INV", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
+			  RX_INVALID_OPERATION, EOPNOTSUPP);
+	skb->priority = RX_INVALID_OPERATION;
+	goto post_abort;
+
 reupgrade:
 	rcu_read_unlock();
 	trace_rxrpc_abort(0, "UPG", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index 93da73bf7098..f9cb83c938f3 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -50,7 +50,6 @@ struct rxrpc_wire_header {
 #define RXRPC_PACKET_TYPE_10		10	/* Ignored */
 #define RXRPC_PACKET_TYPE_11		11	/* Ignored */
 #define RXRPC_PACKET_TYPE_VERSION	13	/* version string request */
-#define RXRPC_N_PACKET_TYPES		14	/* number of packet types (incl type 0) */
 
 	uint8_t		flags;		/* packet flags */
 #define RXRPC_CLIENT_INITIATED	0x01		/* signifies a packet generated by a client */
@@ -72,20 +71,6 @@ struct rxrpc_wire_header {
 
 } __packed;
 
-#define RXRPC_SUPPORTED_PACKET_TYPES (			\
-		(1 << RXRPC_PACKET_TYPE_DATA) |		\
-		(1 << RXRPC_PACKET_TYPE_ACK) |		\
-		(1 << RXRPC_PACKET_TYPE_BUSY) |		\
-		(1 << RXRPC_PACKET_TYPE_ABORT) |	\
-		(1 << RXRPC_PACKET_TYPE_ACKALL) |	\
-		(1 << RXRPC_PACKET_TYPE_CHALLENGE) |	\
-		(1 << RXRPC_PACKET_TYPE_RESPONSE) |	\
-		/*(1 << RXRPC_PACKET_TYPE_DEBUG) | */	\
-		(1 << RXRPC_PACKET_TYPE_PARAMS) |	\
-		(1 << RXRPC_PACKET_TYPE_10) |		\
-		(1 << RXRPC_PACKET_TYPE_11) |		\
-		(1 << RXRPC_PACKET_TYPE_VERSION))
-
 /*****************************************************************************/
 /*
  * jumbo packet secondary header

