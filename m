Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831062173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831062173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeI1Qdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1Qdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F36A530014DC;
        Fri, 28 Sep 2018 10:10:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB99B6253E;
        Fri, 28 Sep 2018 10:10:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 6/8] rxrpc: Make service call handling more robust
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:35 +0100
Message-ID: <153812943588.10469.5140326078229849296.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 28 Sep 2018 10:10:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the following changes to improve the robustness of the code that sets
up a new service call:

 (1) Cache the rxrpc_sock struct obtained in rxrpc_data_ready() to do a
     service ID check and pass that along to rxrpc_new_incoming_call().
     This means that I can remove the check from rxrpc_new_incoming_call()
     without the need to worry about the socket attached to the local
     endpoint getting replaced - which would invalidate the check.

 (2) Cache the rxrpc_peer struct, thereby allowing the peer search to be
     done once.  The peer is passed to rxrpc_new_incoming_call(), thereby
     saving the need to repeat the search.

     This also reduces the possibility of rxrpc_publish_service_conn()
     BUG()'ing due to the detection of a duplicate connection, despite the
     initial search done by rxrpc_find_connection_rcu() having turned up
     nothing.

     This BUG() shouldn't ever get hit since rxrpc_data_ready() *should* be
     non-reentrant and the result of the initial search should still hold
     true, but it has proven possible to hit.

     I *think* this may be due to __rxrpc_lookup_peer_rcu() cutting short
     the iteration over the hash table if it finds a matching peer with a
     zero usage count, but I don't know for sure since it's only ever been
     hit once that I know of.

     Another possibility is that a bug in rxrpc_data_ready() that checked
     the wrong byte in the header for the RXRPC_CLIENT_INITIATED flag
     might've let through a packet that caused a spurious and invalid call
     to be set up.  That is addressed in another patch.

 (3) Fix __rxrpc_lookup_peer_rcu() to skip peer records that have a zero
     usage count rather than stopping and returning not found, just in case
     there's another peer record behind it in the bucket.

 (4) Don't search the peer records in rxrpc_alloc_incoming_call(), but
     rather either use the peer cached in (2) or, if one wasn't found,
     preemptively install a new one.

Fixes: 8496af50eb38 ("rxrpc: Use RCU to access a peer's service connection tree")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    8 +++++---
 net/rxrpc/call_accept.c |   41 ++++++++++++-----------------------------
 net/rxrpc/conn_object.c |    7 ++++++-
 net/rxrpc/input.c       |    7 ++++---
 net/rxrpc/peer_object.c |   35 +++++++++++------------------------
 5 files changed, 38 insertions(+), 60 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e8861cb78070..c72686193d83 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -722,6 +722,8 @@ extern struct workqueue_struct *rxrpc_workqueue;
 int rxrpc_service_prealloc(struct rxrpc_sock *, gfp_t);
 void rxrpc_discard_prealloc(struct rxrpc_sock *);
 struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *,
+					   struct rxrpc_sock *,
+					   struct rxrpc_peer *,
 					   struct rxrpc_connection *,
 					   struct sk_buff *);
 void rxrpc_accept_incoming_calls(struct rxrpc_local *);
@@ -913,7 +915,8 @@ extern unsigned int rxrpc_closed_conn_expiry;
 
 struct rxrpc_connection *rxrpc_alloc_connection(gfp_t);
 struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *,
-						   struct sk_buff *);
+						   struct sk_buff *,
+						   struct rxrpc_peer **);
 void __rxrpc_disconnect_call(struct rxrpc_connection *, struct rxrpc_call *);
 void rxrpc_disconnect_call(struct rxrpc_call *);
 void rxrpc_kill_connection(struct rxrpc_connection *);
@@ -1049,8 +1052,7 @@ struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *,
 struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *,
 				     struct sockaddr_rxrpc *, gfp_t);
 struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *, gfp_t);
