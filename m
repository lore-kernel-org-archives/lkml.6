Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeDBQUs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:20:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752105AbeDBQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:20:46 -0400
Date: Mon, 2 Apr 2018 09:21:35 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com, Peter Zijlstra <peterz@infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: INFO: task hung in perf_trace_event_unreg
Reply-To: paulmck@linux.vnet.ibm.com
References: <0000000000003b5a780568da18cf@google.com>
 <20180402094040.5b6f2ace@gandalf.local.home>
 <20180402153332.GM3948@linux.vnet.ibm.com>
 <CACT4Y+brGUyXsogDsSAakSFq=bh+136JptfS_=sBqkQA1Pc=tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+brGUyXsogDsSAakSFq=bh+136JptfS_=sBqkQA1Pc=tQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040216-0008-0000-0000-000002EF8B85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008789; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012095; UDB=6.00515789; IPR=6.00791365;
 MB=3.00020377; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 16:20:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040216-0009-0000-0000-000038C26B9E
Message-Id: <20180402162135.GW3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 06:04:35PM +0200, Dmitry Vyukov wrote:
> On Mon, Apr 2, 2018 at 5:33 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Mon, Apr 02, 2018 at 09:40:40AM -0400, Steven Rostedt wrote:
> >> On Mon, 02 Apr 2018 02:20:02 -0700
> >> syzbot <syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com> wrote:
> >>
> >> > Hello,
> >> >
> >> > syzbot hit the following crash on upstream commit
> >> > 0adb32858b0bddf4ada5f364a84ed60b196dbcda (Sun Apr 1 21:20:27 2018 +0000)
> >> > Linux 4.16
> >> > syzbot dashboard link:
> >> > https://syzkaller.appspot.com/bug?extid=2dbc55da20fa246378fd
> >> >
> >> > Unfortunately, I don't have any reproducer for this crash yet.
> >> > Raw console output:
> >> > https://syzkaller.appspot.com/x/log.txt?id=5487937873510400
> >> > Kernel config:
> >> > https://syzkaller.appspot.com/x/.config?id=-2374466361298166459
> >> > compiler: gcc (GCC) 7.1.1 20170620
> >> >
> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> > Reported-by: syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com
> >> > It will help syzbot understand when the bug is fixed. See footer for
> >> > details.
> >> > If you forward the report, please keep this part and the footer.
> >> >
> >> > REISERFS warning (device loop4): super-6502 reiserfs_getopt: unknown mount
> >> > option "g �;e�K�׫>pquota"
> >
> > Might not hurt to look into the above, though perhaps this is just syzkaller
> > playing around with mount options.
> >
> >> > INFO: task syz-executor3:10803 blocked for more than 120 seconds.
> >> >        Not tainted 4.16.0+ #10
> >> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> > syz-executor3   D20944 10803   4492 0x80000002
> >> > Call Trace:
> >> >   context_switch kernel/sched/core.c:2862 [inline]
> >> >   __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
> >> >   schedule+0xf5/0x430 kernel/sched/core.c:3499
> >> >   schedule_timeout+0x1a3/0x230 kernel/time/timer.c:1777
> >> >   do_wait_for_common kernel/sched/completion.c:86 [inline]
> >> >   __wait_for_common kernel/sched/completion.c:107 [inline]
> >> >   wait_for_common kernel/sched/completion.c:118 [inline]
> >> >   wait_for_completion+0x415/0x770 kernel/sched/completion.c:139
> >> >   __wait_rcu_gp+0x221/0x340 kernel/rcu/update.c:414
> >> >   synchronize_sched.part.64+0xac/0x100 kernel/rcu/tree.c:3212
> >> >   synchronize_sched+0x76/0xf0 kernel/rcu/tree.c:3213
> >>
> >> I don't think this is a perf issue. Looks like something is preventing
> >> rcu_sched from completing. If there's a CPU that is running in kernel
> >> space and never scheduling, that can cause this issue. Or if RCU
> >> somehow missed a transition into idle or user space.
> >
> > The RCU CPU stall warning below strongly supports this position ...
> 
> I think this is this guy then:
> 
> https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
> 
> #syz dup: INFO: rcu detected stall in __process_echoes

Seems likely to me!

> Looking retrospectively at the various hang/stall bugs that we have, I
> think we need some kind of priority between them. I.e. we have rcu
> stalls, spinlock stalls, workqueue hangs, task hangs, silent machine
> hang and maybe something else. It would be useful if they fire
> deterministically according to priorities. If there is an rcu stall,
> that's always detected as CPU stall. Then if there is no RCU stall,
> but a workqueue stall, then that's always detected as workqueue stall,
> etc.
> Currently if we have an RCU stall (effectively CPU stall), that can be
> detected either RCU stall or a task hung, producing 2 different bug
> reports (which is bad).
> One can say that it's only a matter of tuning timeouts, but at least
> task hung detector has a problem that if you set timeout to X, it can
> detect hung anywhere between X and 2*X. And on one hand we need quite
> large timeout (a minute may not be enough), and on the other hand we
> can't wait for an hour just to make sure that the machine is indeed
> dead (these things happen every few minutes).

