Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeFCBRn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 21:17:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750831AbeFCBRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 21:17:41 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix handling of call quietly cancelled out on
 server
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Sun, 03 Jun 2018 02:17:39 +0100
Message-ID: <152798865948.5814.10196893914153717731.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes an in-progress call will stop responding on the fileserver when
the fileserver quietly cancels the call with an internally marked abort
(RX_CALL_DEAD), without sending an ABORT to the client.

This causes the client's call to eventually expire from lack of incoming
packets directed its way, which currently leads to it being cancelled
locally with ETIME.  Note that it's not currently clear as to why this
happens as it's really hard to reproduce.

The rotation policy implement by kAFS, however, doesn't differentiate
between ETIME meaning we didn't get any response from the server and ETIME
meaning the call got cancelled mid-flow.  The latter leads to an oops when
fetching data as the rotation partially resets the afs_read descriptor,
which can result in a cleared page pointer being dereferenced because that
page has already been filled.

Handle this by the following means:

 (1) Set a flag on a call when we receive a packet for it.

 (2) Store the highest packet serial number so far received for a call
     (bearing in mind this may wrap).

 (3) If, when the "not received anything recently" timeout expires on a
     call, we've received at least one packet for a call and the connection
     as a whole has received packets more recently than that call, then
     cancel the call locally with ECONNRESET rather than ETIME.

     This indicates that the call was definitely in progress on the server.

 (4) In kAFS, if the rotation algorithm sees ECONNRESET rather than ETIME,
     don't try the next server, but rather abort the call.

     This avoids the oops as we don't try to reuse the afs_read struct.
     Rather, as-yet ungotten pages will be reread at a later data.

Also:

 (5) Add an rxrpc tracepoint to log detection of the call being reset.

Without this, I occasionally see an oops like the following:

    general protection fault: 0000 [#1] SMP PTI
    ...
    RIP: 0010:_copy_to_iter+0x204/0x310
    RSP: 0018:ffff8800cae0f828 EFLAGS: 00010206
    RAX: 0000000000000560 RBX: 0000000000000560 RCX: 0000000000000560
    RDX: ffff8800cae0f968 RSI: ffff8800d58b3312 RDI: 0005080000000000
    RBP: ffff8800cae0f968 R08: 0000000000000560 R09: ffff8800ca00f400
    R10: ffff8800c36f28d4 R11: 00000000000008c4 R12: ffff8800cae0f958
    R13: 0000000000000560 R14: ffff8800d58b3312 R15: 0000000000000560
    FS:  00007fdaef108080(0000) GS:ffff8800ca680000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fb28a8fa000 CR3: 00000000d2a76002 CR4: 00000000001606e0
    Call Trace:
     skb_copy_datagram_iter+0x14e/0x289
     rxrpc_recvmsg_data.isra.0+0x6f3/0xf68
     ? trace_buffer_unlock_commit_regs+0x4f/0x89
     rxrpc_kernel_recv_data+0x149/0x421
     afs_extract_data+0x1e0/0x798
     ? afs_wait_for_call_to_complete+0xc9/0x52e
     afs_deliver_fs_fetch_data+0x33a/0x5ab
     afs_deliver_to_call+0x1ee/0x5e0
     ? afs_wait_for_call_to_complete+0xc9/0x52e
     afs_wait_for_call_to_complete+0x12b/0x52e
     ? wake_up_q+0x54/0x54
     afs_make_call+0x287/0x462
     ? afs_fs_fetch_data+0x3e6/0x3ed
     ? rcu_read_lock_sched_held+0x5d/0x63
     afs_fs_fetch_data+0x3e6/0x3ed
     afs_fetch_data+0xbb/0x14a
     afs_readpages+0x317/0x40d
     __do_page_cache_readahead+0x203/0x2ba
     ? ondemand_readahead+0x3a7/0x3c1
     ondemand_readahead+0x3a7/0x3c1
     generic_file_buffered_read+0x18b/0x62f
     __vfs_read+0xdb/0xfe
     vfs_read+0xb2/0x137
     ksys_read+0x50/0x8c
     do_syscall_64+0x7d/0x1a0
     entry_SYSCALL_64_after_hwframe+0x49/0xbe

Note the weird value in RDI which is a result of trying to kmap() a NULL
page pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rotate.c              |    4 ++++
 include/trace/events/rxrpc.h |   32 ++++++++++++++++++++++++++++++++
 net/rxrpc/ar-internal.h      |    2 ++
 net/rxrpc/call_event.c       |    8 +++++++-
 net/rxrpc/input.c            |   10 ++++++++--
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index e065bc0768e6..1faef56b12bd 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -310,6 +310,10 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	case -ETIME:
 		_debug("no conn");
 		goto iterate_address;
+
+	case -ECONNRESET:
+		_debug("call reset");
+		goto failed;
 	}
 
 restart_from_beginning:
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 077e664ac9a2..4fff00e9da8a 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1459,6 +1459,38 @@ TRACE_EVENT(rxrpc_tx_fail,
 		      __print_symbolic(__entry->what, rxrpc_tx_fail_traces))
 	    );
 
