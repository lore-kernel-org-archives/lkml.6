Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeCPRLW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:11:22 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43158 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933388AbeCPRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:00 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 01/22] net: socket: add __sys_recvfrom() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:05:53 +0100
Message-Id: <20180316170614.5392-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_recvfrom() allows us to avoid the
internal calls to the sys_recvfrom() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  6 ++++++
 net/compat.c           |  3 ++-
 net/socket.c           | 21 +++++++++++++--------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 9286a5a8c60c..40cc93b91628 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -353,4 +353,10 @@ extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen
 			  unsigned int flags, struct timespec *timeout);
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags);
+
+/* helpers which do the actual work for syscalls */
+extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
+			  unsigned int flags, struct sockaddr __user *addr,
+			  int __user *addr_len);
+
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 22381719718c..2d8186c277b2 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -760,7 +760,8 @@ COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len
 		       unsigned int, flags, struct sockaddr __user *, addr,
 		       int __user *, addrlen)
 {
-	return sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr, addrlen);
+	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr,
+			      addrlen);
 }
 
 COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
diff --git a/net/socket.c b/net/socket.c
index a93c99b518ca..712d99d8680f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1767,10 +1767,8 @@ SYSCALL_DEFINE4(send, int, fd, void __user *, buff, size_t, len,
  *	sender. We verify the buffers are writable and if needed move the
  *	sender address from kernel to user space.
  */
-
-SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, ubuf, size_t, size,
-		unsigned int, flags, struct sockaddr __user *, addr,
-		int __user *, addr_len)
+int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
+		   struct sockaddr __user *addr, int __user *addr_len)
 {
 	struct socket *sock;
 	struct iovec iov;
@@ -1810,6 +1808,13 @@ SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, ubuf, size_t, size,
 	return err;
 }
 
+SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, ubuf, size_t, size,
+		unsigned int, flags, struct sockaddr __user *, addr,
+		int __user *, addr_len)
+{
+	return __sys_recvfrom(fd, ubuf, size, flags, addr, addr_len);
+}
+
 /*
  *	Receive a datagram from a socket.
  */
@@ -1817,7 +1822,7 @@ SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, ubuf, size_t, size,
 SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, size_t, size,
 		unsigned int, flags)
 {
-	return sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
+	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
 }
 
 /*
@@ -2486,9 +2491,9 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = sys_recv(a0, (void __user *)a1, a[2], a[3]);
 		break;
 	case SYS_RECVFROM:
-		err = sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
-				   (struct sockaddr __user *)a[4],
-				   (int __user *)a[5]);
+		err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
+				     (struct sockaddr __user *)a[4],
+				     (int __user *)a[5]);
 		break;
 	case SYS_SHUTDOWN:
 		err = sys_shutdown(a0, a1);
-- 
2.16.2
