Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeCPRJH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:09:07 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43206 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeCPRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:02 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 22/22] net: socket: add __compat_sys_...msg() helpers; remove in-kernel calls to compat syscalls
Date: Fri, 16 Mar 2018 18:06:14 +0100
Message-Id: <20180316170614.5392-23-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helpers __compat_sys_...msg() allows us to avoid
the internal calls to the compat_sys_...msg() syscalls.
compat_sys_recvmmsg() is handled in a different patch.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 7b2ae42a1598..5ae7437d3853 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -747,25 +747,48 @@ static unsigned char nas[21] = {
 };
 #undef AL
 
-COMPAT_SYSCALL_DEFINE3(sendmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
+static inline long __compat_sys_sendmsg(int fd,
+					struct compat_msghdr __user *msg,
+					unsigned int flags)
 {
 	return __sys_sendmsg(fd, (struct user_msghdr __user *)msg,
 			     flags | MSG_CMSG_COMPAT, false);
 }
 
-COMPAT_SYSCALL_DEFINE4(sendmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
-		       unsigned int, vlen, unsigned int, flags)
+COMPAT_SYSCALL_DEFINE3(sendmsg, int, fd, struct compat_msghdr __user *, msg,
+		       unsigned int, flags)
+{
+	return __compat_sys_sendmsg(fd, msg, flags);
+}
+
+static inline long __compat_sys_sendmmsg(int fd,
+					 struct compat_mmsghdr __user *mmsg,
+					 unsigned int vlen, unsigned int flags)
 {
 	return __sys_sendmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 			      flags | MSG_CMSG_COMPAT, false);
 }
 
-COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, unsigned int, flags)
+COMPAT_SYSCALL_DEFINE4(sendmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags)
+{
+	return __compat_sys_sendmmsg(fd, mmsg, vlen, flags);
+}
+
+static inline long __compat_sys_recvmsg(int fd,
+					struct compat_msghdr __user *msg,
+					unsigned int flags)
 {
 	return __sys_recvmsg(fd, (struct user_msghdr __user *)msg,
 			     flags | MSG_CMSG_COMPAT, false);
 }
 
+COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg,
+		       unsigned int, flags)
+{
+	return __compat_sys_recvmsg(fd, msg, flags);
+}
+
 static inline long __compat_sys_recvfrom(int fd, void __user *buf,
 					 compat_size_t len, unsigned int flags,
 					 struct sockaddr __user *addr,
@@ -893,13 +916,13 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 					      compat_ptr(a[4]));
 		break;
 	case SYS_SENDMSG:
-		ret = compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
+		ret = __compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_SENDMMSG:
-		ret = compat_sys_sendmmsg(a0, compat_ptr(a1), a[2], a[3]);
+		ret = __compat_sys_sendmmsg(a0, compat_ptr(a1), a[2], a[3]);
 		break;
 	case SYS_RECVMSG:
-		ret = compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
+		ret = __compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_RECVMMSG:
 		ret = __compat_sys_recvmmsg(a0, compat_ptr(a1), a[2], a[3],
-- 
2.16.2
