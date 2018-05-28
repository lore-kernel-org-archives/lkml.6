Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755358AbeE1Ntz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:49:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53519 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755310AbeE1Ntk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:40 -0400
X-Google-Smtp-Source: ADUXVKK6kzgS54sAmWzn/kXs3d0JuRlmfIw2dz4JOL5T8OrAtoOZQObWt/4q26xHYwdEF2YY9P0vAQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 7/8] signal: make do_sigpending() void
Date: Mon, 28 May 2018 15:49:15 +0200
Message-Id: <20180528134916.7568-8-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sigpending() returned 0 unconditionally so it doesn't make sense to have
it return at all. This allows us to simplify a bunch of syscall callers.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 3b7712ec0746..42a7b067a49c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2773,7 +2773,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 }
 #endif
 
-static int do_sigpending(sigset_t *set)
+static void do_sigpending(sigset_t *set)
 {
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(set, &current->pending.signal,
@@ -2782,7 +2782,6 @@ static int do_sigpending(sigset_t *set)
 
 	/* Outside the lock because only this thread touches it.  */
 	sigandsets(set, &current->blocked, set);
-	return 0;
 }
 
 /**
@@ -2794,15 +2793,16 @@ static int do_sigpending(sigset_t *set)
 SYSCALL_DEFINE2(rt_sigpending, sigset_t __user *, uset, size_t, sigsetsize)
 {
 	sigset_t set;
-	int err;
 
 	if (sigsetsize > sizeof(*uset))
 		return -EINVAL;
 
-	err = do_sigpending(&set);
-	if (!err && copy_to_user(uset, &set, sigsetsize))
-		err = -EFAULT;
-	return err;
+	do_sigpending(&set);
+
+	if (copy_to_user(uset, &set, sigsetsize))
+		return -EFAULT;
+
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
@@ -2810,15 +2810,13 @@ COMPAT_SYSCALL_DEFINE2(rt_sigpending, compat_sigset_t __user *, uset,
 		compat_size_t, sigsetsize)
 {
 	sigset_t set;
-	int err;
 
 	if (sigsetsize > sizeof(*uset))
 		return -EINVAL;
 
-	err = do_sigpending(&set);
-	if (!err)
-		err = put_compat_sigset(uset, &set, sigsetsize);
-	return err;
+	do_sigpending(&set);
+
+	return put_compat_sigset(uset, &set, sigsetsize);
 }
 #endif
 
@@ -3653,25 +3651,26 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 SYSCALL_DEFINE1(sigpending, old_sigset_t __user *, uset)
 {
 	sigset_t set;
-	int err;
 
 	if (sizeof(old_sigset_t) > sizeof(*uset))
 		return -EINVAL;
 
-	err = do_sigpending(&set);
-	if (!err && copy_to_user(uset, &set, sizeof(old_sigset_t)))
-		err = -EFAULT;
-	return err;
+	do_sigpending(&set);
+
+	if (copy_to_user(uset, &set, sizeof(old_sigset_t)))
+		return -EFAULT;
+
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE1(sigpending, compat_old_sigset_t __user *, set32)
 {
 	sigset_t set;
-	int err = do_sigpending(&set);
-	if (!err)
-		err = put_user(set.sig[0], set32);
-	return err;
+
+	do_sigpending(&set);
+
+	return put_user(set.sig[0], set32);
 }
 #endif
 
-- 
2.17.0
