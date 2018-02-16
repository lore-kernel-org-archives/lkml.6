Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeBPIYN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:24:13 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36478 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753977AbeBPIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:24:08 -0500
X-Google-Smtp-Source: AH8x226mpn++Z26fHTbYzG/oIVh7E9X7EZt3Nk35neMrT0yK1cHFtvstJj7JtHAZw1WE88pGnAjMGAlEH09tfMWTbUk=
MIME-Version: 1.0
In-Reply-To: <001a11438ef07e260a0565500da1@google.com>
References: <001a11438ef07e260a0565500da1@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 16 Feb 2018 09:23:46 +0100
Message-ID: <CACT4Y+bu7P-uJyi8i1oLNFB1x71oNbXT5mFgQ-77--P75oPeXw@mail.gmail.com>
Subject: Re: INFO: task hung in tun_chr_close
To: syzbot <syzbot+06cc4590ce78d7611ef8@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 9:23 AM, syzbot
<syzbot+06cc4590ce78d7611ef8@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 1388c80438e69fc01d83fbe98da3cac24c3c8731 (Thu Feb 15 17:28:47 2018 +0000)
> Merge branch 'sched-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.

Another hang on rtnl lock:

#syz dup: INFO: task hung in netdev_run_todo

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+06cc4590ce78d7611ef8@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: task syz-executor3:4212 blocked for more than 120 seconds.
>       Not tainted 4.16.0-rc1+ #314
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor3   D19392  4212      1 0x80000006
> Call Trace:
>  context_switch kernel/sched/core.c:2862 [inline]
>  __schedule+0x905/0x2070 kernel/sched/core.c:3440
>  schedule+0xf5/0x430 kernel/sched/core.c:3499
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3557
>  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
>  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  tun_detach drivers/net/tun.c:745 [inline]
>  tun_chr_close+0x37/0x60 drivers/net/tun.c:3179
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73a/0x16d0 kernel/signal.c:2469
>  do_signal+0x90/0x1e90 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x258/0x2f0 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6e5/0x940 arch/x86/entry/common.c:292
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x40dd9a
> RSP: 002b:0000000000a2ed68 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
> RAX: fffffffffffffe00 RBX: 0000000000000051 RCX: 000000000040dd9a
> RDX: 0000000040000000 RSI: 0000000000a2ed94 RDI: ffffffffffffffff
> RBP: 0000000000a2eda0 R08: 0000000000000001 R09: 0000000002625940
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a2f420
> R13: 0000000000000195 R14: 0000000000000000 R15: 0000000002625914
>
> Showing all locks held in the system:
> 2 locks held by khungtaskd/756:
>  #0:  (rcu_read_lock){....}, at: [<000000006b36ceac>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<000000006b36ceac>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<000000005abe57a4>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 2 locks held by getty/4132:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4133:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4134:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4135:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4136:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4137:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4138:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000595260b7>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000c36b84df>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 1 lock held by syz-executor3/4212:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 3 locks held by kworker/0:2/4726:
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<00000000302cad21>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((addr_chk_work).work){+.+.}, at: [<0000000095b7c7c2>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 3 locks held by kworker/0:3/7235:
>  #0:  ((wq_completion)"events_power_efficient"){+.+.}, at:
> [<00000000302cad21>] process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((reg_check_chans).work){+.+.}, at: [<0000000095b7c7c2>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor6/7622:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000002f175fa6>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000002f175fa6>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor6/7641:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor6/7667:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000002f175fa6>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000002f175fa6>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor6/7673:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor3/7643:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/7648:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/7670:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000a8309eae>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 756 Comm: khungtaskd Not tainted 4.16.0-rc1+ #314
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
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:407
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10
> arch/x86/include/asm/irqflags.h:54
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a11438ef07e260a0565500da1%40google.com.
> For more options, visit https://groups.google.com/d/optout.
