Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeDWVh6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:37:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38247 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeDWVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:37:54 -0400
X-Google-Smtp-Source: AIpwx485eX0a7r5h2axbwgZeW27PuDMDGdtdAkX47i93v0DPa6xwd4xVbGiqIyVCTgGT/OwoHm4iyw==
Date: Tue, 24 Apr 2018 00:37:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use "unsigned int" in proc_fill_cache()
Message-ID: <20180423213751.GC9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All those lengths are unsigned as they should be.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c     |    6 +++---
 fs/proc/fd.c       |    2 +-
 fs/proc/internal.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1874,7 +1874,7 @@ const struct dentry_operations pid_dentry_operations =
  * by stat.
  */
 bool proc_fill_cache(struct file *file, struct dir_context *ctx,
-	const char *name, int len,
+	const char *name, unsigned int len,
 	instantiate_t instantiate, struct task_struct *task, const void *ptr)
 {
 	struct dentry *child, *dir = file->f_path.dentry;
@@ -3263,7 +3263,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 	     iter.task;
 	     iter.tgid += 1, iter = next_tgid(ns, iter)) {
 		char name[10 + 1];
-		int len;
+		unsigned int len;
 
 		cond_resched();
 		if (!has_pid_permissions(ns, iter.task, HIDEPID_INVISIBLE))
@@ -3595,7 +3595,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	     task;
 	     task = next_tid(task), ctx->pos++) {
 		char name[10 + 1];
-		int len;
+		unsigned int len;
 		tid = task_pid_nr_ns(task, ns);
 		len = snprintf(name, sizeof(name), "%u", tid);
 		if (!proc_fill_cache(file, ctx, name, len,
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -237,7 +237,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	     fd < files_fdtable(files)->max_fds;
 	     fd++, ctx->pos++) {
 		char name[10 + 1];
-		int len;
+		unsigned int len;
 
 		if (!fcheck_files(files, fd))
 			continue;
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -157,7 +157,7 @@ extern loff_t mem_lseek(struct file *, loff_t, int);
 /* Lookups */
 typedef int instantiate_t(struct inode *, struct dentry *,
 				     struct task_struct *, const void *);
-extern bool proc_fill_cache(struct file *, struct dir_context *, const char *, int,
+bool proc_fill_cache(struct file *, struct dir_context *, const char *, unsigned int,
 			   instantiate_t, struct task_struct *, const void *);
 
 /*
