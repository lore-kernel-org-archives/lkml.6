Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA7C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC62075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBC62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJIGBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJIGBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B623430820DF;
        Mon,  8 Oct 2018 22:47:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0286C21D;
        Mon,  8 Oct 2018 22:47:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 04/10] rxrpc: Don't need to take the RCU read lock in
 the packet receiver
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:47:48 +0100
Message-ID: <153903886858.17944.16076683147750254534.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 08 Oct 2018 22:47:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to take the RCU read lock in the rxrpc packet receive
function because it's held further up the stack in the IP input routine
around the UDP receive routines.

Fix this by dropping the RCU read lock calls from rxrpc_input_packet().
This simplifies the code.

Fixes: 70790dbe3f66 ("rxrpc: Pass the last Tx packet marker in the annotation buffer")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c |   41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 1866aeef2284..2dcef482acf2 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1120,6 +1120,8 @@ int rxrpc_extract_header(struct rxrpc_skb_priv *sp, struct sk_buff *skb)
  * The socket is locked by the caller and this prevents the socket from being
  * shut down and the local endpoint from going away, thus sk_user_data will not
  * be cleared until this function returns.
+ *
+ * Called with the RCU read lock held from the IP layer via UDP.
  */
 int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 {
@@ -1215,8 +1217,6 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 	if (sp->hdr.serviceId == 0)
 		goto bad_message;
 
-	rcu_read_lock();
-
 	if (rxrpc_to_server(sp)) {
 		/* Weed out packets to services we're not offering.  Packets
 		 * that would begin a call are explicitly rejected and the rest
@@ -1228,7 +1228,7 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 			    sp->hdr.seq == 1)
 				goto unsupported_service;
-			goto discard_unlock;
+			goto discard;
 		}
 	}
 
@@ -1248,7 +1248,7 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 			/* Connection-level packet */
 			_debug("CONN %p {%d}", conn, conn->debug_id);
 			rxrpc_post_packet_to_conn(conn, skb);
-			goto out_unlock;
+			goto out;
 		}
 
 		/* Note the serial number skew here */
@@ -1267,19 +1267,19 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 
 		/* Ignore really old calls */
 		if (sp->hdr.callNumber < chan->last_call)
-			goto discard_unlock;
+			goto discard;
 
 		if (sp->hdr.callNumber == chan->last_call) {
 			if (chan->call ||
 			    sp->hdr.type == RXRPC_PACKET_TYPE_ABORT)
-				goto discard_unlock;
+				goto discard;
 
 			/* For the previous service call, if completed
 			 * successfully, we discard all further packets.
 			 */
 			if (rxrpc_conn_is_service(conn) &&
 			    chan->last_type == RXRPC_PACKET_TYPE_ACK)
-				goto discard_unlock;
+				goto discard;
 
 			/* But otherwise we need to retransmit the final packet
 			 * from data cached in the connection record.
@@ -1290,16 +1290,14 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 						    sp->hdr.serial,
 						    sp->hdr.flags, 0);
 			rxrpc_post_packet_to_conn(conn, skb);
-			goto out_unlock;
+			goto out;
 		}
 
 		call = rcu_dereference(chan->call);
 
 		if (sp->hdr.callNumber > chan->call_id) {
-			if (rxrpc_to_client(sp)) {
-				rcu_read_unlock();
+			if (rxrpc_to_client(sp))
 				goto reject_packet;
-			}
 			if (call)
 				rxrpc_input_implicit_end_call(conn, call);
 			call = NULL;
@@ -1318,55 +1316,42 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 	if (!call || atomic_read(&call->usage) == 0) {
 		if (rxrpc_to_client(sp) ||
 		    sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
-			goto bad_message_unlock;
+			goto bad_message;
 		if (sp->hdr.seq != 1)
-			goto discard_unlock;
+			goto discard;
 		call = rxrpc_new_incoming_call(local, rx, peer, conn, skb);
-		if (!call) {
-			rcu_read_unlock();
+		if (!call)
 			goto reject_packet;
-		}
 		rxrpc_send_ping(call, skb, skew);
 		mutex_unlock(&call->user_mutex);
 	}
 
 	rxrpc_input_call_packet(call, skb, skew);
-	goto discard_unlock;
+	goto discard;
 
-discard_unlock:
-	rcu_read_unlock();
 discard:
 	rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 out:
 	trace_rxrpc_rx_done(0, 0);
 	return 0;
 
-out_unlock:
-	rcu_read_unlock();
-	goto out;
-
 wrong_security:
-	rcu_read_unlock();
 	trace_rxrpc_abort(0, "SEC", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RXKADINCONSISTENCY, EBADMSG);
 	skb->priority = RXKADINCONSISTENCY;
 	goto post_abort;
 
 unsupported_service:
-	rcu_read_unlock();
 	trace_rxrpc_abort(0, "INV", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_INVALID_OPERATION, EOPNOTSUPP);
 	skb->priority = RX_INVALID_OPERATION;
 	goto post_abort;
 
 reupgrade:
-	rcu_read_unlock();
 	trace_rxrpc_abort(0, "UPG", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_PROTOCOL_ERROR, EBADMSG);
 	goto protocol_error;
 
-bad_message_unlock:
-	rcu_read_unlock();
 bad_message:
 	trace_rxrpc_abort(0, "BAD", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_PROTOCOL_ERROR, EBADMSG);

