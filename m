Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D264C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D74208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFWoM/wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D74208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH0VfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeH0VfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:35:06 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61998208DA;
        Mon, 27 Aug 2018 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535392052;
        bh=By8VjTspwvJ/ITtjGngxsplCRqckKzEQMqFEdyqjQN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFWoM/wtkxJ+tRXOm/9DKWQhha8sl5ZZlb2O6HpKkvCtG2uDYcOcLfE2oagtAwjiq
         RQeyY2kJTI83uR6PDo+qzJMVzXViEm7+XQS9JPGBLUA6DewFPLdBGY5WyIdxK/1OCx
         ONeNnmOE9/TkBYHNkYz49Ba+PUe0GtIY1iuVgtVU=
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] exec: do unshare_files after de_thread
Date:   Mon, 27 Aug 2018 13:47:22 -0400
Message-Id: <20180827174722.3723-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827174722.3723-1-jlayton@kernel.org>
References: <20180827174722.3723-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX mandates that open fds and their associated file locks should be
preserved across an execve. This works, unless the process is
multithreaded at the time that execve is called.

In that case, we'll end up unsharing the files_struct but the locks will
still have their fl_owner set to the address of the old one. Eventually,
when the other threads die and the last reference to the old
files_struct is put, any POSIX locks get torn down since it looks like
a close occurred on them.

The result is that all of your open files will be intact with none of
the locks you held before execve. The simple answer to this is "use OFD
locks", but this is a nasty surprise and it violates the spec.

Fix this by doing unshare_files later during exec, after we've already
killed off the other threads in the process. This helps ensure that we
only unshare the files_struct during exec when it is truly shared with
other processes.

Note that because the unshare_files call is now done just after
de_thread, we need a mechanism to pass the displaced files_struct back
up to __do_execve_file. This is done via a new displaced_files field
inside the linux_binprm.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/exec.c               | 19 +++++++++----------
 include/linux/binfmts.h |  1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ca25f805ebad..a45b0cae5817 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1262,6 +1262,10 @@ int flush_old_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	retval = unshare_files(&bprm->displaced_files);
+	if (retval)
+		goto out;
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visibile until then. This also enables the update
@@ -1712,8 +1716,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 			    int flags, struct file *file)
 {
 	char *pathbuf = NULL;
-	struct linux_binprm *bprm;
-	struct files_struct *displaced;
+	struct linux_binprm *bprm = NULL;
 	int retval;
 
 	if (IS_ERR(filename))
@@ -1735,10 +1738,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	retval = unshare_files(&displaced);
-	if (retval)
-		goto out_ret;
-
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
@@ -1831,8 +1830,8 @@ static int __do_execve_file(int fd, struct filename *filename,
 	kfree(pathbuf);
 	if (filename)
 		putname(filename);
-	if (displaced) {
-		put_files_struct(displaced);
+	if (bprm->displaced_files) {
+		put_files_struct(bprm->displaced_files);
 	} else {
 		spin_lock(&current->files->file_lock);
 		current->files->in_exec = false;
@@ -1855,8 +1854,8 @@ static int __do_execve_file(int fd, struct filename *filename,
 	kfree(pathbuf);
 
 out_files:
-	if (displaced) {
-		reset_files_struct(displaced);
+	if (bprm && bprm->displaced_files) {
+		reset_files_struct(bprm->displaced_files);
 	} else {
 		spin_lock(&current->files->file_lock);
 		current->files->in_exec = false;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c05f24fac4f6..d7ec384bb1b0 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -49,6 +49,7 @@ struct linux_binprm {
 	unsigned int taso:1;
 #endif
 	unsigned int recursion_depth; /* only for search_binary_handler() */
+	struct files_struct * displaced_files;
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
-- 
2.17.1

