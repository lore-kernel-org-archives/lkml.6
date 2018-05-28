Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938976AbeE1Mri (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937813AbeE1K5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:57:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 320/496] Btrfs: clean up resources during umount after trans is aborted
Date: Mon, 28 May 2018 12:01:45 +0200
Message-Id: <20180528100333.321422568@linuxfoundation.org>
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

From: Liu Bo <bo.liu@linux.alibaba.com>

[ Upstream commit af7227338135d2f1b1552bf9a6d43e02dcba10b9 ]

Currently if some fatal errors occur, like all IO get -EIO, resources
would be cleaned up when
a) transaction is being committed or
b) BTRFS_FS_STATE_ERROR is set

However, in some rare cases, resources may be left alone after transaction
gets aborted and umount may run into some ASSERT(), e.g.
ASSERT(list_empty(&block_group->dirty_list));

For case a), in btrfs_commit_transaciton(), there're several places at the
beginning where we just call btrfs_end_transaction() without cleaning up
resources.  For case b), it is possible that the trans handle doesn't have
any dirty stuff, then only trans hanlde is marked as aborted while
BTRFS_FS_STATE_ERROR is not set, so resources remain in memory.

This makes btrfs also check BTRFS_FS_STATE_TRANS_ABORTED to make sure that
all resources won't stay in memory after umount.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3896,7 +3896,8 @@ void close_ctree(struct btrfs_fs_info *f
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
+	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
 		btrfs_error_commit_super(fs_info);
 
 	kthread_stop(fs_info->transaction_kthread);
