Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D92C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD7C218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfABL0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:26:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:43198 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfABL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:26:04 -0500
Received: by mail-it1-f197.google.com with SMTP id 128so35751614itw.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Yq9YfHAA5+E/JVExDkCQ8sczlfc9P6/Du60nco0tFTY=;
        b=JXPcXZN+chUmWdJFWhF8K+kBnGPJ4n0JebHmsM2+UxN0H/dFuQjc48nzO9sW8+A71s
         +WRp9asYZbt8RrL4h3imbJQOs3q+w2+KKmSl0QA/0nxQ4iXUt7Nn859L/nzKyT4LC1HW
         gwn9IFSXFDOje55zTMswrkp7ZO0ZzUndyuk7YTq7RIOwHDYwkdWSSKsC8gc6wC4wvrTd
         KDroztI4w3X3T+ZrZNMlyMqO/7VfCR+dBc9aWi9UBvH4TnViptddNpfnSUvGRsywjD9L
         /nhuitdaI35vc0p/sZHrxZqKt5eiLSZXoTw5poO5jUalTX1gZSOtnDR9FMOshxJTCg4w
         rc5w==
X-Gm-Message-State: AA+aEWZK1eLwz6DFmK0yEDLuJa6aY3KV/MQb0x9+tcN20x1bfXd7WE7P
        ogIbQt3R0nAr14eG/4PR2rvT6BSfuHx63tTVWYJ05o1IP0un
X-Google-Smtp-Source: ALg8bN72K4iwLI2JupIzx2x1yzQYpDDNxevuCdLOLA+2wGmB7eRevpHo/hss3xIklaRWFPhoqY0Ufe5VvK8YsmPiukVIWfxryxlo
MIME-Version: 1.0
X-Received: by 2002:a24:6852:: with SMTP id v79mr31776457itb.29.1546428363727;
 Wed, 02 Jan 2019 03:26:03 -0800 (PST)
Date:   Wed, 02 Jan 2019 03:26:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a6d7c057e77e97e@google.com>
Subject: KASAN: use-after-free Read in refcount_sub_and_test_checked (2)
From:   syzbot <syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com>
To:     andrew.hendry@gmail.com, davem@davemloft.net, dvlasenk@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12227977400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b137b8ba637eb77
dashboard link: https://syzkaller.appspot.com/bug?extid=b0775615fa4c4479b691
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in refcount_sub_and_test_checked+0x9d/0x310  
lib/refcount.c:179
Read of size 4 at addr ffff88808c97fec8 by task syz-executor4/9549

CPU: 1 PID: 9549 Comm: syz-executor4 Not tainted 4.20.0+ #363
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_sub_and_test_checked+0x9d/0x310 lib/refcount.c:179
  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
  x25_neigh_put include/net/x25.h:252 [inline]
  x25_connect+0xc45/0x1050 net/x25/af_x25.c:823
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f61b98b5c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000073c0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f61b98b66d4
R13: 00000000004be405 R14: 00000000004ce5f0 R15: 00000000ffffffff

Allocated by task 5951:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  x25_link_device_up+0xb2/0x500 net/x25/x25_link.c:249
  x25_device_event+0x116/0x2b0 net/x25/af_x25.c:242
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x17a/0x480 net/core/dev.c:7605
  dev_change_flags+0x109/0x160 net/core/dev.c:7643
  dev_ifsioc+0x7da/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9519:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  x25_neigh_put include/net/x25.h:253 [inline]
  x25_connect+0xc67/0x1050 net/x25/af_x25.c:823
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808c97fe00
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 200 bytes inside of
  256-byte region [ffff88808c97fe00, ffff88808c97ff00)
The buggy address belongs to the page:
page:ffffea0002325fc0 count:1 mapcount:0 mapping:ffff88812c3f07c0  
index:0xffff88808c97f2c0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00021df608 ffffea00017f8748 ffff88812c3f07c0
raw: ffff88808c97f2c0 ffff88808c97f040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808c97fd80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff88808c97fe00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808c97fe80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88808c97ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808c97ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
