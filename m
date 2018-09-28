Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F32172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2F32172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeI1Qdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbeI1Qdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E44680F6B;
        Fri, 28 Sep 2018 10:10:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35D6160F86;
        Fri, 28 Sep 2018 10:10:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 8/8] rxrpc: Fix error distribution
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:50 +0100
Message-ID: <153812945037.10469.11505352554836108794.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Sep 2018 10:10:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error distribution by immediately delivering the errors to all the
affected calls rather than deferring them to a worker thread.  The problem
with the latter is that retries and things can happen in the meantime when we
want to stop that sooner.

To this end:

 (1) Stop the error distributor from removing calls from the error_targets
     list so that peer->lock isn't needed to synchronise against other adds
     and removals.

 (2) Require the peer's error_targets list to be accessed with RCU, thereby
     avoiding the need to take peer->lock over distribution.

 (3) Don't attempt to affect a call's state if it is already marked complete.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |    4 +---
 net/rxrpc/ar-internal.h      |    5 -----
 net/rxrpc/call_object.c      |    2 +-
 net/rxrpc/conn_client.c      |    4 ++--
 net/rxrpc/conn_object.c      |    2 +-
 net/rxrpc/peer_event.c       |   46 ++++++++++--------------------------------
 net/rxrpc/peer_object.c      |   17 ----------------
 7 files changed, 16 insertions(+), 64 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 196587b8f204..837393fa897b 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -56,7 +56,6 @@ enum rxrpc_peer_trace {
 	rxrpc_peer_new,
 	rxrpc_peer_processing,
 	rxrpc_peer_put,
-	rxrpc_peer_queued_error,
 };
 
 enum rxrpc_conn_trace {
@@ -257,8 +256,7 @@ enum rxrpc_tx_point {
 	EM(rxrpc_peer_got,			"GOT") \
 	EM(rxrpc_peer_new,			"NEW") \
 	EM(rxrpc_peer_processing,		"PRO") \
-	EM(rxrpc_peer_put,			"PUT") \
-	E_(rxrpc_peer_queued_error,		"QER")
+	E_(rxrpc_peer_put,			"PUT")
 
 #define rxrpc_conn_traces \
 	EM(rxrpc_conn_got,			"GOT") \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c72686193d83..ef9554131434 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -288,7 +288,6 @@ struct rxrpc_peer {
 	struct hlist_node	hash_link;
 	struct rxrpc_local	*local;
 	struct hlist_head	error_targets;	/* targets for net error distribution */
-	struct work_struct	error_distributor;
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
 	time64_t		last_tx_at;	/* Last time packet sent here */
@@ -299,8 +298,6 @@ struct rxrpc_peer {
 	unsigned int		maxdata;	/* data size (MTU - hdrsize) */
 	unsigned short		hdrsize;	/* header size (IP + UDP + RxRPC) */
 	int			debug_id;	/* debug ID for printks */
-	int			error_report;	/* Net (+0) or local (+1000000) to distribute */
-#define RXRPC_LOCAL_ERROR_OFFSET 1000000
 	struct sockaddr_rxrpc	srx;		/* remote address */
 
 	/* calculated RTT cache */
@@ -1039,7 +1036,6 @@ void rxrpc_send_keepalive(struct rxrpc_peer *);
  * peer_event.c
  */
 void rxrpc_error_report(struct sock *);
-void rxrpc_peer_error_distributor(struct work_struct *);
 void rxrpc_peer_add_rtt(struct rxrpc_call *, enum rxrpc_rtt_rx_trace,
 			rxrpc_serial_t, rxrpc_serial_t, ktime_t, ktime_t);
 void rxrpc_peer_keepalive_worker(struct work_struct *);
@@ -1057,7 +1053,6 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *);
 struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *);
 struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *);
 void rxrpc_put_peer(struct rxrpc_peer *);
-void __rxrpc_queue_peer_error(struct rxrpc_peer *);
 
 /*
  * proc.c
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 9486293fef5c..799f75b6900d 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -400,7 +400,7 @@ void rxrpc_incoming_call(struct rxrpc_sock *rx,
 	rcu_assign_pointer(conn->channels[chan].call, call);
 
 	spin_lock(&conn->params.peer->lock);
-	hlist_add_head(&call->error_link, &conn->params.peer->error_targets);
+	hlist_add_head_rcu(&call->error_link, &conn->params.peer->error_targets);
 	spin_unlock(&conn->params.peer->lock);
 
 	_net("CALL incoming %d on CONN %d", call->debug_id, call->conn->debug_id);
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index f8f37188a932..8acf74fe24c0 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -710,8 +710,8 @@ int rxrpc_connect_call(struct rxrpc_call *call,
 	}
 
 	spin_lock_bh(&call->conn->params.peer->lock);
-	hlist_add_head(&call->error_link,
-		       &call->conn->params.peer->error_targets);
+	hlist_add_head_rcu(&call->error_link,
+			   &call->conn->params.peer->error_targets);
 	spin_unlock_bh(&call->conn->params.peer->lock);
 
 out:
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index b4438f98dc5c..885dae829f4a 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -216,7 +216,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 	call->peer->cong_cwnd = call->cong_cwnd;
 
 	spin_lock_bh(&conn->params.peer->lock);
-	hlist_del_init(&call->error_link);
+	hlist_del_rcu(&call->error_link);
 	spin_unlock_bh(&conn->params.peer->lock);
 
 	if (rxrpc_is_client_call(call))
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 4f9da2f51c69..f3e6fc670da2 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -23,6 +23,8 @@
 #include "ar-internal.h"
 
 static void rxrpc_store_error(struct rxrpc_peer *, struct sock_exterr_skb *);
+static void rxrpc_distribute_error(struct rxrpc_peer *, int,
+				   enum rxrpc_call_completion);
 
 /*
  * Find the peer associated with an ICMP packet.
@@ -194,8 +196,6 @@ void rxrpc_error_report(struct sock *sk)
 	rcu_read_unlock();
 	rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
 
-	/* The ref we obtained is passed off to the work item */
-	__rxrpc_queue_peer_error(peer);
 	_leave("");
 }
 
