Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeDYNYo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:24:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbeDYNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:23:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 10/16] y2038: powerpc: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 15:22:36 +0200
Message-Id: <20180425132242.1500539-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:CdLCGtnmTDNlN1K4dtn/CBLw9Lx3H2LL6y4d0ZJxIeo42t8qaRA
 lVf8Em0bBVmhWJ89pWoC4cv7ClPkOx7RXsH3BX16Xdk9zA9WBCbOz3K+q1Mk0pw97dlUMhm
 Tohas2pMRuGxCi2oOyG863GW/s5MNefUo2xxa6IdFl2mgVayXcZMCNLHB2DzV35WyQ/ermi
 seUsJW1giew4oQoi9yPyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a0Aq2V7hIPs=:0CLUzK3H3SKOs/VRaNgHVi
 Dk4MQpVpyfDGzNwdCcbUT3is7LqjsCZW8ab4DKme/naAOd8z9Y4ssxaO0Hv52+JpuaGOnsMNG
 Py8AzWcLMtXTnBche/rIoe0vQaKwPJNQgE4ez0ITGsDOI/PkGeuRb3pe4Iw+2GOmexQ74tJ0k
 b2jK4NV98pdLNQ29M/YejwL4H/mNtJcSY66uVlPg19Xf1/ek8BjUedUsUdHZ5TASOrsYdiLyx
 Us00Aw9vq0SQ9RwrO2I/0FUsv1hlK2MWw51x9KfarMTa15lxtLpWN9bpuOb1wYZ9V/849wNix
 q+DJJJ9DKcBanmAzk1YG1Rs2T71d8Prib6Uwxt3jk+LprdgdVHl+2lKQDnu+O3VMNZH3nV1bi
 /LD2JzgHQkw8X5Foq9WX4IrI26HYZJVXoYwiwXCk84ICgVq4V1Nb3BeApY47Ud0gAIHYh2QZF
 rH4HcR2GD/uQCjVhE+1ArRI/audhUDaYl3X2HG5+ouLhGwsiRYWYhdOdoV7+3YrsbvTP1L93x
 YHrH5NZQbywqlB4r9AD3ecxCa0Omh3emaJ5QcIaG1G+6mFBmfuNXNZf38NLiFbB8gPO5R4x0U
 qg452q0oesAlP6ItYrUB9eY6zKofRtdt6sGkZSQpKsJZirsFBSAy5mp7fCOOuWKNguOcYbJna
 Sbe0Gfr78ozrKgmTObhdr4jzi1Yc07SkGHxGuWkY53ezNLN/1H6q7xEbtGOIJ3XOMFiWCK1fK
 E1zwG068blL3IjkDfs794aZJB/kwhbjz8a3bxA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

powerpc has the same definition as parisc and sparc, but now also
supports little-endian mode, which is now wrong because the
padding is made for big-endian user space.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/powerpc/include/uapi/asm/msgbuf.h | 18 +++++++++---------
 arch/powerpc/include/uapi/asm/sembuf.h | 14 +++++++-------
 arch/powerpc/include/uapi/asm/shmbuf.h | 19 ++++++++-----------
 4 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index b4773c81f7d5..85c8af2bb272 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -162,10 +162,10 @@ struct compat_ipc64_perm {
 
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
@@ -173,12 +173,12 @@ struct compat_semid64_ds {
 
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
@@ -190,12 +190,12 @@ struct compat_msqid64_ds {
 
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
diff --git a/arch/powerpc/include/uapi/asm/msgbuf.h b/arch/powerpc/include/uapi/asm/msgbuf.h
index 65beb0942500..2b1b37797a47 100644
--- a/arch/powerpc/include/uapi/asm/msgbuf.h
+++ b/arch/powerpc/include/uapi/asm/msgbuf.h
@@ -10,18 +10,18 @@
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#ifndef __powerpc64__
-	unsigned int	__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __powerpc64__
-	unsigned int	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __powerpc64__
-	unsigned int	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 8f393d60f02d..3f60946f77e3 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -15,20 +15,20 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * - 2 miscellaneous 32/64-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
 #ifndef __powerpc64__
-	unsigned long	__unused1;
-#endif
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;	/* last change time */
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
-#ifndef __powerpc64__
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
+#endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
 	unsigned long	__unused4;
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index deb1c3e503d3..b591c4d7e4c5 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -16,25 +16,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#ifndef __powerpc64__
-	unsigned long		__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __powerpc64__
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __powerpc64__
-	unsigned long		__unused3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __powerpc64__
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned long		__unused4;
 #endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
-- 
2.9.0
