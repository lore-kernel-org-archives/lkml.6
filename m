Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeCKLD0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:03:26 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54290 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeCKK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:48 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 12/35] syscalls: do not call sys_rt_sigpending() within the kernel
Date: Sun, 11 Mar 2018 11:55:34 +0100
Message-Id: <20180311105557.20807-13-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A similar code path is already open-coded three times (in sys_rt_sigpending
and in the two compat stubs), so do it a fourth time here.

CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h |  2 +-
 kernel/signal.c          | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 700a83a9c1ad..79c46c46603b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -288,7 +288,7 @@ asmlinkage long sys_capset(cap_user_header_t header,
 				const cap_user_data_t data);
 asmlinkage long sys_personality(unsigned int personality);
 
-asmlinkage long sys_sigpending(old_sigset_t __user *set);
+asmlinkage long sys_sigpending(old_sigset_t __user *uset);
 asmlinkage long sys_sigprocmask(int how, old_sigset_t __user *set,
 				old_sigset_t __user *oset);
 asmlinkage long sys_sigaltstack(const struct sigaltstack __user *uss,
diff --git a/kernel/signal.c b/kernel/signal.c
index c6e4c83dc090..fe0906d1d3cc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3631,9 +3631,18 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
  *  sys_sigpending - examine pending signals
  *  @set: where mask of pending signal is returned
  */
-SYSCALL_DEFINE1(sigpending, old_sigset_t __user *, set)
+SYSCALL_DEFINE1(sigpending, old_sigset_t __user *, uset)
 {
-	return sys_rt_sigpending((sigset_t __user *)set, sizeof(old_sigset_t)); 
+	sigset_t set;
+	int err;
+
+	if (sizeof(old_sigset_t) > sizeof(*uset))
+		return -EINVAL;
+
+	err = do_sigpending(&set);
+	if (!err && copy_to_user(uset, &set, sizeof(old_sigset_t)))
+		err = -EFAULT;
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.16.2
