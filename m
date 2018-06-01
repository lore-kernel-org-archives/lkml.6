Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeFANZ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:25:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38662 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeFANWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:22:52 -0400
X-Google-Smtp-Source: ADUXVKJRG6TImoNDH0prZmgy9Sjn9hoEHX5Gt1Ici1HdgxhqxZdwAN3RReeKe/RL900yDydXfKwC7A==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 04/17] signal: make do_sigpending() void
Date: Fri,  1 Jun 2018 15:22:26 +0200
Message-Id: <20180601132239.4421-5-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sigpending() returned 0 unconditionally so it doesn't make sense to have
it return at all. This allows us to simplify a bunch of syscall callers.

Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
---
v1->v2:
* unchanged
v0->v1:
* unchanged
---
 kernel/signal.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index bc750fb4ddcc..7c770556b085 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2767,7 +2767,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 }
 #endif
 
-static int do_sigpending(sigset_t *set)
+static void do_sigpending(sigset_t *set)
 {
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(set, &current->pending.signal,
@@ -2776,7 +2776,6 @@ static int do_sigpending(sigset_t *set)
 
 	/* Outside the lock because only this thread touches it.  */
 	sigandsets(set, &current->blocked, set);
-	return 0;
 }
 
 /**
@@ -2788,15 +2787,16 @@ static int do_sigpending(sigset_t *set)
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
@@ -2804,15 +2804,13 @@ COMPAT_SYSCALL_DEFINE2(rt_sigpending, compat_sigset_t __user *, uset,
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
 
@@ -3647,25 +3645,26 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
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
