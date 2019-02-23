Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B334C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03752085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550977682;
	bh=ibLX0ojixK1NNdd/Mk0kQic+m8hAHvUA4+Fd02oNdlI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0ULgh6tS8KmCsx3NPm9wmm59fy1RQx4D34wmvwyS3DwyL7HMqCw9rRgJg72A2T8dP
	 epPpr8SXnAM+pe7/npXVdAaIxNEIA3W+ESibWsKIHivMKOSiTMFqt791MhcN7DKapK
	 rik1fl8G2qllxnwPlc41EXMDvq6RxuJGLPX/pE4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBXDIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 22:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfBXDIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 22:08:00 -0500
Received: from localhost.localdomain (unknown [49.77.183.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0ED20855;
        Sun, 24 Feb 2019 03:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550977679;
        bh=ibLX0ojixK1NNdd/Mk0kQic+m8hAHvUA4+Fd02oNdlI=;
        h=From:To:Cc:Subject:Date:From;
        b=dud0IFtze//7B+lhXqRZftRu39717pyQVXA2ELH5pRsYq40GYMPV1KXTbJ46GuTp7
         npQ7yd905TsFDVbNUvQ+izdXHNvgRVy8abxFYBCQXeuR0u4NY+uDMXi7+ZxONr6NvC
         XiW2F+aXlcGcNRY5Rdq2Rn9sTnbCucvUa3op58Nc=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to dirty inode for i_mode recovery
Date:   Sat, 23 Feb 2019 09:48:27 +0800
Message-Id: <20190223014827.7028-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Seulbae Kim reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202637

We didn't recover permission field correctly after sudden power-cut,
the reason is in setattr we didn't add inode into global dirty list
once i_mode is changed, so latter checkpoint triggered by fsync will
not flush last i_mode into disk, result in this problem, fix it.

Reported-by: Seulbae Kim <seulbae@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b8f5d1208619..3a8c8eb0f549 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -766,7 +766,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int err;
-	bool size_changed = false;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
@@ -841,8 +840,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		down_write(&F2FS_I(inode)->i_sem);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		up_write(&F2FS_I(inode)->i_sem);
-
-		size_changed = true;
 	}
 
 	__setattr_copy(inode, attr);
@@ -856,7 +853,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	/* file size may changed here */
-	f2fs_mark_inode_dirty_sync(inode, size_changed);
+	f2fs_mark_inode_dirty_sync(inode, true);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
-- 
2.18.0

