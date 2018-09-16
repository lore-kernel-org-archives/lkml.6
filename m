Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6132ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE32220867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE32220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIPXDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:03:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50123 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeIPXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:03:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b1h-0005bu-LP; Sun, 16 Sep 2018 11:40:05 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b1g-00089P-7Y; Sun, 16 Sep 2018 11:40:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
        <87a7ohs5ow.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 19:39:54 +0200
In-Reply-To: <87a7ohs5ow.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 19:38:55 +0200")
Message-ID: <874leps5n9.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1b1g-00089P-7Y;;;mid=<874leps5n9.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Fm6K4TVan17PTKt7k8hTHKWlp8p5O2HE=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 1/3] exec: Move unshare_files down to avoid locks being dropped on exec.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5a521d..6f6167ec08eb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1252,6 +1252,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
  */
 int flush_old_exec(struct linux_binprm * bprm)
 {
+	struct files_struct *displaced;
 	int retval;
 
 	/*
@@ -1291,6 +1292,12 @@ int flush_old_exec(struct linux_binprm * bprm)
 	flush_thread();
 	current->personality &= ~bprm->per_clear;
 
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out;
+	if (displaced)
+		put_files_struct(displaced);
+
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
 	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
@@ -1713,7 +1720,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 {
 	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
-	struct files_struct *displaced;
 	int retval;
 
 	if (IS_ERR(filename))
@@ -1735,14 +1741,10 @@ static int __do_execve_file(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	retval = unshare_files(&displaced);
-	if (retval)
-		goto out_ret;
-
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
-		goto out_files;
+		goto out_ret;
 
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
@@ -1831,8 +1833,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	kfree(pathbuf);
 	if (filename)
 		putname(filename);
-	if (displaced)
-		put_files_struct(displaced);
 	return retval;
 
 out:
@@ -1849,9 +1849,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	free_bprm(bprm);
 	kfree(pathbuf);
 
-out_files:
-	if (displaced)
-		reset_files_struct(displaced);
 out_ret:
 	if (filename)
 		putname(filename);
-- 
2.17.1

