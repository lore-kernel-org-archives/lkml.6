Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43277ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035DB206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035DB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbeGPIFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:05:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeGPIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:05:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 814BACA1;
        Mon, 16 Jul 2018 07:39:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+83699adeb2d13579c31e@syzkaller.appspotmail.com,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.17 65/67] f2fs: sanity check on sit entry
Date:   Mon, 16 Jul 2018 09:35:34 +0200
Message-Id: <20180716073454.243398815@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit b2ca374f33bd33fd822eb871876e4888cf79dc97 upstream.

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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/segment.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3650,6 +3650,15 @@ static int build_sit_entries(struct f2fs
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
 


