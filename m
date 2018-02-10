Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeBJBHI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:07:08 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42693 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeBJBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:07:06 -0500
X-Google-Smtp-Source: AH8x224Ya5+wK8iQRNjQ0e5l7LxoWT3Z+oDuy98jS73YABWwtP4t/n9ymjT469pCacLGfd1Pe2rCmA==
From: Thiago Rafael Becker <thiago.becker@gmail.com>
To: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: trond.myklebust@primarydata.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, jlayton@kernel.org, davem@davemloft.net,
        Thiago Rafael Becker <thiago.becker@gmail.com>
Subject: [PATCH] sunrpc: Add task's xid to 'not responding' messages on call_timeout
Date: Fri,  9 Feb 2018 23:06:28 -0200
Message-Id: <20180210010628.19792-1-thiago.becker@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When investigating reasons for nfs failures, packet dumps arei eventually used.
Finding the rpc that generated the failure is done by comparing all sent
rpc calls and all received rpc replies for those which are unanswered,
which is prone to errors like
- Slow server responses
- Incomplete and uncaptured packets in the packet dump
- The heuristics used to inspect packets failing to interpret one

This patch adds the xid of rpc_tasks to the 'not responding' messages
in call_timeout to make these analysis more precise.

Signed-off-by: Thiago Rafael Becker <thiago.becker@gmail.com>
---
 net/sunrpc/clnt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e2a4184f3c5d..83c8aca951f4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2214,9 +2214,10 @@ call_timeout(struct rpc_task *task)
 	}
 	if (RPC_IS_SOFT(task)) {
 		if (clnt->cl_chatty) {
-			printk(KERN_NOTICE "%s: server %s not responding, timed out\n",
+			printk(KERN_NOTICE "%s: server %s not responding, timed out (xid: %x)\n",
 				clnt->cl_program->name,
-				task->tk_xprt->servername);
+				task->tk_xprt->servername,
+				be32_to_cpu(task->tk_rqstp->rq_xid));
 		}
 		if (task->tk_flags & RPC_TASK_TIMEOUT)
 			rpc_exit(task, -ETIMEDOUT);
@@ -2228,9 +2229,10 @@ call_timeout(struct rpc_task *task)
 	if (!(task->tk_flags & RPC_CALL_MAJORSEEN)) {
 		task->tk_flags |= RPC_CALL_MAJORSEEN;
 		if (clnt->cl_chatty) {
-			printk(KERN_NOTICE "%s: server %s not responding, still trying\n",
+			printk(KERN_NOTICE "%s: server %s not responding, still trying (xid: %x)\n",
 			clnt->cl_program->name,
-			task->tk_xprt->servername);
+			task->tk_xprt->servername,
+			be32_to_cpu(task->tk_rqstp->rq_xid));
 		}
 	}
 	rpc_force_rebind(clnt);
-- 
2.14.3
