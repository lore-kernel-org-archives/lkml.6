Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeCPRMg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:12:36 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43124 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbeCPRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:00 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 13/22] net: socket: add __sys_getsockopt() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:06:05 +0100
Message-Id: <20180316170614.5392-14-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __sys_getsockopt() allows us to avoid the
internal calls to the sys_getsockopt() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/socket.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 5dd2e39a6cd4..a05289b1f863 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1918,8 +1918,8 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
  *	to pass a user mode parameter for the protocols to sort out.
  */
 
-SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
-		char __user *, optval, int __user *, optlen)
+static int __sys_getsockopt(int fd, int level, int optname,
+			    char __user *optval, int __user *optlen)
 {
 	int err, fput_needed;
 	struct socket *sock;
@@ -1944,6 +1944,12 @@ SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 	return err;
 }
 
+SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
+		char __user *, optval, int __user *, optlen)
+{
+	return __sys_getsockopt(fd, level, optname, optval, optlen);
+}
+
 /*
  *	Shutdown a socket.
  */
@@ -2563,8 +2569,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_GETSOCKOPT:
 		err =
-		    sys_getsockopt(a0, a1, a[2], (char __user *)a[3],
-				   (int __user *)a[4]);
+		    __sys_getsockopt(a0, a1, a[2], (char __user *)a[3],
+				     (int __user *)a[4]);
 		break;
 	case SYS_SENDMSG:
 		err = sys_sendmsg(a0, (struct user_msghdr __user *)a1, a[2]);
-- 
2.16.2
