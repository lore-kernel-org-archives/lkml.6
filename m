Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFACQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:02:16 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:43384 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeDFACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:02:02 -0400
X-Google-Smtp-Source: AIpwx49J1MQ9UnUyHNFMfYMqEeaMuAWi/wXjI3/M3l0JmgyoEqRj2S90+1kHkkg0oqcit0o2x6Wekpd0uusc15R30Q3WvqbPBJsl
MIME-Version: 1.0
Date: Thu, 05 Apr 2018 17:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <94eb2c05611408a11a056922c4cb@google.com>
Subject: KASAN: alloca-out-of-bounds Read in unwind_next_frame
From: syzbot <syzbot+9d1d9866b0b8ee6e0a8c@syzkaller.appspotmail.com>
To: hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
06dd3dfeea60e2a6457a6aedf97afc8e6d2ba497 (Thu Apr 5 03:07:20 2018 +0000)
Merge tag 'char-misc-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=9d1d9866b0b8ee6e0a8c

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6478299081474048
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5324218015154176
Kernel config: https://syzkaller.appspot.com/x/.config?id=216543573824217049
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d1d9866b0b8ee6e0a8c@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: alloca-out-of-bounds in __read_once_size  
include/linux/compiler.h:188 [inline]
BUG: KASAN: alloca-out-of-bounds in unwind_next_frame.part.7+0x7ce/0x9c0  
arch/x86/kernel/unwind_frame.c:326
Read of size 8 at addr ffff8801b05e67f8 by task syz-executor2/11326

CPU: 0 PID: 11326 Comm: syz-executor2 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:188 [inline]
  unwind_next_frame.part.7+0x7ce/0x9c0 arch/x86/kernel/unwind_frame.c:326
  unwind_next_frame+0x3e/0x50 arch/x86/kernel/unwind_frame.c:287
  __save_stack_trace+0x6e/0xd0 arch/x86/kernel/stacktrace.c:44
  save_stack_trace+0x1a/0x20 arch/x86/kernel/stacktrace.c:60
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3744
  __d_free+0x20/0x30 fs/dcache.c:257
  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
  rcu_process_callbacks+0x941/0x15f0 kernel/rcu/tree.c:2914
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
  invoke_softirq kernel/softirq.c:365 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:405
  exiting_irq arch/x86/include/asm/apic.h:525 [inline]
  smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:kasan_unpoison_shadow+0x1/0x50 mm/kasan/kasan.c:68
RSP: 0018:ffff8801b05e67e8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: ffff8801c1b24100 RBX: 0000000000000000 RCX: ffffffff859d4219
RDX: 0000000000000000 RSI: 00000000000000a8 RDI: ffff8801b05e6760
RBP: ffff8801b05e67f8 R08: ffff8801c1b24100 R09: ffffed003b6046c2
R10: ffffed003b6046c2 R11: ffff8801db023613 R12: 0000000000000015
R13: 0000000000000001 R14: 0000000000000016 R15: dffffc0000000000
  constrain_params_by_rules+0xbaa/0x1410 sound/core/pcm_param_trace.h:28
  snd_pcm_hw_refine+0x8e9/0x1180 sound/core/pcm_native.c:502
  snd_pcm_hw_param_mask sound/core/oss/pcm_oss.c:205 [inline]
  snd_pcm_oss_change_params+0x8ce/0x3d10 sound/core/oss/pcm_oss.c:870
  snd_pcm_oss_make_ready+0xe3/0x140 sound/core/oss/pcm_oss.c:1127
  snd_pcm_oss_sync.isra.27+0x24b/0x850 sound/core/oss/pcm_oss.c:1651
  snd_pcm_oss_release+0x214/0x290 sound/core/oss/pcm_oss.c:2446
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x90/0x2020 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4552d9
RSP: 002b:00007fd689eb5c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007fd689eb66d4 RCX: 00000000004552d9
RDX: 0000000000000000 RSI: 0000000000004c81 RDI: 000000000000000f
RBP: 000000000072c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000027d R14: 00000000006f6c58 R15: 0000000000000002

The buggy address belongs to the page:
page:ffffea0006c17980 count:0 mapcount:0 mapping:0000000000000000  
index:0xffff8801b05e69c0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffff8801b05e69c0 00000000ffffffff
raw: dead000000000100 dead000000000200 ffff8801dad7f600 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b05e6680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801b05e6700: 00 00 00 00 00 00 00 00 00 00 00 00 ca ca ca ca
> ffff8801b05e6780: 00 00 00 00 00 00 00 00 00 00 04 cb cb cb cb cb
                                                                 ^
  ffff8801b05e6800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801b05e6880: 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2
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
