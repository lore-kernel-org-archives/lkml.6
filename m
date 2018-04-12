Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeDLOVE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:21:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeDLOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 08/13] y2038: parisc: extend sysvipc data structures
Date: Thu, 12 Apr 2018 16:20:19 +0200
Message-Id: <20180412142024.853892-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:SHS+gxmvKO8vy4nd4fFo1/9FwslYqDHEP9puxU0bc3asH3R8Bij
 7Sbc9ZsEptZJuSbGm9u3yVW+5o4qwuyElHOYNbiBYWhDdBq7aB/qbtMBp5pHkHnBtp3lUoc
 da19wxw4jktxSLzdBUULJkqqZftJnZ3agXjoFAFmAW9BJiB0TvHZmtE1H3/DfUFK4PB1rg2
 igKAIklXtWseipWqGRHaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8PljpVIL97M=:l5wWMR6zlAvYGDh4FfCZVy
 j9hYeDinMqVPekhKE6DiCKzECDrIq7+pmOWvS71pNbwt5cE19hdE/D/YhpDYpWEL/TK8TKuj9
 /80YK/q05kjgpovWhjF/shhLpfRiU6pWMmUIIPMnC6EK6embBTDVc/IbzQWS82iTa8MF8O3ag
 jOqphDTse1DqSGs7d7CowxP72fIB/XjpSleJEZNnUZnQQ56qQoc7hqbXUNey6EewcnDbwhuBK
 V9XsRfkzNxPy9VgkQ3+Ww4Jm37GSdUY6OcMtg5rMMNWA4g6jwR1AXpjWska9WkydE5jDs6Id2
 KWqd7WO3C2SJGsJCbLL34ppesD7wz5sTC1Qu3J7b0RIL3AcQGAIsiFMx6AFCuWZpBRqHtLSZt
 qoeRUxsV5RpXbD6fsuceTtPcg4LhQLbKJ9dqsjUGZrw5MvxmLUY/U6LTskm3aztQ7nnQsk6tR
 Iu/nUuGCxwuiCtjvu6EZL6goXwMOdG+0eb29dVZKo8+wRWm54h7arPILEbF5IiYusjPEj/JbT
 Pt5tDbVFjx2RWJ0fz153d+0LcgHbKR1WawVhvwVi1x8UZuKLBe1HGu9Z9vU/Q/+z1sXYfxVZ4
 STRaaBlw8wevfA3pldFb0FtBydv4rCeoTuR59zOUqJUvVIRCOEJupvlsTYjD3NBMha7Jolw+A
 ZDJWej5Nm6HB4fF3vmgl9PaiTdL81K4byGXimZy3Z1Lj0mjA6ZnpFHTISuI6Vv5mh/ePMhkxy
 XfzBVc1n0wK98pUdFaxoa4AYZGb4M1NVAwx3nw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parisc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

Unlike most architectures, parisc actually succeeded in
defining this right for big-endian CPUs, but as everyone else
got it wrong, we just use the same hack everywhere.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/parisc/include/uapi/asm/msgbuf.h | 33 ++++++++++++++++-----------------
 arch/parisc/include/uapi/asm/sembuf.h | 16 ++++++++--------
 arch/parisc/include/uapi/asm/shmbuf.h | 19 ++++++++-----------
 4 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 6f256e7b95e3..e9b391ea1dfc 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -138,10 +138,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
+	unsigned int sem_otime_high;
+	unsigned int sem_otime;
+	unsigned int sem_ctime_high;
+	unsigned int sem_ctime;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -149,12 +149,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
+	unsigned int msg_stime_high;
+	unsigned int msg_stime;
+	unsigned int msg_rtime_high;
+	unsigned int msg_rtime;
+	unsigned int msg_ctime_high;
+	unsigned int msg_ctime;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -166,12 +166,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
+	unsigned int shm_atime_high;
+	unsigned int shm_atime;
+	unsigned int shm_dtime_high;
+	unsigned int shm_dtime;
+	unsigned int shm_ctime_high;
+	unsigned int shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
 	compat_pid_t shm_cpid;
diff --git a/arch/parisc/include/uapi/asm/msgbuf.h b/arch/parisc/include/uapi/asm/msgbuf.h
index b48b810e626b..6a2e9ab2ef8d 100644
--- a/arch/parisc/include/uapi/asm/msgbuf.h
+++ b/arch/parisc/include/uapi/asm/msgbuf.h
@@ -10,31 +10,30 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long msg_cbytes;	/* current number of bytes on queue */
-	unsigned long msg_qnum;		/* number of messages in queue */
-	unsigned long msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long __unused1;
-	unsigned long __unused2;
+#else
+	unsigned long	msg_stime_high;
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_ctime_high;
+	unsigned long	msg_ctime;	/* last change time */
+#endif
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t	msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t	msg_lrpid;	/* last receive pid */
+	unsigned long	__unused1;
+	unsigned long	__unused2;
 };
 
 #endif /* _PARISC_MSGBUF_H */
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 746c5d86a9b1..3c31163b1241 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -10,21 +10,21 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;		/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad2;
-#endif
 	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long 	sem_nsems;		/* no. of semaphores in array */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index cd4dbce55d0b..c89b3dd8db21 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -10,25 +10,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned int		__pad4;
 #endif
 	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
-- 
2.9.0
