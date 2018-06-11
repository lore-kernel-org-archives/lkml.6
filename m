Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8776C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0F220839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0F220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934623AbeFKVl3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:41:29 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:49420 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933271AbeFKVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:41:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 6E3DB181A2BBE;
        Mon, 11 Jun 2018 23:41:26 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        stable@vger.kernel.org
Subject: [PATCH] ubifs: Fix directory size calculation for symlinks
Date:   Mon, 11 Jun 2018 23:41:09 +0200
Message-Id: <20180611214109.14424-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to account the name of the symlink and not the target length.

Fixes: ca7f85be8d6c ("ubifs: Add support for encrypted symlinks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 4e267cc21c77..5c0d9a89663d 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1123,8 +1123,7 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	struct ubifs_inode *ui;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	int err, len = strlen(symname);
-	int sz_change = CALC_DENT_SIZE(len);
+	int err, sz_change, len = strlen(symname);
 	struct fscrypt_str disk_link;
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
 					.new_ino_d = ALIGN(len, 8),
@@ -1151,6 +1150,8 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out_budg;
 
+	sz_change = CALC_DENT_SIZE(fname_len(&nm));
+
 	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-- 
2.13.6