-struct rxrpc_peer *rxrpc_lookup_incoming_peer(struct rxrpc_local *,
-					      struct rxrpc_peer *);
+void rxrpc_new_incoming_peer(struct rxrpc_local *, struct rxrpc_peer *);
 void rxrpc_destroy_all_peers(struct rxrpc_net *);
 struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *);
 struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index e88f131c1d7f..9c7f26d06a52 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -249,11 +249,11 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
  */
 static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 						    struct rxrpc_local *local,
+						    struct rxrpc_peer *peer,
 						    struct rxrpc_connection *conn,
 						    struct sk_buff *skb)
 {
 	struct rxrpc_backlog *b = rx->backlog;
-	struct rxrpc_peer *peer, *xpeer;
 	struct rxrpc_call *call;
 	unsigned short call_head, conn_head, peer_head;
 	unsigned short call_tail, conn_tail, peer_tail;
@@ -276,21 +276,18 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 		return NULL;
 
 	if (!conn) {
-		/* No connection.  We're going to need a peer to start off
-		 * with.  If one doesn't yet exist, use a spare from the
-		 * preallocation set.  We dump the address into the spare in
-		 * anticipation - and to save on stack space.
-		 */
-		xpeer = b->peer_backlog[peer_tail];
-		if (rxrpc_extract_addr_from_skb(local, &xpeer->srx, skb) < 0)
-			return NULL;
-
-		peer = rxrpc_lookup_incoming_peer(local, xpeer);
-		if (peer == xpeer) {
+		if (peer && !rxrpc_get_peer_maybe(peer))
+			peer = NULL;
+		if (!peer) {
+			peer = b->peer_backlog[peer_tail];
+			if (rxrpc_extract_addr_from_skb(local, &peer->srx, skb) < 0)
+				return NULL;
 			b->peer_backlog[peer_tail] = NULL;
 			smp_store_release(&b->peer_backlog_tail,
 					  (peer_tail + 1) &
 					  (RXRPC_BACKLOG_MAX - 1));
+
+			rxrpc_new_incoming_peer(local, peer);
 		}
 
 		/* Now allocate and set up the connection */
@@ -335,30 +332,16 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
  * The call is returned with the user access mutex held.
  */
 struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
+					   struct rxrpc_sock *rx,
+					   struct rxrpc_peer *peer,
 					   struct rxrpc_connection *conn,
 					   struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_sock *rx;
 	struct rxrpc_call *call;
-	u16 service_id = sp->hdr.serviceId;
 
 	_enter("");
 
-	/* Get the socket providing the service */
-	rx = rcu_dereference(local->service);
-	if (rx && (service_id == rx->srx.srx_service ||
-		   service_id == rx->second_service))
-		goto found_service;
-
-	trace_rxrpc_abort(0, "INV", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
-			  RX_INVALID_OPERATION, EOPNOTSUPP);
-	skb->mark = RXRPC_SKB_MARK_REJECT_ABORT;
-	skb->priority = RX_INVALID_OPERATION;
-	_leave(" = NULL [service]");
-	return NULL;
-
-found_service:
 	spin_lock(&rx->incoming_lock);
 	if (rx->sk.sk_state == RXRPC_SERVER_LISTEN_DISABLED ||
 	    rx->sk.sk_state == RXRPC_CLOSE) {
@@ -371,7 +354,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 		goto out;
 	}
 
-	call = rxrpc_alloc_incoming_call(rx, local, conn, skb);
+	call = rxrpc_alloc_incoming_call(rx, local, peer, conn, skb);
 	if (!call) {
 		skb->mark = RXRPC_SKB_MARK_REJECT_BUSY;
 		_leave(" = NULL [busy]");
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 390ba50cfab4..b4438f98dc5c 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -69,10 +69,14 @@ struct rxrpc_connection *rxrpc_alloc_connection(gfp_t gfp)
  * If successful, a pointer to the connection is returned, but no ref is taken.
  * NULL is returned if there is no match.
  *
+ * When searching for a service call, if we find a peer but no connection, we
+ * return that through *_peer in case we need to create a new service call.
+ *
  * The caller must be holding the RCU read lock.
  */
 struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *local,
-						   struct sk_buff *skb)
+						   struct sk_buff *skb,
+						   struct rxrpc_peer **_peer)
 {
 	struct rxrpc_connection *conn;
 	struct rxrpc_conn_proto k;
@@ -104,6 +108,7 @@ struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *local,
 		peer = rxrpc_lookup_peer_rcu(local, &srx);
 		if (!peer)
 			goto not_found;
+		*_peer = peer;
 		conn = rxrpc_find_service_conn_rcu(peer, skb);
 		if (!conn || atomic_read(&conn->usage) == 0)
 			goto not_found;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index a569e9e010d1..800f5b8a1baa 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1128,7 +1128,8 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	struct rxrpc_call *call = NULL;
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_local *local = udp_sk->sk_user_data;
-	struct rxrpc_sock *rx;
+	struct rxrpc_peer *peer = NULL;
+	struct rxrpc_sock *rx = NULL;
 	struct sk_buff *skb;
 	unsigned int channel;
 	int ret, skew = 0;
@@ -1250,7 +1251,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		}
 	}
 
-	conn = rxrpc_find_connection_rcu(local, skb);
+	conn = rxrpc_find_connection_rcu(local, skb, &peer);
 	if (conn) {
 		if (sp->hdr.securityIndex != conn->security_ix)
 			goto wrong_security;
@@ -1339,7 +1340,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 			goto bad_message_unlock;
 		if (sp->hdr.seq != 1)
 			goto discard_unlock;
-		call = rxrpc_new_incoming_call(local, conn, skb);
+		call = rxrpc_new_incoming_call(local, rx, peer, conn, skb);
 		if (!call) {
 			rcu_read_unlock();
 			goto reject_packet;
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 1dc7648e3eff..70083e8fb6e5 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -124,11 +124,9 @@ static struct rxrpc_peer *__rxrpc_lookup_peer_rcu(
 	struct rxrpc_net *rxnet = local->rxnet;
 
 	hash_for_each_possible_rcu(rxnet->peer_hash, peer, hash_link, hash_key) {
-		if (rxrpc_peer_cmp_key(peer, local, srx, hash_key) == 0) {
-			if (atomic_read(&peer->usage) == 0)
-				return NULL;
+		if (rxrpc_peer_cmp_key(peer, local, srx, hash_key) == 0 &&
+		    atomic_read(&peer->usage) > 0)
 			return peer;
-		}
 	}
 
 	return NULL;
@@ -299,34 +297,23 @@ static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_local *local,
 }
 
 /*
- * Set up a new incoming peer.  The address is prestored in the preallocated
- * peer.
+ * Set up a new incoming peer.  There shouldn't be any other matching peers
+ * since we've already done a search in the list from the non-reentrant context
+ * (the data_ready handler) that is the only place we can add new peers.
  */
-struct rxrpc_peer *rxrpc_lookup_incoming_peer(struct rxrpc_local *local,
-					      struct rxrpc_peer *prealloc)
+void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 {
-	struct rxrpc_peer *peer;
 	struct rxrpc_net *rxnet = local->rxnet;
 	unsigned long hash_key;
 
-	hash_key = rxrpc_peer_hash_key(local, &prealloc->srx);
-	prealloc->local = local;
-	rxrpc_init_peer(prealloc, hash_key);
+	hash_key = rxrpc_peer_hash_key(local, &peer->srx);
+	peer->local = local;
+	rxrpc_init_peer(peer, hash_key);
 
 	spin_lock(&rxnet->peer_hash_lock);
-
-	/* Need to check that we aren't racing with someone else */
-	peer = __rxrpc_lookup_peer_rcu(local, &prealloc->srx, hash_key);
-	if (peer && !rxrpc_get_peer_maybe(peer))
-		peer = NULL;
-	if (!peer) {
-		peer = prealloc;
-		hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
-		list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
-	}
-
+	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
+	list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
 	spin_unlock(&rxnet->peer_hash_lock);
-	return peer;
 }
 
 /*

