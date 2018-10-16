Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8373C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738AC20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0r3cwfxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738AC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeJPMBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbeJPMBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78A521479;
        Tue, 16 Oct 2018 04:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663182;
        bh=gloOpzzJaM0P3A/AJ9327t/Jpe77l8M786yVlypI+JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0r3cwfxVaRz2u1tNk9uwPvmlPlI+gutxmJjF6qKI/8jnppcjT4Q4SKeURCLAVsaUD
         ngfych+H5APo20dStgSPrLfmrO0fzXEA8jc0xZOMTaidnBcWETB2zycJVmHH3VFvXg
         +8vua5toZAEHO+uRNmxG1aK18mTDSmzyoHBeTVAU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 043/100] rxrpc: Fix error distribution
Date:   Tue, 16 Oct 2018 00:11:24 -0400
Message-Id: <20181016041221.135528-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit f334430316e7fd37c4821ebec627e27714bb5d76 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h |  4 +---
 net/rxrpc/ar-internal.h      |  5 ----
 net/rxrpc/call_object.c      |  2 +-
 net/rxrpc/conn_client.c      |  4 ++--
 net/rxrpc/conn_object.c      |  2 +-
 net/rxrpc/peer_event.c       | 46 +++++++++---------------------------
 net/rxrpc/peer_object.c      | 17 -------------
 7 files changed, 16 insertions(+), 64 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4fff00e9da8a..0a774b64fc29 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -56,7 +56,6 @@ enum rxrpc_peer_trace {
 	rxrpc_peer_new,
 	rxrpc_peer_processing,
 	rxrpc_peer_put,
-	rxrpc_peer_queued_error,
 };
 
 enum rxrpc_conn_trace {
@@ -257,8 +256,7 @@ enum rxrpc_tx_fail_trace {
 	EM(rxrpc_peer_got,			"GOT") \
 	EM(rxrpc_peer_new,			"NEW") \
 	EM(rxrpc_peer_processing,		"PRO") \
-	EM(rxrpc_peer_put,			"PUT") \
-	E_(rxrpc_peer_queued_error,		"QER")
+	E_(rxrpc_peer_put,			"PUT")
 
 #define rxrpc_conn_traces \
 	EM(rxrpc_conn_got,			"GOT") \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5069193d2cc1..4718d08c0af1 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -293,7 +293,6 @@ struct rxrpc_peer {
 	struct hlist_node	hash_link;
 	struct rxrpc_local	*local;
 	struct hlist_head	error_targets;	/* targets for net error distribution */
-	struct work_struct	error_distributor;
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
 	time64_t		last_tx_at;	/* Last time packet sent here */
@@ -304,8 +303,6 @@ struct rxrpc_peer {
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
@@ -1058,7 +1054,6 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *);
 struct rxrpc_peer *rxrpc_get_peer(struct rxrpc_peer *);
 struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *);
 void rxrpc_put_peer(struct rxrpc_peer *);
-void __rxrpc_queue_peer_error(struct rxrpc_peer *);
 
 /*
  * proc.c
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index f6734d8cb01a..ed69257203c2 100644
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
index 5736f643c516..0be19132202b 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -709,8 +709,8 @@ int rxrpc_connect_call(struct rxrpc_call *call,
 	}
 
 	spin_lock_bh(&call->conn->params.peer->lock);
-	hlist_add_head(&call->error_link,
-		       &call->conn->params.peer->error_targets);
+	hlist_add_head_rcu(&call->error_link,
+			   &call->conn->params.peer->error_targets);
 	spin_unlock_bh(&call->conn->params.peer->lock);
 
 out:
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index c37bf8e282b9..e0d6d0fb7426 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -214,7 +214,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
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
index 24ec7cdcf332..ef4c2e8a35cc 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -222,8 +222,6 @@ struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *local, gfp_t gfp)
 		atomic_set(&peer->usage, 1);
 		peer->local = local;
 		INIT_HLIST_HEAD(&peer->error_targets);
-		INIT_WORK(&peer->error_distributor,
-			  &rxrpc_peer_error_distributor);
 		peer->service_conns = RB_ROOT;
 		seqlock_init(&peer->service_conn_lock);
 		spin_lock_init(&peer->lock);
@@ -415,21 +413,6 @@ struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *peer)
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
-- 
2.17.1

