Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeDLOWl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:22:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752913AbeDLOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 06/13] y2038: mips: extend sysvipc data structures
Date: Thu, 12 Apr 2018 16:20:17 +0200
Message-Id: <20180412142024.853892-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:KYSDhrqIvAcxsCR1+Ad30URxBVX6omKKz6PYZYFQB5WiQUvIMAe
 8OPgle1Eah66sf3O7pmw1S3W/sGseSwpRSeW7RJ7idkh7bJZvFsqu8/FMnB0ZSlzSMcLlAx
 UqioKF8JZgQUJyO97hBSilkLtVa1BHvYn6b5ZgOkguX3xxo2MOcTwZ7axtEqOpMIzeL0wd+
 TFxi7n4FUo073eyUL890A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VU49fow0oy8=:dHkDF2w4XYb0DSHfVSYISM
 kr3CdvvZaRbCl4FAeztnJcJdQ06Wlg07NrNeD0g8awsnt/7g/FEZc8a1aF23Gv/5DNh4MQOAQ
 aw3ONeDDmhLG+noWuaMaP5tbGlLS75j8kTV9NHOBqF02/hVJw7laqvAoEXIRz9JPwP4NeDMzG
 KVPCE4UuoWy+oS8/RHVRX66nHx/9E8woGAT9oK0E5YQjmmstwYCM/N47XYpZMp73uY6ry6QBT
 ElFmEmS1ZadB/Iy3EPyeNmygEPD/F4IFfC+VR+5CVqOlnipXMDul3zASyCjRJLdhPaUHpeFsW
 45aN2VJbKiBTeL1o8WxmdFzhAOECQKz0inGrBOhUD2ed7dB+jCCBHleM43dcpH16wKg/EyMCu
 K/7578QUAQRKGp925J8XcuwO4VRTbKMzq3b/jRDHvIBgKOaco7r0QXKqeGmhQFPzcHWiqlliw
 coDnRpaVsbJ7UIOPrIBxxosVQd82dMMS2z5SZf/ao3JtAOK4CzUHrZS9S/Ran2m9zrLI0XOZZ
 +HG5IeZqAWIvbUlkXdB+lhDU+kS+oDvcUjCtwXzPmon7ClZ4NTdthDQ7nUSq+7JvD6ZuUG3mt
 75R6Zmj2SniloIOzfPpfkcZTy4kEz//UZy0cIvghNPDsQN23Yim9kj8U6oyvB1XPYdB99kAPR
 fzEIGkyCQXRjyzESHW5Qpec01858pSnlHQt9Kup1V1g7m9bVmmk/m7tnRzBCVvDw/139n6KGd
 CsL5WLtvT8GVzkM/V4urZ7I/XCm6qpq+Huv5Ew==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS is the weirdest case for sysvipc, because each of the
three data structures is done differently:

* msqid64_ds has padding in the right place so we could in theory
  extend this one to just have 64-bit values instead of time_t.
  As this does not work for most of the other combinations,
  we just handle it in the common manner though.

* semid64_ds has no padding for 64-bit time_t, but has two reserved
  'long' fields, which are sufficient to extend the sem_otime
  and sem_ctime fields to 64 bit. In order to do this, the libc
  implementation will have to copy the data into another structure
  that has the fields in a different order. MIPS is the only
  architecture with this problem, so this is best done in MIPS
  specific libc code.

* shmid64_ds is slightly worse than that, because it has three
  time_t fields but only two unused 32-bit words. As a workaround,
  we extend each field only by 16 bits, ending up with 48-bit
  timestamps that user space again has to work around by itself.

The compat versions of the data structures are changed in the
same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/compat.h      | 38 +++++++++++++------------
 arch/mips/include/uapi/asm/msgbuf.h | 57 ++++++++++++++++++++++++-------------
 arch/mips/include/uapi/asm/sembuf.h | 15 ++++++++--
 arch/mips/include/uapi/asm/shmbuf.h | 23 +++++++++++++--
 4 files changed, 92 insertions(+), 41 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 3e548ee99a2f..2e058c4d63a3 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -157,35 +157,35 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t	sem_otime;
-	compat_time_t	sem_ctime;
+	compat_ulong_t	sem_otime;
+	compat_ulong_t	sem_ctime;
 	compat_ulong_t	sem_nsems;
