Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiQ7lPjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8C3360555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeFFP5G (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752880AbeFFPzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:55:37 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: don't acquire orphan ino during recovery
Date: Wed,  6 Jun 2018 23:55:01 +0800
Message-Id: <20180606155502.11619-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

During orphan inode recovery, checkpoint should never succeed due to
SBI_POR_DOING flag, so we don't need acquire orphan ino which only be
used by checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9f825a5a5c9f..ae0a06a8dec1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -578,12 +578,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode;
 	struct node_info ni;
-	int err = f2fs_acquire_orphan_inode(sbi);
-
-	if (err)
-		goto err_out;
-
-	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
+	int err;
 
 	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode)) {
@@ -613,7 +608,6 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 		err = -EIO;
 		goto err_out;
 	}
-	__remove_ino_entry(sbi, ino, ORPHAN_INO);
 	return 0;
 
 err_out:
-- 
2.16.2.17.g38e79b1fd
