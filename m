Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeDYNXg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:23:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754124AbeDYNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:23:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 12/16] y2038: ipc: Use ktime_get_real_seconds consistently
Date: Wed, 25 Apr 2018 15:22:38 +0200
Message-Id: <20180425132242.1500539-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/Bwr/CGb098G92uX49eDHx3CelA/h9Pb2XwxvK9kBIIrrZmG49+
 PIkdxhfYaz1w7kdwHoVOj7gPOq+skdOpgv+CW0X85IfnuzDlGL4uO7ev/OfM4bIi3kKlRqh
 SH9tnGOVzL3JrfjJ1VOOjL7v5oAAgb1LKYyOyTrwheeRgBptaCbDHAtNMb+6NW74LH4j2Cl
 sb9jOHVRG/XmL605aWejg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VXtblfxm3es=:jzDRwkeRVeBVK99Q596Anu
 /fKwzTIPe4E1K4IRxtEYc8m4pkNkHuYr6whWR+/hffFSHzv/mYBr6szhz5SbTa83YM0Lh0qcZ
 cJ6Z+6VzKBfsTfav0RH3uwksFFXysKQUGs/7M6xYZyI6703D4xNcTrHmG7XIvDvZGIVpTNtzu
 MBuw21YGOGhQTu+ycP7EayT2WCe4wjegMEh9bXbEZv1SrpXxK+EsLRNRdX97N1UVLM+XaTpYY
 7xV9Ru+4vCB4z1TF5zyYdw6LT3RmHlUTjfQkvipF20LpHprESnDaM+ANNSWemCHsbZwvOYdxA
 hkeqOs809bC1t9yH46jICUTCipwNF1ucZqWw4jzviOaXWpTvIt5G53pc8DmLnhZa6UA1tv1aJ
 R6+cK5HTDzMfvBRyhj6v7z/U8IPEOxRnwq889GevgTueQcOiNBdBpS2xq/03UOwkduxjSxM5M
 nEFk9tweOFv21yZMqIoKM6pWSJ5VU0OwFjuYkTcxl+AxQWBVzmdhObcJh1ZqkMO4DqrTYoC/4
 nBAP6Y+Y7RjYI3wxyEFJ/a7aWuvi3U2cwQkvGKqBCWpmVqvhAbhoV4qAupf/IMm4reuAH761K
 JUu/je1qXZDCOLo3VB0lQUIVDCLY6s3ddCkStxn+Z/ddXcqwKKewjPIiZA10yNmNy4Sw6ngNm
 SKAzL3jaasMiQNRBjaVNRym2bWGx16zE1TfHgflw+gftk4MT/qgJd2ghUMsQRazyYuZPQd5Hv
 Xi9lO/A8f/QZFyHAexVVC+93UoI/iSxpiEpW3A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, we still used get_seconds() instead of
ktime_get_real_seconds(), and I'm changing the remaining ones now to
all use ktime_get_real_seconds() so we use the full available range for
timestamps instead of overflowing the 'unsigned long' return value in
year 2106 on 32-bit kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 6 +++---
 ipc/sem.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 56fd1c73eedc..574f76c9a2ff 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -758,7 +758,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
-				msq->q_rtime = get_seconds();
+				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
 				WRITE_ONCE(msr->r_msg, msg);
@@ -859,7 +859,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	}
 
 	ipc_update_pid(&msq->q_lspid, task_tgid(current));
-	msq->q_stime = get_seconds();
+	msq->q_stime = ktime_get_real_seconds();
 
 	if (!pipelined_send(msq, msg, &wake_q)) {
 		/* no one is waiting for this message, enqueue it */
@@ -1087,7 +1087,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 
 			list_del(&msg->m_list);
 			msq->q_qnum--;
-			msq->q_rtime = get_seconds();
+			msq->q_rtime = ktime_get_real_seconds();
 			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d9217a..c6a8a971769d 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -104,7 +104,7 @@ struct sem {
 					/* that alter the semaphore */
 	struct list_head pending_const; /* pending single-sop operations */
 					/* that do not alter the semaphore*/
-	time_t	sem_otime;	/* candidate for sem_otime */
+	time64_t	 sem_otime;	/* candidate for sem_otime */
 } ____cacheline_aligned_in_smp;
 
 /* One sem_array data structure for each set of semaphores in the system. */
@@ -984,10 +984,10 @@ static int update_queue(struct sem_array *sma, int semnum, struct wake_q_head *w
 static void set_semotime(struct sem_array *sma, struct sembuf *sops)
 {
 	if (sops == NULL) {
-		sma->sems[0].sem_otime = get_seconds();
+		sma->sems[0].sem_otime = ktime_get_real_seconds();
 	} else {
 		sma->sems[sops[0].sem_num].sem_otime =
-							get_seconds();
+						ktime_get_real_seconds();
 	}
 }
 
-- 
2.9.0
