Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C08C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5990D21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690448;
	bh=NqMnZkLH3p53+AJ86fMr5V7Tcu0HR27asKj0bxU0X6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLmH2Utu0xFMkkPBUrwq+HqsFgZJB9zSnG8P0/eXxxOS3Qheb/CoRQr7JzrqMv/Qd
	 1UyxFO8+m1pLVtn63lWVVuYTHuf6KUCFnQxQXn4gXWfi7njzvrjNbdkZ9C/i/fngy+
	 gKgNeb9w20poY0l/9gHFjwOC49Pvj8K3Tmy2sg1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfA1Pr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfA1PrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E15B32177E;
        Mon, 28 Jan 2019 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690441;
        bh=NqMnZkLH3p53+AJ86fMr5V7Tcu0HR27asKj0bxU0X6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKCk1Cly+9JSb/bT0gJceXcyVaYXS/c4I1vrE8IDeYyhLf+7NumZhoixk1K6FS+Mb
         9fcZruJgQF+1lxgIvNtEz0u6xz2ZpF5OW0UoG5w7ga5Zgh8KF7TffAye3rKHL+JDWd
         9OGMO7k+QnjIUPZO1Iyf78/XZ8Cot5hpSg1Altl8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sheng Yong <shengyong1@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.20 088/304] f2fs: fix race between write_checkpoint and write_begin
Date:   Mon, 28 Jan 2019 10:40:05 -0500
Message-Id: <20190128154341.47195-88-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheng Yong <shengyong1@huawei.com>

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
index 17049b030b6c..e90ca6aa3a00 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2326,6 +2326,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	bool locked = false;
 	struct extent_info ei = {0,0,0};
 	int err = 0;
+	int flag;
 
 	/*
 	 * we already allocated all the blocks, so we don't need to get
@@ -2335,9 +2336,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
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
@@ -2375,6 +2382,7 @@ restart:
 				f2fs_put_dnode(&dn);
 				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
 								true);
+				WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
 				locked = true;
 				goto restart;
 			}
@@ -2388,7 +2396,7 @@ out:
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		__do_map_lock(sbi, flag, false);
 	return err;
 }
 
-- 
2.19.1

