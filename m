Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933627AbeD0PS4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:18:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:37022 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeD0PSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:18:52 -0400
X-Google-Smtp-Source: AB8JxZrWBe9HN302kca8+BX/dB4/rXndJVVVr+d7T6UxM7E+KPUdb4TuW7aXJ2aCEmY7y6hDL9DJ8nqv9BNQ/QYEro8=
MIME-Version: 1.0
In-Reply-To: <000000000000c471f4056acdcb9a@google.com>
References: <000000000000c471f4056acdcb9a@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Apr 2018 17:18:30 +0200
Message-ID: <CACT4Y+bxQQ6Ah37y1OkmYARi7Og7MavMvuZJLgAi3Ljc1qLWNA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in process_preds
To: syzbot <syzbot+e47d942a98e75b4bd03e@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 7:30 AM, syzbot
<syzbot+e47d942a98e75b4bd03e@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on bpf-next commit
> af487c5777709d4b7f874fe1a33f9289d51b9adc (Wed Apr 25 07:56:11 2018 +0000)
> Merge branch 'bpf-optimize-neg-sums'
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=e47d942a98e75b4bd03e
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5744539889303552
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-2918904850634584293
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e47d942a98e75b4bd03e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

#syz dup: KASAN: use-after-free Read in process_preds

> ==================================================================
> BUG: KASAN: slab-out-of-bounds in predicate_parse
> kernel/trace/trace_events_filter.c:562 [inline]
> BUG: KASAN: slab-out-of-bounds in process_preds+0x196f/0x19b0
> kernel/trace/trace_events_filter.c:1505
> Read of size 4 at addr ffff8801b2b55ff0 by task syz-executor7/7974
>
> CPU: 1 PID: 7974 Comm: syz-executor7 Not tainted 4.17.0-rc1+ #12
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  predicate_parse kernel/trace/trace_events_filter.c:562 [inline]
>  process_preds+0x196f/0x19b0 kernel/trace/trace_events_filter.c:1505
>  create_filter+0x155/0x270 kernel/trace/trace_events_filter.c:1713
>  ftrace_profile_set_filter+0x130/0x2e0
> kernel/trace/trace_events_filter.c:2038
>  perf_event_set_filter+0x248/0x1230 kernel/events/core.c:9075
>  _perf_ioctl+0x84c/0x15e0 kernel/events/core.c:5059
>  perf_ioctl+0x59/0x80 kernel/events/core.c:5110
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455389
> RSP: 002b:00007f63bbd38c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f63bbd396d4 RCX: 0000000000455389
> RDX: 0000000020000040 RSI: 0000000040082406 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000029a R14: 00000000006f6f10 R15: 0000000000000000
>
> Allocated by task 6559:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>  anon_vma_chain_alloc mm/rmap.c:128 [inline]
>  anon_vma_clone+0x138/0x720 mm/rmap.c:268
>  anon_vma_fork+0xe8/0x950 mm/rmap.c:331
>  dup_mmap kernel/fork.c:468 [inline]
>  dup_mm kernel/fork.c:1235 [inline]
>  copy_mm kernel/fork.c:1289 [inline]
>  copy_process.part.38+0x2f21/0x6e90 kernel/fork.c:1795
>  copy_process kernel/fork.c:1608 [inline]
>  _do_fork+0x291/0x12a0 kernel/fork.c:2089
>  __do_sys_clone kernel/fork.c:2196 [inline]
>  __se_sys_clone kernel/fork.c:2190 [inline]
>  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2190
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 7294:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
>  anon_vma_chain_free mm/rmap.c:133 [inline]
>  unlink_anon_vmas+0x3aa/0xa40 mm/rmap.c:400
>  free_pgtables+0x271/0x380 mm/memory.c:641
>  exit_mmap+0x2ca/0x570 mm/mmap.c:3057
>  __mmput kernel/fork.c:962 [inline]
>  mmput+0x251/0x610 kernel/fork.c:983
>  exec_mmap fs/exec.c:1044 [inline]
>  flush_old_exec+0xb94/0x20e0 fs/exec.c:1276
>  load_elf_binary+0xa33/0x5610 fs/binfmt_elf.c:869
>  search_binary_handler+0x17d/0x570 fs/exec.c:1653
>  exec_binprm fs/exec.c:1695 [inline]
>  do_execveat_common.isra.34+0x16ce/0x2590 fs/exec.c:1817
>  do_execve fs/exec.c:1862 [inline]
>  __do_sys_execve fs/exec.c:1943 [inline]
>  __se_sys_execve fs/exec.c:1938 [inline]
>  __x64_sys_execve+0x8d/0xb0 fs/exec.c:1938
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801b2b55f60
>  which belongs to the cache anon_vma_chain of size 64
> The buggy address is located 80 bytes to the right of
>  64-byte region [ffff8801b2b55f60, ffff8801b2b55fa0)
> The buggy address belongs to the page:
> page:ffffea0006cad540 count:1 mapcount:0 mapping:ffff8801b2b55000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801b2b55000 0000000000000000 000000010000002a
> raw: ffffea0006a72060 ffffea0006f615e0 ffff8801da94a500 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801b2b55e80: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801b2b55f00: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
>>
>> ffff8801b2b55f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>
>                                                              ^
>  ffff8801b2b56000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801b2b56080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c471f4056acdcb9a%40google.com.
> For more options, visit https://groups.google.com/d/optout.
