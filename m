Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeCOTJb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:09:31 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36086 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbeCOTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:23 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 12/36] kernel: open-code sys_rt_sigpending() in sys_sigpending()
Date: Thu, 15 Mar 2018 20:05:05 +0100
Message-Id: <20180315190529.20943-13-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A similar but not fully equivalent code path is already open-coded
three times (in sys_rt_sigpending and in the two compat stubs), so
do it a fourth time here.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h |  2 +-
 kernel/signal.c          | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0526286a0314..a63e21e7a3af 100644
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
index c6e4c83dc090..985c61749bcf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3629,11 +3629,20 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 
 /**
  *  sys_sigpending - examine pending signals
- *  @set: where mask of pending signal is returned
+ *  @uset: where mask of pending signal is returned
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
