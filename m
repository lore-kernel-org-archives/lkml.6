Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4398CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D820820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D820820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbeHAOpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:45:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389190AbeHAOpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2F824219DB4;
        Wed,  1 Aug 2018 12:59:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FE6310CD883;
        Wed,  1 Aug 2018 12:59:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 05/10] rxrpc: Trace packet transmission
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:59:17 +0100
Message-ID: <153312835768.27702.11367268980922351607.stgit@warthog.procyon.org.uk>
In-Reply-To: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
References: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 12:59:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 12:59:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace successful packet transmission (kernel_sendmsg() succeeded, that is)
in AF_RXRPC.  We can share the enum that defines the transmission points
with the trace_rxrpc_tx_fail() tracepoint, so rename its constants to be
applicable to both.

Also, save the internal call->debug_id in the rxrpc_channel struct so that
it can be used in retransmission trace lines.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |  107 ++++++++++++++++++++++++++++--------------
 net/rxrpc/ar-internal.h      |    1 
 net/rxrpc/conn_client.c      |    1 
 net/rxrpc/conn_event.c       |   13 ++++-
 net/rxrpc/input.c            |   11 ++++
 net/rxrpc/local_event.c      |    5 ++
 net/rxrpc/output.c           |   32 ++++++++++---
 net/rxrpc/rxkad.c            |    7 ++-
 8 files changed, 127 insertions(+), 50 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4fff00e9da8a..2aa6f615b60d 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -211,18 +211,18 @@ enum rxrpc_congest_change {
 	rxrpc_cong_saw_nack,
 };
 
