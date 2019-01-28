Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA3C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2111B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694360;
	bh=gxbu0msOyK0hyzZcK8J6f6om0Z7XPZn2H75u5x8rzu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gbl/6t3qq3YMrokUoD59I1ucdzFP9QOjzHxwgicyzebhJTwZ+sdXo0WwY2oG5OZii
	 V1fQTZ0zkj5j18ofix4OgxrShzU9Uk/kfZskdy/H8eG3d0Hq83dOo/p41vuNPFH0IV
	 wFVTNUrbbdkSoEzB7aZRJRI2b7dxXxvM7PcmD49Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfA1QSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388453AbfA1QSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:18:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D52D2147A;
        Mon, 28 Jan 2019 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692316;
        bh=gxbu0msOyK0hyzZcK8J6f6om0Z7XPZn2H75u5x8rzu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkfJYZ9b5ZRzfKArRmaKdmy3NjSrCLUyheTeQZkZPNs53gvy5sZM3AEpMJKkhUfGZ
         0xq3AckWmxtLPMylmxiXhissqW1HHmK0CD2054JDqVUAgu+vJF2XCWz+595Usz+OIW
         JYGfVLi7AlgIXMYvPUOVB8PrD0wyuZhkCoWvj7hw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 150/170] f2fs: fix sbi->extent_list corruption issue
Date:   Mon, 28 Jan 2019 11:11:40 -0500
Message-Id: <20190128161200.55107-150-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit e4589fa545e0020dbbc3c9bde35f35f949901392 ]

When there is a failure in f2fs_fill_super() after/during
the recovery of fsync'd nodes, it frees the current sbi and
retries again. This time the mount is successful, but the files
that got recovered before retry, still holds the extent tree,
whose extent nodes list is corrupted since sbi and sbi->extent_list
is freed up. The list_del corruption issue is observed when the
file system is getting unmounted and when those recoverd files extent
node is being freed up in the below context.

list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
<...>
kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
lr : __list_del_entry_valid+0x94/0xb4
pc : __list_del_entry_valid+0x94/0xb4
<...>
Call trace:
__list_del_entry_valid+0x94/0xb4
__release_extent_node+0xb0/0x114
__free_extent_tree+0x58/0x7c
f2fs_shrink_extent_tree+0xdc/0x3b0
f2fs_leave_shrinker+0x28/0x7c
f2fs_put_super+0xfc/0x1e0
generic_shutdown_super+0x70/0xf4
kill_block_super+0x2c/0x5c
kill_f2fs_super+0x44/0x50
deactivate_locked_super+0x60/0x8c
deactivate_super+0x68/0x74
cleanup_mnt+0x40/0x78
__cleanup_mnt+0x1c/0x28
task_work_run+0x48/0xd0
do_notify_resume+0x678/0xe98
work_pending+0x8/0x14

Fix this by not creating extents for those recovered files if shrinker is
not registered yet. Once mount is successful and shrinker is registered,
those files can have extents again.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h     | 11 ++++++++++-
 fs/f2fs/shrinker.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d2873f227072..64760314c5f2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2295,10 +2295,19 @@ static inline bool is_dot_dotdot(const struct qstr *str)
 
 static inline bool f2fs_may_extent_tree(struct inode *inode)
 {
-	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE) ||
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (!test_opt(sbi, EXTENT_CACHE) ||
 			is_inode_flag_set(inode, FI_NO_EXTENT))
 		return false;
 
+	/*
+	 * for recovered files during mount do not create extents
+	 * if shrinker is not registered.
+	 */
+	if (list_empty(&sbi->s_list))
+		return false;
+
 	return S_ISREG(inode->i_mode);
 }
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 5c60fc28ec75..ec71d2e29a15 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -138,6 +138,6 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi)
 	f2fs_shrink_extent_tree(sbi, __count_extent_cache(sbi));
 
 	spin_lock(&f2fs_list_lock);
-	list_del(&sbi->s_list);
+	list_del_init(&sbi->s_list);
 	spin_unlock(&f2fs_list_lock);
 }
-- 
2.19.1

