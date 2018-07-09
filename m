Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED5C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC842089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC842089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeGIEzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:55:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38138 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbeGIEyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBo-0003gb-HP; Mon, 09 Jul 2018 04:54:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 24/27] new helper: alloc_file_clone()
Date:   Mon,  9 Jul 2018 05:54:14 +0100
Message-Id: <20180709045417.13988-24-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

alloc_file_clone(old_file, mode, ops): create a new struct file with
->f_path equal to that of old_file.  pipe converted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c      | 11 +++++++++++
 fs/pipe.c            |  5 +----
 include/linux/file.h |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index d78bc97f926f..fb7c3b007630 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -209,6 +209,17 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(alloc_file_pseudo);
 
+struct file *alloc_file_clone(struct file *base, fmode_t mode,
+				const struct file_operations *fops)
+{
+	struct file *f = alloc_file(&base->f_path, mode | FMODE_OPENED, fops);
+	if (!IS_ERR(f)) {
+		path_get(&f->f_path);
+		f->f_mapping = base->f_mapping;
+	}
+	return f;
+}
+
 /* the real guts of fput() - releasing the last reference to file
  */
 static void __fput(struct file *file)
diff --git a/fs/pipe.c b/fs/pipe.c
index 312af057f03a..94323a1d7c92 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -760,15 +760,12 @@ int create_pipe_files(struct file **res, int flags)
 	f->f_flags = O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT));
 	f->private_data = inode->i_pipe;
 
-	res[0] = alloc_file(&f->f_path, FMODE_READ | FMODE_OPENED,
-				&pipefifo_fops);
+	res[0] = alloc_file_clone(f, FMODE_READ, &pipefifo_fops);
 	if (IS_ERR(res[0])) {
 		put_pipe_info(inode, inode->i_pipe);
 		fput(f);
 		return PTR_ERR(res[0]);
 	}
-
-	path_get(&f->f_path);
 	res[0]->private_data = inode->i_pipe;
 	res[0]->f_flags = O_RDONLY | (flags & O_NONBLOCK);
 	res[1] = f;
diff --git a/include/linux/file.h b/include/linux/file.h
index 37a4d2c166de..c2e38ec2ee7f 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -23,6 +23,8 @@ extern struct file *alloc_file(const struct path *, fmode_t mode,
 	const struct file_operations *fop);
 extern struct file *alloc_file_pseudo(struct inode *, struct vfsmount *,
 	const char *, fmode_t, const struct file_operations *);
+extern struct file *alloc_file_clone(struct file *, fmode_t,
+	const struct file_operations *);
 
 static inline void fput_light(struct file *file, int fput_needed)
 {
-- 
2.11.0

