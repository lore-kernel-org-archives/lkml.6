Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC2FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A8B214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfAJQ7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:59:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbfAJQ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:59:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 376184480E;
        Thu, 10 Jan 2019 16:59:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C52BC104812D;
        Thu, 10 Jan 2019 16:59:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] Revert "rxrpc: Allow failed client calls to be retried"
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Jan 2019 16:59:13 +0000
Message-ID: <154713955397.15386.3132662854461157170.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 10 Jan 2019 16:59:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes introduced to allow rxrpc calls to be retried creates an issue
when it comes to refcounting afs_call structs.  The problem is that when
rxrpc_send_data() queues the last packet for an asynchronous call, the
following sequence can occur:

 (1) The notify_end_tx callback is invoked which causes the state in the
     afs_call to be changed from AFS_CALL_CL_REQUESTING or
     AFS_CALL_SV_REPLYING.

 (2) afs_deliver_to_call() can then process event notifications from rxrpc
     on the async_work queue.

 (3) Delivery of events, such as an abort from the server, can cause the
     afs_call state to be changed to AFS_CALL_COMPLETE on async_work.

 (4) For an asynchronous call, afs_process_async_call() notes that the call
     is complete and tried to clean up all the refs on async_work.

 (5) rxrpc_send_data() might return the amount of data transferred
     (success) or an error - which could in turn reflect a local error or a
     received error.

Synchronising the clean up after rxrpc_kernel_send_data() returns an error
with the asynchronous cleanup is then tricky to get right.

Mostly revert commit c038a58ccfd6704d4d7d60ed3d6a0fca13cf13a4.  The two API
functions the original commit added aren't currently used.  This makes
rxrpc_kernel_send_data() always return successfully if it queued the data
it was given.

Note that this doesn't affect synchronous calls since their Rx notification
function merely pokes a wait queue and does not refcounting.  The
asynchronous call notification function *has* to do refcounting and pass a
ref over the work item to avoid the need to sync the workqueue in call
cleanup.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/networking/rxrpc.txt |   45 -----------------
 include/net/af_rxrpc.h             |   16 ------
 net/rxrpc/af_rxrpc.c               |   70 --------------------------
 net/rxrpc/ar-internal.h            |   19 ++++---
 net/rxrpc/call_object.c            |   97 ------------------------------------
 net/rxrpc/conn_client.c            |    5 --
 net/rxrpc/sendmsg.c                |   24 ++++-----
 7 files changed, 24 insertions(+), 252 deletions(-)

diff --git a/Documentation/networking/rxrpc.txt b/Documentation/networking/rxrpc.txt
index c9d052e0cf51..2df5894353d6 100644
--- a/Documentation/networking/rxrpc.txt
+++ b/Documentation/networking/rxrpc.txt
@@ -1000,51 +1000,6 @@ The kernel interface functions are as follows:
      size should be set when the call is begun.  tx_total_len may not be less
      than zero.
 
- (*) Check to see the completion state of a call so that the caller can assess
-     whether it needs to be retried.
-
-	enum rxrpc_call_completion {
-		RXRPC_CALL_SUCCEEDED,
-		RXRPC_CALL_REMOTELY_ABORTED,
-		RXRPC_CALL_LOCALLY_ABORTED,
-		RXRPC_CALL_LOCAL_ERROR,
-		RXRPC_CALL_NETWORK_ERROR,
-	};
-
-	int rxrpc_kernel_check_call(struct socket *sock, struct rxrpc_call *call,
-				    enum rxrpc_call_completion *_compl,
-				    u32 *_abort_code);
-
-     On return, -EINPROGRESS will be returned if the call is still ongoing; if
-     it is finished, *_compl will be set to indicate the manner of completion,
-     *_abort_code will be set to any abort code that occurred.  0 will be
-     returned on a successful completion, -ECONNABORTED will be returned if the
-     client failed due to a remote abort and anything else will return an
-     appropriate error code.
-
-     The caller should look at this information to decide if it's worth
-     retrying the call.
-
- (*) Retry a client call.
-
-	int rxrpc_kernel_retry_call(struct socket *sock,
-				    struct rxrpc_call *call,
-				    struct sockaddr_rxrpc *srx,
-				    struct key *key);
-
-     This attempts to partially reinitialise a call and submit it again while
-     reusing the original call's Tx queue to avoid the need to repackage and
-     re-encrypt the data to be sent.  call indicates the call to retry, srx the
-     new address to send it to and key the encryption key to use for signing or
-     encrypting the packets.
-
-     For this to work, the first Tx data packet must still be in the transmit
-     queue, and currently this is only permitted for local and network errors
-     and the call must not have been aborted.  Any partially constructed Tx
-     packet is left as is and can continue being filled afterwards.
-
-     It returns 0 if the call was requeued and an error otherwise.
-
  (*) Get call RTT.
 
 	u64 rxrpc_kernel_get_rtt(struct socket *sock, struct rxrpc_call *call);
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 1adefe42c0a6..2bfb87eb98ce 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -20,18 +20,6 @@ struct sock;
 struct socket;
 struct rxrpc_call;
 
