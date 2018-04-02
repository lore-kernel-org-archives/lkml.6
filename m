Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754768AbeDBWvm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:51:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754522AbeDBWvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:51:41 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] rxrpc: Fix undefined packet handling
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Mon, 02 Apr 2018 23:51:39 +0100
Message-ID: <152270949946.20618.15535005483715424318.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By analogy with other Rx implementations, RxRPC packet types 9, 10 and 11
should just be discarded rather than being aborted like other undefined
packet types.

Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c    |    6 ++++++
 net/rxrpc/protocol.h |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 21800e6f5019..0410d2277ca2 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1200,6 +1200,12 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		    !rxrpc_validate_jumbo(skb))
 			goto bad_message;
 		break;
+
+		/* Packet types 9-11 should just be ignored. */
+	case RXRPC_PACKET_TYPE_PARAMS:
+	case RXRPC_PACKET_TYPE_10:
+	case RXRPC_PACKET_TYPE_11:
+		goto discard;
 	}
 
 	rcu_read_lock();
diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index 4bddcf3face3..93da73bf7098 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -46,6 +46,9 @@ struct rxrpc_wire_header {
 #define RXRPC_PACKET_TYPE_CHALLENGE	6	/* connection security challenge (SRVR->CLNT) */
 #define RXRPC_PACKET_TYPE_RESPONSE	7	/* connection secutity response (CLNT->SRVR) */
 #define RXRPC_PACKET_TYPE_DEBUG		8	/* debug info request */
+#define RXRPC_PACKET_TYPE_PARAMS	9	/* Parameter negotiation (unspec'd, ignore) */
+#define RXRPC_PACKET_TYPE_10		10	/* Ignored */
+#define RXRPC_PACKET_TYPE_11		11	/* Ignored */
 #define RXRPC_PACKET_TYPE_VERSION	13	/* version string request */
 #define RXRPC_N_PACKET_TYPES		14	/* number of packet types (incl type 0) */
 
@@ -78,6 +81,9 @@ struct rxrpc_wire_header {
 		(1 << RXRPC_PACKET_TYPE_CHALLENGE) |	\
 		(1 << RXRPC_PACKET_TYPE_RESPONSE) |	\
 		/*(1 << RXRPC_PACKET_TYPE_DEBUG) | */	\
+		(1 << RXRPC_PACKET_TYPE_PARAMS) |	\
+		(1 << RXRPC_PACKET_TYPE_10) |		\
+		(1 << RXRPC_PACKET_TYPE_11) |		\
 		(1 << RXRPC_PACKET_TYPE_VERSION))
 
 /*****************************************************************************/
