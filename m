Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbeCPRKv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:10:51 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43110 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933404AbeCPRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:01 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 12/22] net: socket: add __sys_setsockopt() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:06:04 +0100
Message-Id: <20180316170614.5392-13-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_setsockopt() allows us to avoid the
internal calls to the sys_setsockopt() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/socket.h |  1 +
 net/socket.c           | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index b205138b69f1..cad120e4ed4b 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -376,4 +376,5 @@ extern int __sys_socketpair(int family, int type, int protocol,
 			    int __user *usockvec);
 extern int __sys_shutdown(int fd, int how);
 
+
 #endif /* _LINUX_SOCKET_H */
diff --git a/net/socket.c b/net/socket.c
index ad5dfd6a1d59..5dd2e39a6cd4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1878,8 +1878,8 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, size_t, size,
  *	to pass the user mode parameter for the protocols to sort out.
  */
 
-SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
-		char __user *, optval, int, optlen)
+static int __sys_setsockopt(int fd, int level, int optname,
+			    char __user *optval, int optlen)
 {
 	int err, fput_needed;
 	struct socket *sock;
@@ -1907,6 +1907,12 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	return err;
 }
 
+SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
+		char __user *, optval, int, optlen)
+{
+	return __sys_setsockopt(fd, level, optname, optval, optlen);
+}
+
 /*
  *	Get a socket option. Because we don't know the option lengths we have
  *	to pass a user mode parameter for the protocols to sort out.
@@ -2552,7 +2558,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = __sys_shutdown(a0, a1);
 		break;
 	case SYS_SETSOCKOPT:
-		err = sys_setsockopt(a0, a1, a[2], (char __user *)a[3], a[4]);
+		err = __sys_setsockopt(a0, a1, a[2], (char __user *)a[3],
+				       a[4]);
 		break;
 	case SYS_GETSOCKOPT:
 		err =
-- 
2.16.2
