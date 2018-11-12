Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2F223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC2F223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeKMI2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:28:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbeKMI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:28:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25998C0587E5;
        Mon, 12 Nov 2018 22:33:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29F6160BE7;
        Mon, 12 Nov 2018 22:33:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix life check
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Mon, 12 Nov 2018 22:33:22 +0000
Message-ID: <154206200235.19188.1775391172980714293.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 12 Nov 2018 22:33:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The life-checking function, which is used by kAFS to make sure that a call
is still live in the event of a pending signal, only samples the received
packet serial number counter; it doesn't actually provoke a change in the
counter, rather relying on the server to happen to give us a packet in the
time window.

Fix this by adding a function to force a ping to be transmitted.

kAFS then keeps track of whether there's been a stall, and if so, uses the
new function to ping the server, resetting the timeout to allow the reply
to come back.

If there's a stall, a ping and the call is *still* stalled in the same
place after another period, then the call will be aborted.

Fixes: bc5e3a546d55 ("rxrpc: Use MSG_WAITALL to tell sendmsg() to temporarily ignore signals")
Fixes: f4d15fb6f99a ("rxrpc: Provide functions for allowing cleaner handling of signals")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/networking/rxrpc.txt |   17 +++++++++++------
 fs/afs/rxrpc.c                     |   11 ++++++++++-
 include/net/af_rxrpc.h             |    3 ++-
 include/trace/events/rxrpc.h       |    2 ++
 net/rxrpc/af_rxrpc.c               |   27 +++++++++++++++++++++++----
 5 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/rxrpc.txt b/Documentation/networking/rxrpc.txt
index 605e00cdd6be..89f1302d593a 100644
--- a/Documentation/networking/rxrpc.txt
+++ b/Documentation/networking/rxrpc.txt
@@ -1056,18 +1056,23 @@ The kernel interface functions are as follows:
 
 	u32 rxrpc_kernel_check_life(struct socket *sock,
 				    struct rxrpc_call *call);
+	void rxrpc_kernel_probe_life(struct socket *sock,
+				     struct rxrpc_call *call);
 
-     This returns a number that is updated when ACKs are received from the peer
-     (notably including PING RESPONSE ACKs which we can elicit by sending PING
-     ACKs to see if the call still exists on the server).  The caller should
-     compare the numbers of two calls to see if the call is still alive after
-     waiting for a suitable interval.
+     The first function returns a number that is updated when ACKs are received
+     from the peer (notably including PING RESPONSE ACKs which we can elicit by
+     sending PING ACKs to see if the call still exists on the server).  The
+     caller should compare the numbers of two calls to see if the call is still
+     alive after waiting for a suitable interval.
 
      This allows the caller to work out if the server is still contactable and
      if the call is still alive on the server whilst waiting for the server to
      process a client operation.
 
-     This function may transmit a PING ACK.
+     The second function causes a ping ACK to be transmitted to try to provoke
+     the peer into responding, which would then cause the value returned by the
+     first function to change.  Note that this must be called in TASK_RUNNING
+     state.
 
  (*) Get reply timestamp.
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 59970886690f..a7b44863d502 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -576,6 +576,7 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 {
 	signed long rtt2, timeout;
 	long ret;
+	bool stalled = false;
 	u64 rtt;
 	u32 life, last_life;
 
@@ -609,12 +610,20 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 
 		life = rxrpc_kernel_check_life(call->net->socket, call->rxcall);
 		if (timeout == 0 &&
-		    life == last_life && signal_pending(current))
+		    life == last_life && signal_pending(current)) {
+			if (stalled)
 				break;
+			__set_current_state(TASK_RUNNING);
+			rxrpc_kernel_probe_life(call->net->socket, call->rxcall);
+			timeout = rtt2;
+			stalled = true;
+			continue;
+		}
 
 		if (life != last_life) {
 			timeout = rtt2;
 			last_life = life;
+			stalled = false;
 		}
 
 		timeout = schedule_timeout(timeout);
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index de587948042a..1adefe42c0a6 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -77,7 +77,8 @@ int rxrpc_kernel_retry_call(struct socket *, struct rxrpc_call *,
 			    struct sockaddr_rxrpc *, struct key *);
 int rxrpc_kernel_check_call(struct socket *, struct rxrpc_call *,
 			    enum rxrpc_call_completion *, u32 *);
