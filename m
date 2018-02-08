Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeBHP7O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:59:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752412AbeBHP7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:59:10 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Don't put crypto buffers on the stack
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 15:59:07 +0000
Message-ID: <151810554726.19320.4571236293389358221.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't put buffers of data to be handed to crypto on the stack as this may
cause an assertion failure in the kernel (see below).  Fix this by using an
kmalloc'd buffer instead.

kernel BUG at ./include/linux/scatterlist.h:147!
...
RIP: 0010:rxkad_encrypt_response.isra.6+0x191/0x1b0 [rxrpc]
RSP: 0018:ffffbe2fc06cfca8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff989277d59900 RCX: 0000000000000028
RDX: 0000259dc06cfd88 RSI: 0000000000000025 RDI: ffffbe30406cfd88
RBP: ffffbe2fc06cfd60 R08: ffffbe2fc06cfd08 R09: ffffbe2fc06cfd08
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff7c5f80d9f95
R13: ffffbe2fc06cfd88 R14: ffff98927a3f7aa0 R15: ffffbe2fc06cfd08
FS:  0000000000000000(0000) GS:ffff98927fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b1ff28f0f8 CR3: 000000001b412003 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rxkad_respond_to_challenge+0x297/0x330 [rxrpc]
 rxrpc_process_connection+0xd1/0x690 [rxrpc]
 ? process_one_work+0x1c3/0x680
 ? __lock_is_held+0x59/0xa0
 process_one_work+0x249/0x680
 worker_thread+0x3a/0x390
 ? process_one_work+0x680/0x680
 kthread+0x121/0x140
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x3a/0x50

Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jonathan Billings <jsbillings@jsbillings.org>
---

 net/rxrpc/conn_event.c |    1 +
 net/rxrpc/rxkad.c      |   92 +++++++++++++++++++++++++++---------------------
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 4ca11be6be3c..b1dfae107431 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -460,6 +460,7 @@ void rxrpc_process_connection(struct work_struct *work)
 		case -EKEYEXPIRED:
 		case -EKEYREJECTED:
 			goto protocol_error;
+		case -ENOMEM:
 		case -EAGAIN:
 			goto requeue_and_leave;
 		case -ECONNABORTED:
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index c38b3a1de56c..77cb23c7bd0a 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -773,8 +773,7 @@ static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
 {
 	const struct rxrpc_key_token *token;
 	struct rxkad_challenge challenge;
-	struct rxkad_response resp
-		__attribute__((aligned(8))); /* must be aligned for crypto */
+	struct rxkad_response *resp;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	const char *eproto;
 	u32 version, nonce, min_level, abort_code;
@@ -818,26 +817,29 @@ static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
 	token = conn->params.key->payload.data[0];
 
 	/* build the response packet */
-	memset(&resp, 0, sizeof(resp));
-
-	resp.version			= htonl(RXKAD_VERSION);
-	resp.encrypted.epoch		= htonl(conn->proto.epoch);
-	resp.encrypted.cid		= htonl(conn->proto.cid);
-	resp.encrypted.securityIndex	= htonl(conn->security_ix);
-	resp.encrypted.inc_nonce	= htonl(nonce + 1);
-	resp.encrypted.level		= htonl(conn->params.security_level);
-	resp.kvno			= htonl(token->kad->kvno);
-	resp.ticket_len			= htonl(token->kad->ticket_len);
-
-	resp.encrypted.call_id[0] = htonl(conn->channels[0].call_counter);
-	resp.encrypted.call_id[1] = htonl(conn->channels[1].call_counter);
-	resp.encrypted.call_id[2] = htonl(conn->channels[2].call_counter);
-	resp.encrypted.call_id[3] = htonl(conn->channels[3].call_counter);
+	resp = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
+	if (!resp)
+		return -ENOMEM;
+
+	resp->version			= htonl(RXKAD_VERSION);
+	resp->encrypted.epoch		= htonl(conn->proto.epoch);
+	resp->encrypted.cid		= htonl(conn->proto.cid);
+	resp->encrypted.securityIndex	= htonl(conn->security_ix);
+	resp->encrypted.inc_nonce	= htonl(nonce + 1);
+	resp->encrypted.level		= htonl(conn->params.security_level);
+	resp->kvno			= htonl(token->kad->kvno);
+	resp->ticket_len		= htonl(token->kad->ticket_len);
+	resp->encrypted.call_id[0]	= htonl(conn->channels[0].call_counter);
+	resp->encrypted.call_id[1]	= htonl(conn->channels[1].call_counter);
+	resp->encrypted.call_id[2]	= htonl(conn->channels[2].call_counter);
+	resp->encrypted.call_id[3]	= htonl(conn->channels[3].call_counter);
 
 	/* calculate the response checksum and then do the encryption */
-	rxkad_calc_response_checksum(&resp);
-	rxkad_encrypt_response(conn, &resp, token->kad);
-	return rxkad_send_response(conn, &sp->hdr, &resp, token->kad);
+	rxkad_calc_response_checksum(resp);
+	rxkad_encrypt_response(conn, resp, token->kad);
+	ret = rxkad_send_response(conn, &sp->hdr, resp, token->kad);
+	kfree(resp);
+	return ret;
 
 protocol_error:
 	trace_rxrpc_rx_eproto(NULL, sp->hdr.serial, eproto);
@@ -1048,8 +1050,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 				 struct sk_buff *skb,
 				 u32 *_abort_code)
 {
-	struct rxkad_response response
-		__attribute__((aligned(8))); /* must be aligned for crypto */
+	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	const char *eproto;
@@ -1061,17 +1062,22 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	_enter("{%d,%x}", conn->debug_id, key_serial(conn->server_key));
 
+	ret = -ENOMEM;
+	response = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
+	if (!response)
+		goto temporary_error;
+
 	eproto = tracepoint_string("rxkad_rsp_short");
 	abort_code = RXKADPACKETSHORT;
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  &response, sizeof(response)) < 0)
+			  response, sizeof(*response)) < 0)
 		goto protocol_error;
