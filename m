Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbeCPRLY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:11:24 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43156 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933387AbeCPRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:00 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 18/22] net: socket: add __compat_sys_recvfrom() helper; remove in-kernel call to compat syscall
Date: Fri, 16 Mar 2018 18:06:10 +0100
Message-Id: <20180316170614.5392-19-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __compat_sys_recvfrom() allows us to avoid
the internal calls to the compat_sys_recvfrom() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 9e0d030063ad..513adc8d0e0f 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -753,18 +753,25 @@ COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, uns
 			     flags | MSG_CMSG_COMPAT, false);
 }
 
+static inline long __compat_sys_recvfrom(int fd, void __user *buf,
+					 compat_size_t len, unsigned int flags,
+					 struct sockaddr __user *addr,
+					 int __user *addrlen)
+{
+	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr,
+			      addrlen);
+}
+
 COMPAT_SYSCALL_DEFINE4(recv, int, fd, void __user *, buf, compat_size_t, len, unsigned int, flags)
 {
-	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, NULL,
-			      NULL);
+	return __compat_sys_recvfrom(fd, buf, len, flags, NULL, NULL);
 }
 
 COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len,
 		       unsigned int, flags, struct sockaddr __user *, addr,
 		       int __user *, addrlen)
 {
-	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, addr,
-			      addrlen);
+	return __compat_sys_recvfrom(fd, buf, len, flags, addr, addrlen);
 }
 
 COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
@@ -845,11 +852,13 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 				   compat_ptr(a[4]), a[5]);
 		break;
 	case SYS_RECV:
-		ret = compat_sys_recv(a0, compat_ptr(a1), a[2], a[3]);
+		ret = __compat_sys_recvfrom(a0, compat_ptr(a1), a[2], a[3],
+					    NULL, NULL);
 		break;
 	case SYS_RECVFROM:
-		ret = compat_sys_recvfrom(a0, compat_ptr(a1), a[2], a[3],
-					  compat_ptr(a[4]), compat_ptr(a[5]));
+		ret = __compat_sys_recvfrom(a0, compat_ptr(a1), a[2], a[3],
+					    compat_ptr(a[4]),
+					    compat_ptr(a[5]));
 		break;
 	case SYS_SHUTDOWN:
 		ret = __sys_shutdown(a0, a1);
-- 
2.16.2
