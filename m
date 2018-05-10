Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756522AbeEJFOt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 01:14:49 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:43332 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755004AbeEJFOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 01:14:47 -0400
X-Google-Smtp-Source: AB8JxZpXbjxfMAnImIYZzF6tBO1EyQp9N3rxbDoSHJeogc6dzW0Cr/ffYqDOi/FQxC0GYGeOLuAIYZoOlHz8sGMie34=
MIME-Version: 1.0
In-Reply-To: <0000000000003723710569916833@google.com>
References: <0000000000003723710569916833@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 10 May 2018 07:14:26 +0200
Message-ID: <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in process_preds
To: syzbot <syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 2:02 PM, syzbot
<syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
> Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=5702a7e6d4a13b3accd5
>
> So far this crash happened 4 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6364313065357312
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=4775648954417152
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6353070183153664
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


This was bisected to:

commit 80765597bc587feae8dbc8ce97a0f32e12a6e625
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Fri Mar 9 13:19:28 2018 -0500

    tracing: Rewrite filter logic to be simpler and faster



> ==================================================================
> BUG: KASAN: slab-out-of-bounds in predicate_parse
> kernel/trace/trace_events_filter.c:557 [inline]
> BUG: KASAN: slab-out-of-bounds in process_preds+0x1958/0x19b0
> kernel/trace/trace_events_filter.c:1505
> Write of size 4 at addr ffff8801ceecdef0 by task syzkaller992239/4513
>
> CPU: 0 PID: 4513 Comm: syzkaller992239 Not tainted 4.16.0+ #17
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
>  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
>  predicate_parse kernel/trace/trace_events_filter.c:557 [inline]
>  process_preds+0x1958/0x19b0 kernel/trace/trace_events_filter.c:1505
>  create_filter+0x1a8/0x370 kernel/trace/trace_events_filter.c:1714
>  ftrace_profile_set_filter+0x109/0x2b0
> kernel/trace/trace_events_filter.c:2042
>  perf_event_set_filter+0x248/0x1230 kernel/events/core.c:9064
>  _perf_ioctl+0x84c/0x1650 kernel/events/core.c:5056
>  perf_ioctl+0x59/0x80 kernel/events/core.c:5107
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  SYSC_ioctl fs/ioctl.c:708 [inline]
>  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x43fdb9
> RSP: 002b:00007ffc7afb3e88 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fdb9
> RDX: 0000000020000040 RSI: 0000000040082406 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004016e0
> R13: 0000000000401770 R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 1:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:512 [inline]
>  call_modprobe kernel/kmod.c:80 [inline]
>  __request_module+0x386/0xcdd kernel/kmod.c:171
>  adfdrv_init+0x1b/0x5f drivers/crypto/qat/qat_dh895xcc/adf_drv.c:315
>  do_one_initcall+0x127/0x913 init/main.c:880
>  do_initcall_level init/main.c:948 [inline]
>  do_initcalls init/main.c:956 [inline]
>  do_basic_setup init/main.c:974 [inline]
>  kernel_init_freeable+0x49b/0x58e init/main.c:1124
>  kernel_init+0x11/0x1b3 init/main.c:1050
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
>
> Freed by task 1:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  free_modprobe_argv+0x74/0xa0 kernel/kmod.c:67
>  call_usermodehelper_freeinfo kernel/umh.c:42 [inline]
>  call_usermodehelper_exec+0x274/0x4f0 kernel/umh.c:458
>  call_modprobe kernel/kmod.c:99 [inline]
>  __request_module+0x4ba/0xcdd kernel/kmod.c:171
>  adfdrv_init+0x1b/0x5f drivers/crypto/qat/qat_dh895xcc/adf_drv.c:315
>  do_one_initcall+0x127/0x913 init/main.c:880
>  do_initcall_level init/main.c:948 [inline]
>  do_initcalls init/main.c:956 [inline]
>  do_basic_setup init/main.c:974 [inline]
>  kernel_init_freeable+0x49b/0x58e init/main.c:1124
>  kernel_init+0x11/0x1b3 init/main.c:1050
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
>
> The buggy address belongs to the object at ffff8801ceecde80
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 48 bytes to the right of
>  64-byte region [ffff8801ceecde80, ffff8801ceecdec0)
> The buggy address belongs to the page:
> page:ffffea00073bb340 count:1 mapcount:0 mapping:ffff8801ceecd000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801ceecd000 0000000000000000 0000000100000020
> raw: ffffea0007392ba0 ffffea0007509220 ffff8801dac00340 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801ceecdd80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801ceecde00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>>
>> ffff8801ceecde80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>
>                                                              ^
>  ffff8801ceecdf00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>  ffff8801ceecdf80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000003723710569916833%40google.com.
> For more options, visit https://groups.google.com/d/optout.