-	if (!pskb_pull(skb, sizeof(response)))
+	if (!pskb_pull(skb, sizeof(*response)))
 		BUG();
 
-	version = ntohl(response.version);
-	ticket_len = ntohl(response.ticket_len);
-	kvno = ntohl(response.kvno);
+	version = ntohl(response->version);
+	ticket_len = ntohl(response->ticket_len);
+	kvno = ntohl(response->kvno);
 	_proto("Rx RESPONSE %%%u { v=%u kv=%u tl=%u }",
 	       sp->hdr.serial, version, kvno, ticket_len);
 
@@ -1105,31 +1111,31 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxkad_decrypt_ticket(conn, skb, ticket, ticket_len, &session_key,
 				   &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free;
+		goto temporary_error_free_resp;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
-	rxkad_decrypt_response(conn, &response, &session_key);
+	rxkad_decrypt_response(conn, response, &session_key);
 
 	eproto = tracepoint_string("rxkad_rsp_param");
 	abort_code = RXKADSEALEDINCON;
-	if (ntohl(response.encrypted.epoch) != conn->proto.epoch)
+	if (ntohl(response->encrypted.epoch) != conn->proto.epoch)
 		goto protocol_error_free;
-	if (ntohl(response.encrypted.cid) != conn->proto.cid)
+	if (ntohl(response->encrypted.cid) != conn->proto.cid)
 		goto protocol_error_free;
-	if (ntohl(response.encrypted.securityIndex) != conn->security_ix)
+	if (ntohl(response->encrypted.securityIndex) != conn->security_ix)
 		goto protocol_error_free;
-	csum = response.encrypted.checksum;
-	response.encrypted.checksum = 0;
-	rxkad_calc_response_checksum(&response);
+	csum = response->encrypted.checksum;
+	response->encrypted.checksum = 0;
+	rxkad_calc_response_checksum(response);
 	eproto = tracepoint_string("rxkad_rsp_csum");
-	if (response.encrypted.checksum != csum)
+	if (response->encrypted.checksum != csum)
 		goto protocol_error_free;
 
 	spin_lock(&conn->channel_lock);
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
 		struct rxrpc_call *call;
-		u32 call_id = ntohl(response.encrypted.call_id[i]);
+		u32 call_id = ntohl(response->encrypted.call_id[i]);
 
 		eproto = tracepoint_string("rxkad_rsp_callid");
 		if (call_id > INT_MAX)
@@ -1153,12 +1159,12 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	eproto = tracepoint_string("rxkad_rsp_seq");
 	abort_code = RXKADOUTOFSEQUENCE;
-	if (ntohl(response.encrypted.inc_nonce) != conn->security_nonce + 1)
+	if (ntohl(response->encrypted.inc_nonce) != conn->security_nonce + 1)
 		goto protocol_error_free;
 
 	eproto = tracepoint_string("rxkad_rsp_level");
 	abort_code = RXKADLEVELFAIL;
-	level = ntohl(response.encrypted.level);
+	level = ntohl(response->encrypted.level);
 	if (level > RXRPC_SECURITY_ENCRYPT)
 		goto protocol_error_free;
 	conn->params.security_level = level;
@@ -1168,9 +1174,10 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	 * as for a client connection */
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 	if (ret < 0)
-		goto temporary_error_free;
+		goto temporary_error_free_ticket;
 
 	kfree(ticket);
+	kfree(response);
 	_leave(" = 0");
 	return 0;
 
@@ -1179,12 +1186,15 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 protocol_error_free:
 	kfree(ticket);
 protocol_error:
+	kfree(response);
 	trace_rxrpc_rx_eproto(NULL, sp->hdr.serial, eproto);
 	*_abort_code = abort_code;
 	return -EPROTO;
 
-temporary_error_free:
+temporary_error_free_ticket:
 	kfree(ticket);
+temporary_error_free_resp:
+	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as
 	 * ENOMEM.  We just want to send the challenge again.  Note that we
