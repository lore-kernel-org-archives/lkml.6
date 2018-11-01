Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A95C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9DF20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9DF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeKAWm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbeKAWmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D5CD30820F0;
        Thu,  1 Nov 2018 13:39:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3911054FD6;
        Thu,  1 Nov 2018 13:39:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix lockup due to no error backoff after ack
 transmit error
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 01 Nov 2018 13:39:53 +0000
Message-ID: <154107959336.26689.262397874166625147.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 01 Nov 2018 13:39:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the network becomes (partially) unavailable, say by disabling IPv6, the
background ACK transmission routine can get itself into a tizzy by
proposing immediate ACK retransmission.  Since we're in the call event
processor, that happens immediately without returning to the workqueue
manager.

The condition should clear after a while when either the network comes back
or the call times out.

Fix this by:

 (1) When re-proposing an ACK on failed Tx, don't schedule it immediately.
     This will allow a certain amount of time to elapse before we try
     again.

 (2) Enforce a return to the workqueue manager after a certain number of
     iterations of the call processing loop.

 (3) Add a backoff delay that increases the delay on deferred ACKs by a
     jiffy per failed transmission to a limit of HZ.  The backoff delay is
     cleared on a successful return from kernel_sendmsg().

 (4) Cancel calls immediately if the opening sendmsg fails.  The layer
     above can arrange retransmission or rotate to another server.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/call_event.c  |   18 ++++++++++++++----
 net/rxrpc/output.c      |   35 +++++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 382196e57a26..bc628acf4f4f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -611,6 +611,7 @@ struct rxrpc_call {
 						 * not hard-ACK'd packet follows this.
 						 */
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
+	u16			tx_backoff;	/* Delay to insert due to Tx failure */
 
 	/* TCP-style slow-start congestion control [RFC5681].  Since the SMSS
 	 * is fixed, we keep these numbers in terms of segments (ie. DATA
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 8e7434e92097..468efc3660c0 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -123,6 +123,7 @@ static void __rxrpc_propose_ACK(struct rxrpc_call *call, u8 ack_reason,
 		else
 			ack_at = expiry;
 
+		ack_at += READ_ONCE(call->tx_backoff);
 		ack_at += now;
 		if (time_before(ack_at, call->ack_at)) {
 			WRITE_ONCE(call->ack_at, ack_at);
@@ -311,6 +312,7 @@ void rxrpc_process_call(struct work_struct *work)
 		container_of(work, struct rxrpc_call, processor);
 	rxrpc_serial_t *send_ack;
 	unsigned long now, next, t;
+	unsigned int iterations = 0;
 
 	rxrpc_see_call(call);
 
@@ -319,6 +321,11 @@ void rxrpc_process_call(struct work_struct *work)
 	       call->debug_id, rxrpc_call_states[call->state], call->events);
 
 recheck_state:
+	/* Limit the number of times we do this before returning to the manager */
+	iterations++;
+	if (iterations > 5)
+		goto requeue;
+
 	if (test_and_clear_bit(RXRPC_CALL_EV_ABORT, &call->events)) {
 		rxrpc_send_abort_packet(call);
 		goto recheck_state;
@@ -447,13 +454,16 @@ void rxrpc_process_call(struct work_struct *work)
 	rxrpc_reduce_call_timer(call, next, now, rxrpc_timer_restart);
 
 	/* other events may have been raised since we started checking */
-	if (call->events && call->state < RXRPC_CALL_COMPLETE) {
-		__rxrpc_queue_call(call);
-		goto out;
-	}
+	if (call->events && call->state < RXRPC_CALL_COMPLETE)
+		goto requeue;
 
 out_put:
 	rxrpc_put_call(call, rxrpc_call_put);
 out:
 	_leave("");
+	return;
+
+requeue:
+	__rxrpc_queue_call(call);
+	goto out;
 }
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 189418888839..736aa9281100 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -34,6 +34,21 @@ struct rxrpc_abort_buffer {
 
 static const char rxrpc_keepalive_string[] = "";
 
+/*
+ * Increase Tx backoff on transmission failure and clear it on success.
+ */
+static void rxrpc_tx_backoff(struct rxrpc_call *call, int ret)
+{
+	if (ret < 0) {
+		u16 tx_backoff = READ_ONCE(call->tx_backoff);
+
+		if (tx_backoff < HZ)
+			WRITE_ONCE(call->tx_backoff, tx_backoff + 1);
+	} else {
+		WRITE_ONCE(call->tx_backoff, 0);
+	}
+}
+
 /*
  * Arrange for a keepalive ping a certain time after we last transmitted.  This
  * lets the far side know we're still interested in this call and helps keep
@@ -210,6 +225,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &pkt->whdr,
 				      rxrpc_tx_point_call_ack);
+	rxrpc_tx_backoff(call, ret);
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
 		if (ret < 0) {
@@ -218,7 +234,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 			rxrpc_propose_ACK(call, pkt->ack.reason,
 					  ntohs(pkt->ack.maxSkew),
 					  ntohl(pkt->ack.serial),
-					  true, true,
+					  false, true,
 					  rxrpc_propose_ack_retry_tx);
 		} else {
 			spin_lock_bh(&call->lock);
@@ -300,7 +316,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &pkt.whdr,
 				      rxrpc_tx_point_call_abort);
-
+	rxrpc_tx_backoff(call, ret);
 
 	rxrpc_put_connection(conn);
 	return ret;
@@ -413,6 +429,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &whdr,
 				      rxrpc_tx_point_call_data_nofrag);
+	rxrpc_tx_backoff(call, ret);
 	if (ret == -EMSGSIZE)
 		goto send_fragmentable;
 
@@ -445,9 +462,18 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 			rxrpc_reduce_call_timer(call, expect_rx_by, nowj,
 						rxrpc_timer_set_for_normal);
 		}
-	}
 
-	rxrpc_set_keepalive(call);
+		rxrpc_set_keepalive(call);
+	} else {
+		/* Cancel the call if the initial transmission fails,
+		 * particularly if that's due to network routing issues that
+		 * aren't going away anytime soon.  The layer above can arrange
+		 * the retransmission.
+		 */
+		if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags))
+			rxrpc_set_call_completion(call, RXRPC_CALL_LOCAL_ERROR,
+						  RX_USER_ABORT, ret);
+	}
 
 	_leave(" = %d [%u]", ret, call->peer->maxdata);
 	return ret;
@@ -506,6 +532,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &whdr,
 				      rxrpc_tx_point_call_data_frag);
+	rxrpc_tx_backoff(call, ret);
 
 	up_write(&conn->params.local->defrag_sem);
 	goto done;

