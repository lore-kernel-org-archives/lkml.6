Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D02C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA01216FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln7sKVz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA01216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeHTSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeHTSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:10:50 -0400
Received: from localhost.localdomain (unknown [121.229.162.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA24421570;
        Mon, 20 Aug 2018 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534776892;
        bh=BilJdYKyhxWFJGMiMikRHnMg0Dj6Mtrw/ETGLxN5jwI=;
        h=From:To:Cc:Subject:Date:From;
        b=ln7sKVz+WqFYMBL02znKb1mhJVWAu1NrlN8j5t694lVDync6aAEZ6Ke1Q1Rp/0pxG
         A10f/l5XnVselIN0h4geK6QlHR8b12YR+ohywcv9MB1v4R8x1QnnldFlCbEWAg9aXj
         pYMgpMP7YR7T2adyg2jjp6dYMzthqm7xGbICSbMQ=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to flush all dirty inodes during recovery
Date:   Mon, 20 Aug 2018 22:54:07 +0800
Message-Id: <20180820145407.5142-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

generic/417 reported as blow:

------------[ cut here ]------------
kernel BUG at /home/yuchao/git/devf2fs/inode.c:695!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 21697 Comm: umount Tainted: G        W  O      4.18.0-rc2+ #39
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
EIP: f2fs_evict_inode+0x556/0x580 [f2fs]
Call Trace:
 ? _raw_spin_unlock+0x2c/0x50
 evict+0xa8/0x170
 dispose_list+0x34/0x40
 evict_inodes+0x118/0x120
 generic_shutdown_super+0x41/0x100
 ? rcu_read_lock_sched_held+0x97/0xa0
 kill_block_super+0x22/0x50
 kill_f2fs_super+0x6f/0x80 [f2fs]
 deactivate_locked_super+0x3d/0x70
 deactivate_super+0x40/0x60
 cleanup_mnt+0x39/0x70
 __cleanup_mnt+0x10/0x20
 task_work_run+0x81/0xa0
 exit_to_usermode_loop+0x59/0xa7
 do_fast_syscall_32+0x1f5/0x22c
 entry_SYSENTER_32+0x53/0x86
EIP: f2fs_evict_inode+0x556/0x580 [f2fs]

It can simply reproduced with scripts:

1. mkfs.f2fs /dev/zram0
2. mount -t f2fs /dev/zram0 /mnt/f2fs
3. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4k" -c "fsync"
4. godown /mnt/f2fs
5. umount /mnt/f2fs
6. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
7. umount /mnt/f2fs

The reason is: during recovery, i_{c,m}time of inode will be updated, then
the inode can be set dirty w/o being tracked in sbi->inode_list[DIRTY_META]
global list, so later write_checkpoint will not flush such dirty inode into
node page.

Once umount is called, sync_filesystem() in generic_shutdown_super() will
skip sync dirty inodes due to sb_rdonly check, leaving dirty inodes there.

To solve this issue, add sync_inodes_sb() in recovery to make sure all
dirty inodes will be flushed before write_checkpoint().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 95511ed11a22..7812121ab057 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -701,6 +701,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
 		};
+
+		sync_inodes_sb(sbi->sb);
+
 		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
-- 
2.18.0

