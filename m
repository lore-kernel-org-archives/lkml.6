Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD64FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695F8208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695F8208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbeGKCZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:25:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbeGKCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4le-0003LG-I9; Wed, 11 Jul 2018 02:22:10 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 35/42] create_pipe_files(): switch the first allocation to alloc_file_pseudo()
Date:   Wed, 11 Jul 2018 03:21:59 +0100
Message-Id: <20180711022206.12571-35-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pipe.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9405e455f5b1..c8c4265bf87b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -744,53 +744,34 @@ static struct inode * get_pipe_inode(void)
 
 int create_pipe_files(struct file **res, int flags)
 {
-	int err;
 	struct inode *inode = get_pipe_inode();
 	struct file *f;
-	struct path path;
 
 	if (!inode)
 		return -ENFILE;
 
-	err = -ENOMEM;
-	path.dentry = d_alloc_pseudo(pipe_mnt->mnt_sb, &empty_name);
-	if (!path.dentry)
-		goto err_inode;
-	path.mnt = mntget(pipe_mnt);
-
-	d_instantiate(path.dentry, inode);
-
-	f = alloc_file(&path, FMODE_WRITE, &pipefifo_fops);
+	f = alloc_file_pseudo(inode, pipe_mnt, "", FMODE_WRITE, &pipefifo_fops);
 	if (IS_ERR(f)) {
-		err = PTR_ERR(f);
-		goto err_dentry;
+		free_pipe_info(inode->i_pipe);
+		iput(inode);
+		return PTR_ERR(f);
 	}
 
 	f->f_flags = O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT));
 	f->private_data = inode->i_pipe;
 
-	res[0] = alloc_file(&path, FMODE_READ, &pipefifo_fops);
+	res[0] = alloc_file(&f->f_path, FMODE_READ, &pipefifo_fops);
 	if (IS_ERR(res[0])) {
 		put_pipe_info(inode, inode->i_pipe);
 		fput(f);
 		return PTR_ERR(res[0]);
 	}
 
-	path_get(&path);
+	path_get(&f->f_path);
 	res[0]->private_data = inode->i_pipe;
 	res[0]->f_flags = O_RDONLY | (flags & O_NONBLOCK);
 	res[1] = f;
 	return 0;
-
-err_dentry:
-	free_pipe_info(inode->i_pipe);
-	path_put(&path);
-	return err;
-
-err_inode:
-	free_pipe_info(inode->i_pipe);
-	iput(inode);
-	return err;
 }
 
 static int __do_pipe_flags(int *fd, struct file **files, int flags)
-- 
2.11.0

