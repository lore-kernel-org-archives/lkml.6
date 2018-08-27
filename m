Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6265C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2A208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D2A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeH0XeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:34:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeH0XeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:34:00 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lw14n-1frRWg1WAP-017mKc; Mon, 27 Aug 2018 21:45:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/14] y2038: Compile utimes()/futimesat() conditionally
Date:   Mon, 27 Aug 2018 21:45:27 +0200
Message-Id: <20180827194531.3796559-11-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ldLBwGAtBnHShU1CkbDcC05BCQC5chbQv0lvadM0afTqQvYpGgV
 CxEZ0iX+6eHDdyGySydvWlaB7MwDapGG0/LBsi/uhbOsquXIuKpG8ri3nJxeQwl26Rnnsdt
 +qjVudtA6z0slDvZ7vI+71tw4QPOXHjDGImT9QupsvmeLJhfrGfixenaUTduyJUve/2kb09
 FSSH+sPHrccZHdI/VfHjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8wkNAu5Y9qM=:+sXHvKu8MAjBq1NWfsZIl/
 40oJaMB3XYk84YGtjJjuEXYTE/shmGe4tzVDruXbVPIPWGesduzMBvw3hW45o95UBX8lX96ZO
 OsFFZPuVYAVS0MU/A5al7bL77CZqKS2wOA6oxgCgYUp1TC1BArHg49xs6cwD9Vj1B3HCxwpsX
 Zcj1Z6BE+FNCvU+Qlb+BOz7YKMjBMmvgJ7IBl/R/An4CU9RQZOeWqqFs2BmTFfe7dUavuJoEx
 MIBOQ3yDdCDv1blPrE4zhotswDMMF3oJNefPWt54syp2vjVfwNNns4lD7Kd6K5BwZjKJtCHDh
 JyfqaIIzlrWiQ00s75EB9jDEsZC8DoXe8geCdZUkOthA49xw/jkdVPHXb/haLivSV4JZTrm21
 fFvmx3vdn7Zf3/PdQFkR1WqdtmUFonsxtk4kgGcEIGBPhXQyIGTecjnF0Xqd1+a2LgFVAvkwh
 5sL1G8+1kV5z0alHR9w2C3jWRHspsEm0arbLaRQeVr61BQ0+VGO/8zpTPirlZ4I33y3W/sOUH
 nV+ZJiK8ehEH0NO9hbZngLs9JrEHhLZMkTGi4cApuDoCLOXnOn4SH3NSNqBsJFAwlBvOz72t+
 fpt9jb/7WULSRB6kGI2ZZ+Ck30fMJVBkiCK8Yn0Hv+8YYnJLBV7ML45frIC9u1y4/Ceo91Mgc
 70NvJLPKPQkQq1WBUMICoVIg8E4yJf2tvcgQoy0g41UjevmCpWON8gYshszPN1prxQ0A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four generations of utimes() syscalls: utime(), utimes(),
futimesat() and utimensat(), each one being a superset of the previous
one. For y2038 support, we have to add another one, which is the same
as the existing utimensat() but always passes 64-bit times_t based
timespec values.

There are currently 10 architectures that only use utimensat(), two
that use utimes(), futimesat() and utimensat() but not utime(), and 11
architectures that have all four, and those define __ARCH_WANT_SYS_UTIME
in order to get a sys_utime implementation. Since all the new
architectures only want utimensat(), moving all the legacy entry points
into a common __ARCH_WANT_SYS_UTIME guard simplifies the logic. Only alpha
and ia64 grow a tiny bit as they now also get an unused sys_utime(),
but it didn't seem worth the extra complexity of adding yet another
ifdef for those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h |  1 +
 arch/arm/include/asm/unistd.h   |  2 +-
 arch/ia64/include/asm/unistd.h  |  1 +
 fs/utimes.c                     | 51 ++++++++++++++-------------------
 include/linux/syscalls.h        | 10 ++++---
 5 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index edc090470023..9ff37aa1165f 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -14,6 +14,7 @@
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 8f1159c26f20..88ef2ce1f69a 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -26,13 +26,13 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_OLD_MMAP
 #define __ARCH_WANT_SYS_OLD_SELECT
