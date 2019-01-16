Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C41C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A5420866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfAPBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:52:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbfAPBwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:52:05 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B5B3FFD5D08F10C4A792;
        Wed, 16 Jan 2019 09:52:03 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 09:51:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <kt0755@gmail.com>, <dan.carpenter@oracle.com>,
        <ebiggers@google.com>, Chao Yu <yuchao0@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
Subject: [PATCH] f2fs: fix to initialize variable to avoid UBSAN/smatch warning
Date:   Wed, 16 Jan 2019 09:51:28 +0800
Message-ID: <20190116015128.112292-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dan Carpenter as below:

The patch df634f444ee9: "f2fs: use rb_*_cached friends" from Oct 4,
2018, leads to the following static checker warning:

	fs/f2fs/extent_cache.c:606 f2fs_update_extent_tree_range()
	error: uninitialized symbol 'leftmost'.

And also Eric Biggers, and Kyungtae Kim reported, there is an UBSAN
warning described as below:

We report a bug in linux-4.20.2: "UBSAN: Undefined behaviour in
fs/f2fs/extent_cache.c"

kernel config: https://kt0755.github.io/etc/config_v4.20_stable
repro: https://kt0755.github.io/etc/repro.4a3e7.c (f2fs is mounted on
/mnt/f2fs/)

This arose in f2fs_update_extent_tree_range (fs/f2fs/extent_cache.c:605).
It seems that, for some reason, its last argument became "24"
although that was supposed to be bool type.

=========================================
UBSAN: Undefined behaviour in fs/f2fs/extent_cache.c:605:4
load of value 24 is not a valid value for type '_Bool'
CPU: 0 PID: 6774 Comm: syz-executor5 Not tainted 4.20.2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xb1/0x118 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 __ubsan_handle_load_invalid_value+0x17a/0x1be lib/ubsan.c:457
 f2fs_update_extent_tree_range+0x1d4a/0x1d50 fs/f2fs/extent_cache.c:605
 f2fs_update_extent_cache+0x2b6/0x350 fs/f2fs/extent_cache.c:804
 f2fs_update_data_blkaddr+0x61/0x70 fs/f2fs/data.c:656
 f2fs_outplace_write_data+0x1d6/0x4b0 fs/f2fs/segment.c:3140
 f2fs_convert_inline_page+0x86d/0x2060 fs/f2fs/inline.c:163
 f2fs_convert_inline_inode+0x6b5/0xad0 fs/f2fs/inline.c:208
 f2fs_preallocate_blocks+0x78b/0xb00 fs/f2fs/data.c:982
 f2fs_file_write_iter+0x31b/0xf40 fs/f2fs/file.c:3062
 call_write_iter include/linux/fs.h:1857 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x538/0x6e0 fs/read_write.c:487
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1ea15edc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1ea15ee6cc RCX: 00000000004497b9
RDX: 0000000000001000 RSI: 0000000020000140 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000bb50 R14: 00000000006f4bf0 R15: 00007f1ea15ee700
=========================================

As I checked, this uninitialized variable won't cause extent cache
corruption, but in order to avoid such kind of warning of both UBSAN
and smatch, fix to initialize related variable.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Eric Biggers <ebiggers@google.com>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 1cb0fcc67d2d..caf77fe8ac07 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -506,7 +506,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	unsigned int end = fofs + len;
 	unsigned int pos = (unsigned int)fofs;
 	bool updated = false;
-	bool leftmost;
+	bool leftmost = false;
 
 	if (!et)
 		return;
-- 
2.18.0.rc1

