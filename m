Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeEJWqu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:46:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751119AbeEJWpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:45:24 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 1/5] rxrpc: Fix missing start of call timeout
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 23:45:23 +0100
Message-ID: <152599232321.26376.8916308939006113046.stgit@warthog.procyon.org.uk>
In-Reply-To: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
References: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expect_rx_by call timeout is supposed to be set when a call is started
to indicate that we need to receive a packet by that point.  This is
currently put back every time we receive a packet, but it isn't started
when we first send a packet.  Without this, the call may wait forever if
the server doesn't deign to reply.

Fix this by setting the timeout upon a successful UDP sendmsg call for the
first DATA packet.  The timeout is initiated only for initial transmission
and not for subsequent retries as we don't want the retry mechanism to
extend the timeout indefinitely.

Fixes: a158bdd3247b ("rxrpc: Fix call timeouts")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/input.c       |    2 +-
 net/rxrpc/output.c      |   11 +++++++++++
 net/rxrpc/sendmsg.c     |   10 ++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 90d7079e0aa9..19975d2ca9a2 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -476,6 +476,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_SEND_PING,		/* A ping will need to be sent */
 	RXRPC_CALL_PINGING,		/* Ping in process */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
+	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
 };
 
 /*
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 0410d2277ca2..b5fd6381313d 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -971,7 +971,7 @@ static void rxrpc_input_call_packet(struct rxrpc_call *call,
 	if (timo) {
 		unsigned long now = jiffies, expect_rx_by;
 
-		expect_rx_by = jiffies + timo;
+		expect_rx_by = now + timo;
 		WRITE_ONCE(call->expect_rx_by, expect_rx_by);
 		rxrpc_reduce_call_timer(call, expect_rx_by, now,
 					rxrpc_timer_set_for_normal);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 7f1fc04775b3..6b9d27f0d7ec 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -414,6 +414,17 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 							rxrpc_timer_set_for_lost_ack);
 			}
 		}
+
+		if (sp->hdr.seq == 1 &&
+		    !test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER,
+				      &call->flags)) {
+			unsigned long nowj = jiffies, expect_rx_by;
+
+			expect_rx_by = nowj + call->next_rx_timo;
+			WRITE_ONCE(call->expect_rx_by, expect_rx_by);
+			rxrpc_reduce_call_timer(call, expect_rx_by, nowj,
+						rxrpc_timer_set_for_normal);
+		}
 	}
 
 	rxrpc_set_keepalive(call);
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 206e802ccbdc..be01f9c5d963 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -223,6 +223,15 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 
 	ret = rxrpc_send_data_packet(call, skb, false);
 	if (ret < 0) {
+		switch (ret) {
+		case -ENETUNREACH:
+		case -EHOSTUNREACH:
+		case -ECONNREFUSED:
+			rxrpc_set_call_completion(call,
+						  RXRPC_CALL_LOCAL_ERROR,
+						  0, ret);
+			goto out;
+		}
 		_debug("need instant resend %d", ret);
 		rxrpc_instant_resend(call, ix);
 	} else {
@@ -241,6 +250,7 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 					rxrpc_timer_set_for_send);
 	}
 
+out:
 	rxrpc_free_skb(skb, rxrpc_skb_tx_freed);
 	_leave("");
 }
