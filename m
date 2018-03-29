Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeC2L3n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:29:43 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59218 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeC2L03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:26:29 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Subject: [PATCH 026/109] net: socket: add __compat_sys_setsockopt() helper; remove in-kernel call to compat syscall
Date: Thu, 29 Mar 2018 13:23:03 +0200
Message-Id: <20180329112426.23043-27-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the net-internal helper __compat_sys_setsockopt() allows us to avoid
the internal calls to the compat_sys_setsockopt() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 513adc8d0e0f..75bfcbbb2e3e 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -383,8 +383,8 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 	return sock_setsockopt(sock, level, optname, optval, optlen);
 }
 
-COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
-		       char __user *, optval, unsigned int, optlen)
+static int __compat_sys_setsockopt(int fd, int level, int optname,
+				   char __user *optval, unsigned int optlen)
 {
 	int err;
 	struct socket *sock = sockfd_lookup(fd, &err);
@@ -410,6 +410,12 @@ COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	return err;
 }
 
+COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
+		       char __user *, optval, unsigned int, optlen)
+{
+	return __compat_sys_setsockopt(fd, level, optname, optval, optlen);
+}
+
 static int do_get_sock_timeout(struct socket *sock, int level, int optname,
 		char __user *optval, int __user *optlen)
 {
@@ -864,8 +870,8 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_shutdown(a0, a1);
 		break;
 	case SYS_SETSOCKOPT:
-		ret = compat_sys_setsockopt(a0, a1, a[2],
-				compat_ptr(a[3]), a[4]);
+		ret = __compat_sys_setsockopt(a0, a1, a[2],
+					      compat_ptr(a[3]), a[4]);
 		break;
 	case SYS_GETSOCKOPT:
 		ret = compat_sys_getsockopt(a0, a1, a[2],
-- 
2.16.3
