Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933495AbeCPRHD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:07:03 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:42920 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933316AbeCPRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:06:57 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 04/22] net: socket: add __sys_socket() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:05:56 +0100
Message-Id: <20180316170614.5392-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_socket() allows us to avoid the
internal calls to the sys_socket() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h | 1 +
 net/compat.c           | 2 +-
 net/socket.c           | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 6a9840271676..f8d040434a13 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -363,5 +363,6 @@ extern int __sys_sendto(int fd, void __user *buff, size_t len,
 			int addr_len);
 extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 			 int __user *upeer_addrlen, int flags);
+extern int __sys_socket(int family, int type, int protocol);
 
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 0ff9f7451b6f..5b3b74c5812e 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -811,7 +811,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 
 	switch (call) {
 	case SYS_SOCKET:
-		ret = sys_socket(a0, a1, a[2]);
+		ret = __sys_socket(a0, a1, a[2]);
 		break;
 	case SYS_BIND:
 		ret = sys_bind(a0, compat_ptr(a1), a[2]);
diff --git a/net/socket.c b/net/socket.c
index 45f6ea0d57a5..07f379e50def 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1332,7 +1332,7 @@ int sock_create_kern(struct net *net, int family, int type, int protocol, struct
 }
 EXPORT_SYMBOL(sock_create_kern);
 
-SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
+int __sys_socket(int family, int type, int protocol)
 {
 	int retval;
 	struct socket *sock;
@@ -1359,6 +1359,11 @@ SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
 	return sock_map_fd(sock, flags & (O_CLOEXEC | O_NONBLOCK));
 }
 
+SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
+{
+	return __sys_socket(family, type, protocol);
+}
+
 /*
  *	Create a pair of connected sockets.
  */
@@ -2463,7 +2468,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 
 	switch (call) {
 	case SYS_SOCKET:
-		err = sys_socket(a0, a1, a[2]);
+		err = __sys_socket(a0, a1, a[2]);
 		break;
 	case SYS_BIND:
 		err = sys_bind(a0, (struct sockaddr __user *)a1, a[2]);
-- 
2.16.2
