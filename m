Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeDLOU5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:20:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeDLOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 13/13] y2038: ipc: report long times to user space
Date: Thu, 12 Apr 2018 16:20:24 +0200
Message-Id: <20180412142024.853892-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Hi3KvLfoP8E4DXp87UJa4gNS/UlnpRQgbUjRAzArzu39NKiIZTd
 spGyW8sYK3975kupdavqbtTYaASykZFaJ49b4h6Phem33kYZ5iOvFH5xRtBt4alacWyErir
 AUZtD5wK4c3dLkxKCoVlwox3ua8Gks43nS0e5MJCXJgfYot5vzho1TAaIjOhtYzVQdsLh7k
 sCWxsNIxflsAaf3KBCpiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9kHgbazk6lA=:D6eMCgnLEPzFaQ6b85dH5M
 UpNLfGhh91EDCRfMjN+og6Ba33CKb79pmlIcu8csHsAadvPEctm/XAz9y2zbFAi4FKnjNXm4k
 ICkcDu9n/e82QfBaSvvN+cLS5eHbyxWCbJAisjsgoDIZS0hztFf8UYGbLPlR6In3lJmgjoYYn
 PdPcn10LRvl9iOXLLoxMF0qwI5DHWHFwSdhjrX2OoHBc4naD+AFT4unxmYLfRcB76Tsndt+HT
 i7utOFltuV9EzinsYzkGoxCxd7fYuW7uBjGaLkRXY3bfEjWpk+WspsbF02XKT9D31RqubI5uf
 AuGbdOizYbd5LwGm83Of9tu5ic53ZlCWiehuIgfIIAYJT3Q2A0YHQirByDrVtb+OCGghPgLQw
 rt4zuldBZzIQqBxJapJxMq6T9kwm5BHbKxCbsRjqDgGuQK1wrLD4QWGOB+QVKqdJZoYXIqZVH
 VtXGHGykUlCkFB9YfCb2KcHRgA81dofP0PhhU60hXopvfI8rSblWVXG3inDjXGU9isTkbr+rD
 ZIQ+Tk+lQZqNC2DrNcYa6dHoV/8OWLOYOjRN4/QnDK8BjCQTRpvaYE3LEn8WgJ4Dy40yss/fp
 0lVcjbrrDL2QkAZqzXGJrh2F4MPD+V2fgDvy2DZ6SqgDd0PijTHl8o7ugnEcUkJdIJBxeT/Ho
 dA/wUPIdLHjo/GyXFjxXu1by13dolnY4UlNrPJau3SNCDWMldkISqgSauO7khlqp64MoT2Pgl
 Qv4qnu53ibN6fgRXTPlcSgu2n2Fp/3evK1FvnA==
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
index 5422d7c10e9f..57869f007265 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -532,6 +532,11 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
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
@@ -640,9 +645,12 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
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
index 579a60265fc6..94164c0a15ae 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1214,6 +1214,7 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			 int cmd, struct semid64_ds *semid64)
 {
 	struct sem_array *sma;
+	time64_t semotime;
 	int id = 0;
 	int err;
 
@@ -1252,8 +1253,13 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
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
@@ -1698,8 +1704,10 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
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
index acefe44fefef..7bbbcd0814eb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -983,6 +983,11 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
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
@@ -1213,9 +1218,12 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
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
