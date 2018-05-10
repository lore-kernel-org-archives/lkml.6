Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeEJWpy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:45:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751649AbeEJWpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:45:49 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 5/5] rxrpc: Trace UDP transmission failure
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 23:45:47 +0100
Message-ID: <152599234790.26376.4005965432336029696.stgit@warthog.procyon.org.uk>
In-Reply-To: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
References: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint to log transmission failure from the UDP transport socket
being used by AF_RXRPC.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |   55 ++++++++++++++++++++++++++++++++++++++++++
 net/rxrpc/conn_event.c       |   11 ++++++--
 net/rxrpc/local_event.c      |    3 ++
 net/rxrpc/output.c           |   23 ++++++++++++++++--
 net/rxrpc/rxkad.c            |    6 +++--
 5 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 497d0b67f421..077e664ac9a2 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -211,6 +211,20 @@ enum rxrpc_congest_change {
 	rxrpc_cong_saw_nack,
 };
 
+enum rxrpc_tx_fail_trace {
+	rxrpc_tx_fail_call_abort,
+	rxrpc_tx_fail_call_ack,
+	rxrpc_tx_fail_call_data_frag,
+	rxrpc_tx_fail_call_data_nofrag,
+	rxrpc_tx_fail_call_final_resend,
+	rxrpc_tx_fail_conn_abort,
+	rxrpc_tx_fail_conn_challenge,
+	rxrpc_tx_fail_conn_response,
+	rxrpc_tx_fail_reject,
+	rxrpc_tx_fail_version_keepalive,
+	rxrpc_tx_fail_version_reply,
+};
+
 #endif /* end __RXRPC_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 /*
@@ -438,6 +452,19 @@ enum rxrpc_congest_change {
 	EM(RXRPC_CALL_LOCAL_ERROR,		"LocalError") \
 	E_(RXRPC_CALL_NETWORK_ERROR,		"NetError")
 
+#define rxrpc_tx_fail_traces \
+	EM(rxrpc_tx_fail_call_abort,		"CallAbort") \
+	EM(rxrpc_tx_fail_call_ack,		"CallAck") \
+	EM(rxrpc_tx_fail_call_data_frag,	"CallDataFrag") \
+	EM(rxrpc_tx_fail_call_data_nofrag,	"CallDataNofrag") \
+	EM(rxrpc_tx_fail_call_final_resend,	"CallFinalResend") \
+	EM(rxrpc_tx_fail_conn_abort,		"ConnAbort") \
+	EM(rxrpc_tx_fail_conn_challenge,	"ConnChall") \
+	EM(rxrpc_tx_fail_conn_response,		"ConnResp") \
+	EM(rxrpc_tx_fail_reject,		"Reject") \
+	EM(rxrpc_tx_fail_version_keepalive,	"VerKeepalive") \
+	E_(rxrpc_tx_fail_version_reply,		"VerReply")
+
 /*
  * Export enum symbols via userspace.
  */
@@ -461,6 +488,7 @@ rxrpc_propose_ack_traces;
 rxrpc_propose_ack_outcomes;
 rxrpc_congest_modes;
 rxrpc_congest_changes;
+rxrpc_tx_fail_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -1404,6 +1432,33 @@ TRACE_EVENT(rxrpc_rx_icmp,
 		      &__entry->srx.transport)
 	    );
 
+TRACE_EVENT(rxrpc_tx_fail,
+	    TP_PROTO(unsigned int debug_id, rxrpc_serial_t serial, int ret,
+		     enum rxrpc_tx_fail_trace what),
+
+	    TP_ARGS(debug_id, serial, ret, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		debug_id	)
+		    __field(rxrpc_serial_t,		serial		)
+		    __field(int,			ret		)
+		    __field(enum rxrpc_tx_fail_trace,   what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->debug_id = debug_id;
+		    __entry->serial = serial;
+		    __entry->ret = ret;
+		    __entry->what = what;
+			   ),
+
+	    TP_printk("c=%08x r=%x ret=%d %s",
+		      __entry->debug_id,
+		      __entry->serial,
+		      __entry->ret,
+		      __print_symbolic(__entry->what, rxrpc_tx_fail_traces))
+	    );
+
 #endif /* _TRACE_RXRPC_H */
 
 /* This part must be outside protection */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index c717152070df..1350f1be8037 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -40,7 +40,7 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	} __attribute__((packed)) pkt;
 	struct rxrpc_ackinfo ack_info;
 	size_t len;
