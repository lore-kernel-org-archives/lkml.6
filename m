Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeCPRHB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:07:01 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:42926 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932399AbeCPRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:06:57 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 08/22] net: socket: add __sys_getsockname() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:06:00 +0100
Message-Id: <20180316170614.5392-9-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_getsockname() allows us to avoid the
internal calls to the sys_getsockname() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  2 ++
 net/compat.c           |  2 +-
 net/socket.c           | 14 ++++++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7e37af25509d..ef0226a61b03 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -368,5 +368,7 @@ extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
 extern int __sys_listen(int fd, int backlog);
+extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
+			     int __user *usockaddr_len);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index c80cb973f383..efd28d02608c 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -826,7 +826,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), 0);
 		break;
 	case SYS_GETSOCKNAME:
-		ret = sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
+		ret = __sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_GETPEERNAME:
 		ret = sys_getpeername(a0, compat_ptr(a1), compat_ptr(a[2]));
diff --git a/net/socket.c b/net/socket.c
index 67d9d70a4734..b61e0d20f37b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1675,8 +1675,8 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
  *	name to user space.
  */
 
-SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
-		int __user *, usockaddr_len)
+int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
+		      int __user *usockaddr_len)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
@@ -1701,6 +1701,12 @@ SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
 	return err;
 }
 
+SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
+		int __user *, usockaddr_len)
+{
+	return __sys_getsockname(fd, usockaddr, usockaddr_len);
+}
+
 /*
  *	Get the remote address ('name') of a socket object. Move the obtained
  *	name to user space.
@@ -2500,8 +2506,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_GETSOCKNAME:
 		err =
-		    sys_getsockname(a0, (struct sockaddr __user *)a1,
-				    (int __user *)a[2]);
+		    __sys_getsockname(a0, (struct sockaddr __user *)a1,
+				      (int __user *)a[2]);
 		break;
 	case SYS_GETPEERNAME:
 		err =
-- 
2.16.2
