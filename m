Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB2C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FA5206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJIGCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJIGCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F0D5811AC;
        Mon,  8 Oct 2018 22:48:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD6D92526D;
        Mon,  8 Oct 2018 22:48:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 08/10] rxrpc: Fix connection-level abort handling
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:48:17 +0100
Message-ID: <153903889793.17944.6041240175569938234.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 08 Oct 2018 22:48:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix connection-level abort handling to cache the abort and error codes
properly so that a new incoming call can be properly aborted if it races
with the parent connection being aborted by another CPU.

The abort_code and error parameters can then be dropped from
rxrpc_abort_calls().

Fixes: f5c17aaeb2ae ("rxrpc: Calls should only have one terminal state")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    4 ++--
 net/rxrpc/call_accept.c |    4 ++--
 net/rxrpc/conn_event.c  |   26 +++++++++++++++-----------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ab60c0313fd4..45307463b7dd 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -442,8 +442,7 @@ struct rxrpc_connection {
 	spinlock_t		state_lock;	/* state-change lock */
 	enum rxrpc_conn_cache_state cache_state;
 	enum rxrpc_conn_proto_state state;	/* current state of connection */
-	u32			local_abort;	/* local abort code */
-	u32			remote_abort;	/* remote abort code */
+	u32			abort_code;	/* Abort code of connection abort */
 	int			debug_id;	/* debug ID for printks */
 	atomic_t		serial;		/* packet serial number counter */
 	unsigned int		hi_serial;	/* highest serial number received */
@@ -453,6 +452,7 @@ struct rxrpc_connection {
 	u8			security_size;	/* security header size */
 	u8			security_ix;	/* security type */
 	u8			out_clientflag;	/* RXRPC_CLIENT_INITIATED if we are client */
+	short			error;		/* Local error code */
 };
 
 static inline bool rxrpc_to_server(const struct rxrpc_skb_priv *sp)
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index f55f67894465..1c4ebc0cb25b 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -405,11 +405,11 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 
 	case RXRPC_CONN_REMOTELY_ABORTED:
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
-					  conn->remote_abort, -ECONNABORTED);
+					  conn->abort_code, conn->error);
 		break;
 	case RXRPC_CONN_LOCALLY_ABORTED:
 		rxrpc_abort_call("CON", call, sp->hdr.seq,
-				 conn->local_abort, -ECONNABORTED);
+				 conn->abort_code, conn->error);
 		break;
 	default:
 		BUG();
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 6df56ce68861..b6fca8ebb117 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -126,7 +126,7 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	switch (chan->last_type) {
 	case RXRPC_PACKET_TYPE_ABORT:
-		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->local_abort);
+		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->abort_code);
 		break;
 	case RXRPC_PACKET_TYPE_ACK:
 		trace_rxrpc_tx_ack(chan->call_debug_id, serial,
@@ -153,13 +153,12 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
  * pass a connection-level abort onto all calls on that connection
  */
 static void rxrpc_abort_calls(struct rxrpc_connection *conn,
-			      enum rxrpc_call_completion compl,
-			      u32 abort_code, int error)
+			      enum rxrpc_call_completion compl)
 {
 	struct rxrpc_call *call;
 	int i;
 
-	_enter("{%d},%x", conn->debug_id, abort_code);
+	_enter("{%d},%x", conn->debug_id, conn->abort_code);
 
 	spin_lock(&conn->channel_lock);
 
@@ -172,9 +171,11 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn,
 				trace_rxrpc_abort(call->debug_id,
 						  "CON", call->cid,
 						  call->call_id, 0,
-						  abort_code, error);
+						  conn->abort_code,
+						  conn->error);
 			if (rxrpc_set_call_completion(call, compl,
-						      abort_code, error))
+						      conn->abort_code,
+						      conn->error))
 				rxrpc_notify_socket(call);
 		}
 	}
@@ -207,10 +208,12 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 		return 0;
 	}
 
+	conn->error = error;
+	conn->abort_code = abort_code;
 	conn->state = RXRPC_CONN_LOCALLY_ABORTED;
 	spin_unlock_bh(&conn->state_lock);
 
-	rxrpc_abort_calls(conn, RXRPC_CALL_LOCALLY_ABORTED, abort_code, error);
+	rxrpc_abort_calls(conn, RXRPC_CALL_LOCALLY_ABORTED);
 
 	msg.msg_name	= &conn->params.peer->srx.transport;
 	msg.msg_namelen	= conn->params.peer->srx.transport_len;
@@ -229,7 +232,7 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 	whdr._rsvd	= 0;
 	whdr.serviceId	= htons(conn->service_id);
 
-	word		= htonl(conn->local_abort);
+	word		= htonl(conn->abort_code);
 
 	iov[0].iov_base	= &whdr;
 	iov[0].iov_len	= sizeof(whdr);
@@ -240,7 +243,7 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 
 	serial = atomic_inc_return(&conn->serial);
 	whdr.serial = htonl(serial);
-	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->local_abort);
+	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->abort_code);
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
@@ -315,9 +318,10 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		abort_code = ntohl(wtmp);
 		_proto("Rx ABORT %%%u { ac=%d }", sp->hdr.serial, abort_code);
 
+		conn->error = -ECONNABORTED;
+		conn->abort_code = abort_code;
 		conn->state = RXRPC_CONN_REMOTELY_ABORTED;
-		rxrpc_abort_calls(conn, RXRPC_CALL_REMOTELY_ABORTED,
-				  abort_code, -ECONNABORTED);
+		rxrpc_abort_calls(conn, RXRPC_CALL_REMOTELY_ABORTED);
 		return -ECONNABORTED;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:

