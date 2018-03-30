Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeC3VPY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:15:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752889AbeC3VPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:15:21 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 12/12] rxrpc: Fix leak of rxrpc_peer objects
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:15:19 +0100
Message-ID: <152244451951.4629.13507651542621408099.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new client call is requested, an rxrpc_conn_parameters struct object
is passed in with a bunch of parameters set, such as the local endpoint to
use.  A pointer to the target peer record is also placed in there by
rxrpc_get_client_conn() - and this is removed if and only if a new
connection object is allocated.  Thus it leaks if a new connection object
isn't allocated.

Fix this by putting any peer object attached to the rxrpc_conn_parameters
object in the function that allocated it.

Fixes: 19ffa01c9c45 ("rxrpc: Use structs to hold connection params and protocol info")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/af_rxrpc.c    |    2 ++
 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/net_ns.c      |    1 +
 net/rxrpc/peer_object.c |   21 +++++++++++++++++++++
 net/rxrpc/sendmsg.c     |    1 +
 5 files changed, 26 insertions(+)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0b3026b8fa40..9a2c8e7c000e 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -324,6 +324,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 		mutex_unlock(&call->user_mutex);
 	}
 
+	rxrpc_put_peer(cp.peer);
 	_leave(" = %p", call);
 	return call;
 }
@@ -447,6 +448,7 @@ int rxrpc_kernel_retry_call(struct socket *sock, struct rxrpc_call *call,
 		ret = rxrpc_retry_client_call(rx, call, &cp, srx, GFP_KERNEL);
 
 	mutex_unlock(&call->user_mutex);
+	rxrpc_put_peer(cp.peer);
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c46583bc255d..90d7079e0aa9 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1041,6 +1041,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *,
 struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *, gfp_t);
 struct rxrpc_peer *rxrpc_lookup_incoming_peer(struct rxrpc_local *,
 					      struct rxrpc_peer *);
+void rxrpc_destroy_all_peers(struct rxrpc_net *);
 struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *);
 struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *);
 void rxrpc_put_peer(struct rxrpc_peer *);
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index fa9ce60e7bfa..c7a023fb22d0 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -118,6 +118,7 @@ static __net_exit void rxrpc_exit_net(struct net *net)
 	cancel_work_sync(&rxnet->peer_keepalive_work);
 	rxrpc_destroy_all_calls(rxnet);
 	rxrpc_destroy_all_connections(rxnet);
+	rxrpc_destroy_all_peers(rxnet);
 	rxrpc_destroy_all_locals(rxnet);
 	proc_remove(rxnet->proc_net);
 }
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index a4a750aea1e5..1b7e8107b3ae 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -463,6 +463,27 @@ void rxrpc_put_peer(struct rxrpc_peer *peer)
 	}
 }
 
+/*
+ * Make sure all peer records have been discarded.
+ */
+void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
+{
+	struct rxrpc_peer *peer;
+	int i;
+
+	for (i = 0; i < HASH_SIZE(rxnet->peer_hash); i++) {
+		if (hlist_empty(&rxnet->peer_hash[i]))
+			continue;
+
+		hlist_for_each_entry(peer, &rxnet->peer_hash[i], hash_link) {
+			pr_err("Leaked peer %u {%u} %pISp\n",
+			       peer->debug_id,
+			       atomic_read(&peer->usage),
+			       &peer->srx.transport);
+		}
+	}
+}
+
 /**
  * rxrpc_kernel_get_peer - Get the peer address of a call
  * @sock: The socket on which the call is in progress.
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index a62980a80151..206e802ccbdc 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -586,6 +586,7 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 				     atomic_inc_return(&rxrpc_debug_id));
 	/* The socket is now unlocked */
 
+	rxrpc_put_peer(cp.peer);
 	_leave(" = %p\n", call);
 	return call;
 }
