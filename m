Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeC0W6x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:58:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752517AbeC0W6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:58:04 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 2/3] rxrpc,
 afs: Use debug_ids rather than pointers in traces
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 23:58:02 +0100
Message-ID: <152219148268.24730.5448775833085412541.stgit@warthog.procyon.org.uk>
In-Reply-To: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
References: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rxrpc and afs, use the debug_ids that are monotonically allocated to
various objects as they're allocated rather than pointers as kernel
pointers are now hashed making them less useful.  Further, the debug ids
aren't reused anywhere nearly as quickly.

In addition, allow kernel services that use rxrpc, such as afs, to take
numbers from the rxrpc counter, assign them to their own call struct and
pass them in to rxrpc for both client and service calls so that the trace
lines for each will have the same ID tag.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h            |    1 
 fs/afs/rxrpc.c               |   12 ++-
 include/net/af_rxrpc.h       |   11 ++-
 include/trace/events/afs.h   |   69 ++++++++-----------
 include/trace/events/rxrpc.h |  155 +++++++++++++++++++++---------------------
 net/rxrpc/af_rxrpc.c         |    7 +-
 net/rxrpc/ar-internal.h      |    8 +-
 net/rxrpc/call_accept.c      |   18 +++--
 net/rxrpc/call_object.c      |   15 ++--
 net/rxrpc/conn_event.c       |    3 +
 net/rxrpc/input.c            |    6 +-
 net/rxrpc/sendmsg.c          |    3 +
 12 files changed, 163 insertions(+), 145 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f38d6a561a84..72217170b155 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -118,6 +118,7 @@ struct afs_call {
 	bool			ret_reply0;	/* T if should return reply[0] on success */
 	bool			upgrade;	/* T to request service upgrade */
 	u16			service_id;	/* Actual service ID (after upgrade) */
+	unsigned int		debug_id;	/* Trace ID */
 	u32			operation_ID;	/* operation ID for an incoming call */
 	u32			count;		/* count for use in unmarshalling */
 	__be32			tmp;		/* place to extract temporary data */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index e1126659f043..b819900916e6 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -131,6 +131,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 
 	call->type = type;
 	call->net = net;
+	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
 	atomic_set(&call->usage, 1);
 	INIT_WORK(&call->async_work, afs_process_async_call);
 	init_waitqueue_head(&call->waitq);
@@ -169,11 +170,12 @@ void afs_put_call(struct afs_call *call)
 		afs_put_server(call->net, call->cm_server);
 		afs_put_cb_interest(call->net, call->cbi);
 		kfree(call->request);
-		kfree(call);
 
-		o = atomic_dec_return(&net->nr_outstanding_calls);
 		trace_afs_call(call, afs_call_trace_free, 0, o,
 			       __builtin_return_address(0));
+		kfree(call);
+
+		o = atomic_dec_return(&net->nr_outstanding_calls);
 		if (o == 0)
 			wake_up_atomic_t(&net->nr_outstanding_calls);
 	}
@@ -378,7 +380,8 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 					 (async ?
 					  afs_wake_up_async_call :
 					  afs_wake_up_call_waiter),
-					 call->upgrade);
+					 call->upgrade,
+					 call->debug_id);
 	if (IS_ERR(rxcall)) {
 		ret = PTR_ERR(rxcall);
 		goto error_kill_call;
@@ -727,7 +730,8 @@ void afs_charge_preallocation(struct work_struct *work)
 					       afs_wake_up_async_call,
 					       afs_rx_attach,
 					       (unsigned long)call,
-					       GFP_KERNEL) < 0)
+					       GFP_KERNEL,
+					       call->debug_id) < 0)
 			break;
 		call = NULL;
 	}
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 2b3a6eec4570..8ae8ee004258 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -31,6 +31,11 @@ enum rxrpc_call_completion {
 	NR__RXRPC_CALL_COMPLETIONS
 };
 
+/*
+ * Debug ID counter for tracing.
+ */
+extern atomic_t rxrpc_debug_id;
+
 typedef void (*rxrpc_notify_rx_t)(struct sock *, struct rxrpc_call *,
 				  unsigned long);
 typedef void (*rxrpc_notify_end_tx_t)(struct sock *, struct rxrpc_call *,
@@ -50,7 +55,8 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *,
 					   s64,
 					   gfp_t,
 					   rxrpc_notify_rx_t,
-					   bool);
+					   bool,
+					   unsigned int);
 int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
 			   struct msghdr *, size_t,
 			   rxrpc_notify_end_tx_t);
@@ -63,7 +69,8 @@ void rxrpc_kernel_get_peer(struct socket *, struct rxrpc_call *,
 			   struct sockaddr_rxrpc *);
 u64 rxrpc_kernel_get_rtt(struct socket *, struct rxrpc_call *);
 int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
-			       rxrpc_user_attach_call_t, unsigned long, gfp_t);
+			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
+			       unsigned int);
 void rxrpc_kernel_set_tx_length(struct socket *, struct rxrpc_call *, s64);
 int rxrpc_kernel_retry_call(struct socket *, struct rxrpc_call *,
 			    struct sockaddr_rxrpc *, struct key *);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 6b59c63a8e51..63815f66b274 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -133,8 +133,7 @@ TRACE_EVENT(afs_recv_data,
 	    TP_ARGS(call, count, offset, want_more, ret),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	rxcall		)
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(enum afs_call_state,	state		)
 		    __field(unsigned int,		count		)
 		    __field(unsigned int,		offset		)
