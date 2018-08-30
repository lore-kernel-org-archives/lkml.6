Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF08C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981402083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="122cBtPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981402083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeH3V1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeH3V1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:27:37 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D3520837;
        Thu, 30 Aug 2018 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649866;
        bh=l4lL2lnAQOveHH40zn0hir3oZW87Ki4F4Q2bN5aDhdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=122cBtPKBbTmTE+lDBJWFhSEd0e29Xyan97J9EjYxz3FZaAATa2ISHJiV8TJ0NkHF
         lTc+S+YzaSBi0EB7l4n0drWLLLvYjA6IRf/joabnMtC3jyKdxKax82mwMg2dqF/kon
         gk6nKVOcmMByrmGOfKfyf6gTAeu510mGbu/t26sg=
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] exec: separate thread_count for files_struct
Date:   Thu, 30 Aug 2018 13:24:21 -0400
Message-Id: <20180830172423.21964-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830172423.21964-1-jlayton@kernel.org>
References: <20180830172423.21964-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we have a single refcount variable inside the files_struct.
When we go to unshare the files_struct, we check this counter and if
it's elevated, then we allocate a new files_struct instead of just
repurposing the old one, under the assumption that that indicates that
it's shared between tasks.

This is not necessarily the case, however. Each task associated with the
files_struct does get a long-held reference, but the refcount can be
elevated for other reasons as well, by callers of get_files_struct.

This means that we can end up allocating a new files_struct if we just
happen to race with a call to get_files_struct. Fix this by adding a new
counter to track the number associated threads, and use that to
determine whether to allocate a new files_struct when unsharing.

We protect this new counter with the file_lock instead of doing it with
atomics, as a later patch will need to track an "in_exec" flag that will
need to be handled in conjunction with the thread counter.

Reported-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/file.c               | 17 +++++++++++++++++
 include/linux/fdtable.h |  1 +
 kernel/fork.c           | 17 ++++++++++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..42e0c8448b20 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -284,6 +284,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 	atomic_set(&newf->count, 1);
 
 	spin_lock_init(&newf->file_lock);
+	newf->thread_count = 1;
 	newf->resize_in_progress = false;
 	init_waitqueue_head(&newf->resize_wait);
 	newf->next_fd = 0;
@@ -415,6 +416,8 @@ void put_files_struct(struct files_struct *files)
 	if (atomic_dec_and_test(&files->count)) {
 		struct fdtable *fdt = close_files(files);
 
+		WARN_ON_ONCE(files->thread_count);
+
 		/* free the arrays if they are not embedded */
 		if (fdt != &files->fdtab)
 			__free_fdtable(fdt);
@@ -428,9 +431,19 @@ void reset_files_struct(struct files_struct *files)
 	struct files_struct *old;
 
 	old = tsk->files;
+
+	spin_lock(&files->file_lock);
+	++files->thread_count;
+	spin_unlock(&files->file_lock);
+
 	task_lock(tsk);
 	tsk->files = files;
 	task_unlock(tsk);
+
+	spin_lock(&old->file_lock);
+	--old->thread_count;
+	spin_unlock(&old->file_lock);
+
 	put_files_struct(old);
 }
 
@@ -442,6 +455,9 @@ void exit_files(struct task_struct *tsk)
 		task_lock(tsk);
 		tsk->files = NULL;
 		task_unlock(tsk);
+		spin_lock(&files->file_lock);
+		--files->thread_count;
+		spin_unlock(&files->file_lock);
 		put_files_struct(files);
 	}
 }
@@ -457,6 +473,7 @@ struct files_struct init_files = {
 		.full_fds_bits	= init_files.full_fds_bits_init,
 	},
 	.file_lock	= __SPIN_LOCK_UNLOCKED(init_files.file_lock),
+	.thread_count	= 1,
 };
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 41615f38bcff..213ec1430ba4 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -59,6 +59,7 @@ struct files_struct {
    * written part on a separate cache line in SMP
    */
 	spinlock_t file_lock ____cacheline_aligned_in_smp;
+	int thread_count;
 	unsigned int next_fd;
 	unsigned long close_on_exec_init[1];
 	unsigned long open_fds_init[1];
diff --git a/kernel/fork.c b/kernel/fork.c
index d896e9ca38b0..82799544b646 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1374,6 +1374,9 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		spin_lock(&oldf->file_lock);
+		oldf->thread_count++;
+		spin_unlock(&oldf->file_lock);
 		goto out;
 	}
 
@@ -2417,10 +2420,15 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
-	int error = 0;
+	int error, count;
+
+	if (!(unshare_flags & CLONE_FILES) || !fd)
+		return 0;
 
-	if ((unshare_flags & CLONE_FILES) &&
-	    (fd && atomic_read(&fd->count) > 1)) {
+	spin_lock(&fd->file_lock);
+	count = fd->thread_count;
+	spin_unlock(&fd->file_lock);
+	if (count > 1) {
 		*new_fdp = dup_fd(fd, &error);
 		if (!*new_fdp)
 			return error;
@@ -2579,6 +2587,9 @@ int unshare_files(struct files_struct **displaced)
 	task_lock(task);
 	task->files = copy;
 	task_unlock(task);
+	spin_lock(&task->files->file_lock);
+	--task->files->thread_count;
+	spin_unlock(&task->files->file_lock);
 	return 0;
 }
 
-- 
2.17.1