-enum rxrpc_tx_fail_trace {
-	rxrpc_tx_fail_call_abort,
-	rxrpc_tx_fail_call_ack,
-	rxrpc_tx_fail_call_data_frag,
-	rxrpc_tx_fail_call_data_nofrag,
-	rxrpc_tx_fail_call_final_resend,
-	rxrpc_tx_fail_conn_abort,
-	rxrpc_tx_fail_conn_challenge,
-	rxrpc_tx_fail_conn_response,
-	rxrpc_tx_fail_reject,
-	rxrpc_tx_fail_version_keepalive,
-	rxrpc_tx_fail_version_reply,
+enum rxrpc_tx_point {
+	rxrpc_tx_point_call_abort,
+	rxrpc_tx_point_call_ack,
+	rxrpc_tx_point_call_data_frag,
+	rxrpc_tx_point_call_data_nofrag,
+	rxrpc_tx_point_call_final_resend,
+	rxrpc_tx_point_conn_abort,
+	rxrpc_tx_point_rxkad_challenge,
+	rxrpc_tx_point_rxkad_response,
+	rxrpc_tx_point_reject,
+	rxrpc_tx_point_version_keepalive,
+	rxrpc_tx_point_version_reply,
 };
 
 #endif /* end __RXRPC_DECLARE_TRACE_ENUMS_ONCE_ONLY */
@@ -452,18 +452,18 @@ enum rxrpc_tx_fail_trace {
 	EM(RXRPC_CALL_LOCAL_ERROR,		"LocalError") \
 	E_(RXRPC_CALL_NETWORK_ERROR,		"NetError")
 
-#define rxrpc_tx_fail_traces \
-	EM(rxrpc_tx_fail_call_abort,		"CallAbort") \
-	EM(rxrpc_tx_fail_call_ack,		"CallAck") \
-	EM(rxrpc_tx_fail_call_data_frag,	"CallDataFrag") \
-	EM(rxrpc_tx_fail_call_data_nofrag,	"CallDataNofrag") \
-	EM(rxrpc_tx_fail_call_final_resend,	"CallFinalResend") \
-	EM(rxrpc_tx_fail_conn_abort,		"ConnAbort") \
-	EM(rxrpc_tx_fail_conn_challenge,	"ConnChall") \
-	EM(rxrpc_tx_fail_conn_response,		"ConnResp") \
-	EM(rxrpc_tx_fail_reject,		"Reject") \
-	EM(rxrpc_tx_fail_version_keepalive,	"VerKeepalive") \
-	E_(rxrpc_tx_fail_version_reply,		"VerReply")
+#define rxrpc_tx_points \
+	EM(rxrpc_tx_point_call_abort,		"CallAbort") \
+	EM(rxrpc_tx_point_call_ack,		"CallAck") \
+	EM(rxrpc_tx_point_call_data_frag,	"CallDataFrag") \
+	EM(rxrpc_tx_point_call_data_nofrag,	"CallDataNofrag") \
+	EM(rxrpc_tx_point_call_final_resend,	"CallFinalResend") \
+	EM(rxrpc_tx_point_conn_abort,		"ConnAbort") \
+	EM(rxrpc_tx_point_reject,		"Reject") \
+	EM(rxrpc_tx_point_rxkad_challenge,	"RxkadChall") \
+	EM(rxrpc_tx_point_rxkad_response,	"RxkadResp") \
+	EM(rxrpc_tx_point_version_keepalive,	"VerKeepalive") \
+	E_(rxrpc_tx_point_version_reply,	"VerReply")
 
 /*
  * Export enum symbols via userspace.
@@ -488,7 +488,7 @@ rxrpc_propose_ack_traces;
 rxrpc_propose_ack_outcomes;
 rxrpc_congest_modes;
 rxrpc_congest_changes;
-rxrpc_tx_fail_traces;
+rxrpc_tx_points;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -801,7 +801,7 @@ TRACE_EVENT(rxrpc_transmit,
 	    );
 
 TRACE_EVENT(rxrpc_rx_data,
-	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
+	    TP_PROTO(unsigned int call, rxrpc_seq_t seq,
 		     rxrpc_serial_t serial, u8 flags, u8 anno),
 
 	    TP_ARGS(call, seq, serial, flags, anno),
@@ -815,7 +815,7 @@ TRACE_EVENT(rxrpc_rx_data,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call;
 		    __entry->seq = seq;
 		    __entry->serial = serial;
 		    __entry->flags = flags;
@@ -918,6 +918,37 @@ TRACE_EVENT(rxrpc_rx_rwind_change,
 		      __entry->wake ? " wake" : "")
 	    );
 
+TRACE_EVENT(rxrpc_tx_packet,
+	    TP_PROTO(unsigned int call_id, struct rxrpc_wire_header *whdr,
+		     enum rxrpc_tx_point where),
+
+	    TP_ARGS(call_id, whdr, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			call	)
+		    __field(enum rxrpc_tx_point,		where	)
+		    __field_struct(struct rxrpc_wire_header,	whdr	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call_id;
+		    memcpy(&__entry->whdr, whdr, sizeof(__entry->whdr));
+			   ),
+
+	    TP_printk("c=%08x %08x:%08x:%08x:%04x %08x %08x %02x %02x %s %s",
+		      __entry->call,
+		      ntohl(__entry->whdr.epoch),
+		      ntohl(__entry->whdr.cid),
+		      ntohl(__entry->whdr.callNumber),
+		      ntohs(__entry->whdr.serviceId),
+		      ntohl(__entry->whdr.serial),
+		      ntohl(__entry->whdr.seq),
+		      __entry->whdr.type, __entry->whdr.flags,
+		      __entry->whdr.type <= 15 ?
+		      __print_symbolic(__entry->whdr.type, rxrpc_pkts) : "?UNK",
+		      __print_symbolic(__entry->where, rxrpc_tx_points))
+	    );
+
 TRACE_EVENT(rxrpc_tx_data,
 	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
 		     rxrpc_serial_t serial, u8 flags, bool retrans, bool lose),
@@ -928,6 +959,8 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __field(unsigned int,		call		)
 		    __field(rxrpc_seq_t,		seq		)
 		    __field(rxrpc_serial_t,		serial		)
+		    __field(u32,			cid		)
+		    __field(u32,			call_id		)
 		    __field(u8,				flags		)
 		    __field(bool,			retrans		)
 		    __field(bool,			lose		)
@@ -935,6 +968,8 @@ TRACE_EVENT(rxrpc_tx_data,
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
+		    __entry->cid = call->cid;
+		    __entry->call_id = call->call_id;
 		    __entry->seq = seq;
 		    __entry->serial = serial;
 		    __entry->flags = flags;
@@ -942,8 +977,10 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __entry->lose = lose;
 			   ),
 
-	    TP_printk("c=%08x DATA %08x q=%08x fl=%02x%s%s",
+	    TP_printk("c=%08x DATA %08x:%08x %08x q=%08x fl=%02x%s%s",
 		      __entry->call,
+		      __entry->cid,
+		      __entry->call_id,
 		      __entry->serial,
 		      __entry->seq,
 		      __entry->flags,
@@ -952,7 +989,7 @@ TRACE_EVENT(rxrpc_tx_data,
 	    );
 
 TRACE_EVENT(rxrpc_tx_ack,
-	    TP_PROTO(struct rxrpc_call *call, rxrpc_serial_t serial,
+	    TP_PROTO(unsigned int call, rxrpc_serial_t serial,
 		     rxrpc_seq_t ack_first, rxrpc_serial_t ack_serial,
 		     u8 reason, u8 n_acks),
 
@@ -968,7 +1005,7 @@ TRACE_EVENT(rxrpc_tx_ack,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call ? call->debug_id : 0;
+		    __entry->call = call;
 		    __entry->serial = serial;
 		    __entry->ack_first = ack_first;
 		    __entry->ack_serial = ack_serial;
@@ -1434,29 +1471,29 @@ TRACE_EVENT(rxrpc_rx_icmp,
 
 TRACE_EVENT(rxrpc_tx_fail,
 	    TP_PROTO(unsigned int debug_id, rxrpc_serial_t serial, int ret,
-		     enum rxrpc_tx_fail_trace what),
+		     enum rxrpc_tx_point where),
 
-	    TP_ARGS(debug_id, serial, ret, what),
+	    TP_ARGS(debug_id, serial, ret, where),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		debug_id	)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(int,			ret		)
-		    __field(enum rxrpc_tx_fail_trace,   what		)
+		    __field(enum rxrpc_tx_point,	where		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->debug_id = debug_id;
 		    __entry->serial = serial;
 		    __entry->ret = ret;
-		    __entry->what = what;
+		    __entry->where = where;
 			   ),
 
 	    TP_printk("c=%08x r=%x ret=%d %s",
 		      __entry->debug_id,
 		      __entry->serial,
 		      __entry->ret,
-		      __print_symbolic(__entry->what, rxrpc_tx_fail_traces))
+		      __print_symbolic(__entry->where, rxrpc_tx_points))
 	    );
 
 TRACE_EVENT(rxrpc_call_reset,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5fb7d3254d9e..7eee955a768a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -420,6 +420,7 @@ struct rxrpc_connection {
 	struct rxrpc_channel {
 		unsigned long		final_ack_at;	/* Time at which to issue final ACK */
 		struct rxrpc_call __rcu	*call;		/* Active call */
+		unsigned int		call_debug_id;	/* call->debug_id */
 		u32			call_id;	/* ID of current call */
 		u32			call_counter;	/* Call ID counter */
 		u32			last_call;	/* ID of last call */
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index e4bfbd7e48a8..f8f37188a932 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -590,6 +590,7 @@ static void rxrpc_activate_one_channel(struct rxrpc_connection *conn,
 	 */
 	smp_wmb();
 	chan->call_id	= call_id;
+	chan->call_debug_id = call->debug_id;
 	rcu_assign_pointer(chan->call, call);
 	wake_up(&call->waitq);
 }
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index d46a68807f08..84d40ba9856f 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -129,7 +129,7 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		_proto("Tx ABORT %%%u { %d } [re]", serial, conn->local_abort);
 		break;
 	case RXRPC_PACKET_TYPE_ACK:
-		trace_rxrpc_tx_ack(NULL, serial,
+		trace_rxrpc_tx_ack(chan->call_debug_id, serial,
 				   ntohl(pkt.ack.firstPacket),
 				   ntohl(pkt.ack.serial),
 				   pkt.ack.reason, 0);
@@ -140,8 +140,11 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, ioc, len);
 	conn->params.peer->last_tx_at = ktime_get_real();
 	if (ret < 0)
-		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
-				    rxrpc_tx_fail_call_final_resend);
+		trace_rxrpc_tx_fail(chan->call_debug_id, serial, ret,
+				    rxrpc_tx_point_call_final_resend);
+	else
+		trace_rxrpc_tx_packet(chan->call_debug_id, &pkt.whdr,
+				      rxrpc_tx_point_call_final_resend);
 
 	_leave("");
 }
