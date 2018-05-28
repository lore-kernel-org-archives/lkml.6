Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423757AbeE1L4j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423558AbeE1LIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 096/272] rxrpc: Dont treat call aborts as conn aborts
Date: Mon, 28 May 2018 12:02:09 +0200
Message-Id: <20180528100249.227678976@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 57b0c9d49b94bbeb53649b7fbd264603c1ebd585 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/input.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1240,16 +1240,19 @@ void rxrpc_data_ready(struct sock *udp_s
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
