Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbeDYNXc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:23:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754139AbeDYNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:23:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 13/16] y2038: ipc: Report long times to user space
Date: Wed, 25 Apr 2018 15:22:39 +0200
Message-Id: <20180425132242.1500539-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:KwPfWWk6me73Ns1gVd+5Fh8sh2XQWraJhawlJMkBsT65GtVtsnb
 psDjHJNN5/MsDFd/bplFtFjyTe6LVKRieeCh7jJeG9eX0mU9+U+5rnb1m8M4zvFBXV037PZ
 9RGwqhubpY4fDA7KoBPkbCEfzGVLLD0GGJc9hjduws9IhsqppIRfn0pTt1F2plrYARc+AWl
 7ko+KQX3tOYMWNGpPpFZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EAzZ5C9f6lg=:LIDJEdsMAsx2NZK+KvTI7n
 23Om6euY/zo4nJrJLum+biBuLFZrDfgc4DE5Y5iJUTEjN7ibCsGvrRr+OXzNqAH3Ps8+yLTXI
 dkVu840dbBAGGdOJZonca5OGpxtUuEiMdxcXhsqj6guy2bWyWXZj4LgfZGMQQlQbGCGoBVksd
 3rDqOKvO0dtiV0uZis3CasVtZ6D4IQQMNLTuJ4co7Nc2pdnWSX07kZBj86UiNffgqZOsx6tuE
 d+jZ1j1xPtdUuaCauMLyfO/eNfraeytcaU4Z1yKGSGDQ0Ian3umwyTuWse8r6RQXeU7k3CkWl
 MzkQJULA9m+ovil4i5PPCcCOjf1Lx3N91s7nG9kZ71SK81volbbiZ0NjrGVdWIRpsERlTrI9k
 DNu3c63wLWl+a7+sTNotGhULQrRO5x6ZSetc/7INL/H9n+cvb/FOfUHgmLPSaqiBPlPsr9wjB
 rdnsyp7vJBhtF4SnwRLo8VPtU46/hCvuQZf49tvpGZLc+g576PSSs+/WLSezKM7jjzdgvSeZm
 vZ1G0+8dlFrsozug2ls4BmnhdIa7jA+jJMyAzVXDhYmII6zSnQS002zh9C1uIPn5mqfmYarau
 Ys7de1PGKVOAbkHlCgNPigrC3qcoUk3GfuwoUWFbEKpeHwsfdIejpCIHrJth3hSHwiEsLCDbu
 3ynyxJ258XvR0PVzcdSlmrnHErcPofjs3P5D8jpknrz2MepY6cKmk2PziIf8BpxYX9yMtPmkz
 yF+qfE5LCuG1nwWb1q1w5KfsANFUxeAL4FG/7A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shmid64_ds/semid64_ds/msqid64_ds data structures have been extended
to contain extra fields for storing the upper bits of the time stamps,
this patch does the other half of the job and and fills the new fields on
32-bit architectures as well as 32-bit tasks running on a 64-bit kernel
in compat mode.

There should be no change for native 64-bit tasks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 14 +++++++++++---
 ipc/sem.c | 14 +++++++++++---
 ipc/shm.c | 14 +++++++++++---
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 574f76c9a2ff..3b6545302598 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -537,6 +537,11 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_stime  = msq->q_stime;
 	p->msg_rtime  = msq->q_rtime;
 	p->msg_ctime  = msq->q_ctime;
+#ifndef CONFIG_64BIT
+	p->msg_stime_high = msq->q_stime >> 32;
+	p->msg_rtime_high = msq->q_rtime >> 32;
+	p->msg_ctime_high = msq->q_ctime >> 32;
+#endif
 	p->msg_cbytes = msq->q_cbytes;
 	p->msg_qnum   = msq->q_qnum;
 	p->msg_qbytes = msq->q_qbytes;
