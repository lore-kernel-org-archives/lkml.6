Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9920C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA742083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA742083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeIHCV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:21:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeIHCV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:21:58 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F705D6B;
        Fri,  7 Sep 2018 21:39:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bill Baker <bill.baker@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.9 39/63] NFSv4 client live hangs after live data migration recovery
Date:   Fri,  7 Sep 2018 23:10:10 +0200
Message-Id: <20180907211015.118451583@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bill Baker <Bill.Baker@Oracle.com>

commit 0f90be132cbf1537d87a6a8b9e80867adac892f6 upstream.

After a live data migration event at the NFS server, the client may send
I/O requests to the wrong server, causing a live hang due to repeated
recovery events.  On the wire, this will appear as an I/O request failing
with NFS4ERR_BADSESSION, followed by successful CREATE_SESSION, repeatedly.
NFS4ERR_BADSSESSION is returned because the session ID being used was
issued by the other server and is not valid at the old server.

The failure is caused by async worker threads having cached the transport
(xprt) in the rpc_task structure.  After the migration recovery completes,
the task is redispatched and the task resends the request to the wrong
server based on the old value still present in tk_xprt.

The solution is to recompute the tk_xprt field of the rpc_task structure
so that the request goes to the correct server.

Signed-off-by: Bill Baker <bill.baker@oracle.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Helen Chao <helen.chao@oracle.com>
Fixes: fb43d17210ba ("SUNRPC: Use the multipath iterator to assign a ...")
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c           |    9 ++++++++-
 include/linux/sunrpc/clnt.h |    1 +
 net/sunrpc/clnt.c           |   28 ++++++++++++++++++++--------
 3 files changed, 29 insertions(+), 9 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -541,8 +541,15 @@ nfs4_async_handle_exception(struct rpc_t
 		ret = -EIO;
 	return ret;
 out_retry:
-	if (ret == 0)
+	if (ret == 0) {
 		exception->retry = 1;
+		/*
+		 * For NFS4ERR_MOVED, the client transport will need to
+		 * be recomputed after migration recovery has completed.
+		 */
+		if (errorcode == -NFS4ERR_MOVED)
+			rpc_task_release_transport(task);
+	}
 	return ret;
 }
 
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -155,6 +155,7 @@ int		rpc_switch_client_transport(struct
 
 void		rpc_shutdown_client(struct rpc_clnt *);
 void		rpc_release_client(struct rpc_clnt *);
+void		rpc_task_release_transport(struct rpc_task *);
 void		rpc_task_release_client(struct rpc_task *);
 
 int		rpcb_create_local(struct net *);
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -965,10 +965,20 @@ out:
 }
 EXPORT_SYMBOL_GPL(rpc_bind_new_program);
 
+void rpc_task_release_transport(struct rpc_task *task)
+{
+	struct rpc_xprt *xprt = task->tk_xprt;
+
+	if (xprt) {
+		task->tk_xprt = NULL;
+		xprt_put(xprt);
+	}
+}
+EXPORT_SYMBOL_GPL(rpc_task_release_transport);
+
 void rpc_task_release_client(struct rpc_task *task)
 {
 	struct rpc_clnt *clnt = task->tk_client;
-	struct rpc_xprt *xprt = task->tk_xprt;
 
 	if (clnt != NULL) {
 		/* Remove from client task list */
@@ -979,12 +989,14 @@ void rpc_task_release_client(struct rpc_
 
 		rpc_release_client(clnt);
 	}
+	rpc_task_release_transport(task);
+}
 
-	if (xprt != NULL) {
-		task->tk_xprt = NULL;
-
-		xprt_put(xprt);
-	}
+static
+void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
+{
+	if (!task->tk_xprt)
+		task->tk_xprt = xprt_iter_get_next(&clnt->cl_xpi);
 }
 
 static
@@ -992,8 +1004,7 @@ void rpc_task_set_client(struct rpc_task
 {
 
 	if (clnt != NULL) {
-		if (task->tk_xprt == NULL)
-			task->tk_xprt = xprt_iter_get_next(&clnt->cl_xpi);
+		rpc_task_set_transport(task, clnt);
 		task->tk_client = clnt;
 		atomic_inc(&clnt->cl_count);
 		if (clnt->cl_softrtry)
@@ -1550,6 +1561,7 @@ call_start(struct rpc_task *task)
 	task->tk_msg.rpc_proc->p_count++;
 	clnt->cl_stats->rpccnt++;
 	task->tk_action = call_reserve;
+	rpc_task_set_transport(task, clnt);
 }
 
 /*