I suppose that we could have a global variable that was set to the
priority of the complaint in question, which would suppress all
lower-priority complaints.  Might need to be opt-in, though -- I would
guess that not everyone is going to be happy with one complaint suppressing
others, especially given the possibility that the two complaints might
be about different things.

Or did you have something more deft in mind?

							Thanx, Paul

> >> >   tracepoint_synchronize_unregister include/linux/tracepoint.h:80 [inline]
> >> >   perf_trace_event_unreg.isra.2+0xb7/0x1f0
> >> > kernel/trace/trace_event_perf.c:161
> >> >   perf_trace_destroy+0xbc/0x100 kernel/trace/trace_event_perf.c:236
> >> >   tp_perf_event_destroy+0x15/0x20 kernel/events/core.c:7976
> >> >   _free_event+0x3bd/0x10f0 kernel/events/core.c:4121
> >> >   put_event+0x24/0x30 kernel/events/core.c:4204
> >> >   perf_event_release_kernel+0x6e8/0xfc0 kernel/events/core.c:4310
> >> >   perf_release+0x37/0x50 kernel/events/core.c:4320
> >> >   __fput+0x327/0x7e0 fs/file_table.c:209
> >> >   ____fput+0x15/0x20 fs/file_table.c:243
> >> >   task_work_run+0x199/0x270 kernel/task_work.c:113
> >> >   exit_task_work include/linux/task_work.h:22 [inline]
> >> >   do_exit+0x9bb/0x1ad0 kernel/exit.c:865
> >> >   do_group_exit+0x149/0x400 kernel/exit.c:968
> >> >   get_signal+0x73a/0x16d0 kernel/signal.c:2469
> >> >   do_signal+0x90/0x1e90 arch/x86/kernel/signal.c:809
> >> >   exit_to_usermode_loop+0x258/0x2f0 arch/x86/entry/common.c:162
> >> >   prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
> >> >   syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
> >> >   do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
> >> >   entry_SYSCALL_64_after_hwframe+0x42/0xb7
> >> > RIP: 0033:0x455269
> >> > RSP: 002b:00007f8976371ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> >> > RAX: 0000000000000000 RBX: 000000000072bec8 RCX: 0000000000455269
> >> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
> >> > RBP: 000000000072bec8 R08: 0000000000000000 R09: 000000000072bea0
> >> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >> > R13: 00007ffe793f79cf R14: 00007f89763729c0 R15: 0000000000000000
> >> >
> >> > Showing all locks held in the system:
> >> > 2 locks held by khungtaskd/876:
> >> >   #0:  (rcu_read_lock){....}, at: [<000000008f2bec4b>]
> >> > check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
> >> >   #0:  (rcu_read_lock){....}, at: [<000000008f2bec4b>] watchdog+0x1c5/0xd60
> >> > kernel/hung_task.c:249
> >
> > ... And two places to start looking are the two above rcu_read_lock() calls.
> > Especially given that khungtask shows up below.
> >
> >> >   #1:  (tasklist_lock){.+.+}, at: [<0000000006b3009f>]
> >> > debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> >> > 2 locks held by getty/4414:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 2 locks held by getty/4415:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 2 locks held by getty/4416:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 2 locks held by getty/4417:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 2 locks held by getty/4418:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 2 locks held by getty/4419:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 2 locks held by getty/4420:
> >> >   #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]
> >> > ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
> >> >   #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]
> >> > n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
> >> > 1 lock held by syz-executor3/10803:
> >> >   #0:  (event_mutex){+.+.}, at: [<00000000c507b78a>]
> >> > perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:234
> >> > 4 locks held by syz-executor5/10816:
> >> >   #0:  (&tty->legacy_mutex){+.+.}, at: [<00000000567b7b94>]
> >> > tty_lock+0x5d/0x90 drivers/tty/tty_mutex.c:19
> >> >   #1:  (&tty->legacy_mutex/1){+.+.}, at: [<00000000567b7b94>]
> >> > tty_lock+0x5d/0x90 drivers/tty/tty_mutex.c:19
> >> >   #2:  (&tty->ldisc_sem){++++}, at: [<000000002b6b6a29>]
> >> > tty_ldisc_ref+0x1b/0x80 drivers/tty/tty_ldisc.c:298
> >> >   #3:  (&o_tty->termios_rwsem/1){++++}, at: [<0000000007d9a7a4>]
> >> > n_tty_flush_buffer+0x21/0x320 drivers/tty/n_tty.c:357
> >> > 1 lock held by syz-executor2/10827:
> >> >   #0:  (event_mutex){+.+.}, at: [<00000000c507b78a>]
> >> > perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:234
> >> > 1 lock held by blkid/10832:
> >> >   #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<000000006e2f031e>]
> >> > lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
> >> > 1 lock held by syz-executor4/10835:
> >> >   #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<000000006e2f031e>]
> >> > lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
> >> > 1 lock held by syz-executor4/10845:
> >> >   #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<000000006e2f031e>]
> >> > lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
> >> >
> >> > =============================================
> >> >
> >> > NMI backtrace for cpu 1
> >> > CPU: 1 PID: 876 Comm: khungtaskd Not tainted 4.16.0+ #10
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> > Google 01/01/2011
> >> > Call Trace:
> >> >   __dump_stack lib/dump_stack.c:17 [inline]
> >> >   dump_stack+0x194/0x24d lib/dump_stack.c:53
> >> >   nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
> >> >   nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
> >> >   arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
> >> >   trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
> >> >   check_hung_task kernel/hung_task.c:132 [inline]
> >> >   check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
> >> >   watchdog+0x90c/0xd60 kernel/hung_task.c:249
> >> > INFO: rcu_sched self-detected stall on CPU
> >> >     0-....: (124996 ticks this GP) idle=75e/1/4611686018427387906
> >> > softirq=33205/33205 fqs=30980
> >> >
> >> >   (t=125000 jiffies g=17618 c=17617 q=921)
> >> >   kthread+0x33c/0x400 kernel/kthread.c:238
> >> >   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> >> > Sending NMI from CPU 1 to CPUs 0:
> >> > NMI backtrace for cpu 0
> >> > CPU: 0 PID: 7457 Comm: kworker/u4:5 Not tainted 4.16.0+ #10
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> > Google 01/01/2011
> >> > Workqueue: events_unbound flush_to_ldisc
> >> > RIP: 0010:__process_echoes+0x641/0x770 drivers/tty/n_tty.c:733
> >> > RSP: 0018:ffff8801af4ff078 EFLAGS: 00000217
> >> > RAX: 0000000000000000 RBX: ffffc90003673000 RCX: ffffffff8352d4c2
> >> > RDX: 0000000000000006 RSI: 1ffff10039602994 RDI: ffffc9000367515e
> >> > RBP: ffff8801af4ff0e0 R08: 1ffff10035e9fdb5 R09: 0000000000000000
> >> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000625628efd
> >> > R13: dffffc0000000000 R14: 0000000000000efe R15: 0000000000001b15
> >> > FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> >> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> > CR2: 00007ffd5bfa4ca8 CR3: 000000000846a005 CR4: 00000000001606f0
> >> > DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> >> > Call Trace:
> >> >   commit_echoes+0x147/0x1b0 drivers/tty/n_tty.c:764
> >> >   n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
> >> >   n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
> >> >   __receive_buf drivers/tty/n_tty.c:1611 [inline]
> >> >   n_tty_receive_buf_common+0x1156/0x2520 drivers/tty/n_tty.c:1709
> >> >   n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
> >> >   tty_ldisc_receive_buf+0xa7/0x180 drivers/tty/tty_buffer.c:456
> >> >   tty_port_default_receive_buf+0x106/0x160 drivers/tty/tty_port.c:38
> >> >   receive_buf drivers/tty/tty_buffer.c:475 [inline]
> >> >   flush_to_ldisc+0x3c4/0x590 drivers/tty/tty_buffer.c:524
> >> >   process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
> >> >   worker_thread+0x223/0x1990 kernel/workqueue.c:2247
> >> >   kthread+0x33c/0x400 kernel/kthread.c:238
> >> >   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> >
> > And the above is another good place to look.
> >
> >                                                         Thanx, Paul
> >
> >> > Code: 60 12 00 00 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38
> >> > d0 7f 08 84 c0 0f 85 21 01 00 00 42 80 bc 33 60 12 00 00 82 <74> 0f e8 48
> >> > 90 1e fe 4d 8d 74 24 02 e9 58 ff ff ff e8 39 90 1e
> >> >
> >> >
> >> > ---
> >> > This bug is generated by a dumb bot. It may contain errors.
> >> > See https://goo.gl/tpsmEJ for details.
> >> > Direct all questions to syzkaller@googlegroups.com.
> >> >
> >> > syzbot will keep track of this bug report.
> >> > If you forgot to add the Reported-by tag, once the fix for this bug is
> >> > merged
> >> > into any tree, please reply to this email with:
> >> > #syz fix: exact-commit-title
> >> > To mark this as a duplicate of another syzbot report, please reply with:
> >> > #syz dup: exact-subject-of-another-report
> >> > If it's a one-off invalid bug report, please reply with:
> >> > #syz invalid
> >> > Note: if the crash happens again, it will cause creation of a new bug
> >> > report.
> >> > Note: all commands must start from beginning of the line in the email body.
> >>
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180402153332.GM3948%40linux.vnet.ibm.com.
> > For more options, visit https://groups.google.com/d/optout.
> 
