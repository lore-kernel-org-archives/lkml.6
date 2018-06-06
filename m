Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0F9W9Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6B6460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeFFP4J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932351AbeFFPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:55:39 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: move s_res{u,g}id initialization to default_options()
Date: Wed,  6 Jun 2018 23:55:02 +0800
Message-Id: <20180606155502.11619-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180606155502.11619-1-chao@kernel.org>
References: <20180606155502.11619-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Let default_options() initialize s_res{u,g}id with default value like
other options.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 73d7d7e51a61..56f3af86f62c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1355,6 +1355,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
 	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
 	F2FS_OPTION(sbi).test_dummy_encryption = false;
+	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
+	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
 	sbi->readdir_ra = 1;
 
 	set_opt(sbi, BG_GC);
@@ -2702,9 +2704,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
-	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
-	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
-
 	/* precompute checksum seed for metadata */
 	if (f2fs_sb_has_inode_chksum(sb))
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
-- 
2.16.2.17.g38e79b1fd
