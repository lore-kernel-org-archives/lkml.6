Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeDLOWk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:22:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDLOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 07/13] y2038: x86: extend sysvipc data structures
Date: Thu, 12 Apr 2018 16:20:18 +0200
Message-Id: <20180412142024.853892-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Gvkx1Iu8HYLWwq7+CQ5Z+JteBlAM+Mz2RC4NGYCcXWf3JshGLHV
 JG64B7ryHRfaqQmdlZU+XOp+aECv0dqUWqfKd+7xYPhdqsXJ6V7YwTI3HFMPdj8+1GWLrEI
 jS2KXQDdj3rhKTErFpg5rfNXKeDIy/MT92i7h+UWOnmn152NCLXwnkCyeKyqtom90QbOMSA
 xrpQNnqqomiJEkXljLxWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sJ4u8su0Pik=:w/GmMoseokDNzWubRb+ish
 SIHmp4ZCdWxdL29KxgNPIfggDnXCqOm4CmvqZKX0eYe4fRJ21g1B7GNJvYz7TR63rlAZ5QrRS
 3jeVICAs9ns8xD3VT6ABe/uRwJFlJPXlCBG0zWDkwoQo2Ey0ocXlN9RVlut3/QAF2ehtfv5eH
 pNs9K5atQDzQHxc7u1KRHDXHJq3vqWxeHwTY8S5+8B6wDk2LxdEpXzr54o9UDyckJ+ehogOyL
 pIbfob/gExtuijS2Waj3HBdjhgqG2/lzITt7x7EEXSP6xU8FjnzJ2JCwnI6nANIzv1fNroaK8
 htsT+mZhbnN5jXJLMik3AfWM+hMxYzaAZyy4y0hjQF2lemj8tjocJ3BLPKaD31fFXnCiVOFLv
 E5vjbrW4I/5gqiQl/BcEPnYKQd7UYD6BESUF+SEw3eBW5ylr1m0LpdynwgvOUkRXXKRmzG5yd
 0pjMPXR7ILCtAlUiOgKNQ1dCfFJ8I3fH5QYcLAH4DT/JGJO+Vl+DuLmiPGMSk6OBPphS2+Nzj
 Jbsf7oXfXmYHOiTkIj79X6gSwQb7uCHcWNVfcpYCcHbUYV2Vb4gHRhrR3iZ7gxTScXa/DQ5A7
 Ny1gToFnqw0JQHRU4hcSF+2SXTaXbQnk/ssu4XKMMel1lHYHTukcos53tPcewca7T8UWxWbtK
 3BS07aFV+OLqeA+VlE2C+Wlgr87GGz4JIE3ABhJyF6MmnaHt7ldzJmALGzbX/k3IiELOKVdau
 di59pXB5YgDXQuphJFopk8Ndxm4wNnhKaRwrFQ==
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
 arch/x86/include/uapi/asm/Kbuild   |  5 ++++-
 arch/x86/include/uapi/asm/msgbuf.h |  1 -
 arch/x86/include/uapi/asm/sembuf.h | 11 ++++++++++-
 arch/x86/include/uapi/asm/shmbuf.h |  1 -
 5 files changed, 30 insertions(+), 20 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/x86/include/uapi/asm/shmbuf.h

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
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 322681622d1e..d1d883e304f7 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -2,7 +2,10 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += shmbuf.h
+
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
-generic-y += poll.h
diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 809134c644a6..000000000000
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/msgbuf.h>
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
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 83c05fc2de38..000000000000
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/shmbuf.h>
-- 
2.9.0
