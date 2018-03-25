Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCYJGE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 05:06:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:56251 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeCYJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 05:06:02 -0400
X-Google-Smtp-Source: AG47ELsSl3jKoL6vuXrlUQuvqSBgpY+vE2KxW/v63UKpmgza6ZXdMUG7ivoqdqmrfEvoLgfjq0l7GB1vtUgYPKv2hYyYao2g5zD+
MIME-Version: 1.0
Date: Sun, 25 Mar 2018 02:06:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <94eb2c0b8e0861a1e4056838f799@google.com>
Subject: KASAN: use-after-free Read in pppol2tp_connect (3)
From: syzbot <syzbot+fbeeb5c3b538e8545644@syzkaller.appspotmail.com>
To: davem@davemloft.net, jchapman@katalix.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
bcfc1f4554662d8f2429ac8bd96064a59c149754 (Sat Mar 24 16:50:12 2018 +0000)
Merge tag 'pinctrl-v4.16-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=fbeeb5c3b538e8545644

So far this crash happened 5 times on net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5150723616538624
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4732053023096832
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5847288391925760
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fbeeb5c3b538e8545644@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

l2tp_core: tunl 2: sockfd_lookup(fd=9) returned -9
l2tp_core: tunl 2: sockfd_lookup(fd=8) returned -9
l2tp_core: tunl 2: sockfd_lookup(fd=9) returned -9
==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:188  
[inline]
BUG: KASAN: use-after-free in sk_dst_get include/net/sock.h:1767 [inline]
BUG: KASAN: use-after-free in pppol2tp_session_init net/l2tp/l2tp_ppp.c:587  
[inline]
BUG: KASAN: use-after-free in pppol2tp_connect+0x1a98/0x1dd0  
net/l2tp/l2tp_ppp.c:747
Read of size 8 at addr ffff8801d18242a8 by task syzkaller117300/8372

CPU: 1 PID: 8372 Comm: syzkaller117300 Not tainted 4.16.0-rc6+ #365
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:188 [inline]
  sk_dst_get include/net/sock.h:1767 [inline]
  pppol2tp_session_init net/l2tp/l2tp_ppp.c:587 [inline]
  pppol2tp_connect+0x1a98/0x1dd0 net/l2tp/l2tp_ppp.c:747
  SYSC_connect+0x213/0x4a0 net/socket.c:1639
  SyS_connect+0x24/0x30 net/socket.c:1620
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x449f39
RSP: 002b:00007fa9d92efce8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000700024 RCX: 0000000000449f39
RDX: 000000000000002e RSI: 0000000020e92000 RDI: 0000000000000009
RBP: 0000000000700020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000080efcf R14: 00007fa9d92f09c0 R15: 0000000000000009

Allocated by task 8381:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3541
  sk_prot_alloc+0x65/0x2a0 net/core/sock.c:1465
  sk_alloc+0x105/0x1440 net/core/sock.c:1525
  inet_create+0x47c/0xf50 net/ipv4/af_inet.c:320
  __sock_create+0x4d4/0x850 net/socket.c:1285
  sock_create net/socket.c:1325 [inline]
  SYSC_socket net/socket.c:1355 [inline]
  SyS_socket+0xeb/0x1d0 net/socket.c:1335
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 21:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3485 [inline]
  kmem_cache_free+0x83/0x2a0 mm/slab.c:3743
  sk_prot_free net/core/sock.c:1506 [inline]
  __sk_destruct+0x628/0x920 net/core/sock.c:1590
  sk_destruct+0x47/0x80 net/core/sock.c:1598
  __sk_free+0xf1/0x2b0 net/core/sock.c:1609
  sk_free+0x2a/0x40 net/core/sock.c:1620
  sock_put include/net/sock.h:1659 [inline]
  l2tp_tunnel_free net/l2tp/l2tp_core.c:160 [inline]
  l2tp_tunnel_dec_refcount net/l2tp/l2tp_core.h:264 [inline]
  l2tp_tunnel_del_work+0x474/0x6a0 net/l2tp/l2tp_core.c:1307
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406

The buggy address belongs to the object at ffff8801d1824080
  which belongs to the cache UDP of size 1472
The buggy address is located 552 bytes inside of
  1472-byte region [ffff8801d1824080, ffff8801d1824640)
The buggy address belongs to the page:
page:ffffea0007460900 count:1 mapcount:0 mapping:ffff8801d1824080 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801d1824080 0000000000000000 0000000100000005
raw: ffffea0006b0fda0 ffffea0006a53820 ffff8801d6f36640 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d1824180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d1824200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d1824280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff8801d1824300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d1824380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
