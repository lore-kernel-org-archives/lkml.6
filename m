Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDLOWj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:22:39 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeDLOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 04/13] y2038: s390: remove unneeded ipc uapi header files
Date: Thu, 12 Apr 2018 16:20:15 +0200
Message-Id: <20180412142024.853892-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:TWBxdmfQkFPtPBIshMFdO+ksugnB6idjxl98LpC3qI7P3sctBjL
 9ZPcFKR2L3Fhn4YBDR4WtMfycCg4Pgrz1zDM0WpoHMPaIffldBNwFxFXZt3ySOHI00nM0dm
 eE7zM740jcbZie6F4yhJocdt8FQ97vPX6IpcML/w62WdrS+0sfqri+YsuvFfGI4Go0WNeAn
 4nqxovSiosW6fNSzxeM/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+aUnCEFwi1M=:g0iDMQN2sTEIv0o70dJwXM
 DFKic6kH8rDOaNfTvpLfrTLmoTMoeeHeY/9ze+aRP4YnyWEwmVKHo1b53CeHIYtCtFrNzX3jz
 IHdAHgdhECy4y0BR/jD25iuLQ7LsvlKczeX1dkj1Z6Mju+iNaARiGZrgLRp0mNoRufAkqsuDj
 LqzriOURcEuOrnsn5Kde1bOQtPMnPbKLx+GdURIZgEMGcKSLkFrUpOakOO03C4TYlbBksCFG4
 qjjeOXsMzMKNT5jrziUDZCvdN/qROKqhZTNjID+ztpdjFT9hMd0rT6hSFJ1gn61v4PluyWGxd
 MquqyyzR8e+hlr1GeCrbI9agSPRkWa3TEwnsXB0W6qii26mOW9WKtB74DsqF6qXNkNedrrIkf
 f4Vd4d0pHGgpX1I1HVVg50MnCQ/yYjEupAbpKoq4xHaNFLcL63a5PAL+zOgSIUp/FigRnlIqA
 3iVo9h62gbuaEAnOc3IL9iBBLciZ9PaQpjjzQtF65AhLj6EHimJ/scvc46+M6cDPQ08uYYzoA
 Nf0Ol47uCwcj6omR+FdasHV4lZiut7fhmCrhO4wCEe43alKVsb/JzXWWXCgTB88+0swcimYSi
 jAjRoWuo2T3Fn3x3swiqV2DmIN1LTTmJlqeZKYFQQlyxVj7NFMBFZZfmYLxAx483zq+Jfn/C2
 MUucQnqZkUvIZGcfKeqNnfcjxHSqDDuj8Ri5vKghxoXe5djOGDaa8JkjnYzIXKzcwoXi0eJFM
 jjIKUHfE8TTphwEdnxmzacRbU/TpLaxoudUULQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s390 msgbuf/sembuf/shmbuf header files are all identical to the
version from asm-generic.

This patch removes the files and replaces them with 'generic-y'
statements, to avoid having to modify each copy when we extend sysvipc
to deal with 64-bit time_t in 32-bit user space.

Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
different here, so I'm leaving the private copy.

To deal with 32-bit compat tasks, we also have to adapt the definitions
of compat_{shm,sem,msg}id_ds to match the changes to the respective
asm-generic files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/Kbuild        |  3 +++
 arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
 arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
 arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
 arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
 5 files changed, 19 insertions(+), 133 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
 delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e3239772887a..d8ca80f081a7 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -20,8 +20,11 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msgbuf.h
 generic-y += preempt.h
 generic-y += rwsem.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += word-at-a-time.h
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 501aaff85304..97db2fba546a 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -232,10 +232,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __pad1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __pad2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused1;
 	compat_ulong_t __unused2;
@@ -243,12 +243,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t   msg_stime;
-	compat_ulong_t __pad1;
-	compat_time_t   msg_rtime;
-	compat_ulong_t __pad2;
-	compat_time_t   msg_ctime;
-	compat_ulong_t __pad3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -261,12 +261,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __pad1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __pad2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __pad3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/s390/include/uapi/asm/msgbuf.h b/arch/s390/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 604f847cd68c..000000000000
--- a/arch/s390/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_MSGBUF_H
-#define _S390_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __s390x__
-	unsigned long	__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __s390x__
-	unsigned long	__unused2;
-#endif /* ! __s390x__ */
-	__kernel_time_t msg_ctime;	/* last change time */
-#ifndef __s390x__
-	unsigned long	__unused3;
-#endif /* ! __s390x__ */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-#endif /* _S390_MSGBUF_H */
diff --git a/arch/s390/include/uapi/asm/sembuf.h b/arch/s390/include/uapi/asm/sembuf.h
deleted file mode 100644
index 3e917697b668..000000000000
--- a/arch/s390/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_SEMBUF_H
-#define _S390_SEMBUF_H
-
-/* 
- * The semid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem (for !__s390x__)
- * - 2 miscellaneous 32-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-#ifndef __s390x__
-	unsigned long	__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t	sem_ctime;		/* last change time */
-#ifndef __s390x__
-	unsigned long	__unused2;
-#endif /* ! __s390x__ */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _S390_SEMBUF_H */
diff --git a/arch/s390/include/uapi/asm/shmbuf.h b/arch/s390/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 9cdce8d7ce60..000000000000
--- a/arch/s390/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_SHMBUF_H
-#define _S390_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem (for !__s390x__)
- * - 2 miscellaneous 32-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __s390x__
-	unsigned long		__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __s390x__
-	unsigned long		__unused2;
-#endif /* ! __s390x__ */
-	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __s390x__
-	unsigned long		__unused3;
-#endif /* ! __s390x__ */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _S390_SHMBUF_H */
-- 
2.9.0
