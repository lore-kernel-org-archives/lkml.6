Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEMOVE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:21:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:37552 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeEMOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:21:02 -0400
X-Google-Smtp-Source: AB8JxZqKK5fFu3g5xWJxy5CMK8RILN9aoOcc65OnPAWW5gEXYVw/+UJrXnjYCnefWNmOomf7N/wLwkjfSFXc+P/41PF4EqJvHsvH
MIME-Version: 1.0
Date: Sun, 13 May 2018 07:21:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d64fe056c1714a3@google.com>
Subject: KASAN: slab-out-of-bounds Read in vmx_vcpu_run
From: syzbot <syzbot+d8f8a4d784b336549b5b@syzkaller.appspotmail.com>
To: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    036db8bd9637 Merge branch 'for-4.17-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11228e07800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31f4b3733894ef79
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f8a4d784b336549b5b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d8f8a4d784b336549b5b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in msr_write_intercepted  
arch/x86/kvm/vmx.c:2126 [inline]
BUG: KASAN: slab-out-of-bounds in vmx_vcpu_run+0x2379/0x25f0  
arch/x86/kvm/vmx.c:9869
Read of size 8 at addr ffff8801d3efc840 by task syz-executor1/11848

CPU: 1 PID: 11848 Comm: syz-executor1 Not tainted 4.17.0-rc4+ #39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  msr_write_intercepted arch/x86/kvm/vmx.c:2126 [inline]
  vmx_vcpu_run+0x2379/0x25f0 arch/x86/kvm/vmx.c:9869

Allocated by task 11848:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  tcp_sendmsg_fastopen net/ipv4/tcp.c:1145 [inline]
  tcp_sendmsg_locked+0x2ff7/0x3ee0 net/ipv4/tcp.c:1209
  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1447
  inet_sendmsg+0x19f/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  __sys_sendto+0x3d7/0x670 net/socket.c:1789
  __do_sys_sendto net/socket.c:1801 [inline]
  __se_sys_sendto net/socket.c:1797 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2388:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  inotify_free_event+0x15/0x20 fs/notify/inotify/inotify_fsnotify.c:182
  fsnotify_destroy_event.part.1+0x1a8/0x270 fs/notify/notification.c:87
  fsnotify_destroy_event+0x69/0x80 fs/notify/notification.c:74
  inotify_read+0x5a8/0x9b0 fs/notify/inotify/inotify_user.c:246
  __vfs_read+0x10f/0xa50 fs/read_write.c:416
  vfs_read+0x17f/0x3d0 fs/read_write.c:452
  ksys_read+0xf9/0x250 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d3efc800
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
  64-byte region [ffff8801d3efc800, ffff8801d3efc840)
The buggy address belongs to the page:
page:ffffea00074fbf00 count:1 mapcount:0 mapping:ffff8801d3efc000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d3efc000 0000000000000000 0000000100000020
raw: ffffea00076687a0 ffffea000766e660 ffff8801da800340 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d3efc700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d3efc780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> ffff8801d3efc800: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                            ^
  ffff8801d3efc880: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
  ffff8801d3efc900: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
