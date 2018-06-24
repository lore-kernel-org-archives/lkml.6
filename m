Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBFC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508324F95
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2508324F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeFXP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:28:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeFXP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:28:09 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90B7249F;
        Sun, 24 Jun 2018 15:28:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.14 12/52] NFSv4.1: Fix up replays of interrupted requests
Date:   Sun, 24 Jun 2018 23:21:05 +0800
Message-Id: <20180624142745.138767678@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 3be0f80b5fe9c16eca2d538f799b94ca8aa59433 upstream.

If the previous request on a slot was interrupted before it was
processed by the server, then our slot sequence number may be out of whack,
and so we try the next operation using the old sequence number.

The problem with this, is that not all servers check to see that the
client is replaying the same operations as previously when they decide
to go to the replay cache, and so instead of the expected error of
NFS4ERR_SEQ_FALSE_RETRY, we get a replay of the old reply, which could
(if the operations match up) be mistaken by the client for a new reply.

To fix this, we attempt to send a COMPOUND containing only the SEQUENCE op
in order to resync our slot sequence number.

Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>
[olga.kornievskaia@gmail.com: fix an Oops]
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4_fs.h  |    2 
 fs/nfs/nfs4proc.c |  150 +++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 104 insertions(+), 48 deletions(-)

--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -465,7 +465,7 @@ extern void nfs_increment_open_seqid(int
 extern void nfs_increment_lock_seqid(int status, struct nfs_seqid *seqid);
 extern void nfs_release_seqid(struct nfs_seqid *seqid);
 extern void nfs_free_seqid(struct nfs_seqid *seqid);
-extern int nfs4_setup_sequence(const struct nfs_client *client,
+extern int nfs4_setup_sequence(struct nfs_client *client,
 				struct nfs4_sequence_args *args,
 				struct nfs4_sequence_res *res,
 				struct rpc_task *task);
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -96,6 +96,10 @@ static int nfs4_do_setattr(struct inode
 			    struct nfs_open_context *ctx, struct nfs4_label *ilabel,
 			    struct nfs4_label *olabel);
 #ifdef CONFIG_NFS_V4_1
+static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
+		struct rpc_cred *cred,
+		struct nfs4_slot *slot,
+		bool is_privileged);
 static int nfs41_test_stateid(struct nfs_server *, nfs4_stateid *,
 		struct rpc_cred *);
 static int nfs41_free_stateid(struct nfs_server *, const nfs4_stateid *,
@@ -641,13 +645,14 @@ static int nfs40_sequence_done(struct rp
 
 #if defined(CONFIG_NFS_V4_1)
 
-static void nfs41_sequence_free_slot(struct nfs4_sequence_res *res)
+static void nfs41_release_slot(struct nfs4_slot *slot)
 {
 	struct nfs4_session *session;
 	struct nfs4_slot_table *tbl;
-	struct nfs4_slot *slot = res->sr_slot;
 	bool send_new_highest_used_slotid = false;
 
+	if (!slot)
+		return;
 	tbl = slot->table;
 	session = tbl->session;
 
@@ -673,13 +678,18 @@ static void nfs41_sequence_free_slot(str
 		send_new_highest_used_slotid = false;
 out_unlock:
 	spin_unlock(&tbl->slot_tbl_lock);
-	res->sr_slot = NULL;
 	if (send_new_highest_used_slotid)
 		nfs41_notify_server(session->clp);
 	if (waitqueue_active(&tbl->slot_waitq))
 		wake_up_all(&tbl->slot_waitq);
 }
 
+static void nfs41_sequence_free_slot(struct nfs4_sequence_res *res)
+{
+	nfs41_release_slot(res->sr_slot);
+	res->sr_slot = NULL;
+}
+
 static int nfs41_sequence_process(struct rpc_task *task,
 		struct nfs4_sequence_res *res)
 {
@@ -707,13 +717,6 @@ static int nfs41_sequence_process(struct
 	/* Check the SEQUENCE operation status */
 	switch (res->sr_status) {
 	case 0:
-		/* If previous op on slot was interrupted and we reused
-		 * the seq# and got a reply from the cache, then retry
-		 */
-		if (task->tk_status == -EREMOTEIO && interrupted) {
-			++slot->seq_nr;
-			goto retry_nowait;
-		}
 		/* Update the slot's sequence and clientid lease timer */
 		slot->seq_done = 1;
 		clp = session->clp;
@@ -747,16 +750,16 @@ static int nfs41_sequence_process(struct
 		 * The slot id we used was probably retired. Try again
 		 * using a different slot id.
 		 */
+		if (slot->seq_nr < slot->table->target_highest_slotid)
+			goto session_recover;
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
 		/*
 		 * Was the last operation on this sequence interrupted?
 		 * If so, retry after bumping the sequence number.
 		 */
-		if (interrupted) {
-			++slot->seq_nr;
-			goto retry_nowait;
-		}
+		if (interrupted)
+			goto retry_new_seq;
 		/*
 		 * Could this slot have been previously retired?
 		 * If so, then the server may be expecting seq_nr = 1!
@@ -765,10 +768,11 @@ static int nfs41_sequence_process(struct
 			slot->seq_nr = 1;
 			goto retry_nowait;
 		}
-		break;
+		goto session_recover;
 	case -NFS4ERR_SEQ_FALSE_RETRY:
-		++slot->seq_nr;
-		goto retry_nowait;
+		if (interrupted)
+			goto retry_new_seq;
+		goto session_recover;
 	default:
 		/* Just update the slot sequence no. */
 		slot->seq_done = 1;
@@ -778,6 +782,11 @@ out:
 	dprintk("%s: Error %d free the slot \n", __func__, res->sr_status);
 out_noaction:
 	return ret;
+session_recover:
+	nfs4_schedule_session_recovery(session, res->sr_status);
+	goto retry_nowait;
+retry_new_seq:
+	++slot->seq_nr;
 retry_nowait:
 	if (rpc_restart_call_prepare(task)) {
 		nfs41_sequence_free_slot(res);
@@ -854,6 +863,17 @@ static const struct rpc_call_ops nfs41_c
 	.rpc_call_done = nfs41_call_sync_done,
 };
 
+static void
+nfs4_sequence_process_interrupted(struct nfs_client *client,
+		struct nfs4_slot *slot, struct rpc_cred *cred)
+{
+	struct rpc_task *task;
+
+	task = _nfs41_proc_sequence(client, cred, slot, true);
+	if (!IS_ERR(task))
+		rpc_put_task_async(task);
+}
+
 #else	/* !CONFIG_NFS_V4_1 */
 
 static int nfs4_sequence_process(struct rpc_task *task, struct nfs4_sequence_res *res)
@@ -874,9 +894,34 @@ int nfs4_sequence_done(struct rpc_task *
 }
 EXPORT_SYMBOL_GPL(nfs4_sequence_done);
 
+static void
+nfs4_sequence_process_interrupted(struct nfs_client *client,
+		struct nfs4_slot *slot, struct rpc_cred *cred)
+{
+	WARN_ON_ONCE(1);
+	slot->interrupted = 0;
+}
+
 #endif	/* !CONFIG_NFS_V4_1 */
 
-int nfs4_setup_sequence(const struct nfs_client *client,
+static
+void nfs4_sequence_attach_slot(struct nfs4_sequence_args *args,
+		struct nfs4_sequence_res *res,
+		struct nfs4_slot *slot)
+{
+	if (!slot)
+		return;
+	slot->privileged = args->sa_privileged ? 1 : 0;
+	args->sa_slot = slot;
+
+	res->sr_slot = slot;
+	res->sr_timestamp = jiffies;
+	res->sr_status_flags = 0;
+	res->sr_status = 1;
+
+}
+
+int nfs4_setup_sequence(struct nfs_client *client,
 			struct nfs4_sequence_args *args,
 			struct nfs4_sequence_res *res,
 			struct rpc_task *task)
@@ -894,30 +939,29 @@ int nfs4_setup_sequence(const struct nfs
 		task->tk_timeout = 0;
 	}
 
-	spin_lock(&tbl->slot_tbl_lock);
-	/* The state manager will wait until the slot table is empty */
-	if (nfs4_slot_tbl_draining(tbl) && !args->sa_privileged)
-		goto out_sleep;
-
-	slot = nfs4_alloc_slot(tbl);
-	if (IS_ERR(slot)) {
-		/* Try again in 1/4 second */
-		if (slot == ERR_PTR(-ENOMEM))
-			task->tk_timeout = HZ >> 2;
-		goto out_sleep;
-	}
-	spin_unlock(&tbl->slot_tbl_lock);
-
-	slot->privileged = args->sa_privileged ? 1 : 0;
-	args->sa_slot = slot;
+	for (;;) {
+		spin_lock(&tbl->slot_tbl_lock);
+		/* The state manager will wait until the slot table is empty */
+		if (nfs4_slot_tbl_draining(tbl) && !args->sa_privileged)
+			goto out_sleep;
+
+		slot = nfs4_alloc_slot(tbl);
+		if (IS_ERR(slot)) {
+			/* Try again in 1/4 second */
+			if (slot == ERR_PTR(-ENOMEM))
+				task->tk_timeout = HZ >> 2;
+			goto out_sleep;
+		}
+		spin_unlock(&tbl->slot_tbl_lock);
 
-	res->sr_slot = slot;
-	if (session) {
-		res->sr_timestamp = jiffies;
-		res->sr_status_flags = 0;
-		res->sr_status = 1;
+		if (likely(!slot->interrupted))
+			break;
+		nfs4_sequence_process_interrupted(client,
+				slot, task->tk_msg.rpc_cred);
 	}
 
+	nfs4_sequence_attach_slot(args, res, slot);
+
 	trace_nfs4_setup_sequence(session, args);
 out_start:
 	rpc_call_start(task);
@@ -8151,6 +8195,7 @@ static const struct rpc_call_ops nfs41_s
 
 static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		struct rpc_cred *cred,
+		struct nfs4_slot *slot,
 		bool is_privileged)
 {
 	struct nfs4_sequence_data *calldata;
@@ -8164,15 +8209,18 @@ static struct rpc_task *_nfs41_proc_sequ
 		.callback_ops = &nfs41_sequence_ops,
 		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
 	};
+	struct rpc_task *ret;
 
+	ret = ERR_PTR(-EIO);
 	if (!atomic_inc_not_zero(&clp->cl_count))
-		return ERR_PTR(-EIO);
+		goto out_err;
+
+	ret = ERR_PTR(-ENOMEM);
 	calldata = kzalloc(sizeof(*calldata), GFP_NOFS);
-	if (calldata == NULL) {
-		nfs_put_client(clp);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (calldata == NULL)
+		goto out_put_clp;
 	nfs4_init_sequence(&calldata->args, &calldata->res, 0);
+	nfs4_sequence_attach_slot(&calldata->args, &calldata->res, slot);
 	if (is_privileged)
 		nfs4_set_sequence_privileged(&calldata->args);
 	msg.rpc_argp = &calldata->args;
@@ -8180,7 +8228,15 @@ static struct rpc_task *_nfs41_proc_sequ
 	calldata->clp = clp;
 	task_setup_data.callback_data = calldata;
 
-	return rpc_run_task(&task_setup_data);
+	ret = rpc_run_task(&task_setup_data);
+	if (IS_ERR(ret))
+		goto out_err;
+	return ret;
+out_put_clp:
+	nfs_put_client(clp);
+out_err:
+	nfs41_release_slot(slot);
+	return ret;
 }
 
 static int nfs41_proc_async_sequence(struct nfs_client *clp, struct rpc_cred *cred, unsigned renew_flags)
@@ -8190,7 +8246,7 @@ static int nfs41_proc_async_sequence(str
 
 	if ((renew_flags & NFS4_RENEW_TIMEOUT) == 0)
 		return -EAGAIN;
-	task = _nfs41_proc_sequence(clp, cred, false);
+	task = _nfs41_proc_sequence(clp, cred, NULL, false);
 	if (IS_ERR(task))
 		ret = PTR_ERR(task);
 	else
@@ -8204,7 +8260,7 @@ static int nfs4_proc_sequence(struct nfs
 	struct rpc_task *task;
 	int ret;
 
-	task = _nfs41_proc_sequence(clp, cred, true);
+	task = _nfs41_proc_sequence(clp, cred, NULL, true);
 	if (IS_ERR(task)) {
 		ret = PTR_ERR(task);
 		goto out;


