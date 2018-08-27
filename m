Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD4FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0912208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0912208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeH1ChU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:37:20 -0400
Received: from nautica.notk.org ([91.121.71.147]:54348 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1ChU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:37:20 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id CFB79C009; Tue, 28 Aug 2018 00:48:39 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: [PATCH 1/2] v9fs_dir_readdir: fix double-free on p9stat_read error
Date:   Tue, 28 Aug 2018 00:48:27 +0200
Message-Id: <1535410108-20650-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <000000000000af648b057456e234@google.com>
References: <000000000000af648b057456e234@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

p9stat_read will call p9stat_free on error, we should only free the
struct content on success.

There also is no need to "p9stat_init" st as the read function will
zero the whole struct for us anyway, so clean up the code a bit while
we are here.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
---
 fs/9p/vfs_dir.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index b0405d6aac85..48db9a9f13f9 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -76,15 +76,6 @@ static inline int dt_type(struct p9_wstat *mistat)
 	return rettype;
 }
 
-static void p9stat_init(struct p9_wstat *stbuf)
-{
-	stbuf->name  = NULL;
-	stbuf->uid   = NULL;
-	stbuf->gid   = NULL;
-	stbuf->muid  = NULL;
-	stbuf->extension = NULL;
-}
-
 /**
  * v9fs_alloc_rdir_buf - Allocate buffer used for read and readdir
  * @filp: opened file structure
@@ -145,12 +136,10 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 			rdir->tail = n;
 		}
 		while (rdir->head < rdir->tail) {
-			p9stat_init(&st);
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
 					  rdir->tail - rdir->head, &st);
 			if (err) {
 				p9_debug(P9_DEBUG_VFS, "returned %d\n", err);
-				p9stat_free(&st);
 				return -EIO;
 			}
 			reclen = st.size+2;
-- 
2.17.1

