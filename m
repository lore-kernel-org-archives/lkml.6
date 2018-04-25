Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDYFrD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeDYFq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:46:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ED2217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: sanity check on sit entry
Date: Tue, 24 Apr 2018 23:46:11 -0600
Message-Id: <20180425054613.2700-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180425054613.2700-1-jaegeuk@kernel.org>
References: <20180425054613.2700-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot hit the following crash on upstream commit
87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=83699adeb2d13579c31e

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5805208181407744
syzkaller reproducer: https://syzkaller.appspot.com/x/repro.syz?id=6005073343676416
Raw console output: https://syzkaller.appspot.com/x/log.txt?id=6555047731134464
Kernel config: https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83699adeb2d13579c31e@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for details.
If you forward the report, please keep this part and the footer.

F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
BUG: unable to handle kernel paging request at ffffed006b2a50c0
PGD 21ffee067 P4D 21ffee067 PUD 21fbeb067 PMD 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4514 Comm: syzkaller989480 Not tainted 4.17.0-rc1+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:build_sit_entries fs/f2fs/segment.c:3653 [inline]
RIP: 0010:build_segment_manager+0x7ef7/0xbf70 fs/f2fs/segment.c:3852
RSP: 0018:ffff8801b102e5b0 EFLAGS: 00010a06
RAX: 1ffff1006b2a50c0 RBX: 0000000000000004 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801ac74243e
RBP: ffff8801b102f410 R08: ffff8801acbd46c0 R09: fffffbfff14d9af8
R10: fffffbfff14d9af8 R11: ffff8801acbd46c0 R12: ffff8801ac742a80
R13: ffff8801d9519100 R14: dffffc0000000000 R15: ffff880359528600
FS:  0000000001e04880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed006b2a50c0 CR3: 00000001ac6ac000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 f2fs_fill_super+0x4095/0x7bf0 fs/f2fs/super.c:2803
 mount_bdev+0x30c/0x3e0 fs/super.c:1165
 f2fs_mount+0x34/0x40 fs/f2fs/super.c:3020
 mount_fs+0xae/0x328 fs/super.c:1268
 vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
 vfs_kern_mount fs/namespace.c:1027 [inline]
 do_new_mount fs/namespace.c:2517 [inline]
 do_mount+0x564/0x3070 fs/namespace.c:2847
 ksys_mount+0x12d/0x140 fs/namespace.c:3063
 __do_sys_mount fs/namespace.c:3077 [inline]
 __se_sys_mount fs/namespace.c:3074 [inline]
 __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443d6a
RSP: 002b:00007ffd312813c8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000c00 RCX: 0000000000443d6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd312813d0
RBP: 0000000000000003 R08: 0000000020016a00 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000004
R13: 0000000000402c60 R14: 0000000000000000 R15: 0000000000000000
RIP: build_sit_entries fs/f2fs/segment.c:3653 [inline] RSP: ffff8801b102e5b0
RIP: build_segment_manager+0x7ef7/0xbf70 fs/f2fs/segment.c:3852 RSP: ffff8801b102e5b0
CR2: ffffed006b2a50c0
---[ end trace a2034989e196ff17 ]---

Reported-and-tested-by: syzbot+83699adeb2d13579c31e@syzkaller.appspotmail.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e4e8bdd645ee..20250b88bf51 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3662,6 +3662,15 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 		unsigned int old_valid_blocks;
 
 		start = le32_to_cpu(segno_in_journal(journal, i));
+		if (start >= MAIN_SEGS(sbi)) {
+			f2fs_msg(sbi->sb, KERN_ERR,
+					"Wrong journal entry on segno %u",
+					start);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			err = -EINVAL;
+			break;
+		}
+
 		se = &sit_i->sentries[start];
 		sit = sit_in_journal(journal, i);
 
-- 
2.17.0.484.g0c8726318c-goog
