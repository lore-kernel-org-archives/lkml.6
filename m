Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C3C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9502075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9502075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIGB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:01:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIGB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:01:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69D0B7D0F4;
        Mon,  8 Oct 2018 22:47:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F117810021B2;
        Mon,  8 Oct 2018 22:47:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 01/10] rxrpc: Fix some missed refs to init_net
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:47:26 +0100
Message-ID: <153903884616.17944.8454555875071108288.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Oct 2018 22:47:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some refs to init_net that should've been changed to the appropriate
network namespace.

Fixes: 2baec2c3f854 ("rxrpc: Support network namespacing")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---

 net/rxrpc/ar-internal.h |   10 ++++++----
 net/rxrpc/call_accept.c |    2 +-
 net/rxrpc/call_object.c |    4 ++--
 net/rxrpc/conn_client.c |   10 ++++++----
 net/rxrpc/input.c       |    4 ++--
 net/rxrpc/peer_object.c |   28 +++++++++++++++++-----------
 6 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ef9554131434..63c43b3a2096 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -891,8 +891,9 @@ extern unsigned long rxrpc_conn_idle_client_fast_expiry;
 extern struct idr rxrpc_client_conn_ids;
 
 void rxrpc_destroy_client_conn_ids(void);
-int rxrpc_connect_call(struct rxrpc_call *, struct rxrpc_conn_parameters *,
-		       struct sockaddr_rxrpc *, gfp_t);
+int rxrpc_connect_call(struct rxrpc_sock *, struct rxrpc_call *,
+		       struct rxrpc_conn_parameters *, struct sockaddr_rxrpc *,
+		       gfp_t);
 void rxrpc_expose_client_call(struct rxrpc_call *);
 void rxrpc_disconnect_client_call(struct rxrpc_call *);
 void rxrpc_put_client_conn(struct rxrpc_connection *);
@@ -1045,10 +1046,11 @@ void rxrpc_peer_keepalive_worker(struct work_struct *);
  */
 struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *,
 					 const struct sockaddr_rxrpc *);
-struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *,
+struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_sock *, struct rxrpc_local *,
 				     struct sockaddr_rxrpc *, gfp_t);
 struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *, gfp_t);
-void rxrpc_new_incoming_peer(struct rxrpc_local *, struct rxrpc_peer *);
+void rxrpc_new_incoming_peer(struct rxrpc_sock *, struct rxrpc_local *,
+			     struct rxrpc_peer *);
 void rxrpc_destroy_all_peers(struct rxrpc_net *);
 struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *);
 struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 9c7f26d06a52..f55f67894465 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -287,7 +287,7 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 					  (peer_tail + 1) &
 					  (RXRPC_BACKLOG_MAX - 1));
 
-			rxrpc_new_incoming_peer(local, peer);
+			rxrpc_new_incoming_peer(rx, local, peer);
 		}
 
 		/* Now allocate and set up the connection */
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 799f75b6900d..0ca2c2dfd196 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -287,7 +287,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 	/* Set up or get a connection record and set the protocol parameters,
 	 * including channel number and call ID.
 	 */
-	ret = rxrpc_connect_call(call, cp, srx, gfp);
+	ret = rxrpc_connect_call(rx, call, cp, srx, gfp);
 	if (ret < 0)
 		goto error;
 
