Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeCPRL2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:11:28 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43142 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933334AbeCPRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:00 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 14/22] net: socket: add do_sys_recvmmsg() helper; remove in-kernel call to syscall
Date: Fri, 16 Mar 2018 18:06:06 +0100
Message-Id: <20180316170614.5392-15-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper do_sys_recvmmsg() allows us to avoid the
internal calls to the sys_getsockopt() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/socket.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index a05289b1f863..72cdaaeccb85 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2445,9 +2445,9 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 	return datagrams;
 }
 
-SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
-		unsigned int, vlen, unsigned int, flags,
-		struct timespec __user *, timeout)
+static long do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
+			    unsigned int vlen, unsigned int flags,
+			    struct timespec __user *timeout)
 {
 	int datagrams;
 	struct timespec timeout_sys;
@@ -2470,6 +2470,13 @@ SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
 	return datagrams;
 }
 
+SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
+		unsigned int, vlen, unsigned int, flags,
+		struct timespec __user *, timeout)
+{
+	return do_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
+}
+
 #ifdef __ARCH_WANT_SYS_SOCKETCALL
 /* Argument list sizes for sys_socketcall */
 #define AL(x) ((x) * sizeof(unsigned long))
@@ -2582,8 +2589,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = sys_recvmsg(a0, (struct user_msghdr __user *)a1, a[2]);
 		break;
 	case SYS_RECVMMSG:
-		err = sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2], a[3],
-				   (struct timespec __user *)a[4]);
+		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
+				      a[3], (struct timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.16.2
