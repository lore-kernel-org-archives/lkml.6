Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeDIGGn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:06:43 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:33579 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIGGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:06:41 -0400
X-Google-Smtp-Source: AIpwx499UGh0RCfk19UVOtvi2btau7rnSzWEg3ka7ky4Xf5O+IzhnY+4O85MlEm31RqtX1LxEXoBCnoqleD0hOHDOfY=
MIME-Version: 1.0
In-Reply-To: <001a11408d9c43ff4a0569641a3f@google.com>
References: <001a11408d9c43ff4a0569641a3f@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 08:06:20 +0200
Message-ID: <CACT4Y+YfM=SL3-cgeJ_7JCvAwX2KsyMWV=HHpGfLV=-RKo7TQQ@mail.gmail.com>
Subject: Re: WARNING in ip_rt_bug
To: syzbot <syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 7:59 AM, syzbot
<syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on net-next commit
> 8bde261e535257e81087d39ff808414e2f5aa39d (Sun Apr 1 02:31:43 2018 +0000)
> Merge tag 'mlx5-updates-2018-03-30' of
> git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=b09ac67a2af842b12eab
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5991727739437056
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=3327544840960562528
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


+Eric said that perhaps we just need to revert:

commit c378a9c019cf5e017d1ed24954b54fae7bebd2bc
Date:   Sat May 21 07:16:42 2011 +0000
    ipv4: Give backtrace in ip_rt_bug().


> netlink: 'syz-executor6': attribute type 3 has an invalid length.
> WARNING: CPU: 0 PID: 11678 at net/ipv4/route.c:1213 ip_rt_bug+0x15/0x20
> net/ipv4/route.c:1212
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 11678 Comm: kworker/u4:7 Not tainted 4.16.0-rc6+ #289
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x1f4/0x2b0 lib/bug.c:186
>  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:ip_rt_bug+0x15/0x20 net/ipv4/route.c:1212
> RSP: 0018:ffff8801db007290 EFLAGS: 00010282
> RAX: dffffc0000000000 RBX: ffff8801d8dda3c0 RCX: ffffffff856c31ca
> RDX: 0000000000000100 RSI: ffffffff8858c300 RDI: 0000000000000282
> RBP: ffff8801db007298 R08: 1ffff1003b600de1 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d8dda3c0
> R13: ffff88019bdb2200 R14: ffff88019bdeed80 R15: ffff8801d8dda418
>  dst_output include/net/dst.h:444 [inline]
>  ip_local_out+0x95/0x160 net/ipv4/ip_output.c:124
>  ip_send_skb+0x3c/0xc0 net/ipv4/ip_output.c:1414
>  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1434
>  icmp_push_reply+0x395/0x4f0 net/ipv4/icmp.c:394
>  icmp_send+0x1136/0x19b0 net/ipv4/icmp.c:741
>  ipv4_link_failure+0x2a/0x1b0 net/ipv4/route.c:1200
>  dst_link_failure include/net/dst.h:427 [inline]
>  arp_error_report+0xae/0x180 net/ipv4/arp.c:297
>  neigh_invalidate+0x225/0x530 net/core/neighbour.c:883
>  neigh_timer_handler+0x897/0xd60 net/core/neighbour.c:969
>  call_timer_fn+0x228/0x820 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7ee/0xb70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  invoke_softirq kernel/softirq.c:365 [inline]
>  irq_exit+0x1cc/0x200 kernel/softirq.c:405
>  exiting_irq arch/x86/include/asm/apic.h:541 [inline]
>  smp_apic_timer_interrupt+0x16b/0x700 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:857
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:778
> [inline]
> RIP: 0010:lock_acquire+0x256/0x580 kernel/locking/lockdep.c:3923
> RSP: 0018:ffff880197b3f980 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff12
> RAX: dffffc0000000000 RBX: ffff8801d225e400 RCX: 0000000000000000
> RDX: 1ffffffff10a24e5 RSI: 00000000b98b8227 RDI: 0000000000000282
> RBP: ffff880197b3fa78 R08: 1ffff10032f67e93 R09: 0000000000000004
> R10: ffff880197b3f960 R11: 0000000000000003 R12: 1ffff10032f67f36
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
>  down_write_killable+0x8a/0x140 kernel/locking/rwsem.c:84
>  __bprm_mm_init fs/exec.c:297 [inline]
>  bprm_mm_init fs/exec.c:414 [inline]
>  do_execveat_common.isra.30+0xc8e/0x23c0 fs/exec.c:1771
>  do_execve+0x31/0x40 fs/exec.c:1847
>  call_usermodehelper_exec_async+0x457/0x8f0 kernel/umh.c:100
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a11408d9c43ff4a0569641a3f%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
