Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031402AbeBNPai (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:30:38 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43397 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031287AbeBNPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:30:36 -0500
X-Google-Smtp-Source: AH8x224EUw2SVnPSIGzdsF/DCHSxo/rk0Y9Rwv3Vhfk7/nZub5MRMyyydXjKyvJUkoaO3QI96GUsbmAD6cYW6Gt3R1U=
MIME-Version: 1.0
In-Reply-To: <f40304380b906f962005652c83b6@google.com>
References: <f40304380b906f962005652c83b6@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 16:30:14 +0100
Message-ID: <CACT4Y+ZcpBrOtyYYH4r7KiTjYeYO2BvD-0hfZmMW2Gt_dc8xCQ@mail.gmail.com>
Subject: Re: INFO: task hung in reg_check_chans_work
To: syzbot <syzbot+c57335ab056cfe211143@syzkaller.appspotmail.com>
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
<syzbot+c57335ab056cfe211143@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> cbd7b8a76b79a2ff6112ef2e77031b694843b8a1 (Tue Feb 6 23:30:52 2018 +0000)
> Merge tag 'platform-drivers-x86-v4.16-1' of
> git://git.infradead.org/linux-platform-drivers-x86
>
> So far this crash happened 6 times on net-next, upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.

Another hang on rtnl lock:

#syz dup: INFO: task hung in linkwatch_event


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c57335ab056cfe211143@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> Cannot find add_set index 2048 as target
> INFO: task kworker/1:3:5678 blocked for more than 120 seconds.
>       Not tainted 4.15.0+ #300
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/1:3     D22704  5678      2 0x80000000
> Workqueue: events_power_efficient reg_check_chans_work
> Call Trace:
>  context_switch kernel/sched/core.c:2845 [inline]
>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3421
>  schedule+0xf5/0x430 kernel/sched/core.c:3480
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3538
>  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
>  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  reg_check_chans_work+0xaa/0xff0 net/wireless/reg.c:2017
>  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
>
> Showing all locks held in the system:
> 2 locks held by khungtaskd/759:
>  #0:  (rcu_read_lock){....}, at: [<00000000d4470309>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<00000000d4470309>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<0000000037ffdeeb>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 3 locks held by kworker/0:3/1827:
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<000000008982763e>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((addr_chk_work).work){+.+.}, at: [<00000000274eb49e>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by rsyslogd/4013:
>  #0:  (&f->f_pos_lock){+.+.}, at: [<0000000008f3ba06>]
> __fdget_pos+0x12b/0x190 fs/file.c:765
> 2 locks held by getty/4134:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4135:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4136:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4137:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4138:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4139:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4140:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000d8e84bec>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003438beb0>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 3 locks held by kworker/1:3/5678:
>  #0:  ((wq_completion)"events_power_efficient"){+.+.}, at:
> [<000000008982763e>] process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((reg_check_chans).work){+.+.}, at: [<00000000274eb49e>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/11029:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<0000000050f92c05>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<0000000050f92c05>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor2/11040:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/11047:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/11051:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/11054:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<0000000050f92c05>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<0000000050f92c05>]
> ipv6_getsockopt+0x1c5/0x2e0 net/ipv6/ipv6_sockglue.c:1370
> 1 lock held by syz-executor2/11055:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/11056:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/11057:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000b75e700b>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> =============================================
>
> NMI backtrace for cpu 0
> CPU: 0 PID: 759 Comm: khungtaskd Not tainted 4.15.0+ #300
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
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10
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
> https://groups.google.com/d/msgid/syzkaller-bugs/f40304380b906f962005652c83b6%40google.com.
> For more options, visit https://groups.google.com/d/optout.
