Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeEURZI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:25:08 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:33938 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeEURZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:25:03 -0400
X-Google-Smtp-Source: AB8JxZrUISZZf8Rff1csd/F1fmNJdpW1JO9qowgtPz2VxyI4C+Ttv0y7c2q1OoAZjr5d1KKR7ebnoEi14TZri11e+KRuc202Rrk6
MIME-Version: 1.0
Date: Mon, 21 May 2018 10:25:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd91d7056cba9422@google.com>
Subject: KASAN: use-after-free Read in irq_bypass_unregister_consumer
From: syzbot <syzbot+37364ced0d0b0fdf115c@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0b449a441dac Merge tag 'dmaengine-fix-4.17-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a44b37800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=37364ced0d0b0fdf115c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1120eb37800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f1227b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+37364ced0d0b0fdf115c@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: use-after-free in irq_bypass_unregister_consumer+0x3cd/0x4a0  
virt/lib/irqbypass.c:247
Read of size 8 at addr ffff8801adf2a168 by task kworker/0:1/24

CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.17.0-rc5+ #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: kvm-irqfd-cleanup irqfd_shutdown
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  irq_bypass_unregister_consumer+0x3cd/0x4a0 virt/lib/irqbypass.c:247
  irqfd_shutdown+0x112/0x1a0 arch/x86/kvm/../../../virt/kvm/eventfd.c:145
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 4534:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:296 [inline]
  kvm_irqfd+0x187/0x1ec0 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
  kvm_vm_ioctl+0xf84/0x1d90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2997
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 24:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  irqfd_shutdown+0x13a/0x1a0 arch/x86/kvm/../../../virt/kvm/eventfd.c:148
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the object at ffff8801adf2a000
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 360 bytes inside of
  512-byte region [ffff8801adf2a000, ffff8801adf2a200)
The buggy address belongs to the page:
page:ffffea0006b7ca80 count:1 mapcount:0 mapping:ffff8801adf2a000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801adf2a000 0000000000000000 0000000100000006
raw: ffffea0007647a20 ffffea0006b45ba0 ffff8801da800940 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801adf2a000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801adf2a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801adf2a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff8801adf2a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801adf2a200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
