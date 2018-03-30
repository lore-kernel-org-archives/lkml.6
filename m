Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeC3VPL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:15:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752889AbeC3VPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:15:08 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 10/12] rxrpc: Fix apparent leak of rxrpc_local
 objects
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:15:06 +0100
Message-ID: <152244450674.4629.4649583360796859288.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_local objects cannot be disposed of until all the connections that
point to them have been RCU'd as a connection object holds refcount on the
local endpoint it is communicating through.  Currently, this can cause an
assertion failure to occur when a network namespace is destroyed as there's
no check that the RCU destructors for the connections have been run before
we start trying to destroy local endpoints.

The kernel reports:

	rxrpc: AF_RXRPC: Leaked local 0000000036a41bc1 {5}
	------------[ cut here ]------------
	kernel BUG at ../net/rxrpc/local_object.c:439!

Fix this by keeping a count of the live connections and waiting for it to
go to zero at the end of rxrpc_destroy_all_connections().

Fixes: dee46364ce6f ("rxrpc: Add RCU destruction for connections and calls")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h  |    1 +
 net/rxrpc/call_accept.c  |    2 ++
 net/rxrpc/conn_client.c  |    1 +
 net/rxrpc/conn_object.c  |    8 ++++++++
 net/rxrpc/conn_service.c |    1 +
 net/rxrpc/net_ns.c       |    1 +
 6 files changed, 14 insertions(+)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index cc51d3eb0548..d40d54b78567 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -77,6 +77,7 @@ struct rxrpc_net {
 	rwlock_t		call_lock;	/* Lock for ->calls */
 	atomic_t		nr_calls;	/* Count of allocated calls */
 
+	atomic_t		nr_conns;
 	struct list_head	conn_proc_list;	/* List of conns in this namespace for proc */
 	struct list_head	service_conns;	/* Service conns in this namespace */
 	rwlock_t		conn_lock;	/* Lock for ->conn_proc_list, ->service_conns */
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 5a9b1d916124..f67017dcb25e 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -219,6 +219,8 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 		list_del(&conn->proc_link);
 		write_unlock(&rxnet->conn_lock);
 		kfree(conn);
+		if (atomic_dec_and_test(&rxnet->nr_conns))
+			wake_up_atomic_t(&rxnet->nr_conns);
 		tail = (tail + 1) & (size - 1);
 	}
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 041da40dbf93..5736f643c516 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -207,6 +207,7 @@ rxrpc_alloc_client_connection(struct rxrpc_conn_parameters *cp, gfp_t gfp)
 	if (ret < 0)
 		goto error_2;
 
+	atomic_inc(&rxnet->nr_conns);
 	write_lock(&rxnet->conn_lock);
 	list_add_tail(&conn->proc_link, &rxnet->conn_proc_list);
 	write_unlock(&rxnet->conn_lock);
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index bfc46fd69a62..0950ee3d26f5 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -365,6 +365,9 @@ static void rxrpc_destroy_connection(struct rcu_head *rcu)
 	key_put(conn->params.key);
 	key_put(conn->server_key);
 	rxrpc_put_peer(conn->params.peer);
+
+	if (atomic_dec_and_test(&conn->params.local->rxnet->nr_conns))
+		wake_up_atomic_t(&conn->params.local->rxnet->nr_conns);
 	rxrpc_put_local(conn->params.local);
 
 	kfree(conn);
@@ -458,6 +461,7 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rxnet)
 
 	_enter("");
 
+	atomic_dec(&rxnet->nr_conns);
 	rxrpc_destroy_all_client_connections(rxnet);
 
 	del_timer_sync(&rxnet->service_conn_reap_timer);
@@ -475,5 +479,9 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rxnet)
 
 	ASSERT(list_empty(&rxnet->conn_proc_list));
 
+	/* We need to wait for the connections to be destroyed by RCU as they
+	 * pin things that we still need to get rid of.
+	 */
+	wait_on_atomic_t(&rxnet->nr_conns, atomic_t_wait, TASK_UNINTERRUPTIBLE);
 	_leave("");
 }
diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index f6fcdb3130a1..80773a50c755 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -132,6 +132,7 @@ struct rxrpc_connection *rxrpc_prealloc_service_connection(struct rxrpc_net *rxn
 		conn->state = RXRPC_CONN_SERVICE_PREALLOC;
 		atomic_set(&conn->usage, 2);
 
+		atomic_inc(&rxnet->nr_conns);
 		write_lock(&rxnet->conn_lock);
 		list_add_tail(&conn->link, &rxnet->service_conns);
 		list_add_tail(&conn->proc_link, &rxnet->conn_proc_list);
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index 101019b0be34..fa9ce60e7bfa 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -57,6 +57,7 @@ static __net_init int rxrpc_init_net(struct net *net)
 	rwlock_init(&rxnet->call_lock);
 	atomic_set(&rxnet->nr_calls, 1);
 
+	atomic_set(&rxnet->nr_conns, 1);
 	INIT_LIST_HEAD(&rxnet->conn_proc_list);
 	INIT_LIST_HEAD(&rxnet->service_conns);
 	rwlock_init(&rxnet->conn_lock);
