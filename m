Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A9C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD5620848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQWg8ToR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD5620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeKCEBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbeKCEBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:49 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C96A2082D;
        Fri,  2 Nov 2018 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184812;
        bh=FKywddF3f/leeIck9HYzSda2orFvp79lW0uqAofLvbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQWg8ToRasSa58cAwQW7RPbtl8XITjh3l/1dE7xLYC3cG3r6KsTRfsBGrI+UiL5CZ
         BRd5E6DGLoB6r+nZg6Tq9Y8W5H+SA3+XSCVN8wEcIgoCWKt4s3hdxaxv6cNlDVIhog
         XEyuGl9B2LnpAEnD5Avk9Kj+NF9Pnhzj1hgq34wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 101/143] rxrpc: Fix connection-level abort handling
Date:   Fri,  2 Nov 2018 19:34:46 +0100
Message-Id: <20181102182905.925952147@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -418,11 +418,11 @@ found_service:
 
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



