Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35B3208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35B3208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeGKCYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45510 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbeGKCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4la-0003Hn-Px; Wed, 11 Jul 2018 02:22:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 07/42] create_pipe_files(): use fput() if allocation of the second file fails
Date:   Wed, 11 Jul 2018 03:21:31 +0100
Message-Id: <20180711022206.12571-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... just use put_pipe_info() to get the pipe->files down to 1 and let
fput()-called pipe_release() do freeing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pipe.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index bb0840e234f3..9405e455f5b1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -771,8 +771,9 @@ int create_pipe_files(struct file **res, int flags)
 
 	res[0] = alloc_file(&path, FMODE_READ, &pipefifo_fops);
 	if (IS_ERR(res[0])) {
-		err = PTR_ERR(res[0]);
-		goto err_file;
+		put_pipe_info(inode, inode->i_pipe);
+		fput(f);
+		return PTR_ERR(res[0]);
 	}
 
 	path_get(&path);
@@ -781,8 +782,6 @@ int create_pipe_files(struct file **res, int flags)
 	res[1] = f;
 	return 0;
 
-err_file:
-	put_filp(f);
 err_dentry:
 	free_pipe_info(inode->i_pipe);
 	path_put(&path);
-- 
2.11.0

