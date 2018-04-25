Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeDYPC1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:02:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbeDYPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:02:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 02/16] y2038: x86: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 17:01:53 +0200
Message-Id: <20180425150207.822862-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:fCYSZwkRaNOlZu2wAfNQLC9N2tMzFr5O5MPzE7ITJ1U6sKMz26B
 MbmETxvs7kojAPjX6cfYd9zN3HGTFhfW8pX2hJDup4sx3EPpeTXs6nFjXu6Yd/8SFZG5CkC
 X27SHCbqr/Q/ugYdReg5NpK34ziUSKGDnLUteu9UIcW4N31AjiIABzRcKVkg00q7d8qy+sq
 5S0LhzFXUtp7TPFNZHhgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NoRwSp5m4HA=:sAltlblqydO5X3bb7dbOZ9
 bS3Q60RuQ6box9PqzP90e0FETsPw+UJKVrTN7e4Ffq7Og2OhWT+0nEy58glcuDai2IOQFnpeL
 orhkTCbBUqNtqib/Zsr8juu3HQuj3OljrbJt7mgVZycBrBzdXONrqRltfqIjo2fKS5ViYq4uK
 02Z5HS1njsErlyehdrq4/wGt0RF+WekmAU2a9Ir+0M6hZt+AwUtbo5Rxe3oyxaBoEdcK1xULs
 pXsW2iLPYwcLM8LuZEpAoI0fz3yiutGglCSP8eC2tborIW1+xm3hUcjaIMKRLgJYVSgCJUYW8
 gKyIm1nYAtnVBywkN5cLpGvYDWfxZ2MBTjY0PnRfjW2MsV3Ug0ikkIiiPj+ux1xyqR9T4ewIO
 2S7r7GfhaqHUImMSNbPNR3cZS2Kk8Og4xWZWBdZ5cBs75bPIRteFnHHeVxak9ngyluHTbHNDE
 Ze0KY57dLg4aS7eDhVRJ2br8L8OPmitW7SgkfwYYpTM5wTd9t/iWdmnlwNMrnOPXpz4nOVuJa
 7gb15zjuVFc435KZ4X9TUrksA6g3Rd0OwlkHKKswPN4BV63EpgY8YgTUvINGi9MBStQsqfAke
 0DcysAGF1T7KN0Tx/8wk9f8xNDCFXH3Z8s5tDc8PirANBOceeXC9teqohpEZ0Tib0/MNkumaA
 4D2xoykecb1I1bhK+WXJkFkkrzAo0KuNtc9M4WWO89cWz/TzOMo/5XY4zLnpGKgJTklGkTaWr
 dOzEVovIShYwmCXpOeyYLYLlXX7KUeS3Qh6atw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the x86 copy of the sysvipc data structures to deal with
32-bit user space that has 64-bit time_t and wants to see timestamps
beyond 2038.

Fortunately, x86 has padding for this purpose in all the data structures,
so we can just add extra fields. With msgid64_ds and shmid64_ds, the
data structure is identical to the asm-generic version, which we have
already extended.

For some reason however, the 64-bit version of semid64_ds ended up with
extra padding, so I'm implementing the same approach as the asm-generic
version here, by using separate fields for the upper and lower halves
of the two timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/x86/include/uapi/asm/sembuf.h | 11 ++++++++++-
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 7cd314b71c51..fb97cf7c4137 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -134,10 +134,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -145,12 +145,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -163,12 +163,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index cabd7476bd6c..89de6cd9f0a7 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -8,15 +8,24 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
+ *
+ * x86_64 and x32 incorrectly added padding here, so the structures
+ * are still incompatible with the padding on x86.
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#ifdef __i386__
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
 	__kernel_ulong_t __unused1;
 	__kernel_time_t	sem_ctime;	/* last change time */
 	__kernel_ulong_t __unused2;
+#endif
 	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
 	__kernel_ulong_t __unused3;
 	__kernel_ulong_t __unused4;
-- 
2.9.0
