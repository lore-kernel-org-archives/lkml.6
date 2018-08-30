Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D69C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C545B2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0LZxIAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C545B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeH3V1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbeH3V1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:27:39 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F7C2083A;
        Thu, 30 Aug 2018 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649868;
        bh=9TQk6d5KzlBYFpfxvPAmVU04TMLIyl2oCJH/Ub5x6Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0LZxIARFk3kccXkIFsox7QzczIWDBV6LN12HoemSLtOp0BmpNkedwvm8zCcvGMI/
         b9m2ts2WBarAm5oRTJ1w7PNVIlH7rIurmoq/jxuZrqJGA43y5JcA2fkuu3NgmE5Hrl
         5lpe7Mhh+Px2vbAlYSr/nPEjTobwoRshooRj5AsU=
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] exec: do unshare_files after de_thread
Date:   Thu, 30 Aug 2018 13:24:23 -0400
Message-Id: <20180830172423.21964-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830172423.21964-1-jlayton@kernel.org>
References: <20180830172423.21964-1-jlayton@kernel.org>
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
 fs/exec.c               | 11 ++++++-----
 include/linux/binfmts.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ca25f805ebad..e32bd1a33660 100644
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
@@ -1713,7 +1717,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 {
 	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
-	struct files_struct *displaced;
+	struct files_struct *displaced = NULL;
 	int retval;
 
 	if (IS_ERR(filename))
@@ -1735,10 +1739,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	retval = unshare_files(&displaced);
-	if (retval)
-		goto out_ret;
-
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
@@ -1817,6 +1817,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	would_dump(bprm, bprm->file);
 
 	retval = exec_binprm(bprm);
+	displaced = bprm->displaced_files;
 	if (retval < 0)
 		goto out;
 
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

