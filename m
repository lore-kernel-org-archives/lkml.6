Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeCPRK0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:10:26 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43198 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933419AbeCPRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:02 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 07/22] net: socket: add __sys_listen() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:05:59 +0100
Message-Id: <20180316170614.5392-8-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_listen() allows us to avoid the
internal calls to the sys_listen() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h | 1 +
 net/compat.c           | 2 +-
 net/socket.c           | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7daa344d7320..7e37af25509d 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -367,5 +367,6 @@ extern int __sys_socket(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
+extern int __sys_listen(int fd, int backlog);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 7ab6352268f3..c80cb973f383 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -820,7 +820,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_connect(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_LISTEN:
-		ret = sys_listen(a0, a1);
+		ret = __sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
 		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), 0);
diff --git a/net/socket.c b/net/socket.c
index 64bdfdf6c6e7..67d9d70a4734 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1496,7 +1496,7 @@ SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
  *	ready for listening.
  */
 
-SYSCALL_DEFINE2(listen, int, fd, int, backlog)
+int __sys_listen(int fd, int backlog)
 {
 	struct socket *sock;
 	int err, fput_needed;
@@ -1517,6 +1517,11 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
 	return err;
 }
 
+SYSCALL_DEFINE2(listen, int, fd, int, backlog)
+{
+	return __sys_listen(fd, backlog);
+}
+
 /*
  *	For accept, we attempt to create a new socket, set up the link
  *	with the client, wake up the client, then return the new
@@ -2487,7 +2492,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = __sys_connect(a0, (struct sockaddr __user *)a1, a[2]);
 		break;
 	case SYS_LISTEN:
-		err = sys_listen(a0, a1);
+		err = __sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.16.2
