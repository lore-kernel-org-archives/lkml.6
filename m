Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA9AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA36206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5CfL1uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA36206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeKVFnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbeKVFnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3FF214F1;
        Wed, 21 Nov 2018 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827277;
        bh=g2ZoqgmS5Ajwm6/TGmQ2uCxMYMxlYvtTMGZ/nfXcJi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5CfL1uHhXfyEvEvz0FE+7cDTaFMK4OPQuwrRwHTyXQnSqbvT9TlaFb32X80+aH7q
         vi07ubEZ8d7jBKPIyk65hd+IuAclSM996eFtR99pqruWrhKtiijK9H0tAUd1F8nus7
         liv5GIIulYnLkgVnCHdy2nfbqN6x7+EHR8uMBezA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 40/42] rxrpc: Fix lockup due to no error backoff after ack transmit error
Date:   Wed, 21 Nov 2018 20:06:16 +0100
Message-Id: <20181121183149.704905588@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit c7e86acfcee30794dc99a0759924bf7b9d43f1ca ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/call_event.c  |   18 ++++++++++++++----
 net/rxrpc/output.c      |   35 +++++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 8 deletions(-)

--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -611,6 +611,7 @@ struct rxrpc_call {
 						 * not hard-ACK'd packet follows this.
 						 */
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
+	u16			tx_backoff;	/* Delay to insert due to Tx failure */
 
 	/* TCP-style slow-start congestion control [RFC5681].  Since the SMSS
 	 * is fixed, we keep these numbers in terms of segments (ie. DATA
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -123,6 +123,7 @@ static void __rxrpc_propose_ACK(struct r
 		else
 			ack_at = expiry;
 
+		ack_at += READ_ONCE(call->tx_backoff);
 		ack_at += now;
 		if (time_before(ack_at, call->ack_at)) {
 			WRITE_ONCE(call->ack_at, ack_at);
@@ -311,6 +312,7 @@ void rxrpc_process_call(struct work_stru
 		container_of(work, struct rxrpc_call, processor);
 	rxrpc_serial_t *send_ack;
 	unsigned long now, next, t;
+	unsigned int iterations = 0;
 
 	rxrpc_see_call(call);
 
@@ -319,6 +321,11 @@ void rxrpc_process_call(struct work_stru
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
@@ -447,13 +454,16 @@ recheck_state:
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
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -35,6 +35,21 @@ struct rxrpc_abort_buffer {
 static const char rxrpc_keepalive_string[] = "";
 
 /*
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
+/*
  * Arrange for a keepalive ping a certain time after we last transmitted.  This
  * lets the far side know we're still interested in this call and helps keep
  * the route through any intervening firewall open.
@@ -210,6 +225,7 @@ int rxrpc_send_ack_packet(struct rxrpc_c
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &pkt->whdr,
 				      rxrpc_tx_point_call_ack);
+	rxrpc_tx_backoff(call, ret);
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
 		if (ret < 0) {
@@ -218,7 +234,7 @@ int rxrpc_send_ack_packet(struct rxrpc_c
 			rxrpc_propose_ACK(call, pkt->ack.reason,
 					  ntohs(pkt->ack.maxSkew),
 					  ntohl(pkt->ack.serial),
-					  true, true,
+					  false, true,
 					  rxrpc_propose_ack_retry_tx);
 		} else {
 			spin_lock_bh(&call->lock);
@@ -300,7 +316,7 @@ int rxrpc_send_abort_packet(struct rxrpc
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &pkt.whdr,
 				      rxrpc_tx_point_call_abort);
-
+	rxrpc_tx_backoff(call, ret);
 
 	rxrpc_put_connection(conn);
 	return ret;
@@ -411,6 +427,7 @@ int rxrpc_send_data_packet(struct rxrpc_
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &whdr,
 				      rxrpc_tx_point_call_data_nofrag);
+	rxrpc_tx_backoff(call, ret);
 	if (ret == -EMSGSIZE)
 		goto send_fragmentable;
 
@@ -445,9 +462,18 @@ done:
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
@@ -506,6 +532,7 @@ send_fragmentable:
 	else
 		trace_rxrpc_tx_packet(call->debug_id, &whdr,
 				      rxrpc_tx_point_call_data_frag);
+	rxrpc_tx_backoff(call, ret);
 
 	up_write(&conn->params.local->defrag_sem);
 	goto done;