-/*
- * Call completion condition (state == RXRPC_CALL_COMPLETE).
- */
-enum rxrpc_call_completion {
-	RXRPC_CALL_SUCCEEDED,		/* - Normal termination */
-	RXRPC_CALL_REMOTELY_ABORTED,	/* - call aborted by peer */
-	RXRPC_CALL_LOCALLY_ABORTED,	/* - call aborted locally on error or close */
-	RXRPC_CALL_LOCAL_ERROR,		/* - call failed due to local error */
-	RXRPC_CALL_NETWORK_ERROR,	/* - call terminated by network error */
-	NR__RXRPC_CALL_COMPLETIONS
-};
-
 /*
  * Debug ID counter for tracing.
  */
@@ -73,10 +61,6 @@ int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
 			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
 			       unsigned int);
 void rxrpc_kernel_set_tx_length(struct socket *, struct rxrpc_call *, s64);
-int rxrpc_kernel_retry_call(struct socket *, struct rxrpc_call *,
-			    struct sockaddr_rxrpc *, struct key *);
-int rxrpc_kernel_check_call(struct socket *, struct rxrpc_call *,
-			    enum rxrpc_call_completion *, u32 *);
 u32 rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
 void rxrpc_kernel_probe_life(struct socket *, struct rxrpc_call *);
 u32 rxrpc_kernel_get_epoch(struct socket *, struct rxrpc_call *);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index a2522f9d71e2..96f2952bbdfd 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -418,76 +418,6 @@ u32 rxrpc_kernel_get_epoch(struct socket *sock, struct rxrpc_call *call)
 }
 EXPORT_SYMBOL(rxrpc_kernel_get_epoch);
 
