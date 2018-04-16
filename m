Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDPF5E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 01:57:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:40019 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeDPF5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 01:57:02 -0400
X-Google-Smtp-Source: AIpwx4/abkpXxbFxA02K385yP+CA4vbAT2J9XoEGmbugDsCeoP5JmsiIfpi4bMhrKfjU8+Qxrez5I6ZurwQE02DaD35HbvRdURMS
MIME-Version: 1.0
Date: Sun, 15 Apr 2018 22:57:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000004c7b0569f0e495@google.com>
Subject: KASAN: use-after-free Read in tipc_nametbl_stop
From: syzbot <syzbot+d64b64afc55660106556@syzkaller.appspotmail.com>
To: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on net-next commit
5d1365940a68dd57b031b6e3c07d7d451cd69daf (Thu Apr 12 18:09:05 2018 +0000)
Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=d64b64afc55660106556

So far this crash happened 5 times on net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6319968803094528
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6099825221173248
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4953018151731200
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d64b64afc55660106556@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

Failed to remove local publication {0,0,0}/206417777
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: use-after-free in tipc_service_delete net/tipc/name_table.c:751  
[inline]
BUG: KASAN: use-after-free in tipc_nametbl_stop+0x94e/0xd70  
net/tipc/name_table.c:780
Read of size 8 at addr ffff8801c4c25130 by task kworker/u4:2/30

CPU: 0 PID: 30 Comm: kworker/u4:2 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  tipc_service_delete net/tipc/name_table.c:751 [inline]
  tipc_nametbl_stop+0x94e/0xd70 net/tipc/name_table.c:780
  tipc_exit_net+0x2d/0x40 net/tipc/core.c:103
  ops_exit_list.isra.7+0xb0/0x160 net/core/net_namespace.c:152
  cleanup_net+0x51d/0xb20 net/core/net_namespace.c:523
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411

Allocated by task 4535:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  tipc_service_create_range net/tipc/name_table.c:183 [inline]
  tipc_service_insert_publ net/tipc/name_table.c:207 [inline]
  tipc_nametbl_insert_publ+0x569/0x1910 net/tipc/name_table.c:371
  tipc_nametbl_publish+0x6c3/0xba0 net/tipc/name_table.c:618
  tipc_sk_publish+0x22a/0x510 net/tipc/socket.c:2604
  tipc_bind+0x206/0x330 net/tipc/socket.c:647
  __sys_bind+0x331/0x440 net/socket.c:1484
  SYSC_bind net/socket.c:1495 [inline]
  SyS_bind+0x24/0x30 net/socket.c:1493
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 30:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  tipc_service_remove_publ.isra.8+0x909/0xc30 net/tipc/name_table.c:283
  tipc_service_delete net/tipc/name_table.c:753 [inline]
  tipc_nametbl_stop+0x746/0xd70 net/tipc/name_table.c:780
  tipc_exit_net+0x2d/0x40 net/tipc/core.c:103
  ops_exit_list.isra.7+0xb0/0x160 net/core/net_namespace.c:152
  cleanup_net+0x51d/0xb20 net/core/net_namespace.c:523
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411

The buggy address belongs to the object at ffff8801c4c25100
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
  64-byte region [ffff8801c4c25100, ffff8801c4c25140)
The buggy address belongs to the page:
page:ffffea0007130940 count:1 mapcount:0 mapping:ffff8801c4c25000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801c4c25000 0000000000000000 0000000100000020
raw: ffffea0006ccf860 ffffea00070840a0 ffff8801dac00340 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c4c25000: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801c4c25080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801c4c25100: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                      ^
  ffff8801c4c25180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801c4c25200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
