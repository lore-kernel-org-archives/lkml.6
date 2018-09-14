Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E84FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD04321477
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wgw8hJSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD04321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeINQHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeINQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:07:12 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561BD2146E;
        Fri, 14 Sep 2018 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536922394;
        bh=CJSnm+wHspCAXTX6nmJb2RjOFk9BY29HLk5k6H680Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgw8hJSC2RlkYf6DkYKPDQ9R8E8SPVCxYf3VXm4bRQ+6oDWih4N2HK0Ua+N9S+7VI
         Vp5R7CUe7VoOU57wEcB4MnrI7xhQeINgJIakM0ADW/UFZtGFrG0XjIWj2kAIgnnnBM
         HmgZhEnVm4dB0/VD8t5X+eRdsujfI0o3EavWEiU8=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     ebiederm@xmission.com, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] exec: delay clone(CLONE_FILES) if task associated with current files_struct is exec'ing
Date:   Fri, 14 Sep 2018 06:53:09 -0400
Message-Id: <20180914105310.6454-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914105310.6454-1-jlayton@kernel.org>
References: <20180914105310.6454-1-jlayton@kernel.org>
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
index e71a70d70158..c8a68481d7eb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1831,8 +1831,13 @@ static int __do_execve_file(int fd, struct filename *filename,
 	kfree(pathbuf);
 	if (filename)
 		putname(filename);
-	if (displaced)
+	if (displaced) {
 		release_files_struct(displaced);
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
index e35eeff4593c..535321846425 100644
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
index 2cb02f438201..a09ba1b20693 100644
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
index c7eb63e4d5c1..a3786efb39f1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1372,10 +1372,15 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
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
 
@@ -2419,18 +2424,20 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
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

