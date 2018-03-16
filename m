Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933538AbeCPRHH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:07:07 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:42924 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933333AbeCPRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:06:57 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 20/22] net: socket: add __compat_sys_getsockopt() helper; remove in-kernel call to compat syscall
Date: Fri, 16 Mar 2018 18:06:12 +0100
Message-Id: <20180316170614.5392-21-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __compat_sys_getsockopt() allows us to avoid
the internal calls to the compat_sys_getsockopt() syscall.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 75bfcbbb2e3e..cdf5b0c1b962 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -509,8 +509,9 @@ int compat_sock_get_timestampns(struct sock *sk, struct timespec __user *usersta
 }
 EXPORT_SYMBOL(compat_sock_get_timestampns);
 
-COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
-		       char __user *, optval, int __user *, optlen)
+static int __compat_sys_getsockopt(int fd, int level, int optname,
+				   char __user *optval,
+				   int __user *optlen)
 {
 	int err;
 	struct socket *sock = sockfd_lookup(fd, &err);
@@ -536,6 +537,12 @@ COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 	return err;
 }
 
+COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
+		       char __user *, optval, int __user *, optlen)
+{
+	return __compat_sys_getsockopt(fd, level, optname, optval, optlen);
+}
+
 struct compat_group_req {
 	__u32				 gr_interface;
 	struct __kernel_sockaddr_storage gr_group
@@ -874,8 +881,9 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 					      compat_ptr(a[3]), a[4]);
 		break;
 	case SYS_GETSOCKOPT:
-		ret = compat_sys_getsockopt(a0, a1, a[2],
-				compat_ptr(a[3]), compat_ptr(a[4]));
+		ret = __compat_sys_getsockopt(a0, a1, a[2],
+					      compat_ptr(a[3]),
+					      compat_ptr(a[4]));
 		break;
 	case SYS_SENDMSG:
 		ret = compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
-- 
2.16.2
