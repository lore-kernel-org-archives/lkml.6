Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeDDWF3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:05:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36678 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeDDWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:05:28 -0400
To: akpm@linux-foundation.org
Cc: dvyukov@google.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, msb@chromium.org, peterz@infradead.org,
        tglx@linutronix.de, vegard.nossum@oracle.com
Subject: [PATCH v2] locking/hung_task: Show all hung tasks before panic
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1522678324-4855-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20180402153530.GN3948@linux.vnet.ibm.com>
        <CACT4Y+Yk0hEDj2EcXTJ5BcTHE0m1Sn0e9RfY=6KC4nWhWOHPmw@mail.gmail.com>
In-Reply-To: <CACT4Y+Yk0hEDj2EcXTJ5BcTHE0m1Sn0e9RfY=6KC4nWhWOHPmw@mail.gmail.com>
Message-Id: <201804050705.BHE57833.HVFOFtSOMQJFOL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Thu, 5 Apr 2018 07:05:21 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get a hung task it can often be valuable to see _all_ the hung
tasks on the system before calling panic().

Quoting from https://syzkaller.appspot.com/text?tag=CrashReport&id=5316056503549952
----------------------------------------
INFO: task syz-executor0:6540 blocked for more than 120 seconds.
      Not tainted 4.16.0+ #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D23560  6540   4521 0x80000004
Call Trace:
 context_switch kernel/sched/core.c:2848 [inline]
 __schedule+0x8fb/0x1ef0 kernel/sched/core.c:3490
 schedule+0xf5/0x430 kernel/sched/core.c:3549
 schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3607
 __mutex_lock_common kernel/locking/mutex.c:833 [inline]
 __mutex_lock+0xb7f/0x1810 kernel/locking/mutex.c:893
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
 lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
 __blkdev_driver_ioctl block/ioctl.c:303 [inline]
 blkdev_ioctl+0x1759/0x1e00 block/ioctl.c:601
 ioctl_by_bdev+0xa5/0x110 fs/block_dev.c:2060
 isofs_get_last_session fs/isofs/inode.c:567 [inline]
 isofs_fill_super+0x2ba9/0x3bc0 fs/isofs/inode.c:660
 mount_bdev+0x2b7/0x370 fs/super.c:1119
 isofs_mount+0x34/0x40 fs/isofs/inode.c:1560
 mount_fs+0x66/0x2d0 fs/super.c:1222
 vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
 vfs_kern_mount fs/namespace.c:2514 [inline]
 do_new_mount fs/namespace.c:2517 [inline]
 do_mount+0xea4/0x2b90 fs/namespace.c:2847
 ksys_mount+0xab/0x120 fs/namespace.c:3063
 SYSC_mount fs/namespace.c:3077 [inline]
 SyS_mount+0x39/0x50 fs/namespace.c:3074
 do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
(...snipped...)
Showing all locks held in the system:
(...snipped...)
2 locks held by syz-executor0/6540:
 #0: 00000000566d4c39 (&type->s_umount_key#49/1){+.+.}, at: alloc_super fs/super.c:211 [inline]
 #0: 00000000566d4c39 (&type->s_umount_key#49/1){+.+.}, at: sget_userns+0x3b2/0xe60 fs/super.c:502 /* down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING); */
 #1: 0000000043ca8836 (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355 /* mutex_lock_nested(&lo->lo_ctl_mutex, 1); */
(...snipped...)
3 locks held by syz-executor7/6541:
 #0: 0000000043ca8836 (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355 /* mutex_lock_nested(&lo->lo_ctl_mutex, 1); */
 #1: 000000007bf3d3f9 (&bdev->bd_mutex){+.+.}, at: blkdev_reread_part+0x1e/0x40 block/ioctl.c:192
 #2: 00000000566d4c39 (&type->s_umount_key#50){.+.+}, at: __get_super.part.10+0x1d3/0x280 fs/super.c:663 /* down_read(&sb->s_umount); */
----------------------------------------

When reporting an AB-BA deadlock like shown above, it would be nice if
trace of PID=6541 is printed as well as trace of PID=6540 before calling
panic().

Showing hung tasks up to /proc/sys/kernel/hung_task_warnings could delay
calling panic() but normally there should not be so many hung tasks.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mandeep Singh Baines <msb@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/hung_task.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 751593e..32b4794 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -44,6 +44,7 @@
 
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
+static bool hung_task_call_panic;
 
 static struct task_struct *watchdog_task;
 
@@ -127,10 +128,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	touch_nmi_watchdog();
 
 	if (sysctl_hung_task_panic) {
-		if (hung_task_show_lock)
-			debug_show_all_locks();
-		trigger_all_cpu_backtrace();
-		panic("hung_task: blocked tasks");
+		hung_task_show_lock = true;
+		hung_task_call_panic = true;
 	}
 }
 
@@ -193,6 +192,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	rcu_read_unlock();
 	if (hung_task_show_lock)
 		debug_show_all_locks();
+	if (hung_task_call_panic) {
+		trigger_all_cpu_backtrace();
+		panic("hung_task: blocked tasks");
+	}
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
-- 
1.8.3.1