@@ -242,11 +245,13 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
-				    rxrpc_tx_fail_conn_abort);
+				    rxrpc_tx_point_conn_abort);
 		_debug("sendmsg failed: %d", ret);
 		return -EAGAIN;
 	}
 
+	trace_rxrpc_tx_packet(conn->debug_id, &whdr, rxrpc_tx_point_conn_abort);
+
 	conn->params.peer->last_tx_at = ktime_get_real();
 
 	_leave(" = 0");
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 608d078a4981..8989d760b6b2 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -496,7 +496,7 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb,
 			return rxrpc_proto_abort("LSA", call, seq);
 	}
 
-	trace_rxrpc_rx_data(call, seq, serial, flags, annotation);
+	trace_rxrpc_rx_data(call->debug_id, seq, serial, flags, annotation);
 	if (before_eq(seq, hard_ack)) {
 		ack = RXRPC_ACK_DUPLICATE;
 		ack_serial = serial;
@@ -592,6 +592,10 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb,
 		rxrpc_propose_ACK(call, ack, skew, ack_serial,
 				  immediate_ack, true,
 				  rxrpc_propose_ack_input_data);
+	else
+		rxrpc_propose_ACK(call, RXRPC_ACK_DELAY, skew, serial,
+				  false, true,
+				  rxrpc_propose_ack_input_data);
 
 	if (sp->hdr.seq == READ_ONCE(call->rx_hard_ack) + 1)
 		rxrpc_notify_socket(call);
@@ -1262,6 +1266,11 @@ void rxrpc_data_ready(struct sock *udp_sk)
 			/* But otherwise we need to retransmit the final packet
 			 * from data cached in the connection record.
 			 */
+			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA)
+				trace_rxrpc_rx_data(chan->call_debug_id,
+						    sp->hdr.seq,
+						    sp->hdr.serial,
+						    sp->hdr.flags, 0);
 			rxrpc_post_packet_to_conn(conn, skb);
 			goto out_unlock;
 		}
