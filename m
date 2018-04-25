Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeDYNYl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:24:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753941AbeDYNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:23:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 09/16] y2038: sparc: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 15:22:35 +0200
Message-Id: <20180425132242.1500539-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:IXH4mBqrBxs1x5+hIrapXftf8q9YT+OtsSxIoC64JC0VPX/ggKT
 moHxVq7/8NEX3t7k4ARaAJ4cenCKCj04U9rv11HJjoBWuTvMElYdP4df1P25jz03kmGZEwZ
 vSE0F8rJJ34g7wIliLhFyF3FzWukNG3csevyeu2wB8Nt3B+IODdIkYNkXo7713JdGUHU0I3
 56CC1z34reuLY0TzikQIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j2ZiHF77Fng=:drIXp+sURUP+hBnatMHUTB
 Sd4dByXL1PyVpN+dGeSmrNFek8b+EaGLVBlWt0GFINYsLJkfq2ipirM4bMWnsLp3OGQJRj944
 o3zv137M+s0kBGaLZUREdDk3eUKD/Cw85DOzBzIgX+ZaMNiGemlIMN8LY1j0xiRwA4Zhqu6mn
 H3hwj3nDMns/z5I17o9OngoIAMhL/9BAXeGphGMseKT+24bX5N0JpTkQQUmpmgOadbnj0mGIn
 0vDKo4q2I3eenauZ8zqt30PPDg+4t+ElRINNCSjZhD5WgIkBOKCKbw6g8LJ8Iej3wdNqYmPSN
 ley8ygM1gqBhvajMVaTewuGU/ySqpyMCzeDvhMWUtflFAUzQwcbTuzm1sNBa2N/TpoIX2XAiw
 L3Jwyav+JLphVRWXFQ/DleOjk6u2bz56YNKPcwH4V6kBhmr/E/R/BZ0qP2sI/6rGY16IwQVCk
 SLfyHvNUqG0x0KsSIY8cgigAI9yEqhkA4ZpRimQwG9ECB5m+N9mfX8uzP2lQgtc6pywT6B+N6
 yrNf9kN8TAfC/c7/8WOVE2Uz/VnxD3ugbN0KD9lcUoaoKMgVjJGxq2i3ByH/7naHFu72h5ods
 pvhHpdSxzXZGemLScP2Ze+R7QUSOEMYhDQtNy0KjnxlvQB13PKYfvsr3qCksAY0tEelkQ+vbw
 RS2IRdUVuBHkRA/etjzT5H054+KYJ8RvBtZL69LNqcSSHUVMpgYe2nGPqL7olvNxKNzFkUgke
 aSjTGTQxxRwRZNKDbgHDaOAQ31k1um7KdEMVmg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

Unlike most architectures, sparc actually succeeded in
defining this right for big-endian CPUs, but as everyone else
got it wrong, we just use the same hack everywhere.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/sparc/include/uapi/asm/msgbuf.h | 22 +++++++++-------------
 arch/sparc/include/uapi/asm/sembuf.h | 16 +++++++---------
 arch/sparc/include/uapi/asm/shmbuf.h | 21 +++++++++------------
 4 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 1910c44521e3..4eb51d2dae98 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -192,10 +192,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int	__pad1;
-	compat_time_t	sem_otime;
-	unsigned int	__pad2;
-	compat_time_t	sem_ctime;
+	unsigned int	sem_otime_high;
+	unsigned int	sem_otime;
+	unsigned int	sem_ctime_high;
+	unsigned int	sem_ctime;
 	u32		sem_nsems;
 	u32		__unused1;
 	u32		__unused2;
@@ -203,12 +203,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int	__pad1;
-	compat_time_t	msg_stime;
-	unsigned int	__pad2;
-	compat_time_t	msg_rtime;
-	unsigned int	__pad3;
-	compat_time_t	msg_ctime;
+	unsigned int	msg_stime_high;
+	unsigned int	msg_stime;
+	unsigned int	msg_rtime_high;
+	unsigned int	msg_rtime;
+	unsigned int	msg_ctime_high;
+	unsigned int	msg_ctime;
 	unsigned int	msg_cbytes;
 	unsigned int	msg_qnum;
 	unsigned int	msg_qbytes;
@@ -220,12 +220,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int	__pad1;
-	compat_time_t	shm_atime;
-	unsigned int	__pad2;
-	compat_time_t	shm_dtime;
-	unsigned int	__pad3;
-	compat_time_t	shm_ctime;
+	unsigned int	shm_atime_high;
+	unsigned int	shm_atime;
+	unsigned int	shm_dtime_high;
+	unsigned int	shm_dtime;
+	unsigned int	shm_ctime_high;
+	unsigned int	shm_ctime;
 	compat_size_t	shm_segsz;
 	compat_pid_t	shm_cpid;
 	compat_pid_t	shm_lpid;
diff --git a/arch/sparc/include/uapi/asm/msgbuf.h b/arch/sparc/include/uapi/asm/msgbuf.h
index b601c4f4d956..ffc46c211d6d 100644
--- a/arch/sparc/include/uapi/asm/msgbuf.h
+++ b/arch/sparc/include/uapi/asm/msgbuf.h
@@ -8,25 +8,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
-
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
-
-
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-	PADDING(__pad2)
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	PADDING(__pad3)
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long msg_stime_high;
+	unsigned long msg_stime;	/* last msgsnd time */
+	unsigned long msg_rtime_high;
+	unsigned long msg_rtime;	/* last msgrcv time */
+	unsigned long msg_ctime_high;
+	unsigned long msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
@@ -35,5 +32,4 @@ struct msqid64_ds {
 	unsigned long  __unused1;
 	unsigned long  __unused2;
 };
-#undef PADDING
 #endif /* _SPARC_MSGBUF_H */
diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/uapi/asm/sembuf.h
index f49b0ffa0ab8..f3d309c2e1cd 100644
--- a/arch/sparc/include/uapi/asm/sembuf.h
+++ b/arch/sparc/include/uapi/asm/sembuf.h
@@ -8,25 +8,23 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t	sem_otime;		/* last semop time */
-	PADDING(__pad2)
 	__kernel_time_t	sem_ctime;		/* last change time */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
-#undef PADDING
 
 #endif /* _SPARC64_SEMBUF_H */
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index 286631db705c..06618b84822d 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -8,24 +8,23 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
-
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t		shm_atime;	/* last attach time */
-	PADDING(__pad2)
 	__kernel_time_t		shm_dtime;	/* last detach time */
-	PADDING(__pad3)
 	__kernel_time_t		shm_ctime;	/* last change time */
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
+#endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
@@ -46,6 +45,4 @@ struct shminfo64 {
 	unsigned long	__unused4;
 };
 
-#undef PADDING
-
 #endif /* _SPARC_SHMBUF_H */
-- 
2.9.0
