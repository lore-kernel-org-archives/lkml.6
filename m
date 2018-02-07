Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeBGJ0x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:26:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753066AbeBGJ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:26:51 -0500
From: Mateusz Guzik <mguzik@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>,
        Jerome Marchand <jmarchan@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proc: get rid of task lock/unlock pair to read umask for the "status" file
Date: Wed,  7 Feb 2018 10:26:48 +0100
Message-Id: <1517995608-23683-1-git-send-email-mguzik@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_task_umask locks/unlocks the task on its own. The only caller does
the same thing immediately after.

Utilize the fact the task has to be locked anyway and just do it once.
Since there are no other users and the code is short, fold it in.

Signed-off-by: Mateusz Guzik <mguzik@redhat.com>
---
 fs/proc/array.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d67a72d..5f0ec1f 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -141,25 +141,12 @@ static inline const char *get_task_state(struct task_struct *tsk)
 	return task_state_array[task_state_index(tsk)];
 }
 
-static inline int get_task_umask(struct task_struct *tsk)
-{
-	struct fs_struct *fs;
-	int umask = -ENOENT;
-
-	task_lock(tsk);
-	fs = tsk->fs;
-	if (fs)
-		umask = fs->umask;
-	task_unlock(tsk);
-	return umask;
-}
-
 static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *p)
 {
 	struct user_namespace *user_ns = seq_user_ns(m);
 	struct group_info *group_info;
-	int g, umask;
+	int g, umask = -1;
 	struct task_struct *tracer;
 	const struct cred *cred;
 	pid_t ppid, tpid = 0, tgid, ngid;
@@ -177,16 +164,16 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	ngid = task_numa_group_id(p);
 	cred = get_task_cred(p);
 
-	umask = get_task_umask(p);
-	if (umask >= 0)
-		seq_printf(m, "Umask:\t%#04o\n", umask);
-
 	task_lock(p);
+	if (p->fs)
+		umask = p->fs->umask;
 	if (p->files)
 		max_fds = files_fdtable(p->files)->max_fds;
 	task_unlock(p);
 	rcu_read_unlock();
 
+	if (umask >= 0)
+		seq_printf(m, "Umask:\t%#04o\n", umask);
 	seq_printf(m, "State:\t%s", get_task_state(p));
 
 	seq_put_decimal_ull(m, "\nTgid:\t", tgid);
-- 
1.8.3.1
