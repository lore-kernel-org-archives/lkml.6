Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F0BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59761218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbeL2AVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:21:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:44941 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeL2AVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:21:04 -0500
Received: by mail-it1-f198.google.com with SMTP id x82so26731600ita.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 16:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+IN9sYV3UE0TlWQrfdPCflzp22PJO/7vIe8OpSpAeos=;
        b=UINhPHXFK2PSK1P3Ec0Vcv0pHFvFljgS9IwLdK9wmtUpLhnN3x/Ukp8DA/g0hjJd3+
         BGkWRCOpBW1lb1ndVtl7/Oo28j+JzUDEh+kkDYwtp/Z8J8hHUO+dayXhN31zpYTyuGyC
         I25Bhi4JWyJsgL9GMurwDAY5C0CwzvObSDQjbwUiCjxqlf7KdWxpFaRSAsFLD4wecgoD
         2DAUCuJLPn15QxsCaKp7DYwNpsxwqF3pm/FxLv678SLPe/UeJU0x8imtaPxjYWtTwm1e
         AWAsLplzj5PFBnDawsKPr4XxB7FzV3HVidotQS0pMa/G4pwo+yXaQB8GzgDT07RMhvTS
         iLcg==
X-Gm-Message-State: AA+aEWZkM1DvrXYWHzNzLJgvwBEqDaId3KoiOrtZ3rwWijJ1EAfWl4PU
        s9HS6CXpuHo1yBV9lR16IKRYLB1wVJ6y6uh9QxR7qaAy/9Ki
X-Google-Smtp-Source: AFSGD/XuGWqOKXLMF1MaVk/aE5zhMCDx9k82yLWi7QY01+7VWMdz1m5mBt9/8CwAz1u5GxMRvdNfhHLssn644ycsoVpqEzuBkDVy
MIME-Version: 1.0
X-Received: by 2002:a24:594f:: with SMTP id p76mr22058907itb.10.1546042863550;
 Fri, 28 Dec 2018 16:21:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:21:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b08bc4057e1e273a@google.com>
Subject: KASAN: invalid-free in x25_asy_free
From:   syzbot <syzbot+5e5e969e525129229052@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c11a3b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=5e5e969e525129229052
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1574eeaf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1417cd8b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5e5e969e525129229052@syzkaller.appspotmail.com

  __alloc_pages include/linux/gfp.h:473 [inline]
  __alloc_pages_node include/linux/gfp.h:486 [inline]
  kmem_getpages mm/slab.c:1409 [inline]
  cache_grow_begin+0x91/0x8c0 mm/slab.c:2677
==================================================================
  cache_alloc_refill mm/slab.c:3044 [inline]
  ____cache_alloc mm/slab.c:3127 [inline]
  slab_alloc_node mm/slab.c:3322 [inline]
  kmem_cache_alloc_node_trace+0x670/0x740 mm/slab.c:3661
BUG: KASAN: double-free or invalid-free in x25_asy_free+0x37/0x140  
drivers/net/wan/x25_asy.c:111

  __do_kmalloc_node mm/slab.c:3683 [inline]
  __kmalloc_node+0x3c/0x70 mm/slab.c:3691
  kmalloc_node include/linux/slab.h:589 [inline]
  kvmalloc_node+0x65/0xf0 mm/util.c:416
  kvmalloc include/linux/mm.h:577 [inline]
  kvzalloc include/linux/mm.h:585 [inline]
  alloc_netdev_mqs+0x17b/0xfe0 net/core/dev.c:8949
  x25_asy_alloc drivers/net/wan/x25_asy.c:83 [inline]
  x25_asy_open_tty+0x551/0x7e7 drivers/net/wan/x25_asy.c:556
  tty_ldisc_open.isra.1+0x8b/0xe0 drivers/tty/tty_ldisc.c:453
  tty_set_ldisc+0x2dc/0x6a0 drivers/tty/tty_ldisc.c:578
  tiocsetd drivers/tty/tty_io.c:2321 [inline]
  tty_ioctl+0x39d/0x17d0 drivers/tty/tty_io.c:2581
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4410e9
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc32511548 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004410e9
RDX: 0000000020000000 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007ffc32511560 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
CPU: 0 PID: 7925 Comm: syz-executor081 Not tainted 4.20.0 #387
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x13a/0x150 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  x25_asy_free+0x37/0x140 drivers/net/wan/x25_asy.c:111
  x25_asy_open_tty+0x6ad/0x7e7 drivers/net/wan/x25_asy.c:572
  tty_ldisc_open.isra.1+0x8b/0xe0 drivers/tty/tty_ldisc.c:453
  tty_set_ldisc+0x2dc/0x6a0 drivers/tty/tty_ldisc.c:578
  tiocsetd drivers/tty/tty_io.c:2321 [inline]
  tty_ioctl+0x39d/0x17d0 drivers/tty/tty_io.c:2581
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4410e9
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
kobject: 'queues' (000000001e78d271): kobject_uevent_env: filter function  
caused the event to drop!
RSP: 002b:00007ffc32511548 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004410e9
RDX: 0000000020000000 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007ffc32511560 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000

kobject: 'rx-0' (00000000b3577da5): kobject_add_internal: parent: 'queues',  
set: 'queues'
Allocated by task 7925:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc+0x15b/0x770 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  x25_asy_open drivers/net/wan/x25_asy.c:465 [inline]
  x25_asy_open_tty+0x32a/0x7e7 drivers/net/wan/x25_asy.c:570
  tty_ldisc_open.isra.1+0x8b/0xe0 drivers/tty/tty_ldisc.c:453
  tty_set_ldisc+0x2dc/0x6a0 drivers/tty/tty_ldisc.c:578
  tiocsetd drivers/tty/tty_io.c:2321 [inline]
  tty_ioctl+0x39d/0x17d0 drivers/tty/tty_io.c:2581
kobject: 'rx-0' (00000000b3577da5): kobject_uevent_env
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7925:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
kobject: 'rx-0' (00000000b3577da5): fill_kobj_path: path  
= '/devices/virtual/net/x25asy1/queues/rx-0'
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  x25_asy_open drivers/net/wan/x25_asy.c:489 [inline]
  x25_asy_open_tty+0x6a0/0x7e7 drivers/net/wan/x25_asy.c:570
  tty_ldisc_open.isra.1+0x8b/0xe0 drivers/tty/tty_ldisc.c:453
  tty_set_ldisc+0x2dc/0x6a0 drivers/tty/tty_ldisc.c:578
  tiocsetd drivers/tty/tty_io.c:2321 [inline]
  tty_ioctl+0x39d/0x17d0 drivers/tty/tty_io.c:2581
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
kobject: 'tx-0' (00000000ae272600): kobject_add_internal: parent: 'queues',  
set: 'queues'
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881afc12000
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
  1024-byte region [ffff8881afc12000, ffff8881afc12400)
The buggy address belongs to the page:
page:ffffea0006bf0480 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
kobject: 'tx-0' (00000000ae272600): kobject_uevent_env
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0007511e08 ffffea0007551288 ffff8881da800ac0
raw: 0000000000000000 ffff8881afc12000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881afc11f00: fb fb fb fb fb fb fc fc fc fc fb fb fb fb fb fb
  ffff8881afc11f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881afc12000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
kobject: 'tx-0' (00000000ae272600): fill_kobj_path: path  
= '/devices/virtual/net/x25asy1/queues/tx-0'
                    ^
  ffff8881afc12080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881afc12100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
