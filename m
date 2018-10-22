Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A20C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D4E20898
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjdEoQQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D4E20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeJVSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbeJVSiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:50 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC00820853;
        Mon, 22 Oct 2018 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203655;
        bh=s0oyn/Up1ImrKvcP4WjNt83zEdfQjls91NMP9JRcoEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjdEoQQsPz87LPtbJ6vGkMEE40wcDDBmYh5h+c+TXg2SDieRWulXm1cDfSTiv2aVy
         oQadEbGwSFI5SGeAyDGfenmEZplnuZxN+zlyVTS1+/5Rxylzb4CJLqobxOHqz9yoDq
         YWUAYwm4j2jvlexj7V1IBzykKQbWHQbBUDednf1g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/15] rxrpc: Fix connection-level abort handling
Date:   Mon, 22 Oct 2018 06:20:21 -0400
Message-Id: <20181022102026.40869-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102026.40869-1-sashal@kernel.org>
References: <20181022102026.40869-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 647530924f47c93db472ee3cf43b7ef1425581b6 ]

Fix connection-level abort handling to cache the abort and error codes
properly so that a new incoming call can be properly aborted if it races
with the parent connection being aborted by another CPU.

The abort_code and error parameters can then be dropped from
rxrpc_abort_calls().

Fixes: f5c17aaeb2ae ("rxrpc: Calls should only have one terminal state")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  4 ++--
 net/rxrpc/call_accept.c |  4 ++--
 net/rxrpc/conn_event.c  | 26 +++++++++++++++-----------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e6c2c4f56fb1..71c7f1dd4599 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -424,8 +424,7 @@ struct rxrpc_connection {
 	spinlock_t		state_lock;	/* state-change lock */
 	enum rxrpc_conn_cache_state cache_state;
 	enum rxrpc_conn_proto_state state;	/* current state of connection */
-	u32			local_abort;	/* local abort code */
-	u32			remote_abort;	/* remote abort code */
+	u32			abort_code;	/* Abort code of connection abort */
 	int			debug_id;	/* debug ID for printks */
 	atomic_t		serial;		/* packet serial number counter */
 	unsigned int		hi_serial;	/* highest serial number received */
@@ -435,6 +434,7 @@ struct rxrpc_connection {
 	u8			security_size;	/* security header size */
 	u8			security_ix;	/* security type */
 	u8			out_clientflag;	/* RXRPC_CLIENT_INITIATED if we are client */
+	short			error;		/* Local error code */
 };
 
 /*
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 62b1581d44a5..2dd13f5c47c8 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -418,11 +418,11 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 
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
index 0435c4167a1a..75ec1ad595b7 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -117,7 +117,7 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	switch (chan->last_type) {
 	case RXRPC_PACKET_TYPE_ABORT:
-		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->local_abort);
+		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->abort_code);
 		break;
 	case RXRPC_PACKET_TYPE_ACK:
 		trace_rxrpc_tx_ack(NULL, serial, chan->last_seq, 0,
@@ -135,13 +135,12 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
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
 
@@ -153,9 +152,11 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn,
 			if (compl == RXRPC_CALL_LOCALLY_ABORTED)
 				trace_rxrpc_abort("CON", call->cid,
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
@@ -188,10 +189,12 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
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
@@ -210,7 +213,7 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 	whdr._rsvd	= 0;
 	whdr.serviceId	= htons(conn->service_id);
 
-	word		= htonl(conn->local_abort);
+	word		= htonl(conn->abort_code);
 
 	iov[0].iov_base	= &whdr;
 	iov[0].iov_len	= sizeof(whdr);
@@ -221,7 +224,7 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 
 	serial = atomic_inc_return(&conn->serial);
 	whdr.serial = htonl(serial);
-	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->local_abort);
+	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->abort_code);
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
@@ -289,9 +292,10 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
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
-- 
2.17.1

