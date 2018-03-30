Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeC3VPT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:15:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752889AbeC3VPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:15:15 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 11/12] rxrpc: Add a tracepoint to track rxrpc_peer
 refcounting
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:15:13 +0100
Message-ID: <152244451323.4629.14491504044376715256.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint to track reference counting on the rxrpc_peer struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |   42 +++++++++++++++++++++++++++
 net/rxrpc/ar-internal.h      |   23 +++------------
 net/rxrpc/peer_event.c       |    2 +
 net/rxrpc/peer_object.c      |   65 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 110 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 0410dfeb79c6..9e96c2fe2793 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -50,6 +50,14 @@ enum rxrpc_local_trace {
 	rxrpc_local_queued,
 };
 
+enum rxrpc_peer_trace {
+	rxrpc_peer_got,
+	rxrpc_peer_new,
+	rxrpc_peer_processing,
+	rxrpc_peer_put,
+	rxrpc_peer_queued_error,
+};
+
 enum rxrpc_conn_trace {
 	rxrpc_conn_got,
 	rxrpc_conn_new_client,
@@ -230,6 +238,13 @@ enum rxrpc_congest_change {
 	EM(rxrpc_local_put,			"PUT") \
 	E_(rxrpc_local_queued,			"QUE")
 
+#define rxrpc_peer_traces \
+	EM(rxrpc_peer_got,			"GOT") \
+	EM(rxrpc_peer_new,			"NEW") \
+	EM(rxrpc_peer_processing,		"PRO") \
+	EM(rxrpc_peer_put,			"PUT") \
+	E_(rxrpc_peer_queued_error,		"QER")
+
 #define rxrpc_conn_traces \
 	EM(rxrpc_conn_got,			"GOT") \
 	EM(rxrpc_conn_new_client,		"NWc") \
@@ -482,6 +497,33 @@ TRACE_EVENT(rxrpc_local,
 		      __entry->where)
 	    );
 
+TRACE_EVENT(rxrpc_peer,
+	    TP_PROTO(struct rxrpc_peer *peer, enum rxrpc_peer_trace op,
+		     int usage, const void *where),
+
+	    TP_ARGS(peer, op, usage, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	peer		)
+		    __field(int,		op		)
+		    __field(int,		usage		)
+		    __field(const void *,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->peer = peer->debug_id;
+		    __entry->op = op;
+		    __entry->usage = usage;
+		    __entry->where = where;
+			   ),
+
+	    TP_printk("P=%08x %s u=%d sp=%pSR",
+		      __entry->peer,
+		      __print_symbolic(__entry->op, rxrpc_peer_traces),
+		      __entry->usage,
+		      __entry->where)
+	    );
+
 TRACE_EVENT(rxrpc_conn,
 	    TP_PROTO(struct rxrpc_connection *conn, enum rxrpc_conn_trace op,
 		     int usage, const void *where),
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index d40d54b78567..c46583bc255d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1041,25 +1041,10 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *,
 struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *, gfp_t);
 struct rxrpc_peer *rxrpc_lookup_incoming_peer(struct rxrpc_local *,
 					      struct rxrpc_peer *);
-
-static inline struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *peer)
-{
-	atomic_inc(&peer->usage);
-	return peer;
-}
-
-static inline
-struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *peer)
-{
-	return atomic_inc_not_zero(&peer->usage) ? peer : NULL;
-}
-
-extern void __rxrpc_put_peer(struct rxrpc_peer *peer);
-static inline void rxrpc_put_peer(struct rxrpc_peer *peer)
-{
-	if (peer && atomic_dec_and_test(&peer->usage))
-		__rxrpc_put_peer(peer);
-}
+struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *);
+struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *);
+void rxrpc_put_peer(struct rxrpc_peer *);
+void __rxrpc_queue_peer_error(struct rxrpc_peer *);
 
 /*
  * proc.c
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index d01eb9a06448..78c2f95d1f22 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -192,7 +192,7 @@ void rxrpc_error_report(struct sock *sk)
 	rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 
 	/* The ref we obtained is passed off to the work item */
-	rxrpc_queue_work(&peer->error_distributor);
+	__rxrpc_queue_peer_error(peer);
 	_leave("");
 }
 
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 94a6dbfcf129..a4a750aea1e5 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -386,9 +386,54 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 }
 
 /*
- * Discard a ref on a remote peer record.
+ * Get a ref on a peer record.
  */
-void __rxrpc_put_peer(struct rxrpc_peer *peer)
+struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *peer)
+{
+	const void *here = __builtin_return_address(0);
+	int n;
+
+	n = atomic_inc_return(&peer->usage);
+	trace_rxrpc_peer(peer, rxrpc_peer_got, n, here);
+	return peer;
+}
+
+/*
+ * Get a ref on a peer record unless its usage has already reached 0.
+ */
+struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *peer)
+{
+	const void *here = __builtin_return_address(0);
+
+	if (peer) {
+		int n = __atomic_add_unless(&peer->usage, 1, 0);
+		if (n > 0)
+			trace_rxrpc_peer(peer, rxrpc_peer_got, n + 1, here);
+		else
+			peer = NULL;
+	}
+	return peer;
+}
+
+/*
+ * Queue a peer record.  This passes the caller's ref to the workqueue.
+ */
+void __rxrpc_queue_peer_error(struct rxrpc_peer *peer)
+{
+	const void *here = __builtin_return_address(0);
+	int n;
+
+	n = atomic_read(&peer->usage);
+	if (rxrpc_queue_work(&peer->error_distributor))
+		trace_rxrpc_peer(peer, rxrpc_peer_queued_error, n, here);
+	else
+		rxrpc_put_peer(peer);
+}
+
+/*
+ * Discard a peer record.
+ */
+static void __rxrpc_put_peer(struct rxrpc_peer *peer)
 {
 	struct rxrpc_net *rxnet = peer->local->rxnet;
 
@@ -402,6 +447,22 @@ void __rxrpc_put_peer(struct rxrpc_peer *peer)
 	kfree_rcu(peer, rcu);
 }
 
+/*
+ * Drop a ref on a peer record.
+ */
+void rxrpc_put_peer(struct rxrpc_peer *peer)
+{
+	const void *here = __builtin_return_address(0);
+	int n;
+
+	if (peer) {
+		n = atomic_dec_return(&peer->usage);
+		trace_rxrpc_peer(peer, rxrpc_peer_put, n, here);
+		if (n == 0)
+			__rxrpc_put_peer(peer);
+	}
+}
+
 /**
  * rxrpc_kernel_get_peer - Get the peer address of a call
  * @sock: The socket on which the call is in progress.
