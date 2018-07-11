Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CE8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2925208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2925208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbeGKC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:27:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45556 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbeGKCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003If-EC; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 13/42] introduce FMODE_OPENED
Date:   Wed, 11 Jul 2018 03:21:37 +0100
Message-Id: <20180711022206.12571-13-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

basically, "is that instance set up enough for regular fput(), or
do we want put_filp() for that one".

NOTE: the only alloc_file() caller that could be followed by put_filp()
is in arch/ia64/kernel/perfmon.c, which is (Kconfig-level) broken.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c    | 2 +-
 fs/open.c          | 3 ++-
 include/linux/fs.h | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index d7a03a47b702..eaee481295de 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -174,7 +174,7 @@ struct file *alloc_file(const struct path *path, fmode_t mode,
 	if ((mode & FMODE_WRITE) &&
 	     likely(fop->write || fop->write_iter))
 		mode |= FMODE_CAN_WRITE;
-	file->f_mode = mode;
+	file->f_mode = mode | FMODE_OPENED;
 	file->f_op = fop;
 	if ((mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_inc(path->dentry->d_inode);
diff --git a/fs/open.c b/fs/open.c
index 008a65e82de5..ce092dda5472 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -752,7 +752,7 @@ static int do_dentry_open(struct file *f,
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH;
+		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		f->f_op = &empty_fops;
 		return 0;
 	}
@@ -794,6 +794,7 @@ static int do_dentry_open(struct file *f,
 		if (error)
 			goto cleanup_all;
 	}
+	f->f_mode |= FMODE_OPENED;
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_inc(inode);
 	if ((f->f_mode & FMODE_READ) &&
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4ca4c9c1130..05f34726e29c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -148,6 +148,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* Has write method(s) */
 #define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
 
+#define FMODE_OPENED		((__force fmode_t)0x80000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
-- 
2.11.0