@@ -205,6 +205,7 @@ void rxrpc_error_report(struct sock *sk)
 static void rxrpc_store_error(struct rxrpc_peer *peer,
 			      struct sock_exterr_skb *serr)
 {
+	enum rxrpc_call_completion compl = RXRPC_CALL_NETWORK_ERROR;
 	struct sock_extended_err *ee;
 	int err;
 
@@ -255,7 +256,7 @@ static void rxrpc_store_error(struct rxrpc_peer *peer,
 	case SO_EE_ORIGIN_NONE:
 	case SO_EE_ORIGIN_LOCAL:
 		_proto("Rx Received local error { error=%d }", err);
-		err += RXRPC_LOCAL_ERROR_OFFSET;
+		compl = RXRPC_CALL_LOCAL_ERROR;
 		break;
 
 	case SO_EE_ORIGIN_ICMP6:
@@ -264,48 +265,23 @@ static void rxrpc_store_error(struct rxrpc_peer *peer,
 		break;
 	}
 
-	peer->error_report = err;
+	rxrpc_distribute_error(peer, err, compl);
 }
 
 /*
- * Distribute an error that occurred on a peer
+ * Distribute an error that occurred on a peer.
  */
-void rxrpc_peer_error_distributor(struct work_struct *work)
+static void rxrpc_distribute_error(struct rxrpc_peer *peer, int error,
+				   enum rxrpc_call_completion compl)
 {
-	struct rxrpc_peer *peer =
-		container_of(work, struct rxrpc_peer, error_distributor);
 	struct rxrpc_call *call;
-	enum rxrpc_call_completion compl;
-	int error;
-
-	_enter("");
-
-	error = READ_ONCE(peer->error_report);
-	if (error < RXRPC_LOCAL_ERROR_OFFSET) {
-		compl = RXRPC_CALL_NETWORK_ERROR;
-	} else {
-		compl = RXRPC_CALL_LOCAL_ERROR;
-		error -= RXRPC_LOCAL_ERROR_OFFSET;
-	}
 
-	_debug("ISSUE ERROR %s %d", rxrpc_call_completions[compl], error);
-
-	spin_lock_bh(&peer->lock);
-
-	while (!hlist_empty(&peer->error_targets)) {
-		call = hlist_entry(peer->error_targets.first,
-				   struct rxrpc_call, error_link);
-		hlist_del_init(&call->error_link);
+	hlist_for_each_entry_rcu(call, &peer->error_targets, error_link) {
 		rxrpc_see_call(call);
-
-		if (rxrpc_set_call_completion(call, compl, 0, -error))
+		if (call->state < RXRPC_CALL_COMPLETE &&
+		    rxrpc_set_call_completion(call, compl, 0, -error))
 			rxrpc_notify_socket(call);
 	}
-
-	spin_unlock_bh(&peer->lock);
-
-	rxrpc_put_peer(peer);
-	_leave("");
 }
 
 /*
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 70083e8fb6e5..01a9febfa367 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -220,8 +220,6 @@ struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *local, gfp_t gfp)
 		atomic_set(&peer->usage, 1);
 		peer->local = local;
 		INIT_HLIST_HEAD(&peer->error_targets);
-		INIT_WORK(&peer->error_distributor,
-			  &rxrpc_peer_error_distributor);
 		peer->service_conns = RB_ROOT;
 		seqlock_init(&peer->service_conn_lock);
 		spin_lock_init(&peer->lock);
@@ -402,21 +400,6 @@ struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *peer)
 	return peer;
 }
 
-/*
- * Queue a peer record.  This passes the caller's ref to the workqueue.
- */
-void __rxrpc_queue_peer_error(struct rxrpc_peer *peer)
-{
-	const void *here = __builtin_return_address(0);
-	int n;
-
-	n = atomic_read(&peer->usage);
-	if (rxrpc_queue_work(&peer->error_distributor))
-		trace_rxrpc_peer(peer, rxrpc_peer_queued_error, n, here);
-	else
-		rxrpc_put_peer(peer);
-}
-
 /*
  * Discard a peer record.
  */

