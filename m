Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeC3VPF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:15:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753099AbeC3VPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:15:02 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 09/12] rxrpc: Add a tracepoint to track rxrpc_local
 refcounting
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:15:00 +0100
Message-ID: <152244450046.4629.5042979694750904739.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint to track reference counting on the rxrpc_local struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |   43 ++++++++++++++++++++++++++++
 net/rxrpc/ar-internal.h      |   27 +++--------------
 net/rxrpc/call_accept.c      |    3 +-
 net/rxrpc/local_object.c     |   65 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 2ea788f6f95d..0410dfeb79c6 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -42,6 +42,14 @@ enum rxrpc_skb_trace {
 	rxrpc_skb_tx_seen,
 };
 
+enum rxrpc_local_trace {
+	rxrpc_local_got,
+	rxrpc_local_new,
+	rxrpc_local_processing,
+	rxrpc_local_put,
+	rxrpc_local_queued,
+};
+
 enum rxrpc_conn_trace {
 	rxrpc_conn_got,
 	rxrpc_conn_new_client,
@@ -215,6 +223,13 @@ enum rxrpc_congest_change {
 	EM(rxrpc_skb_tx_rotated,		"Tx ROT") \
 	E_(rxrpc_skb_tx_seen,			"Tx SEE")
 
+#define rxrpc_local_traces \
+	EM(rxrpc_local_got,			"GOT") \
+	EM(rxrpc_local_new,			"NEW") \
+	EM(rxrpc_local_processing,		"PRO") \
+	EM(rxrpc_local_put,			"PUT") \
+	E_(rxrpc_local_queued,			"QUE")
+
 #define rxrpc_conn_traces \
 	EM(rxrpc_conn_got,			"GOT") \
 	EM(rxrpc_conn_new_client,		"NWc") \
@@ -416,6 +431,7 @@ enum rxrpc_congest_change {
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
 rxrpc_skb_traces;
+rxrpc_local_traces;
 rxrpc_conn_traces;
 rxrpc_client_traces;
 rxrpc_call_traces;
@@ -439,6 +455,33 @@ rxrpc_congest_changes;
 #define EM(a, b)	{ a, b },
 #define E_(a, b)	{ a, b }
 
+TRACE_EVENT(rxrpc_local,
+	    TP_PROTO(struct rxrpc_local *local, enum rxrpc_local_trace op,
+		     int usage, const void *where),
+
+	    TP_ARGS(local, op, usage, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	local		)
+		    __field(int,		op		)
+		    __field(int,		usage		)
+		    __field(const void *,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->local = local->debug_id;
+		    __entry->op = op;
+		    __entry->usage = usage;
+		    __entry->where = where;
+			   ),
+
+	    TP_printk("L=%08x %s u=%d sp=%pSR",
+		      __entry->local,
+		      __print_symbolic(__entry->op, rxrpc_local_traces),
+		      __entry->usage,
+		      __entry->where)
+	    );
+
 TRACE_EVENT(rxrpc_conn,
 	    TP_PROTO(struct rxrpc_connection *conn, enum rxrpc_conn_trace op,
 		     int usage, const void *where),
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 2a2b0fdfb157..cc51d3eb0548 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -981,31 +981,12 @@ extern void rxrpc_process_local_events(struct rxrpc_local *);
  * local_object.c
  */
 struct rxrpc_local *rxrpc_lookup_local(struct net *, const struct sockaddr_rxrpc *);
-void __rxrpc_put_local(struct rxrpc_local *);
+struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *);
+struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *);
+void rxrpc_put_local(struct rxrpc_local *);
+void rxrpc_queue_local(struct rxrpc_local *);
 void rxrpc_destroy_all_locals(struct rxrpc_net *);
 
-static inline void rxrpc_get_local(struct rxrpc_local *local)
-{
-	atomic_inc(&local->usage);
-}
-
-static inline
-struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *local)
-{
-	return atomic_inc_not_zero(&local->usage) ? local : NULL;
-}
-
-static inline void rxrpc_put_local(struct rxrpc_local *local)
-{
-	if (local && atomic_dec_and_test(&local->usage))
-		__rxrpc_put_local(local);
-}
-
-static inline void rxrpc_queue_local(struct rxrpc_local *local)
-{
-	rxrpc_queue_work(&local->processor);
-}
-
 /*
  * misc.c
  */
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 493545033e42..5a9b1d916124 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -296,8 +296,7 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 		b->conn_backlog[conn_tail] = NULL;
 		smp_store_release(&b->conn_backlog_tail,
 				  (conn_tail + 1) & (RXRPC_BACKLOG_MAX - 1));
-		rxrpc_get_local(local);
-		conn->params.local = local;
+		conn->params.local = rxrpc_get_local(local);
 		conn->params.peer = peer;
 		rxrpc_see_connection(conn);
 		rxrpc_new_incoming_connection(rx, conn, skb);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 38b99db30e54..8b54e9531d52 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -95,6 +95,7 @@ static struct rxrpc_local *rxrpc_alloc_local(struct rxrpc_net *rxnet,
 		local->debug_id = atomic_inc_return(&rxrpc_debug_id);
 		memcpy(&local->srx, srx, sizeof(*srx));
 		local->srx.srx_service = 0;
+		trace_rxrpc_local(local, rxrpc_local_new, 1, NULL);
 	}
 
 	_leave(" = %p", local);
@@ -256,15 +257,74 @@ struct rxrpc_local *rxrpc_lookup_local(struct net *net,
 	return ERR_PTR(-EADDRINUSE);
 }
 
+/*
+ * Get a ref on a local endpoint.
+ */
+struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *local)
+{
+	const void *here = __builtin_return_address(0);
+	int n;
+
+	n = atomic_inc_return(&local->usage);
+	trace_rxrpc_local(local, rxrpc_local_got, n, here);
+	return local;
+}
+
+/*
+ * Get a ref on a local endpoint unless its usage has already reached 0.
+ */
+struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *local)
+{
+	const void *here = __builtin_return_address(0);
+
+	if (local) {
+		int n = __atomic_add_unless(&local->usage, 1, 0);
+		if (n > 0)
+			trace_rxrpc_local(local, rxrpc_local_got, n + 1, here);
+		else
+			local = NULL;
+	}
+	return local;
+}
+
+/*
+ * Queue a local endpoint.
+ */
+void rxrpc_queue_local(struct rxrpc_local *local)
+{
+	const void *here = __builtin_return_address(0);
+
+	if (rxrpc_queue_work(&local->processor))
+		trace_rxrpc_local(local, rxrpc_local_queued,
+				  atomic_read(&local->usage), here);
+}
+
 /*
  * A local endpoint reached its end of life.
  */
-void __rxrpc_put_local(struct rxrpc_local *local)
+static void __rxrpc_put_local(struct rxrpc_local *local)
 {
 	_enter("%d", local->debug_id);
 	rxrpc_queue_work(&local->processor);
 }
 
+/*
+ * Drop a ref on a local endpoint.
+ */
+void rxrpc_put_local(struct rxrpc_local *local)
+{
+	const void *here = __builtin_return_address(0);
+	int n;
+
+	if (local) {
+		n = atomic_dec_return(&local->usage);
+		trace_rxrpc_local(local, rxrpc_local_put, n, here);
+
+		if (n == 0)
+			__rxrpc_put_local(local);
+	}
+}
+
 /*
  * Destroy a local endpoint's socket and then hand the record to RCU to dispose
  * of.
@@ -322,7 +382,8 @@ static void rxrpc_local_processor(struct work_struct *work)
 		container_of(work, struct rxrpc_local, processor);
 	bool again;
 
-	_enter("%d", local->debug_id);
+	trace_rxrpc_local(local, rxrpc_local_processing,
+			  atomic_read(&local->usage), NULL);
 
 	do {
 		again = false;
