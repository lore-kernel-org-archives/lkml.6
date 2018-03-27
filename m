Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeC0W6N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:58:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752525AbeC0W6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:58:10 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 3/3] rxrpc: Trace call completion
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 23:58:09 +0100
Message-ID: <152219148922.24730.9230068164834568042.stgit@warthog.procyon.org.uk>
In-Reply-To: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
References: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint to track rxrpc calls moving into the completed state and
to log the completion type and the recorded error value and abort code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |   33 +++++++++++++++++++++++++++++++++
 net/rxrpc/ar-internal.h      |    1 +
 2 files changed, 34 insertions(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4d2c2d35c5cb..2ea788f6f95d 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -400,6 +400,13 @@ enum rxrpc_congest_change {
 	EM(RXRPC_ACK_IDLE,			"IDL") \
 	E_(RXRPC_ACK__INVALID,			"-?-")
 
+#define rxrpc_completions \
+	EM(RXRPC_CALL_SUCCEEDED,		"Succeeded") \
+	EM(RXRPC_CALL_REMOTELY_ABORTED,		"RemoteAbort") \
+	EM(RXRPC_CALL_LOCALLY_ABORTED,		"LocalAbort") \
+	EM(RXRPC_CALL_LOCAL_ERROR,		"LocalError") \
+	E_(RXRPC_CALL_NETWORK_ERROR,		"NetError")
+
 /*
  * Export enum symbols via userspace.
  */
@@ -624,6 +631,32 @@ TRACE_EVENT(rxrpc_abort,
 		      __entry->abort_code, __entry->error, __entry->why)
 	    );
 
+TRACE_EVENT(rxrpc_call_complete,
+	    TP_PROTO(struct rxrpc_call *call),
+
+	    TP_ARGS(call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call		)
+		    __field(enum rxrpc_call_completion,	compl		)
+		    __field(int,			error		)
+		    __field(u32,			abort_code	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call->debug_id;
+		    __entry->compl = call->completion;
+		    __entry->error = call->error;
+		    __entry->abort_code = call->abort_code;
+			   ),
+
+	    TP_printk("c=%08x %s r=%d ac=%d",
+		      __entry->call,
+		      __print_symbolic(__entry->compl, rxrpc_completions),
+		      __entry->error,
+		      __entry->abort_code)
+	    );
+
 TRACE_EVENT(rxrpc_transmit,
 	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_transmit_trace why),
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9c9817ddafc5..21cf164b6d85 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -778,6 +778,7 @@ static inline bool __rxrpc_set_call_completion(struct rxrpc_call *call,
 		call->error = error;
 		call->completion = compl,
 		call->state = RXRPC_CALL_COMPLETE;
+		trace_rxrpc_call_complete(call);
 		wake_up(&call->waitq);
 		return true;
 	}