-/**
- * rxrpc_kernel_check_call - Check a call's state
- * @sock: The socket the call is on
- * @call: The call to check
- * @_compl: Where to store the completion state
- * @_abort_code: Where to store any abort code
- *
- * Allow a kernel service to query the state of a call and find out the manner
- * of its termination if it has completed.  Returns -EINPROGRESS if the call is
- * still going, 0 if the call finished successfully, -ECONNABORTED if the call
- * was aborted and an appropriate error if the call failed in some other way.
- */
-int rxrpc_kernel_check_call(struct socket *sock, struct rxrpc_call *call,
-			    enum rxrpc_call_completion *_compl, u32 *_abort_code)
-{
-	if (call->state != RXRPC_CALL_COMPLETE)
-		return -EINPROGRESS;
-	smp_rmb();
-	*_compl = call->completion;
-	*_abort_code = call->abort_code;
-	return call->error;
-}
-EXPORT_SYMBOL(rxrpc_kernel_check_call);
-
-/**
- * rxrpc_kernel_retry_call - Allow a kernel service to retry a call
- * @sock: The socket the call is on
- * @call: The call to retry
- * @srx: The address of the peer to contact
- * @key: The security context to use (defaults to socket setting)
- *
- * Allow a kernel service to try resending a client call that failed due to a
- * network error to a new address.  The Tx queue is maintained intact, thereby
- * relieving the need to re-encrypt any request data that has already been
- * buffered.
- */
-int rxrpc_kernel_retry_call(struct socket *sock, struct rxrpc_call *call,
-			    struct sockaddr_rxrpc *srx, struct key *key)
-{
-	struct rxrpc_conn_parameters cp;
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	int ret;
-
-	_enter("%d{%d}", call->debug_id, atomic_read(&call->usage));
-
-	if (!key)
-		key = rx->key;
-	if (key && !key->payload.data[0])
-		key = NULL; /* a no-security key */
-
-	memset(&cp, 0, sizeof(cp));
-	cp.local		= rx->local;
-	cp.key			= key;
-	cp.security_level	= 0;
-	cp.exclusive		= false;
-	cp.service_id		= srx->srx_service;
-
-	mutex_lock(&call->user_mutex);
-
-	ret = rxrpc_prepare_call_for_retry(rx, call);
-	if (ret == 0)
-		ret = rxrpc_retry_client_call(rx, call, &cp, srx, GFP_KERNEL);
-
-	mutex_unlock(&call->user_mutex);
-	rxrpc_put_peer(cp.peer);
-	_leave(" = %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(rxrpc_kernel_retry_call);
-
 /**
  * rxrpc_kernel_new_call_notification - Get notifications of new calls
  * @sock: The socket to intercept received messages on
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index bc628acf4f4f..4b1a534d290a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -476,7 +476,6 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_EXPOSED,		/* The call was exposed to the world */
 	RXRPC_CALL_RX_LAST,		/* Received the last packet (at rxtx_top) */
 	RXRPC_CALL_TX_LAST,		/* Last packet in Tx buffer (at rxtx_top) */
-	RXRPC_CALL_TX_LASTQ,		/* Last packet has been queued */
 	RXRPC_CALL_SEND_PING,		/* A ping will need to be sent */
 	RXRPC_CALL_PINGING,		/* Ping in process */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
@@ -517,6 +516,18 @@ enum rxrpc_call_state {
 	NR__RXRPC_CALL_STATES
 };
 
+/*
+ * Call completion condition (state == RXRPC_CALL_COMPLETE).
+ */
+enum rxrpc_call_completion {
+	RXRPC_CALL_SUCCEEDED,		/* - Normal termination */
+	RXRPC_CALL_REMOTELY_ABORTED,	/* - call aborted by peer */
+	RXRPC_CALL_LOCALLY_ABORTED,	/* - call aborted locally on error or close */
+	RXRPC_CALL_LOCAL_ERROR,		/* - call failed due to local error */
+	RXRPC_CALL_NETWORK_ERROR,	/* - call terminated by network error */
+	NR__RXRPC_CALL_COMPLETIONS
+};
+
 /*
  * Call Tx congestion management modes.
  */
@@ -761,15 +772,9 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *,
 					 struct sockaddr_rxrpc *,
 					 struct rxrpc_call_params *, gfp_t,
 					 unsigned int);
-int rxrpc_retry_client_call(struct rxrpc_sock *,
-			    struct rxrpc_call *,
-			    struct rxrpc_conn_parameters *,
-			    struct sockaddr_rxrpc *,
-			    gfp_t);
 void rxrpc_incoming_call(struct rxrpc_sock *, struct rxrpc_call *,
 			 struct sk_buff *);
 void rxrpc_release_call(struct rxrpc_sock *, struct rxrpc_call *);
-int rxrpc_prepare_call_for_retry(struct rxrpc_sock *, struct rxrpc_call *);
 void rxrpc_release_calls_on_socket(struct rxrpc_sock *);
 bool __rxrpc_queue_call(struct rxrpc_call *);
 bool rxrpc_queue_call(struct rxrpc_call *);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 8f1a8f85b1f9..8aa2937b069f 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -324,48 +324,6 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 	return ERR_PTR(ret);
 }
 
-/*
- * Retry a call to a new address.  It is expected that the Tx queue of the call
- * will contain data previously packaged for an old call.
- */
-int rxrpc_retry_client_call(struct rxrpc_sock *rx,
-			    struct rxrpc_call *call,
-			    struct rxrpc_conn_parameters *cp,
-			    struct sockaddr_rxrpc *srx,
-			    gfp_t gfp)
-{
-	const void *here = __builtin_return_address(0);
-	int ret;
-
-	/* Set up or get a connection record and set the protocol parameters,
-	 * including channel number and call ID.
-	 */
-	ret = rxrpc_connect_call(rx, call, cp, srx, gfp);
-	if (ret < 0)
-		goto error;
-
-	trace_rxrpc_call(call, rxrpc_call_connected, atomic_read(&call->usage),
-			 here, NULL);
-
-	rxrpc_start_call_timer(call);
-
-	_net("CALL new %d on CONN %d", call->debug_id, call->conn->debug_id);
-
-	if (!test_and_set_bit(RXRPC_CALL_EV_RESEND, &call->events))
-		rxrpc_queue_call(call);
-
-	_leave(" = 0");
-	return 0;
-
-error:
-	rxrpc_set_call_completion(call, RXRPC_CALL_LOCAL_ERROR,
-				  RX_CALL_DEAD, ret);
-	trace_rxrpc_call(call, rxrpc_call_error, atomic_read(&call->usage),
-			 here, ERR_PTR(ret));
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * Set up an incoming call.  call->conn points to the connection.
  * This is called in BH context and isn't allowed to fail.
@@ -533,61 +491,6 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	_leave("");
 }
 
