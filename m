Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbeDYNXU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:23:20 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeDYNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:23:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 15/16] y2038: ipc: Enable COMPAT_32BIT_TIME
Date: Wed, 25 Apr 2018 15:22:41 +0200
Message-Id: <20180425132242.1500539-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:+3kf9/B378gkx7URUEwAHGXUPS2r3wBwqt5jzmV1+VpV8zOFED5
 7AXAL1PL9ZSTHH4ik5jTrl1yjLWBa/WofrowkPyJZMdjYG10+5zBdazBjU1Cho+2/Mbg7Ww
 mv2v+OVCsb/WWH56mIivALkCb5KQ3Ay7rnNuru/2j1IZ6R66iJ6dwfHfA4U0GMOEh9ae0nz
 QK+udas/unISRfOGl29Ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lS8IKBb8TVQ=:v55OrTgV79AukyB1FrRjQL
 VtpZrgv6HAzbZPH8EDnzPPQYFc+AgxlyWrn+js1f8fwZ+uKEUBbuDn60fdEC3UvGgGtqtYfWK
 WJt6tkD3JINZrwu2mtDA0dOo33vhQZXDTDaEyVUv/+48ux+owEWoH6Y71UPohT5bJ55mOee8c
 oq5I1/odji6zXTpeGGk+TZ8kx6OIFCWuYXbiDIDYjyAymt0Fp2mDYq3VC9mnA8zAGnEvY6N1e
 pJPbLYrNZ/ZTODAo2m58XFYbYgetXAq+u0+xr72udMIMJrsFBvz8RRmyg1g3PTEOL6bCj4LzC
 UgQ15K0gEEZIl2MhcIZqwJbEVfInu1yN3I62yeVTM6BJLcNj9PrcRxHQFKnR/IsCKuAnsAGVv
 nNmCP/mstt5vfrn2/C47cOgyn5UzkQ/WzPR/xYcGBqA4dF0zzwXDacNfDXbIo01+MCJ9Z3Sy8
 NfoDtB5brj7iGM/HEb/g1e4z5otasCSw1ntvHOJjkOTF+O20iaQ/fTls8INqxVzlfShT0WIVM
 mIBVhAvEsEg1W3iSMuG4KWx3NtcNaiwH8N9FMorjurp9qHaHbhQle9b9PREqZVPxETy2zzfg9
 NJ+GBs8LLnaLHsueZu8Nr74JogMzm9STbde0Ozc+L/GhGPtKRv2uHhoiAhiAaLu7JTwyStOds
 vFnN1eZ3jWhX6wihlmzrZuCg5CEw5h8fvY0iks43rwgV8NgZ7ycgKzQCuYg97/K3Kjn0XcZIW
 qawTSm6wYpHc2lv4173QIvwvpdfLs4c5d6ycUg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three ipc syscalls (mq_timedsend, mq_timedreceive and and semtimedop)
take a timespec argument. After we move 32-bit architectures over to
useing 64-bit time_t based syscalls, we need seperate entry points for
the old 32-bit based interfaces.

This changes the #ifdef guards for the existing 32-bit compat syscalls
to check for CONFIG_COMPAT_32BIT_TIME instead, which will then be
enabled on all existing 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/mqueue.c | 80 +++++++++++++++++++++++++++++++-----------------------------
 ipc/sem.c    |  3 ++-
 ipc/util.h   |  2 +-
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 9610afcfa2e5..c0d58f390c3b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1420,6 +1420,47 @@ COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 	return do_mq_open(u_name, oflag, mode, p);
 }
 
+COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
+		       const struct compat_sigevent __user *, u_notification)
+{
+	struct sigevent n, *p = NULL;
+	if (u_notification) {
+		if (get_compat_sigevent(&n, u_notification))
+			return -EFAULT;
+		if (n.sigev_notify == SIGEV_THREAD)
+			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
+		p = &n;
+	}
+	return do_mq_notify(mqdes, p);
+}
+
+COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
+		       const struct compat_mq_attr __user *, u_mqstat,
+		       struct compat_mq_attr __user *, u_omqstat)
+{
+	int ret;
+	struct mq_attr mqstat, omqstat;
+	struct mq_attr *new = NULL, *old = NULL;
+
+	if (u_mqstat) {
+		new = &mqstat;
+		if (get_compat_mq_attr(new, u_mqstat))
+			return -EFAULT;
+	}
+	if (u_omqstat)
+		old = &omqstat;
+
+	ret = do_mq_getsetattr(mqdes, new, old);
+	if (ret || !old)
+		return ret;
+
+	if (put_compat_mq_attr(old, u_omqstat))
+		return -EFAULT;
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 static int compat_prepare_timeout(const struct compat_timespec __user *p,
 				   struct timespec64 *ts)
 {
@@ -1459,45 +1500,6 @@ COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
 	}
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
-
-COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
-		       const struct compat_sigevent __user *, u_notification)
-{
-	struct sigevent n, *p = NULL;
-	if (u_notification) {
-		if (get_compat_sigevent(&n, u_notification))
-			return -EFAULT;
-		if (n.sigev_notify == SIGEV_THREAD)
-			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
-		p = &n;
-	}
-	return do_mq_notify(mqdes, p);
-}
-
-COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
-		       const struct compat_mq_attr __user *, u_mqstat,
-		       struct compat_mq_attr __user *, u_omqstat)
-{
-	int ret;
-	struct mq_attr mqstat, omqstat;
-	struct mq_attr *new = NULL, *old = NULL;
-
-	if (u_mqstat) {
-		new = &mqstat;
-		if (get_compat_mq_attr(new, u_mqstat))
-			return -EFAULT;
-	}
-	if (u_omqstat)
-		old = &omqstat;
-
-	ret = do_mq_getsetattr(mqdes, new, old);
-	if (ret || !old)
-		return ret;
-
-	if (put_compat_mq_attr(old, u_omqstat))
-		return -EFAULT;
-	return 0;
-}
 #endif
 
 static const struct inode_operations mqueue_dir_inode_operations = {
diff --git a/ipc/sem.c b/ipc/sem.c
index b951e25ba2db..cfd94d48a9aa 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -70,6 +70,7 @@
  *   The worst-case behavior is nevertheless O(N^2) for N wakeups.
  */
 
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
@@ -2193,7 +2194,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout)
diff --git a/ipc/util.h b/ipc/util.h
index 975c6de2df9d..0aba3230d007 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -265,10 +265,10 @@ long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
-#ifdef CONFIG_COMPAT
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
+#ifdef CONFIG_COMPAT
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
-- 
2.9.0
