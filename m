Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE5C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659A820835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659A820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeJNXRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:17:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36698 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbeJNXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:17:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMC-0004cJ-3M; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000EK-LR; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.519394247@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 071/366] ipc/sem: Fix semctl(..., GETPID, ...)
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

commit 51d6f2635b39709ee5e62479be23d423b760292c upstream.

Today the last process to update a semaphore is remembered and
reported in the pid namespace of that process.  If there are processes
in any other pid namespace querying that process id with GETPID the
result will be unusable nonsense as it does not make any
sense in your own pid namespace.

Due to ipc_update_pid I don't think you will be able to get System V
ipc semaphores into a troublesome cache line ping-pong.  Using struct
pids from separate process are not a problem because they do not share
a cache line.  Using struct pid from different threads of the same
process are unlikely to be a problem as the reference count update
can be avoided.

Further linux futexes are a much better tool for the job of mutual
exclusion between processes than System V semaphores.  So I expect
programs that  are performance limited by their interprocess mutual
exclusion primitive will be using futexes.

So while it is possible that enhancing the storage of the last
rocess of a System V semaphore from an integer to a struct pid
will cause a performance regression because of the effect
of frequently updating the pid reference count.  I don't expect
that to happen in practice.

This change updates semctl(..., GETPID, ...) to return the
process id of the last process to update a semphore inthe
pid namespace of the calling process.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[bwh: Backported to 3.16:
 - sem_queue::pid was also used to store an error temporarily; add a new
   wake_error field for this purpose
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/sem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -99,7 +99,7 @@ struct sem {
 	 *  - semctl, via SETVAL and SETALL.
 	 *  - at task exit when performing undo adjustments (see exit_sem).
 	 */
-	int	sempid;
+	struct pid *sempid;
 	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
 	struct list_head pending_alter; /* pending single-sop operations */
 					/* that alter the semaphore */
@@ -113,7 +113,8 @@ struct sem_queue {
 	struct list_head	list;	 /* queue of pending operations */
 	struct task_struct	*sleeper; /* this process */
 	struct sem_undo		*undo;	 /* undo structure */
-	int			pid;	 /* process id of requesting process */
+	struct pid		*pid;	 /* process id of requesting process */
+	int			wake_error;
 	int			status;	 /* completion status of operation */
 	struct sembuf		*sops;	 /* array of pending operations */
 	struct sembuf		*blocking; /* the operation that blocked */
@@ -644,7 +645,8 @@ SYSCALL_DEFINE3(semget, key_t, key, int,
  */
 static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 {
-	int result, sem_op, nsops, pid;
+	int result, sem_op, nsops;
+	struct pid *pid;
 	struct sembuf *sop;
 	struct sem *curr;
 	struct sembuf *sops;
@@ -682,7 +684,7 @@ static int perform_atomic_semop(struct s
 	sop--;
 	pid = q->pid;
 	while (sop >= sops) {
-		sma->sem_base[sop->sem_num].sempid = pid;
+		ipc_update_pid(&sma->sem_base[sop->sem_num].sempid, pid);
 		sop--;
 	}
 
@@ -730,7 +732,7 @@ static void wake_up_sem_queue_prepare(st
 		preempt_disable();
 	}
 	q->status = IN_WAKEUP;
-	q->pid = error;
+	q->wake_error = error;
 
 	list_add_tail(&q->list, pt);
 }
@@ -754,7 +756,7 @@ static void wake_up_sem_queue_do(struct
 		wake_up_process(q->sleeper);
 		/* q can disappear immediately after writing q->status. */
 		smp_wmb();
-		q->status = q->pid;
+		q->status = q->wake_error;
 	}
 	if (did_something)
 		preempt_enable();
@@ -812,7 +814,7 @@ static int check_restart(struct sem_arra
  * be called with semnum = -1, as well as with the number of each modified
  * semaphore.
  * The tasks that must be woken up are added to @pt. The return code
- * is stored in q->pid.
+ * is stored in q->wake_error.
  * The function returns 1 if at least one operation was completed successfully.
  */
 static int wake_const_ops(struct sem_array *sma, int semnum,
@@ -912,7 +914,7 @@ static int do_smart_wakeup_zero(struct s
  * be called with semnum = -1, as well as with the number of each modified
  * semaphore.
  * The tasks that must be woken up are added to @pt. The return code
- * is stored in q->pid.
+ * is stored in q->wake_error.
  * The function internally checks if const operations can now succeed.
  *
  * The function return 1 if at least one semop was completed successfully.
@@ -1156,6 +1158,7 @@ static void freeary(struct ipc_namespace
 			unlink_queue(sma, q);
 			wake_up_sem_queue_prepare(&tasks, q, -EIDRM);
 		}
+		ipc_update_pid(&sem->sempid, NULL);
 	}
 
 	/* Remove the semaphore set from the IDR */
@@ -1357,7 +1360,7 @@ static int semctl_setval(struct ipc_name
 		un->semadj[semnum] = 0;
 
 	curr->semval = val;
-	curr->sempid = task_tgid_vnr(current);
+	ipc_update_pid(&curr->sempid, task_tgid(current));
 	sma->sem_ctime = get_seconds();
 	/* maybe some queued-up processes were waiting for this */
 	do_smart_update(sma, NULL, 0, 0, &tasks);
@@ -1478,7 +1481,7 @@ static int semctl_main(struct ipc_namesp
 
 		for (i = 0; i < nsems; i++) {
 			sma->sem_base[i].semval = sem_io[i];
-			sma->sem_base[i].sempid = task_tgid_vnr(current);
+			ipc_update_pid(&sma->sem_base[i].sempid, task_tgid(current));
 		}
 
 		ipc_assert_locked_object(&sma->sem_perm);
@@ -1510,7 +1513,7 @@ static int semctl_main(struct ipc_namesp
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid;
+		err = pid_vnr(curr->sempid);
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semcnt(sma, semnum, 0);
@@ -1933,7 +1936,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid,
 	queue.sops = sops;
 	queue.nsops = nsops;
 	queue.undo = un;
-	queue.pid = task_tgid_vnr(current);
+	queue.pid = task_tgid(current);
 	queue.alter = alter;
 
 	error = perform_atomic_semop(sma, &queue);
@@ -2193,7 +2196,7 @@ void exit_sem(struct task_struct *tsk)
 					semaphore->semval = 0;
 				if (semaphore->semval > SEMVMX)
 					semaphore->semval = SEMVMX;
-				semaphore->sempid = task_tgid_vnr(current);
+				ipc_update_pid(&semaphore->sempid, task_tgid(current));
 			}
 		}
 		/* maybe some queued-up processes were waiting for this */