-u32 rxrpc_kernel_check_life(struct socket *, struct rxrpc_call *);
+u32 rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
+void rxrpc_kernel_probe_life(struct socket *, struct rxrpc_call *);
 u32 rxrpc_kernel_get_epoch(struct socket *, struct rxrpc_call *);
 bool rxrpc_kernel_get_reply_time(struct socket *, struct rxrpc_call *,
 				 ktime_t *);
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 573d5b901fb1..5b50fe4906d2 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -181,6 +181,7 @@ enum rxrpc_timer_trace {
 enum rxrpc_propose_ack_trace {
 	rxrpc_propose_ack_client_tx_end,
 	rxrpc_propose_ack_input_data,
+	rxrpc_propose_ack_ping_for_check_life,
 	rxrpc_propose_ack_ping_for_keepalive,
 	rxrpc_propose_ack_ping_for_lost_ack,
 	rxrpc_propose_ack_ping_for_lost_reply,
@@ -380,6 +381,7 @@ enum rxrpc_tx_point {
 #define rxrpc_propose_ack_traces \
 	EM(rxrpc_propose_ack_client_tx_end,	"ClTxEnd") \
 	EM(rxrpc_propose_ack_input_data,	"DataIn ") \
+	EM(rxrpc_propose_ack_ping_for_check_life, "ChkLife") \
 	EM(rxrpc_propose_ack_ping_for_keepalive, "KeepAlv") \
 	EM(rxrpc_propose_ack_ping_for_lost_ack,	"LostAck") \
 	EM(rxrpc_propose_ack_ping_for_lost_reply, "LostRpl") \
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 64362d078da8..a2522f9d71e2 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -375,16 +375,35 @@ EXPORT_SYMBOL(rxrpc_kernel_end_call);
  * getting ACKs from the server.  Returns a number representing the life state
  * which can be compared to that returned by a previous call.
  *
- * If this is a client call, ping ACKs will be sent to the server to find out
- * whether it's still responsive and whether the call is still alive on the
- * server.
+ * If the life state stalls, rxrpc_kernel_probe_life() should be called and
+ * then 2RTT waited.
  */
-u32 rxrpc_kernel_check_life(struct socket *sock, struct rxrpc_call *call)
+u32 rxrpc_kernel_check_life(const struct socket *sock,
+			    const struct rxrpc_call *call)
 {
 	return call->acks_latest;
 }
 EXPORT_SYMBOL(rxrpc_kernel_check_life);
 
+/**
+ * rxrpc_kernel_probe_life - Poke the peer to see if it's still alive
+ * @sock: The socket the call is on
+ * @call: The call to check
+ *
+ * In conjunction with rxrpc_kernel_check_life(), allow a kernel service to
+ * find out whether a call is still alive by pinging it.  This should cause the
+ * life state to be bumped in about 2*RTT.
+ *
+ * The must be called in TASK_RUNNING state on pain of might_sleep() objecting.
+ */
+void rxrpc_kernel_probe_life(struct socket *sock, struct rxrpc_call *call)
+{
+	rxrpc_propose_ACK(call, RXRPC_ACK_PING, 0, 0, true, false,
+			  rxrpc_propose_ack_ping_for_check_life);
+	rxrpc_send_ack_packet(call, true, NULL);
+}
+EXPORT_SYMBOL(rxrpc_kernel_probe_life);
+
 /**
  * rxrpc_kernel_get_epoch - Retrieve the epoch value from a call.
  * @sock: The socket the call is on