-	compat_ulong_t	__unused1;
-	compat_ulong_t	__unused2;
+	compat_ulong_t	sem_otime_high;
+	compat_ulong_t	sem_ctime_high;
 };
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused1;
+	compat_ulong_t	msg_stime_high;
 #endif
-	compat_time_t	msg_stime;
+	compat_ulong_t	msg_stime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused1;
+	compat_ulong_t	msg_stime_high;
 #endif
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused2;
+	compat_ulong_t	msg_rtime_high;
 #endif
-	compat_time_t	msg_rtime;
+	compat_ulong_t	msg_rtime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused2;
+	compat_ulong_t	msg_rtime_high;
 #endif
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused3;
+	compat_ulong_t	msg_ctime_high;
 #endif
-	compat_time_t	msg_ctime;
+	compat_ulong_t	msg_ctime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused3;
+	compat_ulong_t	msg_ctime_high;
 #endif
 	compat_ulong_t	msg_cbytes;
 	compat_ulong_t	msg_qnum;
@@ -199,14 +199,16 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t	shm_segsz;
-	compat_time_t	shm_atime;
-	compat_time_t	shm_dtime;
-	compat_time_t	shm_ctime;
+	compat_ulong_t	shm_atime;
+	compat_ulong_t	shm_dtime;
+	compat_ulong_t	shm_ctime;
 	compat_pid_t	shm_cpid;
 	compat_pid_t	shm_lpid;
 	compat_ulong_t	shm_nattch;
-	compat_ulong_t	__unused1;
-	compat_ulong_t	__unused2;
+	compat_ushort_t	shm_atime_high;
+	compat_ushort_t	shm_dtime_high;
+	compat_ushort_t	shm_ctime_high;
+	compat_ushort_t	__unused2;
 };
 
 /* MIPS has unusual order of fields in stack_t */
diff --git a/arch/mips/include/uapi/asm/msgbuf.h b/arch/mips/include/uapi/asm/msgbuf.h
index eb4d0f9d7364..46aa15b13e4e 100644
--- a/arch/mips/include/uapi/asm/msgbuf.h
+++ b/arch/mips/include/uapi/asm/msgbuf.h
@@ -9,33 +9,15 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - extension of time_t to 64-bit on 32-bitsystem to solve the y2038 problem
  * - 2 miscellaneous unsigned long values
  */
 
+#if defined(__mips64)
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused1;
-#endif
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused2;
-#endif
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused3;
-#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
@@ -44,5 +26,42 @@ struct msqid64_ds {
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
+#elif defined (__MIPSEB__)
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#elif defined (__MIPSEL__)
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#else
+#warning no endianess set
+#endif
 
 #endif /* _ASM_MSGBUF_H */
diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi/asm/sembuf.h
index 2c0f507ab7d1..cbd19e0f0630 100644
--- a/arch/mips/include/uapi/asm/sembuf.h
+++ b/arch/mips/include/uapi/asm/sembuf.h
@@ -7,10 +7,11 @@
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
+ * Pad space is left for 2 miscellaneous 64-bit values on mips64,
+ * but used for the upper 32 bit of the time values on mips32.
  */
 
+#ifdef __mips64
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 	__kernel_time_t sem_otime;		/* last semop time */
@@ -19,5 +20,15 @@ struct semid64_ds {
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
+#else
+struct semid64_ds {
+	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
+	unsigned long   sem_otime;		/* last semop time */
+	unsigned long   sem_ctime;		/* last change time */
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime_high;
+};
+#endif
 
 #endif /* _ASM_SEMBUF_H */
diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index 379e6bca518b..9b9bba3401f2 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -7,10 +7,13 @@
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
- * Pad space is left for:
- * - 2 miscellaneous 32-bit rsp. 64-bit values
+ * As MIPS was lacking proper padding after shm_?time, we use 48 bits
+ * of the padding at the end to store a few additional bits of the time.
+ * libc implementations need to take care to convert this into a proper
+ * data structure when moving to 64-bit time_t.
  */
 
+#ifdef __mips64
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
@@ -23,6 +26,22 @@ struct shmid64_ds {
 	unsigned long		__unused1;
 	unsigned long		__unused2;
 };
+#else
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned short		shm_atime_high;
+	unsigned short		shm_dtime_high;
+	unsigned short		shm_ctime_high;
+	unsigned short		__unused1;
+};
+#endif
 
 struct shminfo64 {
 	unsigned long	shmmax;
-- 
2.9.0
