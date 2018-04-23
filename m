Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbeDWVuQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:50:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46066 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeDWVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:50:13 -0400
X-Google-Smtp-Source: AIpwx4+6RmEhkwtcW+o4/3YUeF0u4Fg1xpjiAI3Xz5+4u6e6S+rfJivxvlrkXjJwc3DF9sFuBjA+rA==
Date: Tue, 24 Apr 2018 00:50:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH] proc: restore seekdir("/proc", 256) semantics
Message-ID: <20180423215009.GE9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long time ago "/proc/self" was an honest symlink and all not-PID entries
were output before /proc/$PID. To not lose /proc/self in readdir output
after it became permanently positive dentry it was stuck before /proc/1.

One side effect of the change was that the code

	d = opendir("/proc");
	seekdir(d, 256);

stopped pointing to the first PID for applications that want to skip all
the crap.

Later "/proc/thread-self" was added in the same way.

It looks like ps and top aren't seeking over /proc but are simply
skipping over so nobody noticed.

Restore old behaviour, make seekdir(254) point to /proc/self and
seekdir(255) point to /proc/thread-self.

Commit in question:

	commit 021ada7dff22d0d9540ff596cb0f8bb866755ee1
	procfs: switch /proc/self away from proc_dir_entry

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   14 ++++++--------
 fs/proc/root.c |    4 ++--
 2 files changed, 8 insertions(+), 10 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3230,8 +3230,6 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	return iter;
 }
 
-#define TGID_OFFSET (FIRST_PROCESS_ENTRY + 2)
-
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
@@ -3239,22 +3237,22 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 	struct pid_namespace *ns = file_inode(file)->i_sb->s_fs_info;
 	loff_t pos = ctx->pos;
 
-	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
+	if (pos >= PID_MAX_LIMIT + FIRST_PROCESS_ENTRY)
 		return 0;
 
-	if (pos == TGID_OFFSET - 2) {
+	if (pos == FIRST_PROCESS_ENTRY - 2) {
 		struct inode *inode = d_inode(ns->proc_self);
 		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
-	if (pos == TGID_OFFSET - 1) {
+	if (pos == FIRST_PROCESS_ENTRY - 1) {
 		struct inode *inode = d_inode(ns->proc_thread_self);
 		if (!dir_emit(ctx, "thread-self", 11, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
-	iter.tgid = pos - TGID_OFFSET;
+	iter.tgid = pos - FIRST_PROCESS_ENTRY;
 	iter.task = NULL;
 	for (iter = next_tgid(ns, iter);
 	     iter.task;
@@ -3267,14 +3265,14 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 			continue;
 
 		len = snprintf(name, sizeof(name), "%u", iter.tgid);
-		ctx->pos = iter.tgid + TGID_OFFSET;
+		ctx->pos = iter.tgid + FIRST_PROCESS_ENTRY;
 		if (!proc_fill_cache(file, ctx, name, len,
 				     proc_pid_instantiate, iter.task, NULL)) {
 			put_task_struct(iter.task);
 			return 0;
 		}
 	}
-	ctx->pos = PID_MAX_LIMIT + TGID_OFFSET;
+	ctx->pos = PID_MAX_LIMIT + FIRST_PROCESS_ENTRY;
 	return 0;
 }
 
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -162,11 +162,11 @@ static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentr
 
 static int proc_root_readdir(struct file *file, struct dir_context *ctx)
 {
-	if (ctx->pos < FIRST_PROCESS_ENTRY) {
+	if (ctx->pos < FIRST_PROCESS_ENTRY - 2) {
 		int error = proc_readdir(file, ctx);
 		if (unlikely(error <= 0))
 			return error;
-		ctx->pos = FIRST_PROCESS_ENTRY;
+		ctx->pos = FIRST_PROCESS_ENTRY - 2;
 	}
 
 	return proc_pid_readdir(file, ctx);
