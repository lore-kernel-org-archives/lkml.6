Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78852C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D832151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D832151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHULor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:44:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeHULor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:44:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 643034D3FC6B3;
        Tue, 21 Aug 2018 16:25:32 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Tue, 21 Aug 2018 16:25:25 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to flush all dirty inodes recovered in readonly fs
Date:   Tue, 21 Aug 2018 16:25:21 +0800
Message-ID: <20180821082521.9681-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Enable quota feature during mkfs.

Testcase1:
1. mkfs.f2fs /dev/zram0
2. mount -t f2fs /dev/zram0 /mnt/f2fs
3. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4k" -c "fsync"
4. godown /mnt/f2fs
5. umount /mnt/f2fs
6. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
7. umount /mnt/f2fs

Testcase2:
1. mkfs.f2fs /dev/zram0
2. mount -t f2fs /dev/zram0 /mnt/f2fs
3. touch /mnt/f2fs/file
4. create process[pid = x] do:
	a) open /mnt/f2fs/file;
	b) unlink /mnt/f2fs/file
5. godown -f /mnt/f2fs
6. kill process[pid = x]
7. umount /mnt/f2fs
8. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
9. umount /mnt/f2fs

The reason is: during recovery, i_{c,m}time of inode will be updated, then
the inode can be set dirty w/o being tracked in sbi->inode_list[DIRTY_META]
global list, so later write_checkpoint will not flush such dirty inode into
node page.

Once umount is called, sync_filesystem() in generic_shutdown_super() will
skip syncng dirty inodes due to sb_rdonly check, leaving dirty inodes
there.

To solve this issue, during umount, add remove SB_RDONLY flag in
sb->s_flags, to make sure sync_filesystem() will not be skipped.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 ++
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/recovery.c   | 3 +++
 fs/f2fs/super.c      | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2fb4967753e0..91dd10c5d85b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -698,6 +698,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	}
 	/* clear Orphan Flag */
 	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
+
+	set_ckpt_flags(sbi, SBI_IS_RECOVERED);
 out:
 #ifdef CONFIG_QUOTA
 	/* Turn quotas off */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fe3d7ac62cf2..d773ee6f9e8d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1094,6 +1094,7 @@ enum {
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 	SBI_NEED_FLUSH_QUOTA,			/* need to flush quota info in CP */
+	SBI_IS_RECOVERED,			/* recovered orphan/data */
 };
 
 enum {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 59df8c396ae6..f8ebed4e0962 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -702,6 +702,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
 		};
+
+		set_ckpt_flags(sbi, SBI_IS_RECOVERED);
+
 		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c3a3c9ef8c7d..621d56f55fd2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3273,6 +3273,9 @@ static void kill_f2fs_super(struct super_block *sb)
 			};
 			f2fs_write_checkpoint(sbi, &cpc);
 		}
+
+		if (is_sbi_flag_set(sbi, SBI_IS_RECOVERED) && sb_rdonly(sb))
+			sb->s_flags &= ~SB_RDONLY;
 	}
 	kill_block_super(sb);
 }
-- 
2.18.0.rc1

