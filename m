Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeDXCVV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:21:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeDXCVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:21:15 -0400
From: jeffm@suse.com
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 1/5] procfs: factor out a few helpers
Date: Mon, 23 Apr 2018 22:21:02 -0400
Message-Id: <20180424022106.16952-2-jeffm@suse.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com>
References: <20180424022106.16952-1-jeffm@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

In order to make the following series easier to review, this patch
factors out a few helpers:
- proc_fill_cache_entry: proc_fill_cache that takes an entry instead of
  an entry, a name, and a name length
- pident_lookup_task: proc_pident_lookup that takes a task, allowing the
  caller to do the task validation
- pid_entry_match_dentry: the comparison between a dentry's name and
  a pid_entry

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/proc/base.c | 60 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324325ed..e9876a89a5ad 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2453,19 +2453,28 @@ static int proc_pident_instantiate(struct inode *dir,
 	return -ENOENT;
 }
 
-static struct dentry *proc_pident_lookup(struct inode *dir, 
-					 struct dentry *dentry,
-					 const struct pid_entry *ents,
-					 unsigned int nents)
+static bool proc_fill_cache_entry(struct file *file, struct dir_context *ctx,
+				  const struct pid_entry *entry,
+				  struct task_struct *task)
 {
-	int error;
-	struct task_struct *task = get_proc_task(dir);
-	const struct pid_entry *p, *last;
+	return proc_fill_cache(file, ctx, entry->name, entry->len,
+			       proc_pident_instantiate, task, entry);
+}
 
-	error = -ENOENT;
+static bool pid_entry_match_dentry(const struct pid_entry *entry,
+				   const struct dentry *dentry)
+{
+	if (entry->len != dentry->d_name.len)
+		return false;
+	return !memcmp(dentry->d_name.name, entry->name, entry->len);
+}
 
-	if (!task)
-		goto out_no_task;
+static int proc_pident_lookup_task(struct inode *dir, struct dentry *dentry,
+				   const struct pid_entry *ents,
+				   unsigned int nents,
+				   struct task_struct *task)
+{
+	const struct pid_entry *p, *last;
 
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
@@ -2473,18 +2482,30 @@ static struct dentry *proc_pident_lookup(struct inode *dir,
 	 */
 	last = &ents[nents];
 	for (p = ents; p < last; p++) {
-		if (p->len != dentry->d_name.len)
-			continue;
-		if (!memcmp(dentry->d_name.name, p->name, p->len))
+		if (pid_entry_match_dentry(p, dentry))
 			break;
 	}
 	if (p >= last)
-		goto out;
+		return -ENOENT;
+
+	return proc_pident_instantiate(dir, dentry, task, p);
+}
+
+static struct dentry *proc_pident_lookup(struct inode *dir,
+					 struct dentry *dentry,
+					 const struct pid_entry *ents,
+					 unsigned int nents)
+{
+	struct task_struct *task;
+	int error = -ENOENT;
+
+	task = get_proc_task(dir);
+	if (task) {
+		error = proc_pident_lookup_task(dir, dentry, ents,
+						nents, task);
+		put_task_struct(task);
+	}
 
-	error = proc_pident_instantiate(dir, dentry, task, p);
-out:
-	put_task_struct(task);
-out_no_task:
 	return ERR_PTR(error);
 }
 
@@ -2504,8 +2525,7 @@ static int proc_pident_readdir(struct file *file, struct dir_context *ctx,
 		goto out;
 
 	for (p = ents + (ctx->pos - 2); p < ents + nents; p++) {
-		if (!proc_fill_cache(file, ctx, p->name, p->len,
-				proc_pident_instantiate, task, p))
+		if (!proc_fill_cache_entry(file, ctx, p, task))
 			break;
 		ctx->pos++;
 	}
-- 
2.12.3