-	int ioc;
+	int ret, ioc;
 	u32 serial, mtu, call_id, padding;
 
 	_enter("%d", conn->debug_id);
@@ -135,10 +135,13 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		break;
 	}
 
-	kernel_sendmsg(conn->params.local->socket, &msg, iov, ioc, len);
+	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, ioc, len);
 	conn->params.peer->last_tx_at = ktime_get_real();
+	if (ret < 0)
+		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+				    rxrpc_tx_fail_call_final_resend);
+
 	_leave("");
-	return;
 }
 
 /*
@@ -236,6 +239,8 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
+		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+				    rxrpc_tx_fail_conn_abort);
 		_debug("sendmsg failed: %d", ret);
 		return -EAGAIN;
 	}
diff --git a/net/rxrpc/local_event.c b/net/rxrpc/local_event.c
index 93b5d910b4a1..8325f1b86840 100644
--- a/net/rxrpc/local_event.c
+++ b/net/rxrpc/local_event.c
@@ -71,7 +71,8 @@ static void rxrpc_send_version_request(struct rxrpc_local *local,
 
 	ret = kernel_sendmsg(local->socket, &msg, iov, 2, len);
 	if (ret < 0)
-		_debug("sendmsg failed: %d", ret);
+		trace_rxrpc_tx_fail(local->debug_id, 0, ret,
+				    rxrpc_tx_fail_version_reply);
 
 	_leave("");
 }
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 6b9d27f0d7ec..f03de1c59ba3 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -210,6 +210,9 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	if (ping)
 		call->ping_time = now;
 	conn->params.peer->last_tx_at = ktime_get_real();
+	if (ret < 0)
+		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+				    rxrpc_tx_fail_call_ack);
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
 		if (ret < 0) {
@@ -294,6 +297,10 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 	ret = kernel_sendmsg(conn->params.local->socket,
 			     &msg, iov, 1, sizeof(pkt));
 	conn->params.peer->last_tx_at = ktime_get_real();
+	if (ret < 0)
+		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+				    rxrpc_tx_fail_call_abort);
+
 
 	rxrpc_put_connection(conn);
 	return ret;
@@ -387,6 +394,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	conn->params.peer->last_tx_at = ktime_get_real();
 
 	up_read(&conn->params.local->defrag_sem);
+	if (ret < 0)
+		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+				    rxrpc_tx_fail_call_data_nofrag);
 	if (ret == -EMSGSIZE)
 		goto send_fragmentable;
 
@@ -476,6 +486,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 #endif
 	}
 
+	if (ret < 0)
+		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+				    rxrpc_tx_fail_call_data_frag);
+
 	up_write(&conn->params.local->defrag_sem);
 	goto done;
 }
@@ -493,6 +507,7 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 	struct kvec iov[2];
 	size_t size;
 	__be32 code;
+	int ret;
 
 	_enter("%d", local->debug_id);
 
@@ -527,7 +542,10 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 			whdr.flags	^= RXRPC_CLIENT_INITIATED;
 			whdr.flags	&= RXRPC_CLIENT_INITIATED;
 
-			kernel_sendmsg(local->socket, &msg, iov, 2, size);
+			ret = kernel_sendmsg(local->socket, &msg, iov, 2, size);
+			if (ret < 0)
+				trace_rxrpc_tx_fail(local->debug_id, 0, ret,
+						    rxrpc_tx_fail_reject);
 		}
 
 		rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
@@ -578,7 +596,8 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 
 	ret = kernel_sendmsg(peer->local->socket, &msg, iov, 2, len);
 	if (ret < 0)
-		_debug("sendmsg failed: %d", ret);
+		trace_rxrpc_tx_fail(peer->debug_id, 0, ret,
+				    rxrpc_tx_fail_version_keepalive);
 
 	peer->last_tx_at = ktime_get_real();
 	_leave("");
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 588fea0dd362..6c0ae27fff84 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -664,7 +664,8 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
-		_debug("sendmsg failed: %d", ret);
+		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+				    rxrpc_tx_fail_conn_challenge);
 		return -EAGAIN;
 	}
 
@@ -719,7 +720,8 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 3, len);
 	if (ret < 0) {
-		_debug("sendmsg failed: %d", ret);
+		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+				    rxrpc_tx_fail_conn_response);
 		return -EAGAIN;
 	}
 
