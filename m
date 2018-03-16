Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeCPROv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:14:51 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:42922 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeCPRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:06:57 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 21/22] net: socket: add __compat_sys_recvmmsg() helper; remove in-kernel call to compat syscall
Date: Fri, 16 Mar 2018 18:06:13 +0100
Message-Id: <20180316170614.5392-22-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __compat_sys_recvmmsg() allows us to avoid
the internal calls to the compat_sys_recvmmsg() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index cdf5b0c1b962..7b2ae42a1598 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -787,9 +787,9 @@ COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len
 	return __compat_sys_recvfrom(fd, buf, len, flags, addr, addrlen);
 }
 
-COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
-		       unsigned int, vlen, unsigned int, flags,
-		       struct compat_timespec __user *, timeout)
+static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+				 unsigned int vlen, unsigned int flags,
+				 struct compat_timespec __user *timeout)
 {
 	int datagrams;
 	struct timespec ktspec;
@@ -809,6 +809,13 @@ COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
 	return datagrams;
 }
 
+COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags,
+		       struct compat_timespec __user *, timeout)
+{
+	return __compat_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
+}
+
 COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 {
 	u32 a[AUDITSC_ARGS];
@@ -895,8 +902,8 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_RECVMMSG:
-		ret = compat_sys_recvmmsg(a0, compat_ptr(a1), a[2], a[3],
-					  compat_ptr(a[4]));
+		ret = __compat_sys_recvmmsg(a0, compat_ptr(a1), a[2], a[3],
+					    compat_ptr(a[4]));
 		break;
 	case SYS_ACCEPT4:
 		ret = __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]), a[3]);
-- 
2.16.2
