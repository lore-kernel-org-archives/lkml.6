Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbeC3VOw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753093AbeC3VOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:49 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 07/12] rxrpc: Fix checker warnings and errors
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:47 +0100
Message-ID: <152244448786.4629.8296947848637476981.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various issues detected by checker.

Errors:

 (*) rxrpc_discard_prealloc() should be using rcu_assign_pointer to set
     call->socket.

Warnings:

 (*) rxrpc_service_connection_reaper() should be passing NULL rather than 0 to
     trace_rxrpc_conn() as the where argument.

 (*) rxrpc_disconnect_client_call() should get its net pointer via the
     call->conn rather than call->sock to avoid a warning about accessing
     an RCU pointer without protection.

 (*) Proc seq start/stop functions need annotation as they pass locks
     between the functions.

False positives:

 (*) Checker doesn't correctly handle of seq-retry lock context balance in
     rxrpc_find_service_conn_rcu().

 (*) Checker thinks execution may proceed past the BUG() in
     rxrpc_publish_service_conn().

 (*) Variable length array warnings from SKCIPHER_REQUEST_ON_STACK() in
     rxkad.c.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/call_accept.c |    3 ++-
 net/rxrpc/call_object.c |    1 +
 net/rxrpc/conn_client.c |    2 +-
 net/rxrpc/conn_object.c |    2 +-
 net/rxrpc/proc.c        |    6 ++++++
 net/rxrpc/sendmsg.c     |    2 ++
 6 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 92ebd1d7e0bb..4ce24c000653 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -225,7 +225,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	tail = b->call_backlog_tail;
 	while (CIRC_CNT(head, tail, size) > 0) {
 		struct rxrpc_call *call = b->call_backlog[tail];
-		call->socket = rx;
+		rcu_assign_pointer(call->socket, rx);
 		if (rx->discard_new_call) {
 			_debug("discard %lx", call->user_call_ID);
 			rx->discard_new_call(call, call->user_call_ID);
@@ -456,6 +456,7 @@ struct rxrpc_call *rxrpc_accept_call(struct rxrpc_sock *rx,
 				     unsigned long user_call_ID,
 				     rxrpc_notify_rx_t notify_rx)
 	__releases(&rx->sk.sk_lock.slock)
+	__acquires(call->user_mutex)
 {
 	struct rxrpc_call *call;
 	struct rb_node *parent, **pp;
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 147657dfe757..85b12c472522 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -219,6 +219,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 					 gfp_t gfp,
 					 unsigned int debug_id)
 	__releases(&rx->sk.sk_lock.slock)
+	__acquires(&call->user_mutex)
 {
 	struct rxrpc_call *call, *xcall;
 	struct rxrpc_net *rxnet = rxrpc_net(sock_net(&rx->sk));
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 064175068059..041da40dbf93 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -776,7 +776,7 @@ void rxrpc_disconnect_client_call(struct rxrpc_call *call)
 	unsigned int channel = call->cid & RXRPC_CHANNELMASK;
 	struct rxrpc_connection *conn = call->conn;
 	struct rxrpc_channel *chan = &conn->channels[channel];
-	struct rxrpc_net *rxnet = rxrpc_net(sock_net(&call->socket->sk));
+	struct rxrpc_net *rxnet = conn->params.local->rxnet;
 
 	trace_rxrpc_client(conn, channel, rxrpc_client_chan_disconnect);
 	call->conn = NULL;
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index ccbac190add1..bfc46fd69a62 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -418,7 +418,7 @@ void rxrpc_service_connection_reaper(struct work_struct *work)
 		 */
 		if (atomic_cmpxchg(&conn->usage, 1, 0) != 1)
 			continue;
-		trace_rxrpc_conn(conn, rxrpc_conn_reap_service, 0, 0);
+		trace_rxrpc_conn(conn, rxrpc_conn_reap_service, 0, NULL);
 
 		if (rxrpc_conn_is_client(conn))
 			BUG();
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index f79f260c6ddc..7e45db058823 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -29,6 +29,8 @@ static const char *const rxrpc_conn_states[RXRPC_CONN__NR_STATES] = {
  * generate a list of extant and dead calls in /proc/net/rxrpc_calls
  */
 static void *rxrpc_call_seq_start(struct seq_file *seq, loff_t *_pos)
+	__acquires(rcu)
+	__acquires(rxnet->call_lock)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 
@@ -45,6 +47,8 @@ static void *rxrpc_call_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void rxrpc_call_seq_stop(struct seq_file *seq, void *v)
+	__releases(rxnet->call_lock)
+	__releases(rcu)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 
@@ -135,6 +139,7 @@ const struct file_operations rxrpc_call_seq_fops = {
  * generate a list of extant virtual connections in /proc/net/rxrpc_conns
  */
 static void *rxrpc_connection_seq_start(struct seq_file *seq, loff_t *_pos)
+	__acquires(rxnet->conn_lock)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 
@@ -151,6 +156,7 @@ static void *rxrpc_connection_seq_next(struct seq_file *seq, void *v,
 }
 
 static void rxrpc_connection_seq_stop(struct seq_file *seq, void *v)
+	__releases(rxnet->conn_lock)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 783c777fc6e7..a62980a80151 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -556,6 +556,7 @@ static struct rxrpc_call *
 rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 				  struct rxrpc_send_params *p)
 	__releases(&rx->sk.sk_lock.slock)
+	__acquires(&call->user_mutex)
 {
 	struct rxrpc_conn_parameters cp;
 	struct rxrpc_call *call;
@@ -596,6 +597,7 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
  */
 int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	__releases(&rx->sk.sk_lock.slock)
+	__releases(&call->user_mutex)
 {
 	enum rxrpc_call_state state;
 	struct rxrpc_call *call;
