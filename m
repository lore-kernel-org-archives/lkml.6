Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeBDKus (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:50:48 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeBDKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:50:17 -0500
X-Google-Smtp-Source: AH8x227Ab1x8rgZZtclXHGpy+9+99Gs2j7OqS4SNWcG4JM5jXE8gE3OUxMEVOGmU7igm07f7jt8mlA==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [RFC 2/3] seccomp: hoist out filter resolving logic
Date: Sun,  4 Feb 2018 11:49:45 +0100
Message-Id: <20180204104946.25559-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180204104946.25559-1-tycho@tycho.ws>
References: <20180204104946.25559-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoist out the nth filter resolving logic that ptrace uses into a new
function. We'll use this in the next patch to implement the new
PTRACE_SECCOMP_GET_FILTER_FLAGS command. This is based on an older patch
that I had sent a while ago; it significantly revamps the get_nth_filter
logic based on previous suggestions from Oleg.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 kernel/seccomp.c | 77 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9541eb379e74..800db3f2866f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1179,49 +1179,68 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 }
 
 #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
-long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
-			void __user *data)
+static struct seccomp_filter *get_nth_filter(struct task_struct *task,
+					     unsigned long filter_off)
 {
-	struct seccomp_filter *filter;
-	struct sock_fprog_kern *fprog;
-	long ret;
-	unsigned long count = 0;
-
-	if (!capable(CAP_SYS_ADMIN) ||
-	    current->seccomp.mode != SECCOMP_MODE_DISABLED) {
-		return -EACCES;
-	}
+	struct seccomp_filter *orig, *filter;
+	unsigned long count;
 
+	/*
+	 * Note: this is only correct because the caller should be the (ptrace)
+	 * tracer of the task, otherwise lock_task_sighand is needed.
+	 */
 	spin_lock_irq(&task->sighand->siglock);
+
 	if (task->seccomp.mode != SECCOMP_MODE_FILTER) {
-		ret = -EINVAL;
-		goto out;
+		spin_unlock_irq(&task->sighand->siglock);
+		return ERR_PTR(-EINVAL);
 	}
 
-	filter = task->seccomp.filter;
-	while (filter) {
-		filter = filter->prev;
+	orig = task->seccomp.filter;
+	__get_seccomp_filter(orig);
+	spin_unlock_irq(&task->sighand->siglock);
+
+	count = 0;
+	for (filter = orig; filter; filter = filter->prev)
 		count++;
-	}
 
 	if (filter_off >= count) {
-		ret = -ENOENT;
+		filter = ERR_PTR(-ENOENT);
 		goto out;
 	}
-	count -= filter_off;
 
-	filter = task->seccomp.filter;
-	while (filter && count > 1) {
-		filter = filter->prev;
+	count -= filter_off;
+	for (filter = orig; filter && count > 1; filter = filter->prev)
 		count--;
-	}
 
 	if (WARN_ON(count != 1 || !filter)) {
-		/* The filter tree shouldn't shrink while we're using it. */
-		ret = -ENOENT;
+		filter = ERR_PTR(-ENOENT);
 		goto out;
 	}
 
+	__get_seccomp_filter(filter);
+
+out:
+	__put_seccomp_filter(orig);
+	return filter;
+}
+
+long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
+			void __user *data)
+{
+	struct seccomp_filter *filter;
+	struct sock_fprog_kern *fprog;
+	long ret;
+
+	if (!capable(CAP_SYS_ADMIN) ||
+	    current->seccomp.mode != SECCOMP_MODE_DISABLED) {
+		return -EACCES;
+	}
+
+	filter = get_nth_filter(task, filter_off);
+	if (IS_ERR(filter))
+		return PTR_ERR(filter);
+
 	fprog = filter->prog->orig_prog;
 	if (!fprog) {
 		/* This must be a new non-cBPF filter, since we save
@@ -1236,17 +1255,11 @@ long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 	if (!data)
 		goto out;
 
-	__get_seccomp_filter(filter);
-	spin_unlock_irq(&task->sighand->siglock);
-
 	if (copy_to_user(data, fprog->filter, bpf_classic_proglen(fprog)))
 		ret = -EFAULT;
 
-	__put_seccomp_filter(filter);
-	return ret;
-
 out:
-	spin_unlock_irq(&task->sighand->siglock);
+	__put_seccomp_filter(filter);
 	return ret;
 }
 #endif
-- 
2.14.1
