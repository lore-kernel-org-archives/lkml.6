Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeBAXpf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:45:35 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37427 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBAXp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:45:27 -0500
X-Google-Smtp-Source: AH8x224CVVyyFWRK0vOPn5xafFWIsptKnZlnyXXGbpML/iPnVFhOGlqPgx/fEvYtDC7eC97nKYDYBxR1oc+qC9ct84g=
MIME-Version: 1.0
In-Reply-To: <20180201225646.dbug5oh3vupjrpy4@gmail.com>
References: <001a113c0b987a17160561d3de01@google.com> <20180201225646.dbug5oh3vupjrpy4@gmail.com>
From: Wei Wang <weiwan@google.com>
Date: Thu, 1 Feb 2018 15:45:25 -0800
Message-ID: <CAEA6p_Br8VjUits9XBG-opoJMj31Y_eBR7fjDjG3uxWyFNSjLA@mail.gmail.com>
Subject: Re: suspicious RCU usage at net/ipv6/ip6_fib.c:LINE
To: Eric Biggers <ebiggers3@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        syzbot <syzbot+bca7109dba5d86cb0209@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 2:56 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> +weiwan@google.com
>
> On Tue, Jan 02, 2018 at 03:58:02PM -0800, syzbot wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> 6bb8824732f69de0f233ae6b1a8158e149627b38
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>> C reproducer is attached
>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> for information about syzkaller reproducers
>>
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+bca7109dba5d86cb0209@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>>
>> =============================
>> WARNING: suspicious RCU usage
>> 4.15.0-rc5+ #171 Not tainted
>> -----------------------------
>> net/ipv6/ip6_fib.c:1702 suspicious rcu_dereference_protected() usage!
>>
>> other info that might help us debug this:
>>
>>
>> rcu_scheduler_active = 2, debug_locks = 1
>> 4 locks held by swapper/0/0:
>>  #0:  ((&net->ipv6.ip6_fib_timer)){+.-.}, at: [<00000000d43f631b>]
>> lockdep_copy_map include/linux/lockdep.h:178 [inline]
>>  #0:  ((&net->ipv6.ip6_fib_timer)){+.-.}, at: [<00000000d43f631b>]
>> call_timer_fn+0x1c6/0x820 kernel/time/timer.c:1310
>>  #1:  (&(&net->ipv6.fib6_gc_lock)->rlock){+.-.}, at: [<000000002ff9d65c>]
>> spin_lock_bh include/linux/spinlock.h:315 [inline]
>>  #1:  (&(&net->ipv6.fib6_gc_lock)->rlock){+.-.}, at: [<000000002ff9d65c>]
>> fib6_run_gc+0x9d/0x3c0 net/ipv6/ip6_fib.c:2007
>>  #2:  (rcu_read_lock){....}, at: [<0000000091db762d>]
>> __fib6_clean_all+0x0/0x3a0 net/ipv6/ip6_fib.c:1560
>>  #3:  (&(&tb->tb6_lock)->rlock){+.-.}, at: [<000000009e503581>] spin_lock_bh
>> include/linux/spinlock.h:315 [inline]
>>  #3:  (&(&tb->tb6_lock)->rlock){+.-.}, at: [<000000009e503581>]
>> __fib6_clean_all+0x1d0/0x3a0 net/ipv6/ip6_fib.c:1948
>>
>> stack backtrace:
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #171
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>>  lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4585
>>  fib6_del+0xcaa/0x11b0 net/ipv6/ip6_fib.c:1701
>>  fib6_clean_node+0x3aa/0x4f0 net/ipv6/ip6_fib.c:1892
>>  fib6_walk_continue+0x46c/0x8a0 net/ipv6/ip6_fib.c:1815
>>  fib6_walk+0x91/0xf0 net/ipv6/ip6_fib.c:1863
>>  fib6_clean_tree+0x1e6/0x340 net/ipv6/ip6_fib.c:1933
>>  __fib6_clean_all+0x1f4/0x3a0 net/ipv6/ip6_fib.c:1949
>>  fib6_clean_all net/ipv6/ip6_fib.c:1960 [inline]
>>  fib6_run_gc+0x16b/0x3c0 net/ipv6/ip6_fib.c:2016
>>  fib6_gc_timer_cb+0x20/0x30 net/ipv6/ip6_fib.c:2033
>>  call_timer_fn+0x228/0x820 kernel/time/timer.c:1320
>>  expire_timers kernel/time/timer.c:1357 [inline]
>>  __run_timers+0x7ee/0xb70 kernel/time/timer.c:1660
>>  run_timer_softirq+0x4c/0xb0 kernel/time/timer.c:1686
>>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>>  invoke_softirq kernel/softirq.c:365 [inline]
>>  irq_exit+0x1cc/0x200 kernel/softirq.c:405
>>  exiting_irq arch/x86/include/asm/apic.h:540 [inline]
>>  smp_apic_timer_interrupt+0x16b/0x700 arch/x86/kernel/apic/apic.c:1052
>>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:904
>>  </IRQ>
>> RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
>> RSP: 0018:ffffffff86407c38 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff11
>> RAX: dffffc0000000000 RBX: 1ffffffff0c80f8a RCX: 0000000000000000
>> RDX: 1ffffffff0c99048 RSI: 0000000000000001 RDI: ffffffff864c8240
>> RBP: ffffffff86407c38 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> R13: ffffffff86407cf0 R14: ffffffff86c329a0 R15: 0000000000000000
>>  arch_safe_halt arch/x86/include/asm/paravirt.h:93 [inline]
>>  default_idle+0xbf/0x460 arch/x86/kernel/process.c:355
>>  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:346
>>  default_idle_call+0x36/0x90 kernel/sched/idle.c:98
>>  cpuidle_idle_call kernel/sched/idle.c:156 [inline]
>>  do_idle+0x24a/0x3b0 kernel/sched/idle.c:246
>>  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:351
>>  rest_init+0xed/0xf0 init/main.c:435
>>  start_kernel+0x7f1/0x819 init/main.c:713
>>  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>>  x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>>  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
>
> Wei, was this meant to have been fixed by commit 4512c43eac7e00 ("ipv6: remove
> null_entry before adding default route")?  This crash actually still occurred on

Yes. I would think so.

> net-next as recently as 43df215d99e604 (Jan 25) which included your fix.  I will
> go ahead and mark this bug fixed, but syzbot will send a new report if it hits
> it again.
>

OK. Got it.

> #syz fix: ipv6: remove null_entry before adding default route
>
> - Eric
