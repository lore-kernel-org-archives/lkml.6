Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755289AbeCSGfF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:35:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37585 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeCSGfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:35:03 -0400
X-Google-Smtp-Source: AG47ELuwdNb864/3vAbIrGunzSVs9dbPimwgDZcfioQKd68FTKD2Z2wQ5tY+YTF60FttE1wO4grQ9Pu5bLQhSqut6BY=
MIME-Version: 1.0
In-Reply-To: <001a1135b9dafc2a150567be19e9@google.com>
References: <001a1135b9dafc2a150567be19e9@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 19 Mar 2018 09:34:41 +0300
Message-ID: <CACT4Y+aDdDWs9m281e6tWGnfbhR52-W5O3S2wKwznWQ0fmzs2Q@mail.gmail.com>
Subject: Re: INFO: task hung in __tun_chr_ioctl
To: syzbot <syzbot+a13db9a2536a9c41c4f2@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 9:31 AM, syzbot
<syzbot+a13db9a2536a9c41c4f2@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 8f5fd927c3a7576d57248a2d7a0861c3f2795973 (Fri Mar 16 20:37:42 2018 +0000)
> Merge tag 'for-4.16-rc5-tag' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.


Another hung task on rtnl_lock:

#syz dup: INFO: task hung in netdev_run_todo

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a13db9a2536a9c41c4f2@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: task syz-executor1:22250 blocked for more than 120 seconds.
>       Not tainted 4.16.0-rc5+ #357
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor1   D25184 22250   4289 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2862 [inline]
>  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
>  schedule+0xf5/0x430 kernel/sched/core.c:3499
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3557
>  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
>  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  __tun_chr_ioctl+0x1b1/0x40d0 drivers/net/tun.c:2810
>  tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:3077
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x453e69
> RSP: 002b:00007fa8a093bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fa8a093c6d4 RCX: 0000000000453e69
> RDX: 0000000020000080 RSI: 00000000400454ca RDI: 0000000000000013
> RBP: 000000000072bf58 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000000323 R14: 00000000006f4be8 R15: 0000000000000001
>
> Showing all locks held in the system:
> 2 locks held by kworker/1:0/17:
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>] work_static
> include/linux/workqueue.h:198 [inline]
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>]
> set_work_data kernel/workqueue.c:619 [inline]
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>]
> set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>]
> process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>  #1:  ((work_completion)(&rew.rew_work)){+.+.}, at: [<000000006415d644>]
> process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
> 2 locks held by khungtaskd/800:
>  #0:  (rcu_read_lock){....}, at: [<00000000d3e58282>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<00000000d3e58282>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<00000000590b6074>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 3 locks held by kworker/1:2/1784:
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>] work_static
> include/linux/workqueue.h:198 [inline]
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>]
> set_work_data kernel/workqueue.c:619 [inline]
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>]
> set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000c9e8457d>]
> process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>  #1:  ((linkwatch_work).work){+.+.}, at: [<000000006415d644>]
> process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by getty/4207:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4208:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4209:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4210:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4211:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4212:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4213:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000002246b2d4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000025b60669>]
> n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> 3 locks held by kworker/1:3/8166:
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<00000000c9e8457d>]
> work_static include/linux/workqueue.h:198 [inline]
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<00000000c9e8457d>]
> set_work_data kernel/workqueue.c:619 [inline]
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<00000000c9e8457d>]
> set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<00000000c9e8457d>]
> process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>  #1:  ((addr_chk_work).work){+.+.}, at: [<000000006415d644>]
> process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by syz-executor1/22242:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>  #1:  (rcu_sched_state.exp_mutex){+.+.}, at: [<00000000675a5f13>]
> exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>  #1:  (rcu_sched_state.exp_mutex){+.+.}, at: [<00000000675a5f13>]
> _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0
> kernel/rcu/tree_exp.h:596
> 1 lock held by syz-executor1/22250:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor1/22253:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor0/22256:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor0/22261:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor0/22264:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor0/22265:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by syz-executor2/22243:
>  #0:  (&sig->cred_guard_mutex){+.+.}, at: [<00000000096b46ba>]
> SYSC_perf_event_open+0x12ca/0x2e00 kernel/events/core.c:9979
>  #1:  (perf_sched_mutex){+.+.}, at: [<000000007096a60e>] account_event
> kernel/events/core.c:9385 [inline]
>  #1:  (perf_sched_mutex){+.+.}, at: [<000000007096a60e>]
> perf_event_alloc+0x2326/0x2b00 kernel/events/core.c:9576
> 1 lock held by syz-executor2/22245:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/22259:
>  #0:  (rtnl_mutex){+.+.}, at: [<00000000e275d2e6>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by syz-executor6/22247:
>  #0:  (&sig->cred_guard_mutex){+.+.}, at: [<00000000096b46ba>]
> SYSC_perf_event_open+0x12ca/0x2e00 kernel/events/core.c:9979
>  #1:  (perf_sched_mutex){+.+.}, at: [<000000007096a60e>] account_event
> kernel/events/core.c:9385 [inline]
>  #1:  (perf_sched_mutex){+.+.}, at: [<000000007096a60e>]
> perf_event_alloc+0x2326/0x2b00 kernel/events/core.c:9576
> 3 locks held by blkid/22275:
>  #0:  (&bdev->bd_mutex){+.+.}, at: [<0000000012e91cb0>]
> __blkdev_put+0xbc/0x760 fs/block_dev.c:1775
>  #1:  (loop_index_mutex){+.+.}, at: [<00000000f6fa39f1>]
> lo_release+0x1f/0x190 drivers/block/loop.c:1614
>  #2:  (&lo->lo_ctl_mutex#2){+.+.}, at: [<00000000d468c386>] __lo_release
> drivers/block/loop.c:1591 [inline]
>  #2:  (&lo->lo_ctl_mutex#2){+.+.}, at: [<00000000d468c386>]
> lo_release+0x85/0x190 drivers/block/loop.c:1615
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 800 Comm: khungtaskd Not tainted 4.16.0-rc5+ #357
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
>  check_hung_task kernel/hung_task.c:132 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
>  watchdog+0x90c/0xd60 kernel/hung_task.c:249
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.16.0-rc5+ #357
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:jhash2 include/linux/jhash.h:128 [inline]
> RIP: 0010:hash_stack lib/stackdepot.c:161 [inline]
> RIP: 0010:depot_save_stack+0x91/0x460 lib/stackdepot.c:230
> RSP: 0000:ffff8801d9ae6cb0 EFLAGS: 00000206
> RAX: 000000009be52447 RBX: 00000000c56934f1 RCX: 0000000000000006
> RDX: ffff8801d9ae6d80 RSI: 0000000001090220 RDI: ffff8801d9ae6cf0
> RBP: ffff8801d9ae6ce0 R08: 0000000000000012 R09: ffff8801d9ae6d08
> R10: 0000000026be1269 R11: 00000000c56934f1 R12: ffff880149a6a240
> R13: 0000000001090220 R14: ffff880149a6a240 R15: ffff8801dac00940
> FS:  0000000000000000(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f382a0f3db8 CR3: 0000000006e22002 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  save_stack+0xa3/0xd0 mm/kasan/kasan.c:453
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
>  slab_post_alloc_hook mm/slab.h:443 [inline]
>  slab_alloc_node mm/slab.c:3322 [inline]
>  kmem_cache_alloc_node_trace+0x139/0x760 mm/slab.c:3648
>  __do_kmalloc_node mm/slab.c:3668 [inline]
>  __kmalloc_node_track_caller+0x33/0x70 mm/slab.c:3683
>  __kmalloc_reserve.isra.39+0x41/0xd0 net/core/skbuff.c:137
>  __alloc_skb+0x13b/0x780 net/core/skbuff.c:205
>  alloc_skb include/linux/skbuff.h:983 [inline]
>  _sctp_make_chunk+0x51/0x270 net/sctp/sm_make_chunk.c:1390
>  sctp_make_control+0x39/0x150 net/sctp/sm_make_chunk.c:1437
>  sctp_make_heartbeat+0x90/0x420 net/sctp/sm_make_chunk.c:1151
>  sctp_sf_heartbeat.isra.24+0x26/0x180 net/sctp/sm_statefuns.c:973
>  sctp_sf_sendbeat_8_3+0x36b/0x520 net/sctp/sm_statefuns.c:1017
>  sctp_do_sm+0x192/0x6ed0 net/sctp/sm_sideeffect.c:1178
>  sctp_generate_heartbeat_event+0x292/0x3f0 net/sctp/sm_sideeffect.c:406
>  call_timer_fn+0x228/0x820 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7ee/0xb70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  run_ksoftirqd+0x86/0x100 kernel/softirq.c:666
>  smpboot_thread_fn+0x450/0x7c0 kernel/smpboot.c:164
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> Code: 45 31 da 44 29 d0 41 89 c3 44 89 d0 41 01 da c1 c0 06 44 31 d8 29 c3
> 41 89 db 89 c3 44 01 d0 c1 c3 08 44 31 db 41 89 db 41 29 da <01> c3 41 c1 c3
> 10 45 31 da 45 89 d3 44 29 d0 41 01 da 41 c1 cb
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1135b9dafc2a150567be19e9%40google.com.
> For more options, visit https://groups.google.com/d/optout.
