Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF4ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3297C20867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3297C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeIPXEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:04:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59688 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeIPXEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:04:34 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b2U-0007uY-N8; Sun, 16 Sep 2018 11:40:54 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b2T-0008Ly-B5; Sun, 16 Sep 2018 11:40:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
        <87a7ohs5ow.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 19:40:43 +0200
In-Reply-To: <87a7ohs5ow.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 19:38:55 +0200")
Message-ID: <87y3c1qr1g.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1b2T-0008Ly-B5;;;mid=<87y3c1qr1g.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Hnps8IMFsnJthhFMfhiIXR81ymFWCbTQ=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 2/3] exec: Simplify unshare_files
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that exec calls unshare_files after the point of no return there
is no reason to return displaced.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c           |  5 +----
 fs/exec.c               |  5 +----
 include/linux/fdtable.h |  2 +-
 kernel/fork.c           | 12 ++++++------
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1e2c87acac9b..968ee5744bf9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -546,7 +546,6 @@ void do_coredump(const siginfo_t *siginfo)
 	struct cred *cred;
 	int retval = 0;
 	int ispipe;
-	struct files_struct *displaced;
 	/* require nonrelative corefile path and be extra careful */
 	bool need_suid_safe = false;
 	bool core_dumped = false;
@@ -747,11 +746,9 @@ void do_coredump(const siginfo_t *siginfo)
 	}
 
 	/* get us an unshared descriptor table; almost always a no-op */
-	retval = unshare_files(&displaced);
+	retval = unshare_files();
 	if (retval)
 		goto close_fail;
-	if (displaced)
-		put_files_struct(displaced);
 	if (!dump_interrupted()) {
 		file_start_write(cprm.file);
 		core_dumped = binfmt->core_dump(&cprm);
diff --git a/fs/exec.c b/fs/exec.c
index 6f6167ec08eb..7eeffa7d98c6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1252,7 +1252,6 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
  */
 int flush_old_exec(struct linux_binprm * bprm)
 {
-	struct files_struct *displaced;
 	int retval;
 
 	/*
@@ -1292,11 +1291,9 @@ int flush_old_exec(struct linux_binprm * bprm)
 	flush_thread();
 	current->personality &= ~bprm->per_clear;
 
-	retval = unshare_files(&displaced);
+	retval = unshare_files();
 	if (retval)
 		goto out;
-	if (displaced)
-		put_files_struct(displaced);
 
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 41615f38bcff..e65379336c4c 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -108,7 +108,7 @@ struct task_struct;
 struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
 void reset_files_struct(struct files_struct *);
-int unshare_files(struct files_struct **);
+int unshare_files(void);
 struct files_struct *dup_fd(struct files_struct *, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
diff --git a/kernel/fork.c b/kernel/fork.c
index d896e9ca38b0..a06a609075eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2564,21 +2564,21 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
  *	the exec layer of the kernel.
  */
 
-int unshare_files(struct files_struct **displaced)
+int unshare_files(void)
 {
 	struct task_struct *task = current;
-	struct files_struct *copy = NULL;
+	struct files_struct *files, *copy = NULL;
 	int error;
 
 	error = unshare_fd(CLONE_FILES, &copy);
-	if (error || !copy) {
-		*displaced = NULL;
+	if (error || !copy)
 		return error;
-	}
-	*displaced = task->files;
+
+	files = task->files;
 	task_lock(task);
 	task->files = copy;
 	task_unlock(task);
+	put_files_struct(files);
 	return 0;
 }
 
-- 
2.17.1

