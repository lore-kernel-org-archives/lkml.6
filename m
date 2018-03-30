Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeC3VOd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752953AbeC3VOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:30 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 04/12] rxrpc: Don't treat call aborts as conn aborts
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:29 +0100
Message-ID: <152244446933.4629.6759743881458704029.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a call-level abort is received for the previous call to complete on a
connection channel, then that abort is queued for the connection processor
to handle.  Unfortunately, the connection processor then assumes without
checking that the abort is connection-level (ie. callNumber is 0) and
distributes it over all active calls on that connection, thereby
incorrectly aborting them.

Fix this by discarding aborts aimed at a completed call.

Further, discard all packets aimed at a call that's complete if there's
currently an active call on a channel, since the DATA packets associated
with the new call automatically terminate the old call.

Fixes: 18bfeba50dfd ("rxrpc: Perform terminal call ACK/ABORT retransmission from conn processor")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index d4f2509e018b..21800e6f5019 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1242,16 +1242,19 @@ void rxrpc_data_ready(struct sock *udp_sk)
 			goto discard_unlock;
 
 		if (sp->hdr.callNumber == chan->last_call) {
-			/* For the previous service call, if completed successfully, we
-			 * discard all further packets.
+			if (chan->call ||
+			    sp->hdr.type == RXRPC_PACKET_TYPE_ABORT)
+				goto discard_unlock;
+
+			/* For the previous service call, if completed
+			 * successfully, we discard all further packets.
 			 */
 			if (rxrpc_conn_is_service(conn) &&
-			    (chan->last_type == RXRPC_PACKET_TYPE_ACK ||
-			     sp->hdr.type == RXRPC_PACKET_TYPE_ABORT))
+			    chan->last_type == RXRPC_PACKET_TYPE_ACK)
 				goto discard_unlock;
 
-			/* But otherwise we need to retransmit the final packet from
-			 * data cached in the connection record.
+			/* But otherwise we need to retransmit the final packet
+			 * from data cached in the connection record.
 			 */
 			rxrpc_post_packet_to_conn(conn, skb);
 			goto out_unlock;
