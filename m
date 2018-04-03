Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeDCDBE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 23:01:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:54614 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeDCDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 23:01:02 -0400
X-Google-Smtp-Source: AIpwx4+OPbulMGQy3mvxejt27BsaxWufQSVSymQ+NAMz7jIvSIbmCvIddClm5nfLXKo7PZB6gwHAHfGqnQfcCQsTReoO9tV0sPup
MIME-Version: 1.0
Date: Mon, 02 Apr 2018 20:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113f8bf6a9acd90568e8ea59@google.com>
Subject: KASAN: use-after-free Read in uprobe_perf_close
From: syzbot <syzbot+cef9473c7fa0fe8ab95e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
86bbbebac1933e6e95e8234c4f7d220c5ddd38bc (Mon Apr 2 18:47:07 2018 +0000)
Merge branch 'ras-core-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=cef9473c7fa0fe8ab95e

So far this crash happened 4 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6655209589702656
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6230110906613760
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5321669220499456
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6801295859785128502
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cef9473c7fa0fe8ab95e@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: use-after-free in uprobe_perf_close+0x3e0/0x570  
kernel/trace/trace_uprobe.c:1048
Read of size 4 at addr ffff8801d955264c by task syzkaller474457/4485

CPU: 0 PID: 4485 Comm: syzkaller474457 Not tainted 4.16.0+ #376
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  uprobe_perf_close+0x3e0/0x570 kernel/trace/trace_uprobe.c:1048
  trace_uprobe_register+0x4cb/0xc00 kernel/trace/trace_uprobe.c:1210
  perf_trace_event_close kernel/trace/trace_event_perf.c:186 [inline]
  perf_uprobe_destroy+0x9b/0x130 kernel/trace/trace_event_perf.c:335
  _free_event+0x3d7/0x11f0 kernel/events/core.c:4445
  put_event+0x35/0x40 kernel/events/core.c:4528
  perf_event_release_kernel+0x6e8/0xfe0 kernel/events/core.c:4634
  perf_release+0x37/0x50 kernel/events/core.c:4644
  __fput+0x327/0x7f0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ab/0x280 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0xa75/0x2700 kernel/exit.c:865
  do_group_exit+0x149/0x400 kernel/exit.c:968
  SYSC_exit_group kernel/exit.c:979 [inline]
  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x445c89
RSP: 002b:00007ffd332827e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445c89
RDX: 0000000000445c89 RSI: 0000000000445c89 RDI: 0000000000000001
RBP: 00000000006da018 R08: 0000000000000000 R09: 0000000000406fd0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000406f40
R13: 0000000000406fd0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4485:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
  kmem_cache_alloc_node+0x144/0x760 mm/slab.c:3632
  alloc_task_struct_node kernel/fork.c:157 [inline]
  dup_task_struct kernel/fork.c:770 [inline]
  copy_process.part.38+0x1ab9/0x6140 kernel/fork.c:1631
  copy_process kernel/fork.c:1606 [inline]
  _do_fork+0x1f7/0xfa0 kernel/fork.c:2087
  SYSC_clone kernel/fork.c:2194 [inline]
  SyS_clone+0x37/0x50 kernel/fork.c:2188
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 0:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kmem_cache_free+0x83/0x2a0 mm/slab.c:3744
  free_task_struct kernel/fork.c:162 [inline]
  free_task+0x155/0x1b0 kernel/fork.c:391
  __put_task_struct+0x24b/0x3e0 kernel/fork.c:657
  put_task_struct include/linux/sched/task.h:96 [inline]
  delayed_put_task_struct+0xd8/0x3e0 kernel/exit.c:180
  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
  rcu_process_callbacks+0xd6c/0x17b0 kernel/rcu/tree.c:2914
  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285

The buggy address belongs to the object at ffff8801d9552600
  which belongs to the cache task_struct of size 6016
The buggy address is located 76 bytes inside of
  6016-byte region [ffff8801d9552600, ffff8801d9553d80)
The buggy address belongs to the page:
page:ffffea0007655480 count:1 mapcount:0 mapping:ffff8801d9552600 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801d9552600 0000000000000000 0000000100000001
raw: ffffea0007636ba0 ffff8801dad0c248 ffff8801dad46200 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d9552500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d9552580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d9552600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff8801d9552680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d9552700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
