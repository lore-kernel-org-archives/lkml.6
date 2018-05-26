Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031577AbeEZJZf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:25:35 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43665 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031336AbeEZJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:25:33 -0400
X-Google-Smtp-Source: AB8JxZr3k/H1IJZfA/1uhJ1UBSR0wZNNgLMbnl1/Q9yhItXMCejKk8GpYoNXHfDwQufOks9wpqGt+ttDUYaoP2nEpmw=
MIME-Version: 1.0
In-Reply-To: <00000000000065ecae056d185548@google.com>
References: <00000000000065ecae056d185548@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 26 May 2018 11:25:11 +0200
Message-ID: <CACT4Y+buh1GE5zBFfUrPe9keTXioW=rp27o1sShwuKcuJ55eCw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in do_general_protection
To: syzbot <syzbot+a5373bacd7643643b238@syzkaller.appspotmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: KASAN: use-after-free Read in do_general_protection

On Sat, May 26, 2018 at 11:16 AM, syzbot
<syzbot+a5373bacd7643643b238@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    62d18ecfa641 Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1093ccb7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
> dashboard link: https://syzkaller.appspot.com/bug?extid=a5373bacd7643643b238
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1067742f800000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a5373bacd7643643b238@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in do_general_protection+0x2ac/0x2f0
> arch/x86/kernel/traps.c:538
> Read of size 8 at addr ffff8801b21273f8 by task syz-executor0/5106
>
> CPU: 0 PID: 5106 Comm: syz-executor0 Not tainted 4.17.0-rc6+ #92
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  do_general_protection+0x2ac/0x2f0 arch/x86/kernel/traps.c:538
>  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1159
> RIP: 0010:msr_write_intercepted arch/x86/kvm/vmx.c:2132 [inline]
> RIP: 0010:vmx_vcpu_run+0xa12/0x25c0 arch/x86/kvm/vmx.c:9879
> RSP: 0018:ffff8801b2127410 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000010000000 RCX: ffffffff811f76f2
> RDX: 000000000836b156 RSI: ffffffff811f76ff RDI: 0000000000000005
> RBP: ffff8801b2127508 R08: ffff8801cf7a6500 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  mmu_notifier_release include/linux/mmu_notifier.h:244 [inline]
>  exit_mmap+0xa4/0x5a0 mm/mmap.c:3057
>  __mmput kernel/fork.c:961 [inline]
>  mmput+0x251/0x610 kernel/fork.c:982
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0xe98/0x2730 kernel/exit.c:852
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  __do_sys_exit_group kernel/exit.c:979 [inline]
>  __se_sys_exit_group kernel/exit.c:977 [inline]
>  __ia32_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
>  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f88cb9
> RSP: 002b:00000000f7f7fa8c EFLAGS: 00000286 ORIG_RAX: 00000000000000fc
> RAX: ffffffffffffffda RBX: 000000000000000b RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> The buggy address belongs to the page:
> page:ffffea0006c849c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
> raw: 0000000000000000 ffffea0006c80101 0000000000000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801b2127280: 00 f2 00 00 00 00 00 00 00 00 00 00 00 00 f3 00
>  ffff8801b2127300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> ffff8801b2127380: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f8 f2 f2 f2
>
>                                                                 ^
>  ffff8801b2127400: f2 f2 f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2
>  ffff8801b2127480: f2 f2 f2 f2 00 f2 f2 f2 f3 f3 f3 f3 00 00 00 00
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000065ecae056d185548%40google.com.
> For more options, visit https://groups.google.com/d/optout.
