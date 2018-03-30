Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeC3VO2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752898AbeC3VOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:24 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 03/12] rxrpc: Fix Tx ring annotation after initial
 Tx failure
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:23 +0100
Message-ID: <152244446311.4629.2770624963224719961.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc calls have a ring of packets that are awaiting ACK or retransmission
and a parallel ring of annotations that tracks the state of those packets.
If the initial transmission of a packet on the underlying UDP socket fails
then the packet annotation is marked for resend - but the setting of this
mark accidentally erases the last-packet mark also stored in the same
annotation slot.  If this happens, a call won't switch out of the Tx phase
when all the packets have been transmitted.

Fix this by retaining the last-packet mark and only altering the packet
state.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/sendmsg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 8503f279b467..783c777fc6e7 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -130,7 +130,9 @@ static inline void rxrpc_instant_resend(struct rxrpc_call *call, int ix)
 	spin_lock_bh(&call->lock);
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
-		call->rxtx_annotations[ix] = RXRPC_TX_ANNO_RETRANS;
+		call->rxtx_annotations[ix] =
+			(call->rxtx_annotations[ix] & RXRPC_TX_ANNO_LAST) |
+			RXRPC_TX_ANNO_RETRANS;
 		if (!test_and_set_bit(RXRPC_CALL_EV_RESEND, &call->events))
 			rxrpc_queue_call(call);
 	}
