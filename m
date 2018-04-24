Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932759AbeDXCVR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:36644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932670AbeDXCVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:21:14 -0400
From: jeffm@suse.com
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 2/5] procfs: factor out inode revalidation work from pid_revalidation
Date: Mon, 23 Apr 2018 22:21:03 -0400
Message-Id: <20180424022106.16952-3-jeffm@suse.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com>
References: <20180424022106.16952-1-jeffm@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

Subsequent patches will introduce their own d_revalidate callbacks and we
won't want to get the task multiple times.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/proc/base.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index e9876a89a5ad..e7ca45504a5f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1802,14 +1802,24 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 
 /* dentry stuff */
 
+
+/*
+ * Rewrite the inode's ownerships here because the owning task may have
+ * performed a setuid(), etc.
+ */
+static void pid_revalidate_inode(struct inode *inode, struct task_struct *task)
+{
+	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
+
+	inode->i_mode &= ~(S_ISUID | S_ISGID);
+	security_task_to_inode(task, inode);
+}
+
 /*
  *	Exceptional case: normally we are not allowed to unhash a busy
  * directory. In this case, however, we can do it - no aliasing problems
  * due to the way we treat inodes.
  *
- * Rewrite the inode's ownerships here because the owning task may have
- * performed a setuid(), etc.
- *
  */
 int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
@@ -1823,10 +1833,7 @@ int pid_revalidate(struct dentry *dentry, unsigned int flags)
 	task = get_proc_task(inode);
 
 	if (task) {
-		task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
-
-		inode->i_mode &= ~(S_ISUID | S_ISGID);
-		security_task_to_inode(task, inode);
+		pid_revalidate_inode(inode, task);
 		put_task_struct(task);
 		return 1;
 	}
-- 
2.12.3