@@ -339,7 +339,7 @@ int rxrpc_retry_client_call(struct rxrpc_sock *rx,
 	/* Set up or get a connection record and set the protocol parameters,
 	 * including channel number and call ID.
 	 */
-	ret = rxrpc_connect_call(call, cp, srx, gfp);
+	ret = rxrpc_connect_call(rx, call, cp, srx, gfp);
 	if (ret < 0)
 		goto error;
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 8acf74fe24c0..521189f4b666 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -276,7 +276,8 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
  * If we return with a connection, the call will be on its waiting list.  It's
  * left to the caller to assign a channel and wake up the call.
  */
-static int rxrpc_get_client_conn(struct rxrpc_call *call,
+static int rxrpc_get_client_conn(struct rxrpc_sock *rx,
+				 struct rxrpc_call *call,
 				 struct rxrpc_conn_parameters *cp,
 				 struct sockaddr_rxrpc *srx,
 				 gfp_t gfp)
@@ -289,7 +290,7 @@ static int rxrpc_get_client_conn(struct rxrpc_call *call,
 
 	_enter("{%d,%lx},", call->debug_id, call->user_call_ID);
 
-	cp->peer = rxrpc_lookup_peer(cp->local, srx, gfp);
+	cp->peer = rxrpc_lookup_peer(rx, cp->local, srx, gfp);
 	if (!cp->peer)
 		goto error;
 
@@ -683,7 +684,8 @@ static int rxrpc_wait_for_channel(struct rxrpc_call *call, gfp_t gfp)
  * find a connection for a call
  * - called in process context with IRQs enabled
  */
-int rxrpc_connect_call(struct rxrpc_call *call,
+int rxrpc_connect_call(struct rxrpc_sock *rx,
+		       struct rxrpc_call *call,
 		       struct rxrpc_conn_parameters *cp,
 		       struct sockaddr_rxrpc *srx,
 		       gfp_t gfp)
@@ -696,7 +698,7 @@ int rxrpc_connect_call(struct rxrpc_call *call,
 	rxrpc_discard_expired_client_conns(&rxnet->client_conn_reaper);
 	rxrpc_cull_active_client_conns(rxnet);
 
-	ret = rxrpc_get_client_conn(call, cp, srx, gfp);
+	ret = rxrpc_get_client_conn(rx, call, cp, srx, gfp);
 	if (ret < 0)
 		goto out;
 
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 800f5b8a1baa..c5af9955665b 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1156,12 +1156,12 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	/* we'll probably need to checksum it (didn't call sock_recvmsg) */
 	if (skb_checksum_complete(skb)) {
 		rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
-		__UDP_INC_STATS(&init_net, UDP_MIB_INERRORS, 0);
+		__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INERRORS, 0);
 		_leave(" [CSUM failed]");
 		return;
 	}
 
-	__UDP_INC_STATS(&init_net, UDP_MIB_INDATAGRAMS, 0);
+	__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INDATAGRAMS, 0);
 
 	/* The UDP protocol already released all skb resources;
 	 * we are free to add our own data there.
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 01a9febfa367..2d39eaf19620 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -153,8 +153,10 @@ struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *local,
  * assess the MTU size for the network interface through which this peer is
  * reached
  */
-static void rxrpc_assess_MTU_size(struct rxrpc_peer *peer)
+static void rxrpc_assess_MTU_size(struct rxrpc_sock *rx,
+				  struct rxrpc_peer *peer)
 {
+	struct net *net = sock_net(&rx->sk);
 	struct dst_entry *dst;
 	struct rtable *rt;
 	struct flowi fl;
@@ -169,7 +171,7 @@ static void rxrpc_assess_MTU_size(struct rxrpc_peer *peer)
 	switch (peer->srx.transport.family) {
 	case AF_INET:
 		rt = ip_route_output_ports(
-			&init_net, fl4, NULL,
+			net, fl4, NULL,
 			peer->srx.transport.sin.sin_addr.s_addr, 0,
 			htons(7000), htons(7001), IPPROTO_UDP, 0, 0);
 		if (IS_ERR(rt)) {
@@ -188,7 +190,7 @@ static void rxrpc_assess_MTU_size(struct rxrpc_peer *peer)
 		       sizeof(struct in6_addr));
 		fl6->fl6_dport = htons(7001);
 		fl6->fl6_sport = htons(7000);
-		dst = ip6_route_output(&init_net, NULL, fl6);
+		dst = ip6_route_output(net, NULL, fl6);
 		if (dst->error) {
 			_leave(" [route err %d]", dst->error);
 			return;
@@ -240,10 +242,11 @@ struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *local, gfp_t gfp)
 /*
  * Initialise peer record.
  */
-static void rxrpc_init_peer(struct rxrpc_peer *peer, unsigned long hash_key)
+static void rxrpc_init_peer(struct rxrpc_sock *rx, struct rxrpc_peer *peer,
+			    unsigned long hash_key)
 {
 	peer->hash_key = hash_key;
-	rxrpc_assess_MTU_size(peer);
+	rxrpc_assess_MTU_size(rx, peer);
 	peer->mtu = peer->if_mtu;
 	peer->rtt_last_req = ktime_get_real();
 
@@ -275,7 +278,8 @@ static void rxrpc_init_peer(struct rxrpc_peer *peer, unsigned long hash_key)
 /*
  * Set up a new peer.
  */
-static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_local *local,
+static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_sock *rx,
+					    struct rxrpc_local *local,
 					    struct sockaddr_rxrpc *srx,
 					    unsigned long hash_key,
 					    gfp_t gfp)
@@ -287,7 +291,7 @@ static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_local *local,
 	peer = rxrpc_alloc_peer(local, gfp);
 	if (peer) {
 		memcpy(&peer->srx, srx, sizeof(*srx));
-		rxrpc_init_peer(peer, hash_key);
+		rxrpc_init_peer(rx, peer, hash_key);
 	}
 
 	_leave(" = %p", peer);
@@ -299,14 +303,15 @@ static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_local *local,
  * since we've already done a search in the list from the non-reentrant context
  * (the data_ready handler) that is the only place we can add new peers.
  */
-void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
+void rxrpc_new_incoming_peer(struct rxrpc_sock *rx, struct rxrpc_local *local,
+			     struct rxrpc_peer *peer)
 {
 	struct rxrpc_net *rxnet = local->rxnet;
 	unsigned long hash_key;
 
 	hash_key = rxrpc_peer_hash_key(local, &peer->srx);
 	peer->local = local;
-	rxrpc_init_peer(peer, hash_key);
+	rxrpc_init_peer(rx, peer, hash_key);
 
 	spin_lock(&rxnet->peer_hash_lock);
 	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
@@ -317,7 +322,8 @@ void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 /*
  * obtain a remote transport endpoint for the specified address
  */
-struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
+struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_sock *rx,
+				     struct rxrpc_local *local,
 				     struct sockaddr_rxrpc *srx, gfp_t gfp)
 {
 	struct rxrpc_peer *peer, *candidate;
@@ -337,7 +343,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 		/* The peer is not yet present in hash - create a candidate
 		 * for a new record and then redo the search.
 		 */
-		candidate = rxrpc_create_peer(local, srx, hash_key, gfp);
+		candidate = rxrpc_create_peer(rx, local, srx, hash_key, gfp);
 		if (!candidate) {
 			_leave(" = NULL [nomem]");
 			return NULL;

