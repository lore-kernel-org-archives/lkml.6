Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbeDBVJQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:09:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:20476 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeDBVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:09:14 -0400
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org, torvalds@linux-foundation.org, msb@chromium.org,
        peterz@infradead.org, tglx@linutronix.de, vegard.nossum@oracle.com
Subject: Re: [PATCH] locking/hung_task: Show all hung tasks before panic
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1522678324-4855-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20180402153530.GN3948@linux.vnet.ibm.com>
In-Reply-To: <20180402153530.GN3948@linux.vnet.ibm.com>
Message-Id: <201804030609.BBB71756.HOFMOVFSJLQtOF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Tue, 3 Apr 2018 06:09:14 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Mon, Apr 02, 2018 at 11:12:04PM +0900, Tetsuo Handa wrote:
> > When we get a hung task it can often be valuable to see _all_ the hung
> > tasks on the system before calling panic().
> > 
> > Quoting from https://syzkaller.appspot.com/text?tag=CrashReport&id=5412451675799552
> > ----------------------------------------
> > INFO: task syz-executor3:13421 blocked for more than 120 seconds.
> >       Not tainted 4.16.0-rc7+ #9
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor3   D24672 13421   4481 0x00000004
> > Call Trace:
> >  context_switch kernel/sched/core.c:2862 [inline]
> >  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
> >  schedule+0xf5/0x430 kernel/sched/core.c:3499
> >  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
> >  rwsem_down_read_failed+0x401/0x6e0 kernel/locking/rwsem-xadd.c:286
> >  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
> >  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
> >  down_read+0xa4/0x150 kernel/locking/rwsem.c:26
> >  __get_super.part.9+0x1d3/0x280 fs/super.c:663
> >  __get_super include/linux/spinlock.h:310 [inline]
> >  get_super+0x2d/0x40 fs/super.c:692
> >  fsync_bdev+0x19/0x80 fs/block_dev.c:468
> >  invalidate_partition+0x35/0x60 block/genhd.c:1566
> >  drop_partitions.isra.12+0xcd/0x1d0 block/partition-generic.c:440
> >  rescan_partitions+0x72/0x900 block/partition-generic.c:513
> >  __blkdev_reread_part+0x15f/0x1e0 block/ioctl.c:173
> >  blkdev_reread_part+0x26/0x40 block/ioctl.c:193
> >  loop_reread_partitions+0x12f/0x1a0 drivers/block/loop.c:619
> >  loop_set_status+0x9bb/0xf60 drivers/block/loop.c:1161
> >  loop_set_status64+0x9d/0x110 drivers/block/loop.c:1271
> >  lo_ioctl+0xd86/0x1b70 drivers/block/loop.c:1381
> > (...snipped...)
> > Showing all locks held in the system:
> > (...snipped...)
> > 3 locks held by syz-executor3/13421:
> >  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000834f78af>] lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355 /* mutex_lock_nested(&lo->lo_ctl_mutex, 1); */
> >  #1:  (&bdev->bd_mutex){+.+.}, at: [<0000000003605603>] blkdev_reread_part+0x1e/0x40 block/ioctl.c:192
> >  #2:  (&type->s_umount_key#77){.+.+}, at: [<0000000077701649>] __get_super.part.9+0x1d3/0x280 fs/super.c:663 /* down_read(&sb->s_umount); */
> > (...snipped...)
> > 2 locks held by syz-executor0/13428:
> >  #0:  (&type->s_umount_key#76/1){+.+.}, at: [<00000000d25ba33a>] alloc_super fs/super.c:211 [inline]
> >  #0:  (&type->s_umount_key#76/1){+.+.}, at: [<00000000d25ba33a>] sget_userns+0x3a1/0xe40 fs/super.c:502 /* down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING); */
> >  #1:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000834f78af>] lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355 /* mutex_lock_nested(&lo->lo_ctl_mutex, 1); */
> > ----------------------------------------
> > 
> > In addition to showing hashed address of lock instances, it would be
> > nice if trace of 13428 is printed as well as 13421.
> > 
> > Showing hung tasks up to /proc/sys/kernel/hung_task_warnings could delay
> > calling panic() but normally there should not be so many hung tasks.
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Vegard Nossum <vegard.nossum@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Mandeep Singh Baines <msb@chromium.org>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> I just know that I am going to regret this the first time this happens
> on a low-speed console port, but...
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 

Thank you.

Currently sysctl_hung_task_panic case can show only the first task which was
blocked for more than hung_task_timeout_secs. Suppose "there were A, B, C, D, E, F
on the task_list in that order", "B was blocked for e.g. 130 seconds due to C",
and "C and D were blocked for e.g. 180 seconds due to deadlock". Showing B, C, D
would be more helpful than showing only B (who is just a collateral victim of
a problem between C and D).

While vmcore would tell everything, it is not realistic to share vmcore of
development kernels; different config / different compiler / different
source / too large debuginfo / possibly confidential information etc...

Thus, I hope we can get as much information as possible via printk().

> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/hung_task.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index 751593e..32b4794 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -44,6 +44,7 @@
> > 
> >  static int __read_mostly did_panic;
> >  static bool hung_task_show_lock;
> > +static bool hung_task_call_panic;
> > 
> >  static struct task_struct *watchdog_task;
> > 
> > @@ -127,10 +128,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >  	touch_nmi_watchdog();
> > 
> >  	if (sysctl_hung_task_panic) {
> > -		if (hung_task_show_lock)
> > -			debug_show_all_locks();
> > -		trigger_all_cpu_backtrace();
> > -		panic("hung_task: blocked tasks");
> > +		hung_task_show_lock = true;
> > +		hung_task_call_panic = true;
> >  	}
> >  }
> > 
> > @@ -193,6 +192,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >  	rcu_read_unlock();
> >  	if (hung_task_show_lock)
> >  		debug_show_all_locks();
> > +	if (hung_task_call_panic) {
> > +		trigger_all_cpu_backtrace();
> > +		panic("hung_task: blocked tasks");
> > +	}
> >  }
> > 
> >  static long hung_timeout_jiffies(unsigned long last_checked,
> > -- 
> > 1.8.3.1
> > 
> 
> 
