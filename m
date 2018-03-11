Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeCKLCQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:02:16 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54320 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbeCKK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:51 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 10/35] syscalls: do not call sys_signalfd4() within the kernel
Date: Sun, 11 Mar 2018 11:55:32 +0100
Message-Id: <20180311105557.20807-11-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Alexander Viro <viro@zeniv.linux.org.uk>
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
2.16.2
