Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeC0W6B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:58:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752517AbeC0W56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:57:58 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 1/3] rxrpc: Trace resend
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 23:57:56 +0100
Message-ID: <152219147655.24730.15580797859060901896.stgit@warthog.procyon.org.uk>
In-Reply-To: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
References: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint to trace packet resend events and to dump the Tx
annotation buffer for added illumination.

Signed-off-by: David Howells <dhowells@rdhat.com>
---

 include/trace/events/rxrpc.h |   24 ++++++++++++++++++++++++
 net/rxrpc/call_event.c       |    1 +
 2 files changed, 25 insertions(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 36cb50c111a6..41979f907575 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -420,6 +420,7 @@ rxrpc_rtt_rx_traces;
 rxrpc_timer_traces;
 rxrpc_propose_ack_traces;
 rxrpc_propose_ack_outcomes;
+rxrpc_congest_modes;
 rxrpc_congest_changes;
 
 /*
@@ -1229,6 +1230,29 @@ TRACE_EVENT(rxrpc_connect_call,
 		      __entry->call_id)
 	    );
 
+TRACE_EVENT(rxrpc_resend,
+	    TP_PROTO(struct rxrpc_call *call, int ix),
+
+	    TP_ARGS(call, ix),
+
+	    TP_STRUCT__entry(
+		    __field(struct rxrpc_call *,	call		)
+		    __field(int,			ix		)
+		    __array(u8,				anno, 64	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call;
+		    __entry->ix = ix;
+		    memcpy(__entry->anno, call->rxtx_annotations, 64);
+			   ),
+
+	    TP_printk("c=%p ix=%u a=%64phN",
+		      __entry->call,
+		      __entry->ix,
+		      __entry->anno)
+	    );
+
 #endif /* _TRACE_RXRPC_H */
 
 /* This part must be outside protection */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index ad2ab1103189..6a62e42e1d8d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -195,6 +195,7 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 	 * the packets in the Tx buffer we're going to resend and what the new
 	 * resend timeout will be.
 	 */
+	trace_rxrpc_resend(call, (cursor + 1) & RXRPC_RXTX_BUFF_MASK);
 	oldest = now;
 	for (seq = cursor + 1; before_eq(seq, top); seq++) {
 		ix = seq & RXRPC_RXTX_BUFF_MASK;
