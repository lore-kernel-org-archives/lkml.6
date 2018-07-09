Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB329C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC8D208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC8D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeGIDJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:09:07 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:35555 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeGIDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:09:04 -0400
Received: by mail-it0-f69.google.com with SMTP id r184-v6so9557822ith.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=03K4xnuALhaIfQ2sXdfWbWP7qDIAevsN4AUZzihE/2I=;
        b=H2ZLKGke2vklr2WL7JKNw4mAetnGr9Smydqa+EA3zkzr+hmzpeaqyHeLV2wRzfQi8N
         xUm84IPYAzrCEHbTpdbyZaKXE2TEYNMBGb0Bt+/iuI5KBcrEX8T7UkbdXp9/pF3MYBY9
         2MLEAeHfWiAD1avXIMKNYzJ4HhM53FCQQM2axiRDVQYFKvPQ3WwXUFh3lc6sdABn/hrW
         NFs4XmDFPmwONUVLKVHNgasXrMarpfzLTq7Oo+rv4O7UIIn5D+x0EgankUYsTMtgP18L
         llU5ekf/y5XCg9zFoD9Qp2Zu7TXO5AGklCL+eUKtDZ1Cjo22W8u8LVNgdz52vETEz7kC
         ckyQ==
X-Gm-Message-State: APt69E0rwlUd9k2/vetAQ421LnUr/86o4HsuTE5XwtM2VtWKXbs2dY9K
        dpW2SiXKyZoIb6wJeLUQONWHUk5Unb+D4iWuFB83rZ2ZfbPh
X-Google-Smtp-Source: AAOMgpee53MpbCPh75jvbNw9HiiST1401mtPea+tMTUOoCzUPG4TZ6YAP/icevk/2Mo69z5mXnjaVnEnfILUjI9SN5ZlGFNVj1On
MIME-Version: 1.0
X-Received: by 2002:a24:7d0b:: with SMTP id b11-v6mr4372632itc.30.1531105743625;
 Sun, 08 Jul 2018 20:09:03 -0700 (PDT)
Date:   Sun, 08 Jul 2018 20:09:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f665a30570885589@google.com>
Subject: KASAN: use-after-free Read in __queue_work (2)
From:   syzbot <syzbot+1c9db6a163a4000d0765@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1066e6dc400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=1c9db6a163a4000d0765
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1473a452400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14087748400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c9db6a163a4000d0765@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in constant_test_bit  
arch/x86/include/asm/bitops.h:328 [inline]
BUG: KASAN: use-after-free in work_is_static_object+0x39/0x40  
kernel/workqueue.c:442
Read of size 8 at addr ffff8801d7a7fda0 by task kworker/0:2/27

CPU: 0 PID: 27 Comm: kworker/0:2 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
  work_is_static_object+0x39/0x40 kernel/workqueue.c:442
  debug_object_activate+0x2fc/0x690 lib/debugobjects.c:508
  debug_work_activate kernel/workqueue.c:491 [inline]
  __queue_work+0x1ca/0x1410 kernel/workqueue.c:1380
  queue_work_on+0x19a/0x1e0 kernel/workqueue.c:1486
  queue_work include/linux/workqueue.h:512 [inline]
  schedule_work include/linux/workqueue.h:570 [inline]
  p9_poll_mux net/9p/trans_fd.c:628 [inline]
  p9_poll_workfn+0x55e/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 4537:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  p9_fd_open net/9p/trans_fd.c:796 [inline]
  p9_fd_create+0x1a7/0x3f0 net/9p/trans_fd.c:1036
  p9_client_create+0x915/0x16c9 net/9p/client.c:1062
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

Freed by task 4537:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
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

The buggy address belongs to the object at ffff8801d7a7fc80
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 288 bytes inside of
  512-byte region [ffff8801d7a7fc80, ffff8801d7a7fe80)
The buggy address belongs to the page:
page:ffffea00075e9fc0 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007616688 ffffea00075d9a88 ffff8801da800940
raw: 0000000000000000 ffff8801d7a7f000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d7a7fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d7a7fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d7a7fd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801d7a7fe00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d7a7fe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
