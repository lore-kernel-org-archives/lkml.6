Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeE1L5A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423548AbeE1LIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 095/272] rxrpc: Fix Tx ring annotation after initial Tx failure
Date: Mon, 28 May 2018 12:02:08 +0200
Message-Id: <20180528100249.152143582@linuxfoundation.org>
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

[ Upstream commit 03877bf6a30cca7d4bc3ffabd3c3e9464a7a1a19 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/sendmsg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -130,7 +130,9 @@ static inline void rxrpc_instant_resend(
 	spin_lock_bh(&call->lock);
 
 	if (call->state < RXRPC_CALL_COMPLETE) {
-		call->rxtx_annotations[ix] = RXRPC_TX_ANNO_RETRANS;
+		call->rxtx_annotations[ix] =
+			(call->rxtx_annotations[ix] & RXRPC_TX_ANNO_LAST) |
+			RXRPC_TX_ANNO_RETRANS;
 		if (!test_and_set_bit(RXRPC_CALL_EV_RESEND, &call->events))
 			rxrpc_queue_call(call);
 	}
