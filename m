Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422778AbeE1LCB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164868AbeE1LB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:01:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 422/496] f2fs: fix to check extent cache in f2fs_drop_extent_tree
Date: Mon, 28 May 2018 12:03:27 +0200
Message-Id: <20180528100337.536676765@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit bf617f7a92edc6bb2909db2bfa4576f50b280ee5 ]

If noextent_cache mount option is on, we will never initialize extent tree
in inode, but still we're going to access it in f2fs_drop_extent_tree,
result in kernel panic as below:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
 IP: _raw_write_lock+0xc/0x30
 Call Trace:
  ? f2fs_drop_extent_tree+0x41/0x70 [f2fs]
  f2fs_fallocate+0x5a0/0xdd0 [f2fs]
  ? common_file_perm+0x47/0xc0
  ? apparmor_file_permission+0x1a/0x20
  vfs_fallocate+0x15b/0x290
  SyS_fallocate+0x44/0x70
  do_syscall_64+0x6e/0x160
  entry_SYSCALL64_slow_path+0x25/0x25

This patch fixes to check extent cache status before using in
f2fs_drop_extent_tree.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/extent_cache.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -706,6 +706,9 @@ void f2fs_drop_extent_tree(struct inode
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 
+	if (!f2fs_may_extent_tree(inode))
+		return;
+
 	set_inode_flag(inode, FI_NO_EXTENT);
 
 	write_lock(&et->lock);
