Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E12C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19E222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896969;
	bh=HEAJCrTb7lbzzCZRNiudwLejyRmoCdZUXndMzNXMpds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDe0HCnuaeRmUUbWvtYtqvj5yZYZR2WniMWeR9+uuA4tVRAMQozwZvbv/fKS3MM4V
	 R9BRuuKJ3lARivz6ncz1wkqIx8pyz0kGWCpT9sCeUBT2pY0b0yjwARAZ86hc1h8wl5
	 AYt+EQp7Roc7iqlFk95TW7b4YZzPpyGasRGzkE/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfBKO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388451AbfBKO4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7CAA20700;
        Mon, 11 Feb 2019 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896959;
        bh=HEAJCrTb7lbzzCZRNiudwLejyRmoCdZUXndMzNXMpds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWZcOI7hbDsnw2AJIswQTzdHdj85fSW6ehFbji94hRz9KOQ4XhTX7fq3krO9pRwWQ
         pElUIUY21TzF7oBuA3HHbR+BILnKExE32CBX/U3oCmFasFoxyWFkHfzl+PgBzwb4ea
         uCjP1ekzCzamCUOaJGyLL8F6lkJSrIbM2K+lM+DI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Yong <shengyong1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/205] f2fs: fix race between write_checkpoint and write_begin
Date:   Mon, 11 Feb 2019 15:17:22 +0100
Message-Id: <20190211141831.738429864@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2866fb16d67992195b0526d19e65acb6640fb87f ]

The following race could lead to inconsistent SIT bitmap:

Task A                          Task B
======                          ======
f2fs_write_checkpoint
  block_operations
    f2fs_lock_all
      down_write(node_change)
      down_write(node_write)
      ... sync ...
      up_write(node_change)
                                f2fs_file_write_iter
                                  set_inode_flag(FI_NO_PREALLOC)
                                  ......
                                  f2fs_write_begin(index=0, has inline data)
                                    prepare_write_begin
                                      __do_map_lock(AIO) => down_read(node_change)
                                      f2fs_convert_inline_page => update SIT
                                      __do_map_lock(AIO) => up_read(node_change)
  f2fs_flush_sit_entries <= inconsistent SIT
  finish write checkpoint
  sudden-power-off

If SPO occurs after checkpoint is finished, SIT bitmap will be set
incorrectly.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c68b319b07aa..3d37124eb63e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1880,6 +1880,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	bool locked = false;
 	struct extent_info ei = {0,0,0};
 	int err = 0;
+	int flag;
 
 	/*
 	 * we already allocated all the blocks, so we don't need to get
@@ -1889,9 +1890,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			!is_inode_flag_set(inode, FI_NO_PREALLOC))
 		return 0;
 
+	/* f2fs_lock_op avoids race between write CP and convert_inline_page */
+	if (f2fs_has_inline_data(inode) && pos + len > MAX_INLINE_DATA(inode))
+		flag = F2FS_GET_BLOCK_DEFAULT;
+	else
+		flag = F2FS_GET_BLOCK_PRE_AIO;
+
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_MASK) >= i_size_read(inode)) {
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+		__do_map_lock(sbi, flag, true);
 		locked = true;
 	}
 restart:
@@ -1929,6 +1936,7 @@ restart:
 				f2fs_put_dnode(&dn);
 				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
 								true);
+				WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
 				locked = true;
 				goto restart;
 			}
@@ -1942,7 +1950,7 @@ out:
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		__do_map_lock(sbi, flag, false);
 	return err;
 }
 
-- 
2.19.1



