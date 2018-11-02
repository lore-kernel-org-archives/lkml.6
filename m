Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A515C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5337E20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGONq5HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5337E20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeKCDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKCDwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:52:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BDC2084A;
        Fri,  2 Nov 2018 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184268;
        bh=TPgD3RskS/eXgIgzRdfGjpxKuVZbBqT+hdCrSu87rFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGONq5HHFF/3Kfq5MZV39WaxDJm9HK4yjMOF7D42y0MUNGFe5pb8miAVAuz6M+7B0
         aIcfzQz3CwofC1Qi/8QR6pRuLmt1v8BgQ+nLxpYkFUebgeXVgu6cie1N43c9cnEoGN
         5dKRBtRWVgU/HNN8gyiJzKVxRLCOhEdmmX0aYwQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 086/150] rxrpc: Fix connection-level abort handling
Date:   Fri,  2 Nov 2018 19:34:08 +0100
Message-Id: <20181102182909.513550182@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
 net/rxrpc/ar-internal.h |    4 ++--
 net/rxrpc/call_accept.c |    4 ++--
 net/rxrpc/conn_event.c  |   26 +++++++++++++++-----------
 3 files changed, 19 insertions(+), 15 deletions(-)

--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -446,8 +446,7 @@ struct rxrpc_connection {
 	spinlock_t		state_lock;	/* state-change lock */
 	enum rxrpc_conn_cache_state cache_state;
 	enum rxrpc_conn_proto_state state;	/* current state of connection */
-	u32			local_abort;	/* local abort code */
-	u32			remote_abort;	/* remote abort code */
+	u32			abort_code;	/* Abort code of connection abort */
 	int			debug_id;	/* debug ID for printks */
 	atomic_t		serial;		/* packet serial number counter */
 	unsigned int		hi_serial;	/* highest serial number received */
@@ -457,6 +456,7 @@ struct rxrpc_connection {
 	u8			security_size;	/* security header size */
 	u8			security_ix;	/* security type */
 	u8			out_clientflag;	/* RXRPC_CLIENT_INITIATED if we are client */
+	short			error;		/* Local error code */
 };
 
 static inline bool rxrpc_to_server(const struct rxrpc_skb_priv *sp)
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -422,11 +422,11 @@ found_service:
 
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
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -126,7 +126,7 @@ static void rxrpc_conn_retransmit_call(s
 
 	switch (chan->last_type) {
 	case RXRPC_PACKET_TYPE_ABORT:
-		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->local_abort);
+		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->abort_code);
 		break;
 	case RXRPC_PACKET_TYPE_ACK:
 		trace_rxrpc_tx_ack(NULL, serial, chan->last_seq, 0,
@@ -148,13 +148,12 @@ static void rxrpc_conn_retransmit_call(s
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
 
@@ -167,9 +166,11 @@ static void rxrpc_abort_calls(struct rxr
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
@@ -202,10 +203,12 @@ static int rxrpc_abort_connection(struct
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
@@ -224,7 +227,7 @@ static int rxrpc_abort_connection(struct
 	whdr._rsvd	= 0;
 	whdr.serviceId	= htons(conn->service_id);
 
-	word		= htonl(conn->local_abort);
+	word		= htonl(conn->abort_code);
 
 	iov[0].iov_base	= &whdr;
 	iov[0].iov_len	= sizeof(whdr);
@@ -235,7 +238,7 @@ static int rxrpc_abort_connection(struct
 
 	serial = atomic_inc_return(&conn->serial);
 	whdr.serial = htonl(serial);
-	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->local_abort);
+	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->abort_code);
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
@@ -308,9 +311,10 @@ static int rxrpc_process_event(struct rx
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


