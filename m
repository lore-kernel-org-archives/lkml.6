Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbeDYNXE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:23:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeDYNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:22:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 02/16] y2038: x86: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 15:22:28 +0200
Message-Id: <20180425132242.1500539-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:hwYzL4dDm+VjP2fGL4HeIgBy60kDoGpFzOynzUKe165fDM1G5Qo
 cnUIMvk3z+AZCeTBHqO0MmqMKHB/DzFiMKL3uxm7+Uj4FATIs5zZMl0bMaYyCMdOsy2wWOJ
 lQfpHJ8ggyRCDSbcHp5T3bLrfxilTNX/znzj0gi2B8+JM4AQQuW1jm3p1OWIoM2ZiaRsWpl
 fr8ypqq61KfWxLOjnHqJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N4kpLiWWGE8=:pSl4pJ9bQi+Shh2D5MTXJq
 4hrKxuobSwAz/Ypl0BLlKGelIdic/Wpx/IT4a+OHGiEg0NAtYmsh5qWIe4K5h5ff3FOmL7uBJ
 8ihQvQ+qANGEosJAPrLDGUY7y8EEd4WXF1wpnz9R35Yj2kwc4UGo63iu/AX4BLb4pIfg+4R4H
 8vGiasQhxiMZyGgIZWXinzH/8EMwBQe4DkCB+pqy3xYorT1rKT9dTZKj74skL9ItseB1dkUQo
 tHujaB3b6BELbXupuK5xB6wIDSfDB5I6n0+cwLYV8teLGAd0rI4Ih8h+PjT3qVjgcPD7Ih0xm
 Bp79AghsUbRX3vW6bQtIWFZ7O82AcRkRZo2ixG8VxBhgbw8KOLIGBK5NgSwqQ7E6uUwfcXFBZ
 3IjLUtxM6HNxwJfOtI+3flJCSk7eiGjGahanEtOI/u10fYt0OvXL2m815WxLgxQiZaVv8CK+y
 +jDPTl8sJXdHR/8fQkSV7Vr6rSDv/4SxIppDxhb731+qZkcqYBRzT5iXuNFrXnVg7RFrxwK/9
 P++P+FiVHzXuDpzC2/JeIGaFyu8p0HcpeeZL1WRgjxis/M1dx8QIQ/KdMZrZ/jGDmBlibyEZM
 MfXXx6Q+YbQTEQHLwYFJyBLQulRaEYpZEhEGHBy3NLnjlW4AyPGWKdxqtiFi7kPkD8Q8vxWyj
 lVFd6QY4zantOlnU0sjgrVO6A8NGo1taKp88cuIuSmy8Yuq95c32i4vMcFCC10ELza9NQEOnW
 0SqgtESBnijyxuOS5gDS6HW2fnVvlyihEKtn3g==
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
