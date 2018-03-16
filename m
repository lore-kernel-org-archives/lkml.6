Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933474AbeCPRJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:09:31 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43116 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933422AbeCPRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:02 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 11/22] net: socket: add __sys_shutdown() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:06:03 +0100
Message-Id: <20180316170614.5392-12-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_shutdown() allows us to avoid the
internal calls to the sys_shutdown() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h | 1 +
 net/compat.c           | 2 +-
 net/socket.c           | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index dbdddf0d079e..b205138b69f1 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -374,5 +374,6 @@ extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
 			     int __user *usockaddr_len);
 extern int __sys_socketpair(int family, int type, int protocol,
 			    int __user *usockvec);
+extern int __sys_shutdown(int fd, int how);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 04db26316438..f1ec23e9dfce 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -849,7 +849,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 					  compat_ptr(a[4]), compat_ptr(a[5]));
 		break;
 	case SYS_SHUTDOWN:
-		ret = sys_shutdown(a0, a1);
+		ret = __sys_shutdown(a0, a1);
 		break;
 	case SYS_SETSOCKOPT:
 		ret = compat_sys_setsockopt(a0, a1, a[2],
diff --git a/net/socket.c b/net/socket.c
index 5861821f46f5..ad5dfd6a1d59 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1942,7 +1942,7 @@ SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
  *	Shutdown a socket.
  */
 
-SYSCALL_DEFINE2(shutdown, int, fd, int, how)
+int __sys_shutdown(int fd, int how)
 {
 	int err, fput_needed;
 	struct socket *sock;
@@ -1957,6 +1957,11 @@ SYSCALL_DEFINE2(shutdown, int, fd, int, how)
 	return err;
 }
 
+SYSCALL_DEFINE2(shutdown, int, fd, int, how)
+{
+	return __sys_shutdown(fd, how);
+}
+
 /* A couple of helpful macros for getting the address of the 32/64 bit
  * fields which are the same type (int / unsigned) on our platforms.
  */
@@ -2544,7 +2549,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				     (int __user *)a[5]);
 		break;
 	case SYS_SHUTDOWN:
-		err = sys_shutdown(a0, a1);
+		err = __sys_shutdown(a0, a1);
 		break;
 	case SYS_SETSOCKOPT:
 		err = sys_setsockopt(a0, a1, a[2], (char __user *)a[3], a[4]);
-- 
2.16.2
