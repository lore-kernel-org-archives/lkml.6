Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F00C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D770220866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRkX5MBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D770220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbeKLJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbeKLIRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE64208A3;
        Sun, 11 Nov 2018 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975276;
        bh=LuWY5mnsjjbrnPDrM1TA4pDx7qMA7iESnHRKBJ1Of/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRkX5MBjTddCO6q7qU7zKBObDwuY5VgShwXbMpYDCDD7ZDsR1pkO8DvHzh0yCcsXv
         0ymyF4Se1WrYN7oVeBpixC/g+NiVYNno4tyt8H2YE4IMOBGSsIUdzuQtwweuCySD8G
         4Pg7udCO+6eUZ2BumXGN5YrvLs4syKwJm+shTpWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/361] f2fs: fix to flush all dirty inodes recovered in readonly fs
Date:   Sun, 11 Nov 2018 14:18:53 -0800
Message-Id: <20181111221646.475215199@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 1378752b9921e60749eaf18ec6c47b33f9001abb ]

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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    2 ++
 fs/f2fs/f2fs.h       |    1 +
 fs/f2fs/recovery.c   |   14 +++++++++-----
 fs/f2fs/super.c      |    3 +++
 4 files changed, 15 insertions(+), 5 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -696,6 +696,8 @@ int f2fs_recover_orphan_inodes(struct f2
 	/* clear Orphan Flag */
 	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
 out:
+	set_sbi_flag(sbi, SBI_IS_RECOVERED);
+
 #ifdef CONFIG_QUOTA
 	/* Turn quotas off */
 	if (quota_enabled)
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1089,6 +1089,7 @@ enum {
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
+	SBI_IS_RECOVERED,			/* recovered orphan/data */
 };
 
 enum {
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -698,11 +698,15 @@ skip:
 	/* let's drop all the directory inodes for clean checkpoint */
 	destroy_fsync_dnodes(&dir_list);
 
-	if (!err && need_writecp) {
-		struct cp_control cpc = {
-			.reason = CP_RECOVERY,
-		};
-		err = f2fs_write_checkpoint(sbi, &cpc);
+	if (need_writecp) {
+		set_sbi_flag(sbi, SBI_IS_RECOVERED);
+
+		if (!err) {
+			struct cp_control cpc = {
+				.reason = CP_RECOVERY,
+			};
+			err = f2fs_write_checkpoint(sbi, &cpc);
+		}
 	}
 
 	kmem_cache_destroy(fsync_entry_slab);
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3188,6 +3188,9 @@ static void kill_f2fs_super(struct super
 			};
 			f2fs_write_checkpoint(sbi, &cpc);
 		}
+
+		if (is_sbi_flag_set(sbi, SBI_IS_RECOVERED) && f2fs_readonly(sb))
+			sb->s_flags &= ~SB_RDONLY;
 	}
 	kill_block_super(sb);
 }


