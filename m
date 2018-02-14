Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031448AbeBNPdj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:33:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35419 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031333AbeBNPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:33:37 -0500
X-Google-Smtp-Source: AH8x227lQBDC6SuKcLWvGfbnLWzEqCoi5jcaZthu6KVJpA9z7mSHzIh0P5RD2R5gmUPQegoB6wIVlezfewAnZiU0iiA=
MIME-Version: 1.0
In-Reply-To: <001a114031f4798f2d05652c8335@google.com>
References: <001a114031f4798f2d05652c8335@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 16:33:15 +0100
Message-ID: <CACT4Y+ZKba_uuE28uVy_cw0f8fvebe36titj8UCBOeDt4G3U=Q@mail.gmail.com>
Subject: Re: INFO: task hung in linkwatch_event
To: syzbot <syzbot+a3926c3116d237751fd8@syzkaller.appspotmail.com>
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

On Wed, Feb 14, 2018 at 2:59 PM, syzbot
<syzbot+a3926c3116d237751fd8@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> a2e5790d841658485d642196dbb0927303d6c22f (Wed Feb 7 06:15:42 2018 +0000)
> Merge branch 'akpm' (patches from Andrew)
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.

Another hang on rtnl lock:

#syz dup: INFO: task hung in netdev_run_todo

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a3926c3116d237751fd8@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: task kworker/1:3:1828 blocked for more than 120 seconds.
>       Not tainted 4.15.0+ #301
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/1:3     D19968  1828      2 0x80000000
> Workqueue: events linkwatch_event
> Call Trace:
>  context_switch kernel/sched/core.c:2857 [inline]
>  __schedule+0x8e2/0x2040 kernel/sched/core.c:3435
>  schedule+0xf5/0x430 kernel/sched/core.c:3494
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3552
>  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
>  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  linkwatch_event+0x57/0xc0 net/core/link_watch.c:236
>  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
>
> Showing all locks held in the system:
> 3 locks held by kworker/1:1/23:
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<000000003027d709>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((addr_chk_work).work){+.+.}, at: [<00000000f19350a7>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by khungtaskd/760:
>  #0:  (rcu_read_lock){....}, at: [<000000007d511abd>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<000000007d511abd>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<0000000078b2aec7>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 3 locks held by kworker/1:3/1828:
>  #0:  ((wq_completion)"events"){+.+.}, at: [<000000003027d709>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((linkwatch_work).work){+.+.}, at: [<00000000f19350a7>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by rsyslogd/3879:
>  #0:  (&f->f_pos_lock){+.+.}, at: [<000000001e0f1a09>]
> __fdget_pos+0x12b/0x190 fs/file.c:765
> 2 locks held by getty/4002:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4003:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4004:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4005:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4006:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4007:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/22206:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004b23cd0c>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000007b8990ce>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 1 lock held by syz-executor0/953:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<00000000918a22c0>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<00000000918a22c0>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor0/964:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<00000000918a22c0>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<00000000918a22c0>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor0/970:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor1/977:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor1/987:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor1/1007:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor1/1008:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor3/986:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor3/1009:
>  #0:  (rtnl_mutex){+.+.}, at: [<0000000055e4e532>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 760 Comm: khungtaskd Not tainted 4.15.0+ #301
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
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a114031f4798f2d05652c8335%40google.com.
> For more options, visit https://groups.google.com/d/optout.
