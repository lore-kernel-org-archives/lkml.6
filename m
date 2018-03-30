Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeC3VOP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752106AbeC3VOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:12 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 01/12] rxrpc: Fix firewall route keepalive
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:10 +0100
Message-ID: <152244445045.4629.8020946799919512411.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the firewall route keepalive part of AF_RXRPC which is currently
function incorrectly by replying to VERSION REPLY packets from the server
with VERSION REQUEST packets.

Instead, send VERSION REPLY packets to the peers of service connections to
act as keep-alives 20s after the latest packet was transmitted to that
peer.

Also, just discard VERSION REPLY packets rather than replying to them.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/af_rxrpc.c    |    4 ++
 net/rxrpc/ar-internal.h |   14 ++++++-
 net/rxrpc/conn_event.c  |    3 +
 net/rxrpc/input.c       |    2 +
 net/rxrpc/net_ns.c      |   21 ++++++++++
 net/rxrpc/output.c      |   59 ++++++++++++++++++++++++++++-
 net/rxrpc/peer_event.c  |   96 +++++++++++++++++++++++++++++++++++++++++++++++
 net/rxrpc/peer_object.c |    7 +++
 net/rxrpc/rxkad.c       |    2 +
 9 files changed, 204 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index ec5ec68be1aa..0b3026b8fa40 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -762,6 +762,7 @@ static __poll_t rxrpc_poll(struct file *file, struct socket *sock,
 static int rxrpc_create(struct net *net, struct socket *sock, int protocol,
 			int kern)
 {
+	struct rxrpc_net *rxnet;
 	struct rxrpc_sock *rx;
 	struct sock *sk;
 
@@ -801,6 +802,9 @@ static int rxrpc_create(struct net *net, struct socket *sock, int protocol,
 	rwlock_init(&rx->call_lock);
 	memset(&rx->srx, 0, sizeof(rx->srx));
 
+	rxnet = rxrpc_net(sock_net(&rx->sk));
+	timer_reduce(&rxnet->peer_keepalive_timer, jiffies + 1);
+
 	_leave(" = 0 [%p]", rx);
 	return 0;
 }
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 21cf164b6d85..8a348e0a9d95 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -97,8 +97,16 @@ struct rxrpc_net {
 	struct list_head	local_endpoints;
 	struct mutex		local_mutex;	/* Lock for ->local_endpoints */
 
-	spinlock_t		peer_hash_lock;	/* Lock for ->peer_hash */
 	DECLARE_HASHTABLE	(peer_hash, 10);
+	spinlock_t		peer_hash_lock;	/* Lock for ->peer_hash */
+
+#define RXRPC_KEEPALIVE_TIME 20 /* NAT keepalive time in seconds */
+	u8			peer_keepalive_cursor;
+	ktime_t			peer_keepalive_base;
+	struct hlist_head	peer_keepalive[RXRPC_KEEPALIVE_TIME + 1];
+	struct hlist_head	peer_keepalive_new;
+	struct timer_list	peer_keepalive_timer;
+	struct work_struct	peer_keepalive_work;
 };
 
 /*
@@ -285,6 +293,8 @@ struct rxrpc_peer {
 	struct hlist_head	error_targets;	/* targets for net error distribution */
 	struct work_struct	error_distributor;
 	struct rb_root		service_conns;	/* Service connections */
+	struct hlist_node	keepalive_link;	/* Link in net->peer_keepalive[] */
+	time64_t		last_tx_at;	/* Last time packet sent here */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
 	unsigned int		if_mtu;		/* interface MTU for this peer */
@@ -1026,6 +1036,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *, bool, rxrpc_serial_t *);
 int rxrpc_send_abort_packet(struct rxrpc_call *);
 int rxrpc_send_data_packet(struct rxrpc_call *, struct sk_buff *, bool);
 void rxrpc_reject_packets(struct rxrpc_local *);
+void rxrpc_send_keepalive(struct rxrpc_peer *);
 
 /*
  * peer_event.c
@@ -1034,6 +1045,7 @@ void rxrpc_error_report(struct sock *);
 void rxrpc_peer_error_distributor(struct work_struct *);
 void rxrpc_peer_add_rtt(struct rxrpc_call *, enum rxrpc_rtt_rx_trace,
 			rxrpc_serial_t, rxrpc_serial_t, ktime_t, ktime_t);
+void rxrpc_peer_keepalive_worker(struct work_struct *);
 
 /*
  * peer_object.c
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index d2ec3fd593e8..c717152070df 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -136,6 +136,7 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	}
 
 	kernel_sendmsg(conn->params.local->socket, &msg, iov, ioc, len);
+	conn->params.peer->last_tx_at = ktime_get_real();
 	_leave("");
 	return;
 }
@@ -239,6 +240,8 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 		return -EAGAIN;
 	}
 
+	conn->params.peer->last_tx_at = ktime_get_real();
+
 	_leave(" = 0");
 	return 0;
 }
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 2a868fdab0ae..d4f2509e018b 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1183,6 +1183,8 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_VERSION:
+		if (!(sp->hdr.flags & RXRPC_CLIENT_INITIATED))
+			goto discard;
 		rxrpc_post_packet_to_local(local, skb);
 		goto out;
 
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index f18c9248e0d4..66baf2b80b6c 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -32,13 +32,22 @@ static void rxrpc_service_conn_reap_timeout(struct timer_list *timer)
 		rxrpc_queue_work(&rxnet->service_conn_reaper);
 }
 
+static void rxrpc_peer_keepalive_timeout(struct timer_list *timer)
+{
+	struct rxrpc_net *rxnet =
+		container_of(timer, struct rxrpc_net, peer_keepalive_timer);
+
+	if (rxnet->live)
+		rxrpc_queue_work(&rxnet->peer_keepalive_work);
+}
+
 /*
  * Initialise a per-network namespace record.
  */
 static __net_init int rxrpc_init_net(struct net *net)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(net);
-	int ret;
+	int ret, i;
 
 	rxnet->live = true;
 	get_random_bytes(&rxnet->epoch, sizeof(rxnet->epoch));
@@ -70,8 +79,16 @@ static __net_init int rxrpc_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&rxnet->local_endpoints);
 	mutex_init(&rxnet->local_mutex);
