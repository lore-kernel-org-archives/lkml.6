Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeCGKc5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:32:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:41676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeCGKcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:32:54 -0500
Date: Wed, 7 Mar 2018 11:32:52 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Andy Lutomirski <luto@kernel.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has been
 populated
Message-ID: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

There is no point going through all the audit slow path syscall entry/exit 
in case the audit daemon is running, but hasn't populated the audit filter 
with any rules whatsoever.

Only set TIF_AUDIT_SYSCALL in case the number of populated audit rules is 
non-zero.

Originally-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

This is basically resurrection / rebase of patch Andi Lutomirski sent some
time back in 2014 or so.
 
Andi, is there any reason this hasn't been pursued further? I think we 
still want to get some of the slow path performance back.

Thanks.

 include/linux/audit.h | 15 +++++++++++++--
 kernel/auditfilter.c  |  4 ++--
 kernel/auditsc.c      | 45 ++++++++++++++++++++++++++++++++++++++++-----
 kernel/fork.c         |  2 +-
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index af410d9fbf2d..3d5e96f96be5 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -451,8 +451,10 @@ static inline void audit_fanotify(unsigned int response)
 		__audit_fanotify(response);
 }
 
-extern int audit_n_rules;
 extern int audit_signals;
+extern void audit_populate(struct task_struct *tsk);
+extern void audit_inc_n_rules(void);
+extern void audit_dec_n_rules(void);
 #else /* CONFIG_AUDITSYSCALL */
 static inline int audit_alloc(struct task_struct *task)
 {
@@ -572,7 +574,16 @@ static inline void audit_fanotify(unsigned int response)
 
 static inline void audit_ptrace(struct task_struct *t)
 { }
-#define audit_n_rules 0
+
+static inline void audit_populate(struct task_struct *tsk)
+{ }
+
+static inline void audit_inc_n_rules(void)
+{ }
+
+static inline void audit_dec_n_rules(void)
+{ }
+
 #define audit_signals 0
 #endif /* CONFIG_AUDITSYSCALL */
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4a1758adb222..46ad138d8ba2 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -991,7 +991,7 @@ static inline int audit_add_rule(struct audit_entry *entry)
 	}
 #ifdef CONFIG_AUDITSYSCALL
 	if (!dont_count)
-		audit_n_rules++;
+		audit_inc_n_rules();
 
 	if (!audit_match_signal(entry))
 		audit_signals++;
@@ -1038,7 +1038,7 @@ int audit_del_rule(struct audit_entry *entry)
 
 #ifdef CONFIG_AUDITSYSCALL
 	if (!dont_count)
-		audit_n_rules--;
+		audit_dec_n_rules();
 
 	if (!audit_match_signal(entry))
 		audit_signals--;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f7e132..642dd856e716 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -91,7 +91,7 @@
 #define MAX_PROCTITLE_AUDIT_LEN 128
 
 /* number of audit rules */
-int audit_n_rules;
+static int audit_n_rules;
 
 /* determines whether we collect data for signals sent */
 int audit_signals;
@@ -919,6 +919,36 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	return context;
 }
 
+void audit_inc_n_rules()
+{
+	struct task_struct *p, *g;
+	unsigned long flags;
+
+	read_lock_irqsave(&tasklist_lock, flags);
+	if (!audit_n_rules++) {
+		do_each_thread(g, p) {
+			if (p->audit_context)
+				set_tsk_thread_flag(p, TIF_SYSCALL_AUDIT);
+		} while_each_thread(g, p);
+	}
+	read_unlock_irqrestore(&tasklist_lock, flags);
+}
+
+void audit_dec_n_rules()
+{
+	struct task_struct *p, *g;
+	unsigned long flags;
+
+	read_lock_irqsave(&tasklist_lock, flags);
+	audit_n_rules--;
+	if (!audit_n_rules) {
+		do_each_thread(g, p) {
+			clear_tsk_thread_flag(p, TIF_SYSCALL_AUDIT);
+		} while_each_thread(g, p);
+	}
+	read_unlock_irqrestore(&tasklist_lock, flags);
+}
+
 /**
  * audit_alloc - allocate an audit context block for a task
  * @tsk: task
@@ -938,10 +968,8 @@ int audit_alloc(struct task_struct *tsk)
 		return 0; /* Return if not auditing. */
 
 	state = audit_filter_task(tsk, &key);
-	if (state == AUDIT_DISABLED) {
-		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+	if (state == AUDIT_DISABLED)
 		return 0;
-	}
 
 	if (!(context = audit_alloc_context(state))) {
 		kfree(key);
@@ -951,7 +979,6 @@ int audit_alloc(struct task_struct *tsk)
 	context->filterkey = key;
 
 	tsk->audit_context  = context;
-	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
 	return 0;
 }
 
@@ -967,6 +994,14 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
+void audit_populate(struct task_struct *tsk)
+{
+	if (tsk->audit_context && audit_n_rules)
+		set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+	else
+		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+}
+
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid, unsigned int sessionid,
 				 u32 sid, char *comm)
diff --git a/kernel/fork.c b/kernel/fork.c
index e5d9d405ae4e..79c828746d24 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1955,7 +1955,7 @@ static __latent_entropy struct task_struct *copy_process(
 		attach_pid(p, PIDTYPE_PID);
 		nr_threads++;
 	}
-
+	audit_populate(p);
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	syscall_tracepoint_update(p);
-- 
Jiri Kosina
SUSE Labs