@@ -144,8 +143,7 @@ TRACE_EVENT(afs_recv_data,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->rxcall	= call->rxcall;
-		    __entry->call	= call;
+		    __entry->call	= call->debug_id;
 		    __entry->state	= call->state;
 		    __entry->unmarshall	= call->unmarshall;
 		    __entry->count	= count;
@@ -154,8 +152,7 @@ TRACE_EVENT(afs_recv_data,
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("c=%p ac=%p s=%u u=%u %u/%u wm=%u ret=%d",
-		      __entry->rxcall,
+	    TP_printk("c=%08x s=%u u=%u %u/%u wm=%u ret=%d",
 		      __entry->call,
 		      __entry->state, __entry->unmarshall,
 		      __entry->offset, __entry->count,
@@ -168,21 +165,18 @@ TRACE_EVENT(afs_notify_call,
 	    TP_ARGS(rxcall, call),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	rxcall		)
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(enum afs_call_state,	state		)
 		    __field(unsigned short,		unmarshall	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->rxcall	= rxcall;
-		    __entry->call	= call;
+		    __entry->call	= call->debug_id;
 		    __entry->state	= call->state;
 		    __entry->unmarshall	= call->unmarshall;
 			   ),
 
-	    TP_printk("c=%p ac=%p s=%u u=%u",
-		      __entry->rxcall,
+	    TP_printk("c=%08x s=%u u=%u",
 		      __entry->call,
 		      __entry->state, __entry->unmarshall)
 	    );
@@ -193,21 +187,18 @@ TRACE_EVENT(afs_cb_call,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	rxcall		)
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(const char *,		name		)
 		    __field(u32,			op		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->rxcall	= call->rxcall;
-		    __entry->call	= call;
+		    __entry->call	= call->debug_id;
 		    __entry->name	= call->type->name;
 		    __entry->op		= call->operation_ID;
 			   ),
 
-	    TP_printk("c=%p ac=%p %s o=%u",
-		      __entry->rxcall,
+	    TP_printk("c=%08x %s o=%u",
 		      __entry->call,
 		      __entry->name,
 		      __entry->op)
@@ -220,7 +211,7 @@ TRACE_EVENT(afs_call,
 	    TP_ARGS(call, op, usage, outstanding, where),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(int,			op		)
 		    __field(int,			usage		)
 		    __field(int,			outstanding	)
@@ -228,14 +219,14 @@ TRACE_EVENT(afs_call,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->op = op;
 		    __entry->usage = usage;
 		    __entry->outstanding = outstanding;
 		    __entry->where = where;
 			   ),
 
-	    TP_printk("c=%p %s u=%d o=%d sp=%pSR",
+	    TP_printk("c=%08x %s u=%d o=%d sp=%pSR",
 		      __entry->call,
 		      __print_symbolic(__entry->op, afs_call_traces),
 		      __entry->usage,
@@ -249,13 +240,13 @@ TRACE_EVENT(afs_make_fs_call,
 	    TP_ARGS(call, fid),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(enum afs_fs_operation,	op		)
 		    __field_struct(struct afs_fid,	fid		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->op = call->operation_ID;
 		    if (fid) {
 			    __entry->fid = *fid;
@@ -266,7 +257,7 @@ TRACE_EVENT(afs_make_fs_call,
 		    }
 			   ),
 
-	    TP_printk("c=%p %06x:%06x:%06x %s",
+	    TP_printk("c=%08x %06x:%06x:%06x %s",
 		      __entry->call,
 		      __entry->fid.vid,
 		      __entry->fid.vnode,
@@ -280,16 +271,16 @@ TRACE_EVENT(afs_make_vl_call,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(enum afs_vl_operation,	op		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->op = call->operation_ID;
 			   ),
 
-	    TP_printk("c=%p %s",
+	    TP_printk("c=%08x %s",
 		      __entry->call,
 		      __print_symbolic(__entry->op, afs_vl_operations))
 	    );
@@ -300,20 +291,20 @@ TRACE_EVENT(afs_call_done,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(struct rxrpc_call *,	rx_call		)
 		    __field(int,			ret		)
 		    __field(u32,			abort_code	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->rx_call = call->rxcall;
 		    __entry->ret = call->error;
 		    __entry->abort_code = call->abort_code;
 			   ),
 
-	    TP_printk("   c=%p ret=%d ab=%d [%p]",
+	    TP_printk("   c=%08x ret=%d ab=%d [%p]",
 		      __entry->call,
 		      __entry->ret,
 		      __entry->abort_code,
@@ -327,7 +318,7 @@ TRACE_EVENT(afs_send_pages,
 	    TP_ARGS(call, msg, first, last, offset),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(pgoff_t,			first		)
 		    __field(pgoff_t,			last		)
 		    __field(unsigned int,		nr		)
@@ -337,7 +328,7 @@ TRACE_EVENT(afs_send_pages,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->first = first;
 		    __entry->last = last;
 		    __entry->nr = msg->msg_iter.nr_segs;
@@ -346,7 +337,7 @@ TRACE_EVENT(afs_send_pages,
 		    __entry->flags = msg->msg_flags;
 			   ),
 
-	    TP_printk(" c=%p %lx-%lx-%lx b=%x o=%x f=%x",
+	    TP_printk(" c=%08x %lx-%lx-%lx b=%x o=%x f=%x",
 		      __entry->call,
 		      __entry->first, __entry->first + __entry->nr - 1, __entry->last,
 		      __entry->bytes, __entry->offset,
@@ -360,7 +351,7 @@ TRACE_EVENT(afs_sent_pages,
 	    TP_ARGS(call, first, last, cursor, ret),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(pgoff_t,			first		)
 		    __field(pgoff_t,			last		)
 		    __field(pgoff_t,			cursor		)
@@ -368,14 +359,14 @@ TRACE_EVENT(afs_sent_pages,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->first = first;
 		    __entry->last = last;
 		    __entry->cursor = cursor;
 		    __entry->ret = ret;
 			   ),
 
-	    TP_printk(" c=%p %lx-%lx c=%lx r=%d",
+	    TP_printk(" c=%08x %lx-%lx c=%lx r=%d",
 		      __entry->call,
 		      __entry->first, __entry->last,
 		      __entry->cursor, __entry->ret)
@@ -450,7 +441,7 @@ TRACE_EVENT(afs_call_state,
 	    TP_ARGS(call, from, to, ret, remote_abort),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_call *,		call		)
+		    __field(unsigned int,		call		)
 		    __field(enum afs_call_state,	from		)
 		    __field(enum afs_call_state,	to		)
 		    __field(int,			ret		)
@@ -458,14 +449,14 @@ TRACE_EVENT(afs_call_state,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->from = from;
 		    __entry->to = to;
 		    __entry->ret = ret;
 		    __entry->abort = remote_abort;
 			   ),
 
-	    TP_printk("c=%p %u->%u r=%d ab=%d",
+	    TP_printk("c=%08x %u->%u r=%d ab=%d",
 		      __entry->call,
 		      __entry->from, __entry->to,
 		      __entry->ret, __entry->abort)
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 41979f907575..4d2c2d35c5cb 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -439,20 +439,20 @@ TRACE_EVENT(rxrpc_conn,
 	    TP_ARGS(conn, op, usage, where),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_connection *,	conn		)
-		    __field(int,			op		)
-		    __field(int,			usage		)
-		    __field(const void *,		where		)
+		    __field(unsigned int,	conn		)
+		    __field(int,		op		)
+		    __field(int,		usage		)
+		    __field(const void *,	where		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->conn = conn;
+		    __entry->conn = conn->debug_id;
 		    __entry->op = op;
 		    __entry->usage = usage;
 		    __entry->where = where;
 			   ),
 
-	    TP_printk("C=%p %s u=%d sp=%pSR",
+	    TP_printk("C=%08x %s u=%d sp=%pSR",
 		      __entry->conn,
 		      __print_symbolic(__entry->op, rxrpc_conn_traces),
 		      __entry->usage,
@@ -466,7 +466,7 @@ TRACE_EVENT(rxrpc_client,
 	    TP_ARGS(conn, channel, op),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_connection *,	conn		)
+		    __field(unsigned int,		conn		)
 		    __field(u32,			cid		)
 		    __field(int,			channel		)
 		    __field(int,			usage		)
@@ -475,7 +475,7 @@ TRACE_EVENT(rxrpc_client,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->conn = conn;
+		    __entry->conn = conn->debug_id;
 		    __entry->channel = channel;
 		    __entry->usage = atomic_read(&conn->usage);
 		    __entry->op = op;
@@ -483,7 +483,7 @@ TRACE_EVENT(rxrpc_client,
 		    __entry->cs = conn->cache_state;
 			   ),
 
-	    TP_printk("C=%p h=%2d %s %s i=%08x u=%d",
+	    TP_printk("C=%08x h=%2d %s %s i=%08x u=%d",
 		      __entry->conn,
 		      __entry->channel,
 		      __print_symbolic(__entry->op, rxrpc_client_traces),
@@ -499,7 +499,7 @@ TRACE_EVENT(rxrpc_call,
 	    TP_ARGS(call, op, usage, where, aux),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(int,			op		)
 		    __field(int,			usage		)
 		    __field(const void *,		where		)
@@ -507,14 +507,14 @@ TRACE_EVENT(rxrpc_call,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->op = op;
 		    __entry->usage = usage;
 		    __entry->where = where;
 		    __entry->aux = aux;
 			   ),
 
-	    TP_printk("c=%p %s u=%d sp=%pSR a=%p",
+	    TP_printk("c=%08x %s u=%d sp=%pSR a=%p",
 		      __entry->call,
 		      __print_symbolic(__entry->op, rxrpc_call_traces),
 		      __entry->usage,
@@ -593,12 +593,13 @@ TRACE_EVENT(rxrpc_rx_done,
 	    );
 
 TRACE_EVENT(rxrpc_abort,
-	    TP_PROTO(const char *why, u32 cid, u32 call_id, rxrpc_seq_t seq,
-		     int abort_code, int error),
+	    TP_PROTO(unsigned int call_nr, const char *why, u32 cid, u32 call_id,
+		     rxrpc_seq_t seq, int abort_code, int error),
 
-	    TP_ARGS(why, cid, call_id, seq, abort_code, error),
+	    TP_ARGS(call_nr, why, cid, call_id, seq, abort_code, error),
 
 	    TP_STRUCT__entry(
+		    __field(unsigned int,		call_nr		)
 		    __array(char,			why, 4		)
 		    __field(u32,			cid		)
 		    __field(u32,			call_id		)
@@ -609,6 +610,7 @@ TRACE_EVENT(rxrpc_abort,
 
 	    TP_fast_assign(
 		    memcpy(__entry->why, why, 4);
+		    __entry->call_nr = call_nr;
 		    __entry->cid = cid;
 		    __entry->call_id = call_id;
 		    __entry->abort_code = abort_code;
@@ -616,7 +618,8 @@ TRACE_EVENT(rxrpc_abort,
 		    __entry->seq = seq;
 			   ),
 
-	    TP_printk("%08x:%08x s=%u a=%d e=%d %s",
+	    TP_printk("c=%08x %08x:%08x s=%u a=%d e=%d %s",
+		      __entry->call_nr,
 		      __entry->cid, __entry->call_id, __entry->seq,
 		      __entry->abort_code, __entry->error, __entry->why)
 	    );
@@ -627,7 +630,7 @@ TRACE_EVENT(rxrpc_transmit,
 	    TP_ARGS(call, why),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(enum rxrpc_transmit_trace,	why		)
 		    __field(rxrpc_seq_t,		tx_hard_ack	)
 		    __field(rxrpc_seq_t,		tx_top		)
@@ -635,14 +638,14 @@ TRACE_EVENT(rxrpc_transmit,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->why = why;
 		    __entry->tx_hard_ack = call->tx_hard_ack;
 		    __entry->tx_top = call->tx_top;
 		    __entry->tx_winsize = call->tx_winsize;
 			   ),
 
-	    TP_printk("c=%p %s f=%08x n=%u/%u",
+	    TP_printk("c=%08x %s f=%08x n=%u/%u",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_transmit_traces),
 		      __entry->tx_hard_ack + 1,
@@ -657,7 +660,7 @@ TRACE_EVENT(rxrpc_rx_data,
 	    TP_ARGS(call, seq, serial, flags, anno),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_seq_t,		seq		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(u8,				flags		)
@@ -665,14 +668,14 @@ TRACE_EVENT(rxrpc_rx_data,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->seq = seq;
 		    __entry->serial = serial;
 		    __entry->flags = flags;
 		    __entry->anno = anno;
 			   ),
 
-	    TP_printk("c=%p DATA %08x q=%08x fl=%02x a=%02x",
+	    TP_printk("c=%08x DATA %08x q=%08x fl=%02x a=%02x",
 		      __entry->call,
 		      __entry->serial,
 		      __entry->seq,
@@ -688,7 +691,7 @@ TRACE_EVENT(rxrpc_rx_ack,
 	    TP_ARGS(call, serial, ack_serial, first, prev, reason, n_acks),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(rxrpc_serial_t,		ack_serial	)
 		    __field(rxrpc_seq_t,		first		)
@@ -698,7 +701,7 @@ TRACE_EVENT(rxrpc_rx_ack,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->serial = serial;
 		    __entry->ack_serial = ack_serial;
 		    __entry->first = first;
@@ -707,7 +710,7 @@ TRACE_EVENT(rxrpc_rx_ack,
 		    __entry->n_acks = n_acks;
 			   ),
 
-	    TP_printk("c=%p %08x %s r=%08x f=%08x p=%08x n=%u",
+	    TP_printk("c=%08x %08x %s r=%08x f=%08x p=%08x n=%u",
 		      __entry->call,
 		      __entry->serial,
 		      __print_symbolic(__entry->reason, rxrpc_ack_names),
@@ -724,18 +727,18 @@ TRACE_EVENT(rxrpc_rx_abort,
 	    TP_ARGS(call, serial, abort_code),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(u32,			abort_code	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->serial = serial;
 		    __entry->abort_code = abort_code;
 			   ),
 
-	    TP_printk("c=%p ABORT %08x ac=%d",
+	    TP_printk("c=%08x ABORT %08x ac=%d",
 		      __entry->call,
 		      __entry->serial,
 		      __entry->abort_code)
@@ -748,20 +751,20 @@ TRACE_EVENT(rxrpc_rx_rwind_change,
 	    TP_ARGS(call, serial, rwind, wake),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(u32,			rwind		)
 		    __field(bool,			wake		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->serial = serial;
 		    __entry->rwind = rwind;
 		    __entry->wake = wake;
 			   ),
 
-	    TP_printk("c=%p %08x rw=%u%s",
+	    TP_printk("c=%08x %08x rw=%u%s",
 		      __entry->call,
 		      __entry->serial,
 		      __entry->rwind,
@@ -775,7 +778,7 @@ TRACE_EVENT(rxrpc_tx_data,
 	    TP_ARGS(call, seq, serial, flags, retrans, lose),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_seq_t,		seq		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(u8,				flags		)
@@ -784,7 +787,7 @@ TRACE_EVENT(rxrpc_tx_data,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->seq = seq;
 		    __entry->serial = serial;
 		    __entry->flags = flags;
@@ -792,7 +795,7 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __entry->lose = lose;
 			   ),
 
-	    TP_printk("c=%p DATA %08x q=%08x fl=%02x%s%s",
+	    TP_printk("c=%08x DATA %08x q=%08x fl=%02x%s%s",
 		      __entry->call,
 		      __entry->serial,
 		      __entry->seq,
@@ -809,7 +812,7 @@ TRACE_EVENT(rxrpc_tx_ack,
 	    TP_ARGS(call, serial, ack_first, ack_serial, reason, n_acks),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(rxrpc_seq_t,		ack_first	)
 		    __field(rxrpc_serial_t,		ack_serial	)
@@ -818,7 +821,7 @@ TRACE_EVENT(rxrpc_tx_ack,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call ? call->debug_id : 0;
 		    __entry->serial = serial;
 		    __entry->ack_first = ack_first;
 		    __entry->ack_serial = ack_serial;
@@ -826,7 +829,7 @@ TRACE_EVENT(rxrpc_tx_ack,
 		    __entry->n_acks = n_acks;
 			   ),
 
-	    TP_printk(" c=%p ACK  %08x %s f=%08x r=%08x n=%u",
+	    TP_printk(" c=%08x ACK  %08x %s f=%08x r=%08x n=%u",
 		      __entry->call,
 		      __entry->serial,
 		      __print_symbolic(__entry->reason, rxrpc_ack_names),
@@ -842,7 +845,7 @@ TRACE_EVENT(rxrpc_receive,
 	    TP_ARGS(call, why, serial, seq),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(enum rxrpc_receive_trace,	why		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(rxrpc_seq_t,		seq		)
@@ -851,7 +854,7 @@ TRACE_EVENT(rxrpc_receive,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->why = why;
 		    __entry->serial = serial;
 		    __entry->seq = seq;
@@ -859,7 +862,7 @@ TRACE_EVENT(rxrpc_receive,
 		    __entry->top = call->rx_top;
 			   ),
 
-	    TP_printk("c=%p %s r=%08x q=%08x w=%08x-%08x",
+	    TP_printk("c=%08x %s r=%08x q=%08x w=%08x-%08x",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_receive_traces),
 		      __entry->serial,
@@ -876,7 +879,7 @@ TRACE_EVENT(rxrpc_recvmsg,
 	    TP_ARGS(call, why, seq, offset, len, ret),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(enum rxrpc_recvmsg_trace,	why		)
 		    __field(rxrpc_seq_t,		seq		)
 		    __field(unsigned int,		offset		)
@@ -885,7 +888,7 @@ TRACE_EVENT(rxrpc_recvmsg,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->why = why;
 		    __entry->seq = seq;
 		    __entry->offset = offset;
@@ -893,7 +896,7 @@ TRACE_EVENT(rxrpc_recvmsg,
 		    __entry->ret = ret;
 			   ),
 
-	    TP_printk("c=%p %s q=%08x o=%u l=%u ret=%d",
+	    TP_printk("c=%08x %s q=%08x o=%u l=%u ret=%d",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_recvmsg_traces),
 		      __entry->seq,
@@ -909,18 +912,18 @@ TRACE_EVENT(rxrpc_rtt_tx,
 	    TP_ARGS(call, why, send_serial),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(enum rxrpc_rtt_tx_trace,	why		)
 		    __field(rxrpc_serial_t,		send_serial	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->why = why;
 		    __entry->send_serial = send_serial;
 			   ),
 
-	    TP_printk("c=%p %s sr=%08x",
+	    TP_printk("c=%08x %s sr=%08x",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_rtt_tx_traces),
 		      __entry->send_serial)
@@ -934,7 +937,7 @@ TRACE_EVENT(rxrpc_rtt_rx,
 	    TP_ARGS(call, why, send_serial, resp_serial, rtt, nr, avg),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(enum rxrpc_rtt_rx_trace,	why		)
 		    __field(u8,				nr		)
 		    __field(rxrpc_serial_t,		send_serial	)
@@ -944,7 +947,7 @@ TRACE_EVENT(rxrpc_rtt_rx,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->why = why;
 		    __entry->send_serial = send_serial;
 		    __entry->resp_serial = resp_serial;
@@ -953,7 +956,7 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		    __entry->avg = avg;
 			   ),
 
-	    TP_printk("c=%p %s sr=%08x rr=%08x rtt=%lld nr=%u avg=%lld",
+	    TP_printk("c=%08x %s sr=%08x rr=%08x rtt=%lld nr=%u avg=%lld",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_rtt_rx_traces),
 		      __entry->send_serial,
@@ -970,7 +973,7 @@ TRACE_EVENT(rxrpc_timer,
 	    TP_ARGS(call, why, now),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,		call		)
+		    __field(unsigned int,			call		)
 		    __field(enum rxrpc_timer_trace,		why		)
 		    __field(long,				now		)
 		    __field(long,				ack_at		)
@@ -984,7 +987,7 @@ TRACE_EVENT(rxrpc_timer,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call		= call;
+		    __entry->call		= call->debug_id;
 		    __entry->why		= why;
 		    __entry->now		= now;
 		    __entry->ack_at		= call->ack_at;
@@ -996,7 +999,7 @@ TRACE_EVENT(rxrpc_timer,
 		    __entry->timer		= call->timer.expires;
 			   ),
 
-	    TP_printk("c=%p %s a=%ld la=%ld r=%ld xr=%ld xq=%ld xt=%ld t=%ld",
+	    TP_printk("c=%08x %s a=%ld la=%ld r=%ld xr=%ld xq=%ld xt=%ld t=%ld",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_timer_traces),
 		      __entry->ack_at - __entry->now,
@@ -1039,7 +1042,7 @@ TRACE_EVENT(rxrpc_propose_ack,
 		    outcome),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,		call		)
+		    __field(unsigned int,			call		)
 		    __field(enum rxrpc_propose_ack_trace,	why		)
 		    __field(rxrpc_serial_t,			serial		)
 		    __field(u8,					ack_reason	)
@@ -1049,7 +1052,7 @@ TRACE_EVENT(rxrpc_propose_ack,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call	= call;
+		    __entry->call	= call->debug_id;
 		    __entry->why	= why;
 		    __entry->serial	= serial;
 		    __entry->ack_reason	= ack_reason;
@@ -1058,7 +1061,7 @@ TRACE_EVENT(rxrpc_propose_ack,
 		    __entry->outcome	= outcome;
 			   ),
 
-	    TP_printk("c=%p %s %s r=%08x i=%u b=%u%s",
+	    TP_printk("c=%08x %s %s r=%08x i=%u b=%u%s",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_propose_ack_traces),
 		      __print_symbolic(__entry->ack_reason, rxrpc_ack_names),
@@ -1075,20 +1078,20 @@ TRACE_EVENT(rxrpc_retransmit,
 	    TP_ARGS(call, seq, annotation, expiry),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_seq_t,		seq		)
 		    __field(u8,				annotation	)
 		    __field(s64,			expiry		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->seq = seq;
 		    __entry->annotation = annotation;
 		    __entry->expiry = expiry;
 			   ),
 
-	    TP_printk("c=%p q=%x a=%02x xp=%lld",
+	    TP_printk("c=%08x q=%x a=%02x xp=%lld",
 		      __entry->call,
 		      __entry->seq,
 		      __entry->annotation,
@@ -1102,7 +1105,7 @@ TRACE_EVENT(rxrpc_congest,
 	    TP_ARGS(call, summary, ack_serial, change),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,		call		)
+		    __field(unsigned int,			call		)
 		    __field(enum rxrpc_congest_change,		change		)
 		    __field(rxrpc_seq_t,			hard_ack	)
 		    __field(rxrpc_seq_t,			top		)
@@ -1112,7 +1115,7 @@ TRACE_EVENT(rxrpc_congest,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call	= call;
+		    __entry->call	= call->debug_id;
 		    __entry->change	= change;
 		    __entry->hard_ack	= call->tx_hard_ack;
 		    __entry->top	= call->tx_top;
@@ -1121,7 +1124,7 @@ TRACE_EVENT(rxrpc_congest,
 		    memcpy(&__entry->sum, summary, sizeof(__entry->sum));
 			   ),
 
-	    TP_printk("c=%p r=%08x %s q=%08x %s cw=%u ss=%u nr=%u,%u nw=%u,%u r=%u b=%u u=%u d=%u l=%x%s%s%s",
+	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u nr=%u,%u nw=%u,%u r=%u b=%u u=%u d=%u l=%x%s%s%s",
 		      __entry->call,
 		      __entry->ack_serial,
 		      __print_symbolic(__entry->sum.ack_reason, rxrpc_ack_names),
@@ -1146,16 +1149,16 @@ TRACE_EVENT(rxrpc_disconnect_call,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(u32,			abort_code	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->abort_code = call->abort_code;
 			   ),
 
-	    TP_printk("c=%p ab=%08x",
+	    TP_printk("c=%08x ab=%08x",
 		      __entry->call,
 		      __entry->abort_code)
 	    );
@@ -1166,16 +1169,16 @@ TRACE_EVENT(rxrpc_improper_term,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(u32,			abort_code	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->abort_code = call->abort_code;
 			   ),
 
-	    TP_printk("c=%p ab=%08x",
+	    TP_printk("c=%08x ab=%08x",
 		      __entry->call,
 		      __entry->abort_code)
 	    );
@@ -1187,18 +1190,18 @@ TRACE_EVENT(rxrpc_rx_eproto,
 	    TP_ARGS(call, serial, why),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(rxrpc_serial_t,		serial		)
 		    __field(const char *,		why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->serial = serial;
 		    __entry->why = why;
 			   ),
 
-	    TP_printk("c=%p EPROTO %08x %s",
+	    TP_printk("c=%08x EPROTO %08x %s",
 		      __entry->call,
 		      __entry->serial,
 		      __entry->why)
@@ -1210,20 +1213,20 @@ TRACE_EVENT(rxrpc_connect_call,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(unsigned long,		user_call_ID	)
 		    __field(u32,			cid		)
 		    __field(u32,			call_id		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->user_call_ID = call->user_call_ID;
 		    __entry->cid = call->cid;
 		    __entry->call_id = call->call_id;
 			   ),
 
-	    TP_printk("c=%p u=%p %08x:%08x",
+	    TP_printk("c=%08x u=%p %08x:%08x",
 		      __entry->call,
 		      (void *)__entry->user_call_ID,
 		      __entry->cid,
@@ -1236,18 +1239,18 @@ TRACE_EVENT(rxrpc_resend,
 	    TP_ARGS(call, ix),
 
 	    TP_STRUCT__entry(
-		    __field(struct rxrpc_call *,	call		)
+		    __field(unsigned int,		call		)
 		    __field(int,			ix		)
 		    __array(u8,				anno, 64	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call;
+		    __entry->call = call->debug_id;
 		    __entry->ix = ix;
 		    memcpy(__entry->anno, call->rxtx_annotations, 64);
 			   ),
 
-	    TP_printk("c=%p ix=%u a=%64phN",
+	    TP_printk("c=%08x ix=%u a=%64phN",
 		      __entry->call,
 		      __entry->ix,
 		      __entry->anno)
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9e1c2c6b6a67..ec5ec68be1aa 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -40,6 +40,7 @@ static const struct proto_ops rxrpc_rpc_ops;
 
 /* current debugging ID */
 atomic_t rxrpc_debug_id;
+EXPORT_SYMBOL(rxrpc_debug_id);
 
 /* count of skbs currently in use */
 atomic_t rxrpc_n_tx_skbs, rxrpc_n_rx_skbs;
@@ -267,6 +268,7 @@ static int rxrpc_listen(struct socket *sock, int backlog)
  * @gfp: The allocation constraints
  * @notify_rx: Where to send notifications instead of socket queue
  * @upgrade: Request service upgrade for call
+ * @debug_id: The debug ID for tracing to be assigned to the call
  *
  * Allow a kernel service to begin a call on the nominated socket.  This just
  * sets up all the internal tracking structures and allocates connection and
@@ -282,7 +284,8 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   s64 tx_total_len,
 					   gfp_t gfp,
 					   rxrpc_notify_rx_t notify_rx,
-					   bool upgrade)
+					   bool upgrade,
+					   unsigned int debug_id)
 {
 	struct rxrpc_conn_parameters cp;
 	struct rxrpc_call_params p;
@@ -314,7 +317,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 	cp.exclusive		= false;
 	cp.upgrade		= upgrade;
 	cp.service_id		= srx->srx_service;
-	call = rxrpc_new_client_call(rx, &cp, srx, &p, gfp);
+	call = rxrpc_new_client_call(rx, &cp, srx, &p, gfp, debug_id);
 	/* The socket has been unlocked. */
 	if (!IS_ERR(call)) {
 		call->notify_rx = notify_rx;
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 416688381eb7..9c9817ddafc5 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -691,7 +691,6 @@ struct rxrpc_send_params {
  * af_rxrpc.c
  */
 extern atomic_t rxrpc_n_tx_skbs, rxrpc_n_rx_skbs;
-extern atomic_t rxrpc_debug_id;
 extern struct workqueue_struct *rxrpc_workqueue;
 
 /*
@@ -732,11 +731,12 @@ extern unsigned int rxrpc_max_call_lifetime;
 extern struct kmem_cache *rxrpc_call_jar;
 
 struct rxrpc_call *rxrpc_find_call_by_user_ID(struct rxrpc_sock *, unsigned long);
-struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *, gfp_t);
+struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *, gfp_t, unsigned int);
 struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *,
 					 struct rxrpc_conn_parameters *,
 					 struct sockaddr_rxrpc *,
-					 struct rxrpc_call_params *, gfp_t);
+					 struct rxrpc_call_params *, gfp_t,
+					 unsigned int);
 int rxrpc_retry_client_call(struct rxrpc_sock *,
 			    struct rxrpc_call *,
 			    struct rxrpc_conn_parameters *,
@@ -822,7 +822,7 @@ static inline bool __rxrpc_abort_call(const char *why, struct rxrpc_call *call,
 				      rxrpc_seq_t seq,
 				      u32 abort_code, int error)
 {
-	trace_rxrpc_abort(why, call->cid, call->call_id, seq,
+	trace_rxrpc_abort(call->debug_id, why, call->cid, call->call_id, seq,
 			  abort_code, error);
 	return __rxrpc_set_call_completion(call, RXRPC_CALL_LOCALLY_ABORTED,
 					   abort_code, error);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 3028298ca561..92ebd1d7e0bb 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -34,7 +34,8 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 				      struct rxrpc_backlog *b,
 				      rxrpc_notify_rx_t notify_rx,
 				      rxrpc_user_attach_call_t user_attach_call,
-				      unsigned long user_call_ID, gfp_t gfp)
+				      unsigned long user_call_ID, gfp_t gfp,
+				      unsigned int debug_id)
 {
 	const void *here = __builtin_return_address(0);
 	struct rxrpc_call *call;
@@ -94,7 +95,7 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 	/* Now it gets complicated, because calls get registered with the
 	 * socket here, particularly if a user ID is preassigned by the user.
 	 */
-	call = rxrpc_alloc_call(rx, gfp);
+	call = rxrpc_alloc_call(rx, gfp, debug_id);
 	if (!call)
 		return -ENOMEM;
 	call->flags |= (1 << RXRPC_CALL_IS_SERVICE);
@@ -174,7 +175,8 @@ int rxrpc_service_prealloc(struct rxrpc_sock *rx, gfp_t gfp)
 	if (rx->discard_new_call)
 		return 0;
 
-	while (rxrpc_service_prealloc_one(rx, b, NULL, NULL, 0, gfp) == 0)
+	while (rxrpc_service_prealloc_one(rx, b, NULL, NULL, 0, gfp,
+					  atomic_inc_return(&rxrpc_debug_id)) == 0)
 		;
 
 	return 0;
@@ -347,7 +349,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 		   service_id == rx->second_service))
 		goto found_service;
 
-	trace_rxrpc_abort("INV", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
+	trace_rxrpc_abort(0, "INV", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_INVALID_OPERATION, EOPNOTSUPP);
 	skb->mark = RXRPC_SKB_MARK_LOCAL_ABORT;
 	skb->priority = RX_INVALID_OPERATION;
@@ -358,7 +360,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	spin_lock(&rx->incoming_lock);
 	if (rx->sk.sk_state == RXRPC_SERVER_LISTEN_DISABLED ||
 	    rx->sk.sk_state == RXRPC_CLOSE) {
-		trace_rxrpc_abort("CLS", sp->hdr.cid, sp->hdr.callNumber,
+		trace_rxrpc_abort(0, "CLS", sp->hdr.cid, sp->hdr.callNumber,
 				  sp->hdr.seq, RX_INVALID_OPERATION, ESHUTDOWN);
 		skb->mark = RXRPC_SKB_MARK_LOCAL_ABORT;
 		skb->priority = RX_INVALID_OPERATION;
@@ -635,6 +637,7 @@ int rxrpc_reject_call(struct rxrpc_sock *rx)
  * @user_attach_call: Func to attach call to user_call_ID
  * @user_call_ID: The tag to attach to the preallocated call
  * @gfp: The allocation conditions.
+ * @debug_id: The tracing debug ID.
  *
  * Charge up the socket with preallocated calls, each with a user ID.  A
  * function should be provided to effect the attachment from the user's side.
@@ -645,7 +648,8 @@ int rxrpc_reject_call(struct rxrpc_sock *rx)
 int rxrpc_kernel_charge_accept(struct socket *sock,
 			       rxrpc_notify_rx_t notify_rx,
 			       rxrpc_user_attach_call_t user_attach_call,
-			       unsigned long user_call_ID, gfp_t gfp)
+			       unsigned long user_call_ID, gfp_t gfp,
+			       unsigned int debug_id)
 {
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 	struct rxrpc_backlog *b = rx->backlog;
@@ -655,6 +659,6 @@ int rxrpc_kernel_charge_accept(struct socket *sock,
 
 	return rxrpc_service_prealloc_one(rx, b, notify_rx,
 					  user_attach_call, user_call_ID,
-					  gfp);
+					  gfp, debug_id);
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 0b2db38dd32d..147657dfe757 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -99,7 +99,8 @@ struct rxrpc_call *rxrpc_find_call_by_user_ID(struct rxrpc_sock *rx,
 /*
  * allocate a new call
  */
-struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp)
+struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
+				    unsigned int debug_id)
 {
 	struct rxrpc_call *call;
 
@@ -138,7 +139,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp)
 	spin_lock_init(&call->notify_lock);
 	rwlock_init(&call->state_lock);
 	atomic_set(&call->usage, 1);
-	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
+	call->debug_id = debug_id;
 	call->tx_total_len = -1;
 	call->next_rx_timo = 20 * HZ;
 	call->next_req_timo = 1 * HZ;
@@ -166,14 +167,15 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp)
  */
 static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 						  struct sockaddr_rxrpc *srx,
-						  gfp_t gfp)
+						  gfp_t gfp,
+						  unsigned int debug_id)
 {
 	struct rxrpc_call *call;
 	ktime_t now;
 
 	_enter("");
 
-	call = rxrpc_alloc_call(rx, gfp);
+	call = rxrpc_alloc_call(rx, gfp, debug_id);
 	if (!call)
 		return ERR_PTR(-ENOMEM);
 	call->state = RXRPC_CALL_CLIENT_AWAIT_CONN;
@@ -214,7 +216,8 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 					 struct rxrpc_conn_parameters *cp,
 					 struct sockaddr_rxrpc *srx,
 					 struct rxrpc_call_params *p,
-					 gfp_t gfp)
+					 gfp_t gfp,
+					 unsigned int debug_id)
 	__releases(&rx->sk.sk_lock.slock)
 {
 	struct rxrpc_call *call, *xcall;
@@ -225,7 +228,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 
 	_enter("%p,%lx", rx, p->user_call_ID);
 
-	call = rxrpc_alloc_client_call(rx, srx, gfp);
+	call = rxrpc_alloc_client_call(rx, srx, gfp, debug_id);
 	if (IS_ERR(call)) {
 		release_sock(&rx->sk);
 		_leave(" = %ld", PTR_ERR(call));
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index b1dfae107431..d2ec3fd593e8 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -160,7 +160,8 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn,
 			lockdep_is_held(&conn->channel_lock));
 		if (call) {
 			if (compl == RXRPC_CALL_LOCALLY_ABORTED)
-				trace_rxrpc_abort("CON", call->cid,
+				trace_rxrpc_abort(call->debug_id,
+						  "CON", call->cid,
 						  call->call_id, 0,
 						  abort_code, error);
 			if (rxrpc_set_call_completion(call, compl,
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 6fc61400337f..2a868fdab0ae 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1307,21 +1307,21 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
 wrong_security:
 	rcu_read_unlock();
-	trace_rxrpc_abort("SEC", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
+	trace_rxrpc_abort(0, "SEC", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RXKADINCONSISTENCY, EBADMSG);
 	skb->priority = RXKADINCONSISTENCY;
 	goto post_abort;
 
 reupgrade:
 	rcu_read_unlock();
-	trace_rxrpc_abort("UPG", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
+	trace_rxrpc_abort(0, "UPG", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_PROTOCOL_ERROR, EBADMSG);
 	goto protocol_error;
 
 bad_message_unlock:
 	rcu_read_unlock();
 bad_message:
-	trace_rxrpc_abort("BAD", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
+	trace_rxrpc_abort(0, "BAD", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_PROTOCOL_ERROR, EBADMSG);
 protocol_error:
 	skb->priority = RX_PROTOCOL_ERROR;
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 09f2a3e05221..8503f279b467 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -579,7 +579,8 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 	cp.exclusive		= rx->exclusive | p->exclusive;
 	cp.upgrade		= p->upgrade;
 	cp.service_id		= srx->srx_service;
-	call = rxrpc_new_client_call(rx, &cp, srx, &p->call, GFP_KERNEL);
+	call = rxrpc_new_client_call(rx, &cp, srx, &p->call, GFP_KERNEL,
+				     atomic_inc_return(&rxrpc_debug_id));
 	/* The socket is now unlocked */
 
 	_leave(" = %p\n", call);