diff --git a/net/rxrpc/local_event.c b/net/rxrpc/local_event.c
index 8325f1b86840..13bd8a4dfac7 100644
--- a/net/rxrpc/local_event.c
+++ b/net/rxrpc/local_event.c
@@ -72,7 +72,10 @@ static void rxrpc_send_version_request(struct rxrpc_local *local,
 	ret = kernel_sendmsg(local->socket, &msg, iov, 2, len);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(local->debug_id, 0, ret,
-				    rxrpc_tx_fail_version_reply);
+				    rxrpc_tx_point_version_reply);
+	else
+		trace_rxrpc_tx_packet(local->debug_id, &whdr,
+				      rxrpc_tx_point_version_reply);
 
 	_leave("");
 }
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index f03de1c59ba3..801dbf3d3478 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -183,7 +183,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 
 	serial = atomic_inc_return(&conn->serial);
 	pkt->whdr.serial = htonl(serial);
-	trace_rxrpc_tx_ack(call, serial,
+	trace_rxrpc_tx_ack(call->debug_id, serial,
 			   ntohl(pkt->ack.firstPacket),
 			   ntohl(pkt->ack.serial),
 			   pkt->ack.reason, pkt->ack.nAcks);
@@ -212,7 +212,10 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	conn->params.peer->last_tx_at = ktime_get_real();
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
-				    rxrpc_tx_fail_call_ack);
+				    rxrpc_tx_point_call_ack);
+	else
+		trace_rxrpc_tx_packet(call->debug_id, &pkt->whdr,
+				      rxrpc_tx_point_call_ack);
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
 		if (ret < 0) {
@@ -299,7 +302,10 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 	conn->params.peer->last_tx_at = ktime_get_real();
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
-				    rxrpc_tx_fail_call_abort);
+				    rxrpc_tx_point_call_abort);
+	else
+		trace_rxrpc_tx_packet(call->debug_id, &pkt.whdr,
+				      rxrpc_tx_point_call_abort);
 
 
 	rxrpc_put_connection(conn);
