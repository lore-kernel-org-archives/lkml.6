Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931ABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB8020838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdIxfnGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB8020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeH3V1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbeH3V1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:27:37 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02DC20839;
        Thu, 30 Aug 2018 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649867;
        bh=M29UbAcqa2kStdHv4P0JecL9w5mSQYEgcS68W46MRQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdIxfnGFZkc93xqMHvNdL0UfJZYCYraBw6uAPKjAIF52IEt4a3+kbQ/TeBuw4gar1
         pFc3P9Tm2ijzsEMECgmWtm281M0fQ7iWTtyTolQnNsqtoHurarGDbjmxKj6vI8tdaH
         AE3WKr7bZZT5+WmkNwR3oHU2Ql1h2w2Ms7H4efwU=
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] exec: delay clone(CLONE_FILES) if task associated with current files_struct is exec'ing
Date:   Thu, 30 Aug 2018 13:24:22 -0400
Message-Id: <20180830172423.21964-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830172423.21964-1-jlayton@kernel.org>
References: <20180830172423.21964-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a later patch, we're going to move the unshare_files call in
__do_execve_file to later in the process, but this opens up a potential
race with clone(CLONE_FILES). We could end up bumping the refcount on
the files_struct after we've checked to see if it was shared. What we
really want to do in that case is have the clone return -EAGAIN, much
like the handling of the similar situation in copy_fs.

Add a new in_exec boolean to files_struct that is protected by the
file_lock. Set it if the files_struct turns out not to be shared, and
clear at the end of __do_execve_file. If it's set when we go to
copy_process, then just return -EAGAIN.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/exec.c               | 14 ++++++++++++--
 fs/file.c               |  1 +
 include/linux/fdtable.h |  1 +
 kernel/fork.c           | 21 ++++++++++++++-------
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5a521d..ca25f805ebad 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1831,8 +1831,13 @@ static int __do_execve_file(int fd, struct filename *filename,
 	kfree(pathbuf);
 	if (filename)
 		putname(filename);
-	if (displaced)
+	if (displaced) {
 		put_files_struct(displaced);
+	} else {
+		spin_lock(&current->files->file_lock);
+		current->files->in_exec = false;
+		spin_unlock(&current->files->file_lock);
+	}
 	return retval;
 
 out:
@@ -1850,8 +1855,13 @@ static int __do_execve_file(int fd, struct filename *filename,
 	kfree(pathbuf);
 
 out_files:
-	if (displaced)
+	if (displaced) {
 		reset_files_struct(displaced);
+	} else {
+		spin_lock(&current->files->file_lock);
+		current->files->in_exec = false;
+		spin_unlock(&current->files->file_lock);
+	}
 out_ret:
 	if (filename)
 		putname(filename);
diff --git a/fs/file.c b/fs/file.c
index 42e0c8448b20..dc5de1ec5395 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -286,6 +286,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 	spin_lock_init(&newf->file_lock);
 	newf->thread_count = 1;
 	newf->resize_in_progress = false;
+	newf->in_exec = false;
 	init_waitqueue_head(&newf->resize_wait);
 	newf->next_fd = 0;
 	new_fdt = &newf->fdtab;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 213ec1430ba4..310454db9049 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -51,6 +51,7 @@ struct files_struct {
    */
 	atomic_t count;
 	bool resize_in_progress;
+	bool in_exec;
 	wait_queue_head_t resize_wait;
 
 	struct fdtable __rcu *fdt;
diff --git a/kernel/fork.c b/kernel/fork.c
index 82799544b646..d296dc501c0c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1373,10 +1373,15 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 		goto out;
 
 	if (clone_flags & CLONE_FILES) {
-		atomic_inc(&oldf->count);
 		spin_lock(&oldf->file_lock);
-		oldf->thread_count++;
-		spin_unlock(&oldf->file_lock);
+		if (oldf->in_exec) {
+			spin_unlock(&oldf->file_lock);
+			error = -EAGAIN;
+		} else {
+			oldf->thread_count++;
+			spin_unlock(&oldf->file_lock);
+			atomic_inc(&oldf->count);
+		}
 		goto out;
 	}
 
@@ -2420,18 +2425,20 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
-	int error, count;
+	int error;
 
 	if (!(unshare_flags & CLONE_FILES) || !fd)
 		return 0;
 
 	spin_lock(&fd->file_lock);
-	count = fd->thread_count;
-	spin_unlock(&fd->file_lock);
-	if (count > 1) {
+	if (fd->thread_count > 1) {
+		spin_unlock(&fd->file_lock);
 		*new_fdp = dup_fd(fd, &error);
 		if (!*new_fdp)
 			return error;
+	} else {
+		fd->in_exec = true;
+		spin_unlock(&fd->file_lock);
 	}
 
 	return 0;
-- 
2.17.1