+
 	hash_init(rxnet->peer_hash);
 	spin_lock_init(&rxnet->peer_hash_lock);
+	for (i = 0; i < ARRAY_SIZE(rxnet->peer_keepalive); i++)
+		INIT_HLIST_HEAD(&rxnet->peer_keepalive[i]);
+	INIT_HLIST_HEAD(&rxnet->peer_keepalive_new);
+	timer_setup(&rxnet->peer_keepalive_timer,
+		    rxrpc_peer_keepalive_timeout, 0);
+	INIT_WORK(&rxnet->peer_keepalive_work, rxrpc_peer_keepalive_worker);
+	rxnet->peer_keepalive_base = ktime_add(ktime_get_real(), NSEC_PER_SEC);
 
 	ret = -ENOMEM;
 	rxnet->proc_net = proc_net_mkdir(net, "rxrpc", net->proc_net);
@@ -95,6 +112,8 @@ static __net_exit void rxrpc_exit_net(struct net *net)
 	struct rxrpc_net *rxnet = rxrpc_net(net);
 
 	rxnet->live = false;
+	del_timer_sync(&rxnet->peer_keepalive_timer);
+	cancel_work_sync(&rxnet->peer_keepalive_work);
 	rxrpc_destroy_all_calls(rxnet);
 	rxrpc_destroy_all_connections(rxnet);
 	rxrpc_destroy_all_locals(rxnet);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index cf73dc006c3b..7f1fc04775b3 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -32,6 +32,8 @@ struct rxrpc_abort_buffer {
 	__be32 abort_code;
 };
 
+static const char rxrpc_keepalive_string[] = "";
+
 /*
  * Arrange for a keepalive ping a certain time after we last transmitted.  This
  * lets the far side know we're still interested in this call and helps keep
@@ -122,6 +124,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	struct kvec iov[2];
 	rxrpc_serial_t serial;
 	rxrpc_seq_t hard_ack, top;
+	ktime_t now;
 	size_t len, n;
 	int ret;
 	u8 reason;
@@ -203,8 +206,10 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	}
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
+	now = ktime_get_real();
 	if (ping)
-		call->ping_time = ktime_get_real();
+		call->ping_time = now;
+	conn->params.peer->last_tx_at = ktime_get_real();
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
 		if (ret < 0) {
@@ -288,6 +293,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 
 	ret = kernel_sendmsg(conn->params.local->socket,
 			     &msg, iov, 1, sizeof(pkt));
+	conn->params.peer->last_tx_at = ktime_get_real();
 
 	rxrpc_put_connection(conn);
 	return ret;
@@ -378,6 +384,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	 *     message and update the peer record
 	 */
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
+	conn->params.peer->last_tx_at = ktime_get_real();
 
 	up_read(&conn->params.local->defrag_sem);
 	if (ret == -EMSGSIZE)
