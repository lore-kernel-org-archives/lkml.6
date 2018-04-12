Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDLOU7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:20:59 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDLOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 11/13] y2038: xtensa: extend sysvipc data structures
Date: Thu, 12 Apr 2018 16:20:22 +0200
Message-Id: <20180412142024.853892-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:4QYNCMxY7eA0qd5x4/fVmxJ5c2C4hULScC96HtZWkwsiQWQkhnz
 MyRw4CWhR4nmFv6LqxxqIW/josPusMwq2ZwWJ4bnR+lUYvDT7KhEvL9dd4WddtwGN42cXkA
 /bE+FZocHfAmSyeGDYpdY98bcQBdZwkt/yU7TV8uxDtUlHL+mLVYs6NH+eLUAPxrorOwc6N
 EPnafvyajY0fPEzA9S5vQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ld6VFo/VGjE=:KHil8KbDgxpbbHiLVeIglU
 vAhgtrM5kxLtgX9zixNKSP6NdCKmGWQvix1z8r3wcjTPBXcQCLYyoFTwt67R2C+fPr8GyfXgK
 yscVG2K3+UU14NVx1cGMUceUVazEe3qobLJ1hzPs37f5zAGAEXZe/0zvJI80VOJpjrS0GfoKO
 z0ac6W/rZ9SaemBV13IOtXS2CqjPsfvN9K2kgOgBKcYMm7sWRXnN4LTdfXN9bCzH6KY9CGg4T
 yUrJGoup59MuNviY+khVjI3LxTK1SJkKeR91GAVoZN4HQ4PmlsZuF08/LduPWBZL0p4/xafLI
 xEfUCGSdBej+M1nqAb2vG3T5V1MwSVgAn4nXuIpQJKeZZV1EgRcN2eIYhU08ureBJ4WIZkiKS
 j+kCbKKQponVW0iuZIMjGCuTXsAteUhc85InNJDxu9zw7Q1xPfDlpEhr/ISbZ5zBuGSIH6mmv
 ID1xxTp+NRSoSyaKqvJpcS5yLt0+KbFnalfHpghDiTyPULSh7rtVfp5DQ3d2B190fTaUKj6En
 P0ZvHwhmHrhyDSEJ9a0Hre6WbZgQN7vUB9mzEpfrK6/RRXVWv2f6kPUX+sKENPambVqcNOvRA
 PaJtn/Go4yIqkatpvOuQWfkztFv32JvjQIMQhBxNex2gwrlyqhvxbDLCObxTvW7XHzltDwQ3f
 WoGx2NH8ickUg0PqhfGE8ZpyNF4WarKkAem5Ux3SqOz75ge+FJ1enKK/+ZXbybrdVgKX6wOWQ
 Vwb0rmgyMzYE5k4TfsgblWIZdUuOC6q+aiHz5Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

xtensa tries hard to define the structures so they work
in both big-endian and little-endian systems with padding
on the right side.
However, they only succeeded for for two of the three structures,
and their struct shmid64_ds ended up being defined in two
identical copies, and the big-endian one is wrong.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/include/uapi/asm/msgbuf.h | 25 ++++++++++++-----------
 arch/xtensa/include/uapi/asm/sembuf.h | 17 ++++++++--------
 arch/xtensa/include/uapi/asm/shmbuf.h | 37 ++++++++---------------------------
 3 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/arch/xtensa/include/uapi/asm/msgbuf.h b/arch/xtensa/include/uapi/asm/msgbuf.h
index 36e2e103ca38..d6915e9f071c 100644
--- a/arch/xtensa/include/uapi/asm/msgbuf.h
+++ b/arch/xtensa/include/uapi/asm/msgbuf.h
@@ -7,7 +7,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -21,19 +20,19 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #ifdef __XTENSA_EB__
-	unsigned int	__unused1;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused3;
-	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
 #elif defined(__XTENSA_EL__)
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused1;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned int	__unused3;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
 #else
 # error processor byte order undefined!
 #endif
diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/uapi/asm/sembuf.h
index f61b6331a10c..09f348d643f1 100644
--- a/arch/xtensa/include/uapi/asm/sembuf.h
+++ b/arch/xtensa/include/uapi/asm/sembuf.h
@@ -14,7 +14,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  */
@@ -27,15 +26,15 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 #ifdef __XTENSA_EL__
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused1;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	__unused2;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;		/* last change time */
+	unsigned long	sem_ctime_high;
 #else
-	unsigned long	__unused1;
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused2;
-	__kernel_time_t	sem_ctime;		/* last change time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
 #endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index 26550bdc8430..554a57a6a90f 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -4,10 +4,10 @@
  *
  * The shmid64_ds structure for Xtensa architecture.
  * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
+ * between kernel and user space, but the padding is on the wrong
+ * side for big-endian xtensa, for historic reasons.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -20,42 +20,21 @@
 #ifndef _XTENSA_SHMBUF_H
 #define _XTENSA_SHMBUF_H
 
-#if defined (__XTENSA_EL__)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
 	unsigned long		__unused4;
 	unsigned long		__unused5;
 };
-#elif defined (__XTENSA_EB__)
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-#else
-# error endian order not defined
-#endif
-
 
 struct shminfo64 {
 	unsigned long	shmmax;
-- 
2.9.0