+TRACE_EVENT(rxrpc_call_reset,
+	    TP_PROTO(struct rxrpc_call *call),
+
+	    TP_ARGS(call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		debug_id	)
+		    __field(u32,			cid		)
+		    __field(u32,			call_id		)
+		    __field(rxrpc_serial_t,		call_serial	)
+		    __field(rxrpc_serial_t,		conn_serial	)
+		    __field(rxrpc_seq_t,		tx_seq		)
+		    __field(rxrpc_seq_t,		rx_seq		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->debug_id = call->debug_id;
+		    __entry->cid = call->cid;
+		    __entry->call_id = call->call_id;
+		    __entry->call_serial = call->rx_serial;
+		    __entry->conn_serial = call->conn->hi_serial;
+		    __entry->tx_seq = call->tx_hard_ack;
+		    __entry->rx_seq = call->ackr_seen;
+			   ),
+
+	    TP_printk("c=%08x %08x:%08x r=%08x/%08x tx=%08x rx=%08x",
+		      __entry->debug_id,
+		      __entry->cid, __entry->call_id,
+		      __entry->call_serial, __entry->conn_serial,
+		      __entry->tx_seq, __entry->rx_seq)
+	    );
+
 #endif /* _TRACE_RXRPC_H */
 
 /* This part must be outside protection */
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 29923ec2189c..5fb7d3254d9e 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -477,6 +477,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_PINGING,		/* Ping in process */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
 	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
+	RXRPC_CALL_RX_HEARD,		/* The peer responded at least once to this call */
 };
 
 /*
@@ -624,6 +625,7 @@ struct rxrpc_call {
 						 */
 	rxrpc_seq_t		rx_top;		/* Highest Rx slot allocated. */
 	rxrpc_seq_t		rx_expect_next;	/* Expected next packet sequence number */
+	rxrpc_serial_t		rx_serial;	/* Highest serial received for this call */
 	u8			rx_winsize;	/* Size of Rx window */
 	u8			tx_winsize;	/* Maximum size of Tx window */
 	bool			tx_phase;	/* T if transmission phase, F if receive phase */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 6e0d788b4dc4..20210418904b 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -392,7 +392,13 @@ void rxrpc_process_call(struct work_struct *work)
 
 	/* Process events */
 	if (test_and_clear_bit(RXRPC_CALL_EV_EXPIRED, &call->events)) {
-		rxrpc_abort_call("EXP", call, 0, RX_USER_ABORT, -ETIME);
+		if (test_bit(RXRPC_CALL_RX_HEARD, &call->flags) &&
+		    (int)call->conn->hi_serial - (int)call->rx_serial > 0) {
+			trace_rxrpc_call_reset(call);
+			rxrpc_abort_call("EXP", call, 0, RX_USER_ABORT, -ECONNRESET);
+		} else {
+			rxrpc_abort_call("EXP", call, 0, RX_USER_ABORT, -ETIME);
+		}
 		set_bit(RXRPC_CALL_EV_ABORT, &call->events);
 		goto recheck_state;
 	}
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index b5fd6381313d..608d078a4981 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1278,8 +1278,14 @@ void rxrpc_data_ready(struct sock *udp_sk)
 			call = NULL;
 		}
 
-		if (call && sp->hdr.serviceId != call->service_id)
-			call->service_id = sp->hdr.serviceId;
+		if (call) {
+			if (sp->hdr.serviceId != call->service_id)
+				call->service_id = sp->hdr.serviceId;
+			if ((int)sp->hdr.serial - (int)call->rx_serial > 0)
+				call->rx_serial = sp->hdr.serial;
+			if (!test_bit(RXRPC_CALL_RX_HEARD, &call->flags))
+				set_bit(RXRPC_CALL_RX_HEARD, &call->flags);
+		}
 	} else {
 		skew = 0;
 		call = NULL;