@@ -429,6 +436,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		if (ret == 0) {
 			ret = kernel_sendmsg(conn->params.local->socket, &msg,
 					     iov, 2, len);
+			conn->params.peer->last_tx_at = ktime_get_real();
 
 			opt = IP_PMTUDISC_DO;
 			kernel_setsockopt(conn->params.local->socket, SOL_IP,
@@ -446,6 +454,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		if (ret == 0) {
 			ret = kernel_sendmsg(conn->params.local->socket, &msg,
 					     iov, 2, len);
+			conn->params.peer->last_tx_at = ktime_get_real();
 
 			opt = IPV6_PMTUDISC_DO;
 			kernel_setsockopt(conn->params.local->socket,
@@ -515,3 +524,51 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 
 	_leave("");
 }
+
+/*
+ * Send a VERSION reply to a peer as a keepalive.
+ */
+void rxrpc_send_keepalive(struct rxrpc_peer *peer)
+{
+	struct rxrpc_wire_header whdr;
+	struct msghdr msg;
+	struct kvec iov[2];
+	size_t len;
+	int ret;
+
+	_enter("");
+
+	msg.msg_name	= &peer->srx.transport;
+	msg.msg_namelen	= peer->srx.transport_len;
+	msg.msg_control	= NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags	= 0;
+
+	whdr.epoch	= htonl(peer->local->rxnet->epoch);
+	whdr.cid	= 0;
+	whdr.callNumber	= 0;
+	whdr.seq	= 0;
+	whdr.serial	= 0;
+	whdr.type	= RXRPC_PACKET_TYPE_VERSION; /* Not client-initiated */
+	whdr.flags	= RXRPC_LAST_PACKET;
+	whdr.userStatus	= 0;
+	whdr.securityIndex = 0;
+	whdr._rsvd	= 0;
+	whdr.serviceId	= 0;
+
+	iov[0].iov_base	= &whdr;
+	iov[0].iov_len	= sizeof(whdr);
+	iov[1].iov_base	= (char *)rxrpc_keepalive_string;
+	iov[1].iov_len	= sizeof(rxrpc_keepalive_string);
+
+	len = iov[0].iov_len + iov[1].iov_len;
+
+	_proto("Tx VERSION (keepalive)");
+
+	ret = kernel_sendmsg(peer->local->socket, &msg, iov, 2, len);
+	if (ret < 0)
+		_debug("sendmsg failed: %d", ret);
+
+	peer->last_tx_at = ktime_get_real();
+	_leave("");
+}
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 7f749505e699..d01eb9a06448 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -348,3 +348,99 @@ void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 	trace_rxrpc_rtt_rx(call, why, send_serial, resp_serial, rtt,
 			   usage, avg);
 }
+
+/*
+ * Perform keep-alive pings with VERSION packets to keep any NAT alive.
+ */
+void rxrpc_peer_keepalive_worker(struct work_struct *work)
+{
+	struct rxrpc_net *rxnet =
+		container_of(work, struct rxrpc_net, peer_keepalive_work);
+	struct rxrpc_peer *peer;
+	unsigned long delay;
+	ktime_t base, now = ktime_get_real();
+	s64 diff;
+	u8 cursor, slot;
+
+	base = rxnet->peer_keepalive_base;
+	cursor = rxnet->peer_keepalive_cursor;
+
+	_enter("%u,%lld", cursor, ktime_sub(now, base));
+
+next_bucket:
+	diff = ktime_to_ns(ktime_sub(now, base));
+	if (diff < 0)
+		goto resched;
+
+	_debug("at %u", cursor);
+	spin_lock_bh(&rxnet->peer_hash_lock);
+next_peer:
+	if (!rxnet->live) {
+		spin_unlock_bh(&rxnet->peer_hash_lock);
+		goto out;
+	}
+
+	/* Everything in the bucket at the cursor is processed this second; the
+	 * bucket at cursor + 1 goes now + 1s and so on...
+	 */
+	if (hlist_empty(&rxnet->peer_keepalive[cursor])) {
+		if (hlist_empty(&rxnet->peer_keepalive_new)) {
+			spin_unlock_bh(&rxnet->peer_hash_lock);
+			goto emptied_bucket;
+		}
+
+		hlist_move_list(&rxnet->peer_keepalive_new,
+				&rxnet->peer_keepalive[cursor]);
+	}
+
+	peer = hlist_entry(rxnet->peer_keepalive[cursor].first,
+			   struct rxrpc_peer, keepalive_link);
+	hlist_del_init(&peer->keepalive_link);
+	if (!rxrpc_get_peer_maybe(peer))
+		goto next_peer;
+
+	spin_unlock_bh(&rxnet->peer_hash_lock);
+
+	_debug("peer %u {%pISp}", peer->debug_id, &peer->srx.transport);
+
+recalc:
+	diff = ktime_divns(ktime_sub(peer->last_tx_at, base), NSEC_PER_SEC);
+	if (diff < -30 || diff > 30)
+		goto send; /* LSW of 64-bit time probably wrapped on 32-bit */
+	diff += RXRPC_KEEPALIVE_TIME - 1;
+	if (diff < 0)
+		goto send;
+
+	slot = (diff > RXRPC_KEEPALIVE_TIME - 1) ? RXRPC_KEEPALIVE_TIME - 1 : diff;
+	if (slot == 0)
+		goto send;
+
+	/* A transmission to this peer occurred since last we examined it so
+	 * put it into the appropriate future bucket.
+	 */
+	slot = (slot + cursor) % ARRAY_SIZE(rxnet->peer_keepalive);
+	spin_lock_bh(&rxnet->peer_hash_lock);
+	hlist_add_head(&peer->keepalive_link, &rxnet->peer_keepalive[slot]);
+	rxrpc_put_peer(peer);
+	goto next_peer;
+
+send:
+	rxrpc_send_keepalive(peer);
+	now = ktime_get_real();
+	goto recalc;
+
+emptied_bucket:
+	cursor++;
+	if (cursor >= ARRAY_SIZE(rxnet->peer_keepalive))
+		cursor = 0;
+	base = ktime_add_ns(base, NSEC_PER_SEC);
+	goto next_bucket;
+
+resched:
+	rxnet->peer_keepalive_base = base;
+	rxnet->peer_keepalive_cursor = cursor;
+	delay = nsecs_to_jiffies(-diff) + 1;
+	timer_reduce(&rxnet->peer_keepalive_timer, jiffies + delay);
+out:
+	_leave("");
+}
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index d02a99f37f5f..94a6dbfcf129 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -322,6 +322,7 @@ struct rxrpc_peer *rxrpc_lookup_incoming_peer(struct rxrpc_local *local,
 	if (!peer) {
 		peer = prealloc;
 		hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
+		hlist_add_head(&peer->keepalive_link, &rxnet->peer_keepalive_new);
 	}
 
 	spin_unlock(&rxnet->peer_hash_lock);
@@ -363,9 +364,12 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 		peer = __rxrpc_lookup_peer_rcu(local, srx, hash_key);
 		if (peer && !rxrpc_get_peer_maybe(peer))
 			peer = NULL;
-		if (!peer)
+		if (!peer) {
 			hash_add_rcu(rxnet->peer_hash,
 				     &candidate->hash_link, hash_key);
+			hlist_add_head(&candidate->keepalive_link,
+				       &rxnet->peer_keepalive_new);
+		}
 
 		spin_unlock_bh(&rxnet->peer_hash_lock);
 
@@ -392,6 +396,7 @@ void __rxrpc_put_peer(struct rxrpc_peer *peer)
 
 	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_del_rcu(&peer->hash_link);
+	hlist_del_init(&peer->keepalive_link);
 	spin_unlock_bh(&rxnet->peer_hash_lock);
 
 	kfree_rcu(peer, rcu);
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 77cb23c7bd0a..588fea0dd362 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -668,6 +668,7 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 		return -EAGAIN;
 	}
 
+	conn->params.peer->last_tx_at = ktime_get_real();
 	_leave(" = 0");
 	return 0;
 }
@@ -722,6 +723,7 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 		return -EAGAIN;
 	}
 
+	conn->params.peer->last_tx_at = ktime_get_real();
 	_leave(" = 0");
 	return 0;
 }