@@ -396,7 +402,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	up_read(&conn->params.local->defrag_sem);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
-				    rxrpc_tx_fail_call_data_nofrag);
+				    rxrpc_tx_point_call_data_nofrag);
+	else
+		trace_rxrpc_tx_packet(call->debug_id, &whdr,
+				      rxrpc_tx_point_call_data_nofrag);
 	if (ret == -EMSGSIZE)
 		goto send_fragmentable;
 
@@ -488,7 +497,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
-				    rxrpc_tx_fail_call_data_frag);
+				    rxrpc_tx_point_call_data_frag);
+	else
+		trace_rxrpc_tx_packet(call->debug_id, &whdr,
+				      rxrpc_tx_point_call_data_frag);
 
 	up_write(&conn->params.local->defrag_sem);
 	goto done;
@@ -545,7 +557,10 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 			ret = kernel_sendmsg(local->socket, &msg, iov, 2, size);
 			if (ret < 0)
 				trace_rxrpc_tx_fail(local->debug_id, 0, ret,
-						    rxrpc_tx_fail_reject);
+						    rxrpc_tx_point_reject);
+			else
+				trace_rxrpc_tx_packet(local->debug_id, &whdr,
+						      rxrpc_tx_point_reject);
 		}
 
 		rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
@@ -597,7 +612,10 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 	ret = kernel_sendmsg(peer->local->socket, &msg, iov, 2, len);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(peer->debug_id, 0, ret,
-				    rxrpc_tx_fail_version_keepalive);
+				    rxrpc_tx_point_version_keepalive);
+	else
+		trace_rxrpc_tx_packet(peer->debug_id, &whdr,
+				      rxrpc_tx_point_version_keepalive);
 
 	peer->last_tx_at = ktime_get_real();
 	_leave("");
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 278ac0807a60..6988073ae842 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -665,11 +665,13 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
-				    rxrpc_tx_fail_conn_challenge);
+				    rxrpc_tx_point_rxkad_challenge);
 		return -EAGAIN;
 	}
 
 	conn->params.peer->last_tx_at = ktime_get_real();
+	trace_rxrpc_tx_packet(conn->debug_id, &whdr,
+			      rxrpc_tx_point_rxkad_challenge);
 	_leave(" = 0");
 	return 0;
 }
@@ -721,11 +723,12 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 3, len);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
-				    rxrpc_tx_fail_conn_response);
+				    rxrpc_tx_point_rxkad_response);
 		return -EAGAIN;
 	}
 
 	conn->params.peer->last_tx_at = ktime_get_real();
+	trace_rxrpc_tx_packet(0, &whdr, rxrpc_tx_point_rxkad_response);
 	_leave(" = 0");
 	return 0;
 }

