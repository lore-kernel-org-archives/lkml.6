Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeC2LiL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:38:11 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59048 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeC2L0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:26:22 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Subject: [PATCH 023/109] net: socket: replace calls to sys_send() with __sys_sendto()
Date: Thu, 29 Mar 2018 13:23:00 +0200
Message-Id: <20180329112426.23043-24-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_send() merely expands the parameters to __sys_sendto() by NULL and 0.
Open-code this in the two places which used sys_send() as a wrapper to
__sys_sendto().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 2 +-
 net/socket.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 5caa48987bb2..d55982ff5c59 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -837,7 +837,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 		ret = __sys_socketpair(a0, a1, a[2], compat_ptr(a[3]));
 		break;
 	case SYS_SEND:
-		ret = sys_send(a0, compat_ptr(a1), a[2], a[3]);
+		ret = __sys_sendto(a0, compat_ptr(a1), a[2], a[3], NULL, 0);
 		break;
 	case SYS_SENDTO:
 		ret = __sys_sendto(a0, compat_ptr(a1), a[2], a[3],
diff --git a/net/socket.c b/net/socket.c
index a70793a7ce78..92de21bb1a2e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2558,7 +2558,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		err = __sys_socketpair(a0, a1, a[2], (int __user *)a[3]);
 		break;
 	case SYS_SEND:
-		err = sys_send(a0, (void __user *)a1, a[2], a[3]);
+		err = __sys_sendto(a0, (void __user *)a1, a[2], a[3],
+				   NULL, 0);
 		break;
 	case SYS_SENDTO:
 		err = __sys_sendto(a0, (void __user *)a1, a[2], a[3],
-- 
2.16.3
