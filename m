Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C221C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C130222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899520;
	bh=yAtpNdE9k2J1QG0wDC94ANOwj0S+++ZwKJgC/emeGnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6z/c9Mjr0BWmIXPoP459TLlrGvlXlKJdMXQIYjDckzJyvotUSm3BgqQk61GeKmF8
	 RXNmU0VkljE5Fjw8uuWNEL/DU9vdhHj8zA31tDKpwQBSRc3Z6lOT5RlQp5PkW0gL6h
	 iUKOYIw9TnIuUrhkgu+kulC+CWc6rUFhWVf/oLq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfBKOuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfBKOuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3349C2081B;
        Mon, 11 Feb 2019 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896600;
        bh=yAtpNdE9k2J1QG0wDC94ANOwj0S+++ZwKJgC/emeGnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnI4baDINjuQiiLPri8tznDjX/e4yOC9qJecN1u/8BVLyoFnnZ0/6vLd5Z92+Ix35
         V6SvRJQMOwGNAEQBDz4UbVfYX8z+OBwkd0v6o3cdLAk0yb/eDrlPfrjth8zX97hzBo
         Jyd6+ZM/2wQRxDl8096g3V3bmw2ZMB7ebRjRdHE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 221/313] f2fs: fix sbi->extent_list corruption issue
Date:   Mon, 11 Feb 2019 15:18:21 +0100
Message-Id: <20190211141907.978430394@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 462a2fb8aa69..eea2811dc672 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2614,10 +2614,19 @@ static inline bool is_dot_dotdot(const struct qstr *str)
 
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
index 36cfd816c160..29042e6d5126 100644
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



