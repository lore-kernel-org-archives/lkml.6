Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6EFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98420867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F98420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeIPXFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:05:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59713 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeIPXFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:05:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b2z-0007wF-Hm; Sun, 16 Sep 2018 11:41:25 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b2y-00025x-FK; Sun, 16 Sep 2018 11:41:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
        <87a7ohs5ow.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 19:41:14 +0200
In-Reply-To: <87a7ohs5ow.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 19:38:55 +0200")
Message-ID: <87sh29qr0l.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1b2y-00025x-FK;;;mid=<87sh29qr0l.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+eAqVFbK+r3st06NXz++ZkJ8nUpQRdNYE=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 3/3] exec: Remove reset_files_struct
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that unshare_files is called after the point of no return there
are no more callers of reset_files_struct so remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 12 ------------
 include/linux/fdtable.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..eed29e034a47 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -422,18 +422,6 @@ void put_files_struct(struct files_struct *files)
 	}
 }
 
-void reset_files_struct(struct files_struct *files)
-{
-	struct task_struct *tsk = current;
-	struct files_struct *old;
-
-	old = tsk->files;
-	task_lock(tsk);
-	tsk->files = files;
-	task_unlock(tsk);
-	put_files_struct(old);
-}
-
 void exit_files(struct task_struct *tsk)
 {
 	struct files_struct * files = tsk->files;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e65379336c4c..68858f620e87 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -107,7 +107,6 @@ struct task_struct;
 
 struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
-void reset_files_struct(struct files_struct *);
 int unshare_files(void);
 struct files_struct *dup_fd(struct files_struct *, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
-- 
2.17.1

