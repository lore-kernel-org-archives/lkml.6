Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933500AbeCPRNP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:13:15 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43116 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753754AbeCPRG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:06:59 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 17/22] net: socket: replace call to sys_recv() with __sys_recvfrom()
Date: Fri, 16 Mar 2018 18:06:09 +0100
Message-Id: <20180316170614.5392-18-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_recv() merely expands the parameters to __sys_recvfrom() by NULL and
NULL. Open-code this in the two places which used sys_recv() as a wrapper
to __sys_recvfrom().

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 net/compat.c | 3 ++-
 net/socket.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index d55982ff5c59..9e0d030063ad 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -755,7 +755,8 @@ COMPAT_SYSCALL_DEFINE3(recvmsg, int, fd, struct compat_msghdr __user *, msg, uns
 
 COMPAT_SYSCALL_DEFINE4(recv, int, fd, void __user *, buf, compat_size_t, len, unsigned int, flags)
 {
-	return sys_recv(fd, buf, len, flags | MSG_CMSG_COMPAT);
+	return __sys_recvfrom(fd, buf, len, flags | MSG_CMSG_COMPAT, NULL,
+			      NULL);
 }
 
 COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len,
diff --git a/net/socket.c b/net/socket.c
index c4fb60be194b..34cf4b163f8f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2566,7 +2566,8 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				   (struct sockaddr __user *)a[4], a[5]);
 		break;
 	case SYS_RECV:
-		err = sys_recv(a0, (void __user *)a1, a[2], a[3]);
+		err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
+				     NULL, NULL);
 		break;
 	case SYS_RECVFROM:
 		err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
-- 
2.16.2
