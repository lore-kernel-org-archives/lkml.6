Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeE1KIx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934203AbeE1KIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:08:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Hannes Reinecke <hare@suse.de>, Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 041/185] bcache: properly set task state in bch_writeback_thread()
Date: Mon, 28 May 2018 12:01:22 +0200
Message-Id: <20180528100054.276713317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Coly Li <colyli@suse.de>

[ Upstream commit 99361bbf26337186f02561109c17a4c4b1a7536a ]

Kernel thread routine bch_writeback_thread() has the following code block,

447         down_write(&dc->writeback_lock);
448~450     if (check conditions) {
451                 up_write(&dc->writeback_lock);
452                 set_current_state(TASK_INTERRUPTIBLE);
453
454                 if (kthread_should_stop())
455                         return 0;
456
457                 schedule();
458                 continue;
459         }

If condition check is true, its task state is set to TASK_INTERRUPTIBLE
and call schedule() to wait for others to wake up it.

There are 2 issues in current code,
1, Task state is set to TASK_INTERRUPTIBLE after the condition checks, if
   another process changes the condition and call wake_up_process(dc->
   writeback_thread), then at line 452 task state is set back to
   TASK_INTERRUPTIBLE, the writeback kernel thread will lose a chance to be
   waken up.
2, At line 454 if kthread_should_stop() is true, writeback kernel thread
   will return to kernel/kthread.c:kthread() with TASK_INTERRUPTIBLE and
   call do_exit(). It is not good to enter do_exit() with task state
   TASK_INTERRUPTIBLE, in following code path might_sleep() is called and a
   warning message is reported by __might_sleep(): "WARNING: do not call
   blocking ops when !TASK_RUNNING; state=1 set at [xxxx]".

For the first issue, task state should be set before condition checks.
Ineed because dc->writeback_lock is required when modifying all the
conditions, calling set_current_state() inside code block where dc->
writeback_lock is hold is safe. But this is quite implicit, so I still move
set_current_state() before all the condition checks.

For the second issue, frankley speaking it does not hurt when kernel thread
exits with TASK_INTERRUPTIBLE state, but this warning message scares users,
makes them feel there might be something risky with bcache and hurt their
data.  Setting task state to TASK_RUNNING before returning fixes this
problem.

In alloc.c:allocator_wait(), there is also a similar issue, and is also
fixed in this patch.

Changelog:
v3: merge two similar fixes into one patch
v2: fix the race issue in v1 patch.
v1: initial buggy fix.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Junhui Tang <tang.junhui@zte.com.cn>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/alloc.c     |    4 +++-
 drivers/md/bcache/writeback.c |    7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -285,8 +285,10 @@ do {									\
 			break;						\
 									\
 		mutex_unlock(&(ca)->set->bucket_lock);			\
-		if (kthread_should_stop())				\
+		if (kthread_should_stop()) {				\
+			set_current_state(TASK_RUNNING);		\
 			return 0;					\
+		}							\
 									\
 		try_to_freeze();					\
 		schedule();						\
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -425,19 +425,22 @@ static int bch_writeback_thread(void *ar
 
 	while (!kthread_should_stop()) {
 		down_write(&dc->writeback_lock);
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (!atomic_read(&dc->has_dirty) ||
 		    (!test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags) &&
 		     !dc->writeback_running)) {
 			up_write(&dc->writeback_lock);
-			set_current_state(TASK_INTERRUPTIBLE);
 
-			if (kthread_should_stop())
+			if (kthread_should_stop()) {
+				set_current_state(TASK_RUNNING);
 				return 0;
+			}
 
 			try_to_freeze();
 			schedule();
 			continue;
 		}
+		set_current_state(TASK_RUNNING);
 
 		searched_full_index = refill_dirty(dc);
 
