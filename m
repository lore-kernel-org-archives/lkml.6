Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FE8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25AB208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25AB208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeH0Xdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeH0Xdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:50 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M73gb-1fgOuX1pbR-00wp38; Mon, 27 Aug 2018 21:45:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/14] y2038: socket: Change recvmmsg to use __kernel_timespec
Date:   Mon, 27 Aug 2018 21:45:30 +0200
Message-Id: <20180827194531.3796559-14-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:V7XQZl/ZW81NfyBSLXtTx6Jd2VYw1T3PcNZLy3/zcKCVKE9TsTG
 MrL5oHyvdviiYMXRqro6oD2iHv0Qb2gyWygNsKMspFNy3ANSGzQkP9cBBPdtJ+TSV4FOpPD
 4Ls+28sfWTuWmtgv57FPhCGvJwE50NF1WtJCvhRVxQOnQH8yUYSu5m2cxeSipJ4O3ZT3uPE
 4CtdNnGpaJ3KMEMBlJmYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o+GhUvvZZsk=:OAa5iFyoQhNLOLn8C/lsRz
 IFjuXBxLVZtmtNg4uTzbkPzaahDhamX5EwHybWBJsQHHZOa6sVhqkvxH7Ao20V6DWck9RJN+V
 6EF0jQc6UPmPs9wq1BQs8jdvaOrsFF7jbwwz20dMe2UdbRPlJHtdmmrs2hogVhge+tXGZKkqB
 64NWTCvli18aep74XbhysCZbW2pdMAehVZqfeeLq7LU2r1tqCLUgo6QrkRsXEfU6dOnjglcyZ
 zmAtBSo2UHRbBRpCzXgUh1CHH4PRnDT5HWCbG7Ir6J3beru7hTnj7KyT1I07KwatHB+LAeiXb
 juxcL4kmcV+YN3N7O+K6sATd144roeoYdjN8BNFs2JschtVEojvSpRByqIXvwPUEFVEvyDUoE
 Po8yAt/MmTsAaEmYZdunQ7OUAuQ6fXB7pcrGl7nGfg2sqSGz30k6YMK71WaeQ9gnhdfEME4Jq
 L+iV1ZJmdeinSaoI1+L3CQ3vlSCOWcVgCxQRjJc67AMExXDGBY5j+UYF9sw2WYDYxiIALEj6w
 0m+rZ3yvy6gWVJtLcjFTDa/zJzBjEBkX4GQ8HS8Mg0n+jfH0c5rO8QjlIIRL43U7f6mhoaGuR
 DRjmW51iH3U129ahKANVvDcYvgE0zczHEYfxcJB41OE+Quogj8xk/9fB5cPQ7JhYTty81fVB7
 sF0CFmZI5Whw5E+fvFtMq1cC4EWY4VqQNvdzA6dtzu+yH16dp4AVk9+og/GIrp4/4t68=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the recvmmsg() system call in all its variations to use
'timespec64' internally for its timeout, and have a __kernel_timespec64
argument in the native entry point. This lets us change the type to use
64-bit time_t at a later point while using the 32-bit compat system call
emulation for existing user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/socket.h   |  4 ++--
 include/linux/syscalls.h |  2 +-
 net/compat.c             |  6 +++---
 net/socket.c             | 18 ++++++++----------
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7ed4713d5337..8b571e9b9f76 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -348,7 +348,7 @@ struct ucred {
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
-struct timespec;
+struct timespec64;
 
 /* The __sys_...msg variants allow MSG_CMSG_COMPAT iff
  * forbid_cmsg_compat==false
@@ -358,7 +358,7 @@ extern long __sys_recvmsg(int fd, struct user_msghdr __user *msg,
 extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
 			  unsigned int flags, bool forbid_cmsg_compat);
 extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-			  unsigned int flags, struct timespec *timeout);
+			  unsigned int flags, struct timespec64 *timeout);
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  bool forbid_cmsg_compat);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5642016a312d..fb3a05fab8aa 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -830,7 +830,7 @@ asmlinkage long sys_perf_event_open(
 asmlinkage long sys_accept4(int, struct sockaddr __user *, int __user *, int);
 asmlinkage long sys_recvmmsg(int fd, struct mmsghdr __user *msg,
 			     unsigned int vlen, unsigned flags,
-			     struct timespec __user *timeout);
+			     struct __kernel_timespec __user *timeout);
 
 asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
 				int options, struct rusage __user *ru);
diff --git a/net/compat.c b/net/compat.c
index 2ef160876bc1..47a614b370cd 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -815,18 +815,18 @@ static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				 struct old_timespec32 __user *timeout)
 {
 	int datagrams;
-	struct timespec ktspec;
+	struct timespec64 ktspec;
 
 	if (timeout == NULL)
 		return __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				      flags | MSG_CMSG_COMPAT, NULL);
 
-	if (compat_get_timespec(&ktspec, timeout))
+	if (compat_get_timespec64(&ktspec, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				   flags | MSG_CMSG_COMPAT, &ktspec);
-	if (datagrams > 0 && compat_put_timespec(&ktspec, timeout))
+	if (datagrams > 0 && compat_put_timespec64(&ktspec, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
diff --git a/net/socket.c b/net/socket.c
index e6945e318f02..b9d71b503720 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2340,7 +2340,7 @@ SYSCALL_DEFINE3(recvmsg, int, fd, struct user_msghdr __user *, msg,
  */
 
 int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-		   unsigned int flags, struct timespec *timeout)
+		   unsigned int flags, struct timespec64 *timeout)
 {
 	int fput_needed, err, datagrams;
 	struct socket *sock;
@@ -2405,8 +2405,7 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 		if (timeout) {
 			ktime_get_ts64(&timeout64);
-			*timeout = timespec64_to_timespec(
-					timespec64_sub(end_time, timeout64));
+			*timeout = timespec64_sub(end_time, timeout64);
 			if (timeout->tv_sec < 0) {
 				timeout->tv_sec = timeout->tv_nsec = 0;
 				break;
@@ -2452,10 +2451,10 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			   unsigned int vlen, unsigned int flags,
-			   struct timespec __user *timeout)
+			   struct __kernel_timespec __user *timeout)
 {
 	int datagrams;
-	struct timespec timeout_sys;
+	struct timespec64 timeout_sys;
 
 	if (flags & MSG_CMSG_COMPAT)
 		return -EINVAL;
@@ -2463,13 +2462,12 @@ static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 	if (!timeout)
 		return __sys_recvmmsg(fd, mmsg, vlen, flags, NULL);
 
-	if (copy_from_user(&timeout_sys, timeout, sizeof(timeout_sys)))
+	if (get_timespec64(&timeout_sys, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, mmsg, vlen, flags, &timeout_sys);
 
-	if (datagrams > 0 &&
-	    copy_to_user(timeout, &timeout_sys, sizeof(timeout_sys)))
+	if (datagrams > 0 && put_timespec64(&timeout_sys, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
@@ -2477,7 +2475,7 @@ static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 
 SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
 		unsigned int, vlen, unsigned int, flags,
-		struct timespec __user *, timeout)
+		struct __kernel_timespec __user *, timeout)
 {
 	return do_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
 }
@@ -2601,7 +2599,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_RECVMMSG:
 		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
-				      a[3], (struct timespec __user *)a[4]);
+				      a[3], (struct __kernel_timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.18.0

