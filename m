Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeCOMfr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:35:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeCOMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:39 -0400
Message-Id: <20180315123202.525165667@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 04/11] sched/wait,afs: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-4.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/afs/cell.c   |    6 +++---
 fs/afs/rxrpc.c  |    6 +++---
 fs/afs/server.c |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -25,7 +25,7 @@ static void afs_manage_cell(struct work_
 static void afs_dec_cells_outstanding(struct afs_net *net)
 {
 	if (atomic_dec_and_test(&net->cells_outstanding))
-		wake_up_atomic_t(&net->cells_outstanding);
+		wake_up_var(&net->cells_outstanding);
 }
 
 /*
@@ -764,7 +764,7 @@ void afs_cell_purge(struct afs_net *net)
 	afs_queue_cell_manager(net);
 
 	_debug("wait");
-	wait_on_atomic_t(&net->cells_outstanding, atomic_t_wait,
-			 TASK_UNINTERRUPTIBLE);
+	wait_var_event(&net->cells_outstanding,
+		       !atomic_read(&net->cells_outstanding));
 	_leave("");
 }
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -103,8 +103,8 @@ void afs_close_socket(struct afs_net *ne
 	}
 
 	_debug("outstanding %u", atomic_read(&net->nr_outstanding_calls));
-	wait_on_atomic_t(&net->nr_outstanding_calls, atomic_t_wait,
-			 TASK_UNINTERRUPTIBLE);
+	wait_var_event(&net->nr_outstanding_calls,
+		       !atomic_read(&net->nr_outstanding_calls));
 	_debug("no outstanding calls");
 
 	kernel_sock_shutdown(net->socket, SHUT_RDWR);
@@ -175,7 +175,7 @@ void afs_put_call(struct afs_call *call)
 		trace_afs_call(call, afs_call_trace_free, 0, o,
 			       __builtin_return_address(0));
 		if (o == 0)
-			wake_up_atomic_t(&net->nr_outstanding_calls);
+			wake_up_var(&net->nr_outstanding_calls);
 	}
 }
 
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -25,7 +25,7 @@ static void afs_inc_servers_outstanding(
 static void afs_dec_servers_outstanding(struct afs_net *net)
 {
 	if (atomic_dec_and_test(&net->servers_outstanding))
-		wake_up_atomic_t(&net->servers_outstanding);
+		wake_up_var(&net->servers_outstanding);
 }
 
 /*
@@ -521,8 +521,8 @@ void afs_purge_servers(struct afs_net *n
 	afs_queue_server_manager(net);
 
 	_debug("wait");
-	wait_on_atomic_t(&net->servers_outstanding, atomic_t_wait,
-			 TASK_UNINTERRUPTIBLE);
+	wait_var_event(&net->servers_outstanding,
+		       !atomic_read(&net->servers_outstanding));
 	_leave("");
 }
 
