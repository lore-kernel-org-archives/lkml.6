Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDLOUh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:20:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeDLOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 01/13] y2038: asm-generic: extend sysvipc data structures
Date: Thu, 12 Apr 2018 16:20:12 +0200
Message-Id: <20180412142024.853892-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:NKuutRqI7p067JW9fwCYbYyyW5hB2v4KVD1KMZ03pNBoh8uamoZ
 oKp7k9gCNOABF52XfSSrde5pwVMKeB+KzMJRy3Ms28hKu8oYwFXBVJWv23JHcu2ROlApjIx
 d/fTyFVeAONjo+WVMtoYiwsjxyYmTMX1TE0TFbyD5Nhynl6I+x2/xpJkMnrF2Dp71w6Y3e2
 7psoxVSL71ggwRa+Y5tWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yLQPo0kZ66Q=:546iYtnoa36G6ymDpAudWk
 m/+c5+0umWeO73tabDghNOlzoAZBw59aahCWmbzLwzKeZimmPcu2K2ooh3snRXndC/seiIRhm
 /R9B06OxYD3Re5xAjT1xidC1IlOy6MKVNX38oMCIAaZS168IYXTW4WLJ7T5QHiTZ7yTEJWdwB
 8HWwxV1Y/qofYTLK+8rn2ZfWvBpSBC+aTs1D2xuErwE6n8+cS3fRk0vsH8Jar9OMzQWrmD5WW
 xkg5tMm9pmH6p4r3ja/MMZu45xppHsIhF0Qm6PFTOt9Q/SxDsEiQp5jS7cdG4sni07SaLSR2e
 Zsrg+Bpcgc/nJmStwooaUEcsqtvo/FII3ho/fQ76iK+yt1nnUen0SqtFAHn07yaWTy1t1qx83
 UAa4G45Cq26nlu9L2Ltw252PooerJkBAGSSs8CiI9stQGjH1lwQFpZ8WEyTEEUIVtsOa+KHui
 t+xO6eQIFnJJZiM1m5Trq6HFod75I3S+xRaiPnJkOZvOdMxBzILK0/UB0uGGzN3hFcsBj1jxU
 Af8Q3ZN14UyWPFuWyfRNg80+joV+pfKs/Cy0kvMe/y9wB8d3uvkgIKPRrCAQVVl122NY4u+Bf
 fNEh6vz6hRmCFHXDgdhN68QVFaav7r5Tg/A45TsxcDFb/nNmiwE/+L+xNC/2B0Rp9ti7NPCnZ
 zCgwzLXH5gER1voJPfHv8efTYCkrj5Me066MzVmu+ZeiKxITJ28nRQzhaZC3bp6ux6OobPI3h
 iydfL1JAbFkkKjgEpHcyCM5ChooCrBwo472LuA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures now use the asm-generic copy of the sysvipc data
structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
__kernel_time_t on 32-bit architectures but have padding behind them to
allow extending the type to 64-bit.

Unfortunately, that fails on all big-endian architectures, which have the
padding on the wrong side. As so many of them get it wrong, we decided to
not bother even trying to fix it up when we introduced the asm-generic
copy. Instead we always use the padding word now to provide the upper
32 bits of the seconds value, regardless of the endianess.

A libc implementation on a typical big-endian system can deal with
this by providing its own copy of the structure definition to user
space, and swapping the two 32-bit words before returning from the
semctl/shmctl/msgctl system calls.

ARM64 and s/390 are architectures that use these generic headers and
also provide support for compat mode on 64-bit kernels, so we adapt
their copies here as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/msgbuf.h | 17 ++++++++---------
 include/uapi/asm-generic/sembuf.h | 26 ++++++++++++++++----------
 include/uapi/asm-generic/shmbuf.h | 17 ++++++++---------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index fb306ebdb36f..d2169cae93b8 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -18,23 +18,22 @@
  * On big-endian systems, the padding is in the wrong place.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused3;
+#else
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_stime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_ctime;	/* last change time */
+	unsigned long	msg_ctime_high;
 #endif
 	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
 	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index cbf9cfe977d6..0bae010f1b64 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -13,23 +13,29 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures typically define a 64 bit __kernel_time_t,
+ * 64 bit architectures use a 64-bit __kernel_time_t here, while
+ * 32 bit architectures have a pair of unsigned long values.
  * so they do not need the first two padding words.
- * On big-endian systems, the padding is in the wrong place.
  *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * On big-endian systems, the padding is in the wrong place for
+ * historic reasons, so user space has to reconstruct a time_t
+ * value using
+ *
+ * user_semid_ds.sem_otime = kernel_semid64_ds.sem_otime +
+ *		((long long)kernel_semid64_ds.sem_otime_high << 32)
+ *
+ * Pad space is left for 2 miscellaneous 32-bit values
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;	/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
+#else
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
 #endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2b6c3bb97f97..602f1b5b462b 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -19,24 +19,23 @@
  *
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused1;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused3;
+#else
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 #endif
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-- 
2.9.0
