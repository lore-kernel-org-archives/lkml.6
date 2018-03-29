Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeC2L5o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:57:44 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59008 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeC2L0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:26:04 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, Alexander Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 053/109] fs: add do_signalfd4() helper; remove internal calls to sys_signalfd4()
Date: Thu, 29 Mar 2018 13:23:30 +0200
Message-Id: <20180329112426.23043-54-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper removes in-kernel calls to the sys_signalfd4() syscall
function.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/signalfd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 76bf9cc62074..501c41f3351f 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -256,8 +256,8 @@ static const struct file_operations signalfd_fops = {
 	.llseek		= noop_llseek,
 };
 
-SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
-		size_t, sizemask, int, flags)
+static int do_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask,
+			int flags)
 {
 	sigset_t sigmask;
 	struct signalfd_ctx *ctx;
@@ -310,10 +310,16 @@ SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
 	return ufd;
 }
 
+SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
+		size_t, sizemask, int, flags)
+{
+	return do_signalfd4(ufd, user_mask, sizemask, flags);
+}
+
 SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *, user_mask,
 		size_t, sizemask)
 {
-	return sys_signalfd4(ufd, user_mask, sizemask, 0);
+	return do_signalfd4(ufd, user_mask, sizemask, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -333,7 +339,7 @@ COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
 	if (copy_to_user(ksigmask, &tmp, sizeof(sigset_t)))
 		return -EFAULT;
 
-	return sys_signalfd4(ufd, ksigmask, sizeof(sigset_t), flags);
+	return do_signalfd4(ufd, ksigmask, sizeof(sigset_t), flags);
 }
 
 COMPAT_SYSCALL_DEFINE3(signalfd, int, ufd,
-- 
2.16.3
