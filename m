Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933172AbeBLKFM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:05:12 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38253 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeBLKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:05:09 -0500
X-Google-Smtp-Source: AH8x224s9C8iZJZPk8RP5DbWjTWCnmOEBsBzOdyANSADhfZChi/weCNmpGN0BQz8CxdAu6gVaWiPgRlZDBY/JBcyPqs=
MIME-Version: 1.0
In-Reply-To: <001a11374860d849ee0564a0939c@google.com>
References: <001a11374860d849ee0564a0939c@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 11:04:47 +0100
Message-ID: <CACT4Y+aQq=HeK9qFC2nEXr4=4AgVKRZ5ZSrEO1iEaXJ+-1RpDg@mail.gmail.com>
Subject: Re: INFO: task hung in check_lifetime
To: syzbot <syzbot+c630b6e9170ae563e405@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>, mschiffer@universe-factory.net,
        netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 4:02 PM, syzbot
<syzbot+c630b6e9170ae563e405@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on net-next commit
> 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
> Merge tag 'usercopy-v4.16-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c630b6e9170ae563e405@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

Let's consider this as:

#syz dup: INFO: task hung in netdev_run_todo

both hanged on rtnl_lock.


> Cannot find set identified by id 0 to match
> Cannot find set identified by id 0 to match
> INFO: task kworker/1:3:6053 blocked for more than 120 seconds.
>       Not tainted 4.15.0+ #221
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/1:3     D22992  6053      2 0x80000000
> Workqueue: events_power_efficient check_lifetime
> Call Trace:
>  context_switch kernel/sched/core.c:2845 [inline]
>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3421
>  schedule+0xf5/0x430 kernel/sched/core.c:3480
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3538
>  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
>  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  check_lifetime+0x4e9/0x8d0 net/ipv4/devinet.c:700
>  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:542
>
> Showing all locks held in the system:
> 3 locks held by kworker/0:1/24:
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<00000000ea6cb14c>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((addr_chk_work).work){+.+.}, at: [<00000000ccf8e54d>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000d8542286>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by khungtaskd/757:
>  #0:  (rcu_read_lock){....}, at: [<000000007a7193b5>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<000000007a7193b5>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<000000003712cc52>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 2 locks held by getty/4145:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4146:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4147:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4148:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4149:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4150:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4151:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000a116195c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c4d26882>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 3 locks held by kworker/1:3/6053:
>  #0:  ((wq_completion)"events_power_efficient"){+.+.}, at:
> [<00000000ea6cb14c>] process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((check_lifetime_work).work){+.+.}, at: [<00000000ccf8e54d>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000d8542286>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 3 locks held by kworker/1:4/6058:
>  #0:  ((wq_completion)"events_power_efficient"){+.+.}, at:
> [<00000000ea6cb14c>] process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((reg_check_chans).work){+.+.}, at: [<00000000ccf8e54d>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000d8542286>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor7/10525:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000003aa50582>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000003aa50582>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor7/10527:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000d8542286>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 757 Comm: khungtaskd Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
>  check_hung_task kernel/hung_task.c:132 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
>  watchdog+0x90c/0xd60 kernel/hung_task.c:249
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:542
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:ktime_get+0x7e/0x3a0 kernel/time/timekeeping.c:759
> RSP: 0018:ffff8801db407c30 EFLAGS: 00000093
> RAX: ffffffff86a2c340 RBX: ffff8801db426620 RCX: ffffffff816158c8
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000082
> RBP: ffff8801db407d18 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003b680f8a
> R13: ffff8801db407cf0 R14: ffff8801db407e68 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8801db400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001eb8000 CR3: 0000000006a22002 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  tick_nohz_irq_enter kernel/time/tick-sched.c:1148 [inline]
>  tick_irq_enter+0x9e/0x390 kernel/time/tick-sched.c:1169
>  irq_enter+0xb6/0xd0 kernel/softirq.c:346
>  scheduler_ipi+0x23d/0x820 kernel/sched/core.c:1794
>  smp_reschedule_interrupt+0xe6/0x670 arch/x86/kernel/smp.c:277
>  reschedule_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:962
>  </IRQ>
> RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
> RSP: 0018:ffffffff86a07c38 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
> RAX: dffffc0000000000 RBX: 1ffffffff0d40f8a RCX: 0000000000000000
> RDX: 1ffffffff0d59280 RSI: 0000000000000001 RDI: ffffffff86ac9400
> RBP: ffffffff86a07c38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff86a07cf0 R14: ffffffff87268d60 R15: 0000000000000000
>  arch_safe_halt arch/x86/include/asm/paravirt.h:93 [inline]
>  default_idle+0xbf/0x430 arch/x86/kernel/process.c:354
>  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:345
>  default_idle_call+0x36/0x90 kernel/sched/idle.c:98
>  cpuidle_idle_call kernel/sched/idle.c:156 [inline]
>  do_idle+0x24a/0x3b0 kernel/sched/idle.c:246
>  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:351
>  rest_init+0xed/0xf0 init/main.c:436
>  start_kernel+0x7f1/0x819 init/main.c:716
>  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>  x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
> Code: f1 f1 f1 f1 c7 40 04 04 f2 f2 f2 c7 40 08 f2 f2 f2 f2 c7 40 0c 00 f2
> f2 f2 c7 40 10 f3 f3 f3 f3 e8 e8 4c 0f 00 8b 15 26 36 c5 05 <85> d2 0f 85 b4
> 02 00 00 48 c7 c0 f0 93 ac 86 48 bb 00 00 00 00
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a11374860d849ee0564a0939c%40google.com.
> For more options, visit https://groups.google.com/d/optout.
