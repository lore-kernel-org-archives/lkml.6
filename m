Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeDLOU6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:20:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeDLOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 12/13] y2038: ipc: use ktime_get_real_seconds consistently
Date: Thu, 12 Apr 2018 16:20:23 +0200
Message-Id: <20180412142024.853892-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:d6Hun3WAu7qxSe9UnY5niAfmpFphUwr7LFNqTeDeFker6GOT9gV
 jCZKWy5FGIt5zH8/SixzRBxpamWaWSa3zPnNwXde9mF/dRAUpQAQ4dtIaNNOjs/odUtxVYc
 tKRTezQYMG9bZytFuTM5ALnvaHDGPesodm5yorull3cMfpXadH8593egj3lQXuj33kIcgDP
 7lqAypuPzTxTHCVRSdKfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ddn6WtrQL9E=:wCpvl1SzqkWWN4X4tqe1Kz
 jLOb4mZ5QguLdR2R88uLbMA/G4kdkVOPz3uomwmCGmoSqk6+73sfA/WxDk8NGlizEiVnfCaQr
 VU0BDeEe2oMgDoEMjKgF24LyCvlkGh1k+h70d9514ns5XSe9HDKLiSQMUmQvIOTn+vTR7AALI
 yiSXrzA+o2bc0v0wUQIj0W9hMrmD4F8IotBXs/4JJ43DIrHW4V2zk9QtCX+Iu5F3RRqpx0BcP
 R/fT7iWoLOtgPdSbGF3cdG9w3SZaxuGNgQYm4Q5ZCiwPHVqoce4OeXjU2ONiQCpskxIQ8u/Cc
 fgVytgg84RJstvFxNKtcz9eEH7b6LYxRKseb4wQ/DzY7fMrauWIjTfj4cuGRF9d4X2EUZBs47
 8Kn1rRxYyPNNn/gxmHoOxh+ZCqPABNbAx8Mlw1vcn+MMkpQ8dEawUFxad3I9EJkJ36FgxE0Fd
 VBbaBjjzZpFBq9tbnH6P3Y7/4SXWkiucvy9A7VmxNrO7anGcL62nyrM4Hi9+Y1uXS4CKKRZQs
 iZA0dSdmJkdS6X5hu7+XVk/ICoW9gs5IseflyKIaYIlnJSJV2qspHJVZop1THLD6bKk7noYSW
 aAlxeepBSDyy4HPnPv8cYlFRxDGOt1NOMg+8dGOcaLYt9a/kdzBt7Qu7h16Nz/0Iw6gmQqczi
 m/Z3oFPFVqL8CHFjo61QelkpwaD1RJ1JbnH7cFZMgNduOaLcP7V9EVZb5GCnX2ZVNVJGx0Bv3
 oE3TcCa9AU22G0eVJJh0fBC2gSFe8uxTalVAOQ==
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
index 114a21189613..5422d7c10e9f 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -751,7 +751,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
-				msq->q_rtime = get_seconds();
+				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
 				WRITE_ONCE(msr->r_msg, msg);
@@ -852,7 +852,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	}
 
 	ipc_update_pid(&msq->q_lspid, task_tgid(current));
-	msq->q_stime = get_seconds();
+	msq->q_stime = ktime_get_real_seconds();
 
 	if (!pipelined_send(msq, msg, &wake_q)) {
 		/* no one is waiting for this message, enqueue it */
@@ -1080,7 +1080,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 
 			list_del(&msg->m_list);
 			msq->q_qnum--;
-			msq->q_rtime = get_seconds();
+			msq->q_rtime = ktime_get_real_seconds();
 			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
diff --git a/ipc/sem.c b/ipc/sem.c
index 2994da8ccc7f..579a60265fc6 100644
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