@@ -646,9 +651,12 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		struct compat_msqid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.msg_perm, &in->msg_perm);
-		v.msg_stime = in->msg_stime;
-		v.msg_rtime = in->msg_rtime;
-		v.msg_ctime = in->msg_ctime;
+		v.msg_stime	 = lower_32_bits(in->msg_stime);
+		v.msg_stime_high = upper_32_bits(in->msg_stime);
+		v.msg_rtime	 = lower_32_bits(in->msg_rtime);
+		v.msg_rtime_high = upper_32_bits(in->msg_rtime);
+		v.msg_ctime	 = lower_32_bits(in->msg_ctime);
+		v.msg_ctime_high = upper_32_bits(in->msg_ctime);
 		v.msg_cbytes = in->msg_cbytes;
 		v.msg_qnum = in->msg_qnum;
 		v.msg_qbytes = in->msg_qbytes;
diff --git a/ipc/sem.c b/ipc/sem.c
index c6a8a971769d..8935cd8cf166 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1214,6 +1214,7 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			 int cmd, struct semid64_ds *semid64)
 {
 	struct sem_array *sma;
+	time64_t semotime;
 	int id = 0;
 	int err;
 
@@ -1257,8 +1258,13 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	}
 
 	kernel_to_ipc64_perm(&sma->sem_perm, &semid64->sem_perm);
-	semid64->sem_otime = get_semotime(sma);
+	semotime = get_semotime(sma);
+	semid64->sem_otime = semotime;
 	semid64->sem_ctime = sma->sem_ctime;
+#ifndef CONFIG_64BIT
+	semid64->sem_otime_high = semotime >> 32;
+	semid64->sem_ctime_high = sma->sem_ctime >> 32;
+#endif
 	semid64->sem_nsems = sma->sem_nsems;
 
 	ipc_unlock_object(&sma->sem_perm);
@@ -1704,8 +1710,10 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		struct compat_semid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.sem_perm, &in->sem_perm);
-		v.sem_otime = in->sem_otime;
-		v.sem_ctime = in->sem_ctime;
+		v.sem_otime	 = lower_32_bits(in->sem_otime);
+		v.sem_otime_high = upper_32_bits(in->sem_otime);
+		v.sem_ctime	 = lower_32_bits(in->sem_ctime);
+		v.sem_ctime_high = upper_32_bits(in->sem_ctime);
 		v.sem_nsems = in->sem_nsems;
 		return copy_to_user(buf, &v, sizeof(v));
 	} else {
diff --git a/ipc/shm.c b/ipc/shm.c
index 3cf48988d68c..0075990338f4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1002,6 +1002,11 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_atime	= shp->shm_atim;
 	tbuf->shm_dtime	= shp->shm_dtim;
 	tbuf->shm_ctime	= shp->shm_ctim;
+#ifndef CONFIG_64BIT
+	tbuf->shm_atime_high = shp->shm_atim >> 32;
+	tbuf->shm_dtime_high = shp->shm_dtim >> 32;
+	tbuf->shm_ctime_high = shp->shm_ctim >> 32;
+#endif
 	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
 	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
@@ -1233,9 +1238,12 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		struct compat_shmid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.shm_perm, &in->shm_perm);
-		v.shm_atime = in->shm_atime;
-		v.shm_dtime = in->shm_dtime;
-		v.shm_ctime = in->shm_ctime;
+		v.shm_atime	 = lower_32_bits(in->shm_atime);
+		v.shm_atime_high = upper_32_bits(in->shm_atime);
+		v.shm_dtime	 = lower_32_bits(in->shm_dtime);
+		v.shm_dtime_high = upper_32_bits(in->shm_dtime);
+		v.shm_ctime	 = lower_32_bits(in->shm_ctime);
+		v.shm_ctime_high = upper_32_bits(in->shm_ctime);
 		v.shm_segsz = in->shm_segsz;
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
-- 
2.9.0