+#define __ARCH_WANT_SYS_UTIME
 
 #if !defined(CONFIG_AEABI) || defined(CONFIG_OABI_COMPAT)
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_ALARM
-#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_SOCKETCALL
diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index c5b2620c4a4c..49e34db2529c 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -29,6 +29,7 @@
 #define __IGNORE_umount2	/* umount() */
 
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SYS_UTIME
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff --git a/fs/utimes.c b/fs/utimes.c
index d30f409ecc1a..2f6f08061a26 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -8,35 +8,6 @@
 #include <linux/compat.h>
 #include <asm/unistd.h>
 
-#ifdef __ARCH_WANT_SYS_UTIME
-
-/*
- * sys_utime() can be implemented in user-level using sys_utimes().
- * Is this for backwards compatibility?  If so, why not move it
- * into the appropriate arch directory (for those architectures that
- * need it).
- */
-
-/* If times==NULL, set access and modification to current time,
- * must be owner or have write permission.
- * Else, update from *times, must be owner or super user.
- */
-SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
-{
-	struct timespec64 tv[2];
-
-	if (times) {
-		if (get_user(tv[0].tv_sec, &times->actime) ||
-		    get_user(tv[1].tv_sec, &times->modtime))
-			return -EFAULT;
-		tv[0].tv_nsec = 0;
-		tv[1].tv_nsec = 0;
-	}
-	return do_utimes(AT_FDCWD, filename, times ? tv : NULL, 0);
-}
-
-#endif
-
 static bool nsec_valid(long nsec)
 {
 	if (nsec == UTIME_OMIT || nsec == UTIME_NOW)
@@ -184,6 +155,13 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, flags);
 }
 
+#ifdef __ARCH_WANT_SYS_UTIME
+/*
+ * futimesat(), utimes() and utime() are older versions of utimensat()
+ * that are provided for compatibility with traditional C libraries.
+ * On modern architectures, we always use libc wrappers around
+ * utimensat() instead.
+ */
 static long do_futimesat(int dfd, const char __user *filename,
 			 struct timeval __user *utimes)
 {
@@ -225,6 +203,21 @@ SYSCALL_DEFINE2(utimes, char __user *, filename,
 	return do_futimesat(AT_FDCWD, filename, utimes);
 }
 
+SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
+{
+	struct timespec64 tv[2];
+
+	if (times) {
+		if (get_user(tv[0].tv_sec, &times->actime) ||
+		    get_user(tv[1].tv_sec, &times->modtime))
+			return -EFAULT;
+		tv[0].tv_nsec = 0;
+		tv[1].tv_nsec = 0;
+	}
+	return do_utimes(AT_FDCWD, filename, times ? tv : NULL, 0);
+}
+#endif
+
 #ifdef CONFIG_COMPAT
 /*
  * Not all architectures have sys_utime, so implement this in terms
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 420ac881a610..95e795fb0593 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -955,8 +955,6 @@ asmlinkage long sys_access(const char __user *filename, int mode);
 asmlinkage long sys_rename(const char __user *oldname,
 				const char __user *newname);
 asmlinkage long sys_symlink(const char __user *old, const char __user *new);
-asmlinkage long sys_utimes(char __user *filename,
-				struct timeval __user *utimes);
 #if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
 asmlinkage long sys_stat64(const char __user *filename,
 				struct stat64 __user *statbuf);
@@ -986,14 +984,18 @@ asmlinkage long sys_alarm(unsigned int seconds);
 asmlinkage long sys_getpgrp(void);
 asmlinkage long sys_pause(void);
 asmlinkage long sys_time(time_t __user *tloc);
+#ifdef __ARCH_WANT_SYS_UTIME
 asmlinkage long sys_utime(char __user *filename,
 				struct utimbuf __user *times);
+asmlinkage long sys_utimes(char __user *filename,
+				struct timeval __user *utimes);
+asmlinkage long sys_futimesat(int dfd, const char __user *filename,
+			      struct timeval __user *utimes);
+#endif
 asmlinkage long sys_creat(const char __user *pathname, umode_t mode);
 asmlinkage long sys_getdents(unsigned int fd,
 				struct linux_dirent __user *dirent,
 				unsigned int count);
-asmlinkage long sys_futimesat(int dfd, const char __user *filename,
-			      struct timeval __user *utimes);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-- 
2.18.0

