Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C28AC65C1D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBED20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0Txyvy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBED20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJGUoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeJGUoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:44:19 -0400
Received: from localhost.localdomain (unknown [49.77.226.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F2C2075C;
        Sun,  7 Oct 2018 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538919424;
        bh=xo2neObXqXRegz0wzfn2YmjjMn2Dn6Pyo0hvsH02zps=;
        h=From:To:Cc:Subject:Date:From;
        b=M0Txyvy34+LGsAnytYbxmosvcfl0dxC0F7mARcW1e4Sk6ySv5xggSUM8XQDLB8zco
         fkAj3LrKPnIVnwJ/IJlHc3al3DbSp5I2Mhh2MMIL6R4jCZthifD2MYRUAog3IjxRTS
         0Mof2O7PnOijFNwfvwFBQYDjoPzDhYEu91fKAkvA=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: spread f2fs_set_inode_flags()
Date:   Sun,  7 Oct 2018 19:06:15 +0800
Message-Id: <20181007110615.6826-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch changes codes as below:
- use f2fs_set_inode_flags() to update i_flags atomically to avoid
potential race.
- synchronize F2FS_I(inode)->i_flags to inode->i_flags in
f2fs_new_inode().
- use f2fs_set_inode_flags() to simply codes in f2fs_quota_{on,off}.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/namei.c | 2 ++
 fs/f2fs/super.c | 5 ++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 188a14bc9fcd..de9a5507f2ae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3411,7 +3411,7 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
 {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	file_set_encrypt(inode);
-	inode->i_flags |= S_ENCRYPTED;
+	f2fs_set_inode_flags(inode);
 #endif
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a285f3197bd7..4f8d4d8fc0e0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -122,6 +122,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
+	f2fs_set_inode_flags(inode);
+
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 79060c96da5b..5c561afbe376 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1939,8 +1939,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
-	inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
-					S_NOATIME | S_IMMUTABLE);
+	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 
@@ -1965,7 +1964,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags &= ~(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
-	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
+	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 out_put:
-- 
2.18.0

