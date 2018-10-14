Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0576DC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B139020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B139020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeJNXeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37464 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729528AbeJNXeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:34:17 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMD-0004io-5w; Sun, 14 Oct 2018 16:31:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000E9-In; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.720225896@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 069/366] ipc/msg: Fix msgctl(..., IPC_STAT, ...)
 between pid namespaces
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 39a4940eaa185910bb802ca9829c12268fd2c855 upstream.

Today msg_lspid and msg_lrpid are remembered in the pid namespace of
the creator and the processes that last send or received a sysvipc
message.  If you have processes in multiple pid namespaces that is
just wrong.  The process ids reported will not make the least bit of
sense.

This fix is slightly more susceptible to a performance problem than
the related fix for System V shared memory.  By definition the pids
are updated by msgsnd and msgrcv, the fast path of System V message
queues.  The only concern over the previous implementation is the
incrementing and decrementing of the pid reference count.  As that is
the only difference and multiple updates by of the task_tgid by
threads in the same process have been shown in af_unix sockets to
create a cache line ping-pong between cpus of the same processor.

In this case I don't expect cache lines holding pid reference counts
to ping pong between cpus.  As senders and receivers update different
pids there is a natural separation there.  Further if multiple threads
of the same process either send or receive messages the pid will be
updated to the same value and ipc_update_pid will avoid the reference
count update.

Which means in the common case I expect msg_lspid and msg_lrpid to
remain constant, and reference counts not to be updated when messages
are sent.

In rare cases it may be possible to trigger the issue which was
observed for af_unix sockets, but it will require multiple processes
with multiple threads to be either sending or receiving messages.  It
just does not feel likely that anyone would do that in practice.

This change updates msgctl(..., IPC_STAT, ...) to return msg_lspid and
msg_lrpid in the pid namespace of the process calling stat.

This change also updates cat /proc/sysvipc/msg to return print msg_lspid
and msg_lrpid in the pid namespace of the process that opened the proc
file.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -23,8 +23,8 @@ struct msg_queue {
 	unsigned long q_cbytes;		/* current number of bytes on queue */
 	unsigned long q_qnum;		/* number of messages in queue */
 	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
+	struct pid *q_lspid;		/* pid of last msgsnd */
+	struct pid *q_lrpid;		/* last receive pid */
 
 	struct list_head q_messages;
 	struct list_head q_receivers;
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -141,7 +141,7 @@ static int newque(struct ipc_namespace *
 	msq->q_ctime = get_seconds();
 	msq->q_cbytes = msq->q_qnum = 0;
 	msq->q_qbytes = ns->msg_ctlmnb;
-	msq->q_lspid = msq->q_lrpid = 0;
+	msq->q_lspid = msq->q_lrpid = NULL;
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
@@ -225,6 +225,8 @@ static void freeque(struct ipc_namespace
 		free_msg(msg);
 	}
 	atomic_sub(msq->q_cbytes, &ns->msg_bytes);
+	ipc_update_pid(&msq->q_lspid, NULL);
+	ipc_update_pid(&msq->q_lrpid, NULL);
 	ipc_rcu_putref(msq, msg_rcu_free);
 }
 
@@ -500,8 +502,8 @@ static int msgctl_nolock(struct ipc_name
 		tbuf.msg_cbytes = msq->q_cbytes;
 		tbuf.msg_qnum   = msq->q_qnum;
 		tbuf.msg_qbytes = msq->q_qbytes;
-		tbuf.msg_lspid  = msq->q_lspid;
-		tbuf.msg_lrpid  = msq->q_lrpid;
+		tbuf.msg_lspid  = pid_vnr(msq->q_lspid);
+		tbuf.msg_lrpid  = pid_vnr(msq->q_lrpid);
 		rcu_read_unlock();
 
 		if (copy_msqid_to_user(buf, &tbuf, version))
@@ -584,7 +586,7 @@ static inline int pipelined_send(struct
 				msr->r_msg = ERR_PTR(-E2BIG);
 			} else {
 				msr->r_msg = NULL;
-				msq->q_lrpid = task_pid_vnr(msr->r_tsk);
+				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
 				msq->q_rtime = get_seconds();
 				wake_up_process(msr->r_tsk);
 				/*
@@ -693,7 +695,7 @@ long do_msgsnd(int msqid, long mtype, vo
 		}
 
 	}
-	msq->q_lspid = task_tgid_vnr(current);
+	ipc_update_pid(&msq->q_lspid, task_tgid(current));
 	msq->q_stime = get_seconds();
 
 	if (!pipelined_send(msq, msg)) {
@@ -887,7 +889,7 @@ long do_msgrcv(int msqid, void __user *b
 			list_del(&msg->m_list);
 			msq->q_qnum--;
 			msq->q_rtime = get_seconds();
-			msq->q_lrpid = task_tgid_vnr(current);
+			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
 			atomic_dec(&ns->msg_hdrs);
@@ -1043,6 +1045,7 @@ void msg_exit_ns(struct ipc_namespace *n
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 {
+	struct pid_namespace *pid_ns = ipc_seq_pid_ns(s);
 	struct user_namespace *user_ns = seq_user_ns(s);
 	struct msg_queue *msq = it;
 
@@ -1053,8 +1056,8 @@ static int sysvipc_msg_proc_show(struct
 		   msq->q_perm.mode,
 		   msq->q_cbytes,
 		   msq->q_qnum,
-		   msq->q_lspid,
-		   msq->q_lrpid,
+		   pid_nr_ns(msq->q_lspid, pid_ns),
+		   pid_nr_ns(msq->q_lrpid, pid_ns),
 		   from_kuid_munged(user_ns, msq->q_perm.uid),
 		   from_kgid_munged(user_ns, msq->q_perm.gid),
 		   from_kuid_munged(user_ns, msq->q_perm.cuid),

