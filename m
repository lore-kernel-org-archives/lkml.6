Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F72C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE595208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE595208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeGIDJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:09:06 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:44834 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeGIDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:09:04 -0400
Received: by mail-io0-f198.google.com with SMTP id f12-v6so15126105iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xxuiNAklasy4HdEaGAcriKr8cEdr1N5jrFBqu3sUqzk=;
        b=McwrNhpr396DvyETwsezk5+1Wqrd1v1Rvluoiax1pQQPbQ+sG41PMAuuGzecHMPzn2
         Xibg0TZGbw2UjI4SOE39Z6sj9dMUKfhczUHiRZpyxNOowlYZ7TdsBpbK07OIJZJ/Qp0N
         R6wJhw8nwrGLCG4niFU1S+qdUYCRkAHix6zmH/Bxc1jGuipyHFggAwRfqSfBfiDzmMMl
         OxQ18tualeUS5cehrj9BgcGifEY9aROT8AZc/Iqrz0HboilS0KmV2qBQpjAodVGan31i
         w8FUn9tb0l//7SH2J74ccITGa/ZrQBD154INogpM3Pvth4sb2X5Vb6I8yA4E+aYRs10S
         zO2A==
X-Gm-Message-State: APt69E0gX0ss5J6i9Q+OPFAtBHJKfIdCpuLMjU2tDPeXOBIByGDXEdr3
        kZVtMevvxlgAuzyYrHhSONx0hIHy9tqvx3JiZiLVXl56Gf9r
X-Google-Smtp-Source: AAOMgpe9JRq1Bm9/grufVKbzateCuaRVX6VhPIHpcGrXhT3XaDu6O6cVkOLo/3XwygZDOZDvPBCmxTcY9V9s5cb4UpQ+hq3cB3Jt
MIME-Version: 1.0
X-Received: by 2002:a24:f716:: with SMTP id x22-v6mr8065209ith.24.1531105743440;
 Sun, 08 Jul 2018 20:09:03 -0700 (PDT)
Date:   Sun, 08 Jul 2018 20:09:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f396f9057088555b@google.com>
Subject: KASAN: slab-out-of-bounds Read in pdu_read
From:   syzbot <syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1609e968400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=65c6b72f284a39d416b4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1704f6d0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17188a78400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:345 [inline]
BUG: KASAN: slab-out-of-bounds in pdu_read+0x90/0xd0 net/9p/protocol.c:59
Read of size 62219 at addr ffff8801c9e904ed by task syz-executor251/4548

CPU: 0 PID: 4548 Comm: syz-executor251 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memcpy+0x23/0x50 mm/kasan/kasan.c:302
  memcpy include/linux/string.h:345 [inline]
  pdu_read+0x90/0xd0 net/9p/protocol.c:59
  p9pdu_vreadf net/9p/protocol.c:162 [inline]
  p9pdu_readf+0x579/0x2170 net/9p/protocol.c:536
  p9_client_version net/9p/client.c:986 [inline]
  p9_client_create+0xde0/0x16c9 net/9p/client.c:1069
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440319
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdfd76d4e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440319
RDX: 0000000020000140 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 69736f7030707070 R08: 0000000020000280 R09: 0000000000000001
R10: 0000000000010000 R11: 0000000000000206 R12: 4c50473070707028
R13: 64663d736e617274 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4548:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  p9_fcall_alloc+0x1e/0x90 net/9p/client.c:236
  p9_tag_alloc net/9p/client.c:306 [inline]
  p9_client_prepare_req.part.8+0x754/0xcd0 net/9p/client.c:722
  p9_client_prepare_req net/9p/client.c:757 [inline]
  p9_client_rpc+0x1bd/0x1400 net/9p/client.c:757
  p9_client_version net/9p/client.c:976 [inline]
  p9_client_create+0xd09/0x16c9 net/9p/client.c:1069
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801c9e904c0
  which belongs to the cache kmalloc-16384 of size 16384
The buggy address is located 45 bytes inside of
  16384-byte region [ffff8801c9e904c0, ffff8801c9e944c0)
The buggy address belongs to the page:
page:ffffea000727a400 count:1 mapcount:0 mapping:ffff8801da802200 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006d88408 ffff8801da801c48 ffff8801da802200
raw: 0000000000000000 ffff8801c9e904c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c9e92380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801c9e92400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801c9e92480: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
                                                        ^
  ffff8801c9e92500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801c9e92580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
