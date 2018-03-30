Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeC3VPA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:15:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753099AbeC3VO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:56 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 08/12] rxrpc: Fix potential call vs socket/net
 destruction race
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:54 +0100
Message-ID: <152244449416.4629.799535285611128924.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_call structs don't pin sockets or network namespaces, but may attempt
to access both after their refcount reaches 0 so that they can detach
themselves from the network namespace.  However, there's no guarantee that
the socket still exists at this point (so sock_net(&call->socket->sk) may
be invalid) and the namespace may have gone away if the call isn't pinning
a peer.

Fix this by (a) carrying a net pointer in the rxrpc_call struct and (b)
waiting for all calls to be destroyed when the network namespace goes away.

This was detected by checker:

net/rxrpc/call_object.c:634:57: warning: incorrect type in argument 1 (different address spaces)
net/rxrpc/call_object.c:634:57:    expected struct sock const *sk
net/rxrpc/call_object.c:634:57:    got struct sock [noderef] <asn:4>*<noident>

Fixes: 2baec2c3f854 ("rxrpc: Support network namespacing")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    2 ++
 net/rxrpc/call_accept.c |    1 +
 net/rxrpc/call_object.c |   16 +++++++++++++---
 net/rxrpc/net_ns.c      |    1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 8a348e0a9d95..2a2b0fdfb157 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -75,6 +75,7 @@ struct rxrpc_net {
 	u32			epoch;		/* Local epoch for detecting local-end reset */
 	struct list_head	calls;		/* List of calls active in this namespace */
 	rwlock_t		call_lock;	/* Lock for ->calls */
+	atomic_t		nr_calls;	/* Count of allocated calls */
 
 	struct list_head	conn_proc_list;	/* List of conns in this namespace for proc */
 	struct list_head	service_conns;	/* Service conns in this namespace */
@@ -528,6 +529,7 @@ struct rxrpc_call {
 	struct rxrpc_connection	*conn;		/* connection carrying call */
 	struct rxrpc_peer	*peer;		/* Peer record for remote address */
 	struct rxrpc_sock __rcu	*socket;	/* socket responsible */
+	struct rxrpc_net	*rxnet;		/* Network namespace to which call belongs */
 	struct mutex		user_mutex;	/* User access mutex */
 	unsigned long		ack_at;		/* When deferred ACK needs to happen */
 	unsigned long		ack_lost_at;	/* When ACK is figured as lost */
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 4ce24c000653..493545033e42 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -138,6 +138,7 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 
 	write_unlock(&rx->call_lock);
 
+	rxnet = call->rxnet;
 	write_lock(&rxnet->call_lock);
 	list_add_tail(&call->link, &rxnet->calls);
 	write_unlock(&rxnet->call_lock);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 85b12c472522..f721c2b7e234 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -103,6 +103,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 				    unsigned int debug_id)
 {
 	struct rxrpc_call *call;
+	struct rxrpc_net *rxnet = rxrpc_net(sock_net(&rx->sk));
 
 	call = kmem_cache_zalloc(rxrpc_call_jar, gfp);
 	if (!call)
@@ -153,6 +154,9 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 
 	call->cong_cwnd = 2;
 	call->cong_ssthresh = RXRPC_RXTX_BUFF_SIZE - 1;
+
+	call->rxnet = rxnet;
+	atomic_inc(&rxnet->nr_calls);
 	return call;
 
 nomem_2:
@@ -222,7 +226,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 	__acquires(&call->user_mutex)
 {
 	struct rxrpc_call *call, *xcall;
-	struct rxrpc_net *rxnet = rxrpc_net(sock_net(&rx->sk));
+	struct rxrpc_net *rxnet;
 	struct rb_node *parent, **pp;
 	const void *here = __builtin_return_address(0);
 	int ret;
@@ -272,6 +276,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 
 	write_unlock(&rx->call_lock);
 
+	rxnet = call->rxnet;
 	write_lock(&rxnet->call_lock);
 	list_add_tail(&call->link, &rxnet->calls);
 	write_unlock(&rxnet->call_lock);
@@ -617,7 +622,7 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
  */
 void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
 {
-	struct rxrpc_net *rxnet;
+	struct rxrpc_net *rxnet = call->rxnet;
 	const void *here = __builtin_return_address(0);
 	int n;
 
@@ -631,7 +636,6 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
 		ASSERTCMP(call->state, ==, RXRPC_CALL_COMPLETE);
 
 		if (!list_empty(&call->link)) {
-			rxnet = rxrpc_net(sock_net(&call->socket->sk));
 			write_lock(&rxnet->call_lock);
 			list_del_init(&call->link);
 			write_unlock(&rxnet->call_lock);
@@ -647,11 +651,14 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
 static void rxrpc_rcu_destroy_call(struct rcu_head *rcu)
 {
 	struct rxrpc_call *call = container_of(rcu, struct rxrpc_call, rcu);
+	struct rxrpc_net *rxnet = call->rxnet;
 
 	rxrpc_put_peer(call->peer);
 	kfree(call->rxtx_buffer);
 	kfree(call->rxtx_annotations);
 	kmem_cache_free(rxrpc_call_jar, call);
+	if (atomic_dec_and_test(&rxnet->nr_calls))
+		wake_up_atomic_t(&rxnet->nr_calls);
 }
 
 /*
@@ -716,4 +723,7 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	}
 
 	write_unlock(&rxnet->call_lock);
+
+	atomic_dec(&rxnet->nr_calls);
+	wait_on_atomic_t(&rxnet->nr_calls, atomic_t_wait, TASK_UNINTERRUPTIBLE);
 }
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index 66baf2b80b6c..101019b0be34 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -55,6 +55,7 @@ static __net_init int rxrpc_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&rxnet->calls);
 	rwlock_init(&rxnet->call_lock);
+	atomic_set(&rxnet->nr_calls, 1);
 
 	INIT_LIST_HEAD(&rxnet->conn_proc_list);
 	INIT_LIST_HEAD(&rxnet->service_conns);
