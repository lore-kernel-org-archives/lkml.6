Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06681C67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEBE20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108067;
	bh=n14lwEW6eQtcGZgGPAiuOCYwMTpb0Yd+oEo2Cr5Es7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2sToYDxtHLeaX4v8hXNr1weFWZXe9s2opJnADKn4oYvBu5GM0UObPghTyb+aAWGnc
	 7D7CCywLIS5IrTmmRjfXGbkX91sFundKt1sM9ZerQjhlV2EAjSIoAoy+qr2wSSdtYU
	 sg9lJfQP7M9v/s1cP4otMF0I5qrnsdvycG1l/RP8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEBE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeLFOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbeLFOou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2606C2082B;
        Thu,  6 Dec 2018 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107489;
        bh=n14lwEW6eQtcGZgGPAiuOCYwMTpb0Yd+oEo2Cr5Es7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmRU6Bka2Z7laTeHveIPb9g0YPloETYZoOz2B6U2bw9wfk6C+tkGzPw18WpiRQNuv
         1jnIXesUT2pq1ClyHnnqs/rqTwKAv9it5WIq0X4H0r3wlCAHKxKIbXoCLeRs6wCJn3
         M89pI1z9UUWGIlP3BlQxBzuaXYlvU0wej330sTxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.9 025/101] binder: fix proc->files use-after-free
Date:   Thu,  6 Dec 2018 15:38:24 +0100
Message-Id: <20181206143013.033685511@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit 7f3dc0088b98533f17128058fac73cd8b2752ef1 upstream.

proc->files cleanup is initiated by binder_vma_close. Therefore
a reference on the binder_proc is not enough to prevent the
files_struct from being released while the binder_proc still has
a reference. This can lead to an attempt to dereference the
stale pointer obtained from proc->files prior to proc->files
cleanup. This has been seen once in task_get_unused_fd_flags()
when __alloc_fd() is called with a stale "files".

The fix is to protect proc->files with a mutex to prevent cleanup
while in use.

Signed-off-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |   41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -302,6 +302,7 @@ struct binder_proc {
 	struct mm_struct *vma_vm_mm;
 	struct task_struct *tsk;
 	struct files_struct *files;
+	struct mutex files_lock;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	void *buffer;
@@ -375,20 +376,26 @@ binder_defer_work(struct binder_proc *pr
 
 static int task_get_unused_fd_flags(struct binder_proc *proc, int flags)
 {
-	struct files_struct *files = proc->files;
 	unsigned long rlim_cur;
 	unsigned long irqs;
+	int ret;
 
-	if (files == NULL)
-		return -ESRCH;
-
-	if (!lock_task_sighand(proc->tsk, &irqs))
-		return -EMFILE;
-
+	mutex_lock(&proc->files_lock);
+	if (proc->files == NULL) {
+		ret = -ESRCH;
+		goto err;
+	}
+	if (!lock_task_sighand(proc->tsk, &irqs)) {
+		ret = -EMFILE;
+		goto err;
+	}
 	rlim_cur = task_rlimit(proc->tsk, RLIMIT_NOFILE);
 	unlock_task_sighand(proc->tsk, &irqs);
 
-	return __alloc_fd(files, 0, rlim_cur, flags);
+	ret = __alloc_fd(proc->files, 0, rlim_cur, flags);
+err:
+	mutex_unlock(&proc->files_lock);
+	return ret;
 }
 
 /*
@@ -397,8 +404,10 @@ static int task_get_unused_fd_flags(stru
 static void task_fd_install(
 	struct binder_proc *proc, unsigned int fd, struct file *file)
 {
+	mutex_lock(&proc->files_lock);
 	if (proc->files)
 		__fd_install(proc->files, fd, file);
+	mutex_unlock(&proc->files_lock);
 }
 
 /*
@@ -408,9 +417,11 @@ static long task_close_fd(struct binder_
 {
 	int retval;
 
-	if (proc->files == NULL)
-		return -ESRCH;
-
+	mutex_lock(&proc->files_lock);
+	if (proc->files == NULL) {
+		retval = -ESRCH;
+		goto err;
+	}
 	retval = __close_fd(proc->files, fd);
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
@@ -418,7 +429,8 @@ static long task_close_fd(struct binder_
 		     retval == -ERESTARTNOHAND ||
 		     retval == -ERESTART_RESTARTBLOCK))
 		retval = -EINTR;
-
+err:
+	mutex_unlock(&proc->files_lock);
 	return retval;
 }
 
@@ -2946,7 +2958,9 @@ static int binder_mmap(struct file *filp
 	binder_insert_free_buffer(proc, buffer);
 	proc->free_async_space = proc->buffer_size / 2;
 	barrier();
+	mutex_lock(&proc->files_lock);
 	proc->files = get_files_struct(current);
+	mutex_unlock(&proc->files_lock);
 	proc->vma = vma;
 	proc->vma_vm_mm = vma->vm_mm;
 
@@ -2982,6 +2996,7 @@ static int binder_open(struct inode *nod
 		return -ENOMEM;
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
+	mutex_init(&proc->files_lock);
 	INIT_LIST_HEAD(&proc->todo);
 	init_waitqueue_head(&proc->wait);
 	proc->default_priority = task_nice(current);
@@ -3220,9 +3235,11 @@ static void binder_deferred_func(struct
 
 		files = NULL;
 		if (defer & BINDER_DEFERRED_PUT_FILES) {
+			mutex_lock(&proc->files_lock);
 			files = proc->files;
 			if (files)
 				proc->files = NULL;
+			mutex_unlock(&proc->files_lock);
 		}
 
 		if (defer & BINDER_DEFERRED_FLUSH)