-/*
- * Prepare a kernel service call for retry.
- */
-int rxrpc_prepare_call_for_retry(struct rxrpc_sock *rx, struct rxrpc_call *call)
-{
-	const void *here = __builtin_return_address(0);
-	int i;
-	u8 last = 0;
-
-	_enter("{%d,%d}", call->debug_id, atomic_read(&call->usage));
-
-	trace_rxrpc_call(call, rxrpc_call_release, atomic_read(&call->usage),
-			 here, (const void *)call->flags);
-
-	ASSERTCMP(call->state, ==, RXRPC_CALL_COMPLETE);
-	ASSERTCMP(call->completion, !=, RXRPC_CALL_REMOTELY_ABORTED);
-	ASSERTCMP(call->completion, !=, RXRPC_CALL_LOCALLY_ABORTED);
-	ASSERT(list_empty(&call->recvmsg_link));
-
-	del_timer_sync(&call->timer);
-
-	_debug("RELEASE CALL %p (%d CONN %p)", call, call->debug_id, call->conn);
-
-	if (call->conn)
-		rxrpc_disconnect_call(call);
-
-	if (rxrpc_is_service_call(call) ||
-	    !call->tx_phase ||
-	    call->tx_hard_ack != 0 ||
-	    call->rx_hard_ack != 0 ||
-	    call->rx_top != 0)
-		return -EINVAL;
-
-	call->state = RXRPC_CALL_UNINITIALISED;
-	call->completion = RXRPC_CALL_SUCCEEDED;
-	call->call_id = 0;
-	call->cid = 0;
-	call->cong_cwnd = 0;
-	call->cong_extra = 0;
-	call->cong_ssthresh = 0;
-	call->cong_mode = 0;
-	call->cong_dup_acks = 0;
-	call->cong_cumul_acks = 0;
-	call->acks_lowest_nak = 0;
-
-	for (i = 0; i < RXRPC_RXTX_BUFF_SIZE; i++) {
-		last |= call->rxtx_annotations[i];
-		call->rxtx_annotations[i] &= RXRPC_TX_ANNO_LAST;
-		call->rxtx_annotations[i] |= RXRPC_TX_ANNO_RETRANS;
-	}
-
-	_leave(" = 0");
-	return 0;
-}
-
 /*
  * release all the calls associated with a socket
  */
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 521189f4b666..b2adfa825363 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -562,10 +562,7 @@ static void rxrpc_activate_one_channel(struct rxrpc_connection *conn,
 	clear_bit(RXRPC_CONN_FINAL_ACK_0 + channel, &conn->flags);
 
 	write_lock_bh(&call->state_lock);
-	if (!test_bit(RXRPC_CALL_TX_LASTQ, &call->flags))
-		call->state = RXRPC_CALL_CLIENT_SEND_REQUEST;
-	else
-		call->state = RXRPC_CALL_CLIENT_AWAIT_REPLY;
+	call->state = RXRPC_CALL_CLIENT_SEND_REQUEST;
 	write_unlock_bh(&call->state_lock);
 
 	rxrpc_see_call(call);
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index be01f9c5d963..46c9312085b1 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -169,10 +169,8 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 
 	ASSERTCMP(seq, ==, call->tx_top + 1);
 
-	if (last) {
+	if (last)
 		annotation |= RXRPC_TX_ANNO_LAST;
-		set_bit(RXRPC_CALL_TX_LASTQ, &call->flags);
-	}
 
 	/* We have to set the timestamp before queueing as the retransmit
 	 * algorithm can see the packet as soon as we queue it.
@@ -386,6 +384,11 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 				call->tx_total_len -= copy;
 		}
 
+		/* check for the far side aborting the call or a network error
+		 * occurring */
+		if (call->state == RXRPC_CALL_COMPLETE)
+			goto call_terminated;
+
 		/* add the packet to the send queue if it's now full */
 		if (sp->remain <= 0 ||
 		    (msg_data_left(msg) == 0 && !more)) {
@@ -425,16 +428,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 					   notify_end_tx);
 			skb = NULL;
 		}
-
-		/* Check for the far side aborting the call or a network error
-		 * occurring.  If this happens, save any packet that was under
-		 * construction so that in the case of a network error, the
-		 * call can be retried or redirected.
-		 */
-		if (call->state == RXRPC_CALL_COMPLETE) {
-			ret = call->error;
-			goto out;
-		}
 	} while (msg_data_left(msg) > 0);
 
 success:
@@ -444,6 +437,11 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	_leave(" = %d", ret);
 	return ret;
 
+call_terminated:
+	rxrpc_free_skb(skb, rxrpc_skb_tx_freed);
+	_leave(" = %d", call->error);
+	return call->error;
+
 maybe_error:
 	if (copied)
 		goto success;

