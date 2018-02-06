Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBFQoZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:44:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeBFQoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:44:15 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix received abort handling
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 06 Feb 2018 16:44:12 +0000
Message-ID: <151793545229.24105.9015810583725369029.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AF_RXRPC is incorrectly sending back to the server any abort it receives
for a client connection.  This is due to the final-ACK offload to the
connection event processor patch.  The abort code is copied into the
last-call information on the connection channel and then the event
processor is set.

Instead, the following should be done:

 (1) In the case of a final-ACK for a successful call, the ACK should be
     scheduled as before.

 (2) In the case of a locally generated ABORT, the ABORT details should be
     cached for sending in response to further packets related to that
     call and no further action scheduled at call disconnect time.

 (3) In the case of an ACK received from the peer, the call should be
     considered dead, no ABORT should be transmitted at this time.  In
     response to further non-ABORT packets from the peer relating to this
     call, an RX_USER_ABORT ABORT should be transmitted.

 (4) In the case of a call killed due to network error, an RX_USER_ABORT
     ABORT should be cached for transmission in response to further
     packets, but no ABORT should be sent at this time.

Fixes: 3136ef49a14c ("rxrpc: Delay terminal ACK transmission on a client call")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/conn_client.c |    3 ++-
 net/rxrpc/conn_object.c |   16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 7f74ca3059f8..064175068059 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -834,7 +834,8 @@ void rxrpc_disconnect_client_call(struct rxrpc_call *call)
 	 * can be skipped if we find a follow-on call.  The first DATA packet
 	 * of the follow on call will implicitly ACK this call.
 	 */
-	if (test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
+	if (call->completion == RXRPC_CALL_SUCCEEDED &&
+	    test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
 		unsigned long final_ack_at = jiffies + 2;
 
 		WRITE_ONCE(chan->final_ack_at, final_ack_at);
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index c628351eb900..ccbac190add1 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -177,13 +177,21 @@ void __rxrpc_disconnect_call(struct rxrpc_connection *conn,
 		 * through the channel, whilst disposing of the actual call record.
 		 */
 		trace_rxrpc_disconnect_call(call);
-		if (call->abort_code) {
-			chan->last_abort = call->abort_code;
-			chan->last_type = RXRPC_PACKET_TYPE_ABORT;
-		} else {
+		switch (call->completion) {
+		case RXRPC_CALL_SUCCEEDED:
 			chan->last_seq = call->rx_hard_ack;
 			chan->last_type = RXRPC_PACKET_TYPE_ACK;
+			break;
+		case RXRPC_CALL_LOCALLY_ABORTED:
+			chan->last_abort = call->abort_code;
+			chan->last_type = RXRPC_PACKET_TYPE_ABORT;
+			break;
+		default:
+			chan->last_abort = RX_USER_ABORT;
+			chan->last_type = RXRPC_PACKET_TYPE_ABORT;
+			break;
 		}
+
 		/* Sync with rxrpc_conn_retransmit(). */
 		smp_wmb();
 		chan->last_call = chan->call_id;
