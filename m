Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeCMSmr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:42:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49801 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeCMSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:42:45 -0400
Date: Tue, 13 Mar 2018 19:42:41 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [RT PATCH 2/2] block: blk-mq: move blk_queue_usage_counter_release()
 into process context
Message-ID: <20180313184240.ndq2pw2fmvhkwidc@linutronix.de>
References: <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
 <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
 <20180312132729.GI4064@hirez.programming.kicks-ass.net>
 <20180312141107.roveviectc6a75s7@linutronix.de>
 <20180312142933.GF4043@hirez.programming.kicks-ass.net>
 <20180312195118.rye5lg2pb26kmavn@linutronix.de>
 <20180313184039.begptzircgb5ketk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313184039.begptzircgb5ketk@linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

| BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:914
| in_atomic(): 1, irqs_disabled(): 0, pid: 255, name: kworker/u257:6
| 5 locks held by kworker/u257:6/255:
|  #0:  ("events_unbound"){.+.+.+}, at: [<ffffffff8108edf1>] process_one_work+0x171/0x5e0
|  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108edf1>] process_one_work+0x171/0x5e0
|  #2:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffffa000faa3>] __scsi_add_device+0xa3/0x130 [scsi_mod]
|  #3:  (&set->tag_list_lock){+.+...}, at: [<ffffffff812f09fa>] blk_mq_init_queue+0x96a/0xa50
|  #4:  (rcu_read_lock_sched){......}, at: [<ffffffff8132887d>] percpu_ref_kill_and_confirm+0x1d/0x120
| Preemption disabled at:[<ffffffff812eff76>] blk_mq_freeze_queue_start+0x56/0x70
|
| CPU: 2 PID: 255 Comm: kworker/u257:6 Not tainted 3.18.7-rt0+ #1
| Workqueue: events_unbound async_run_entry_fn
|  0000000000000003 ffff8800bc29f998 ffffffff815b3a12 0000000000000000
|  0000000000000000 ffff8800bc29f9b8 ffffffff8109aa16 ffff8800bc29fa28
|  ffff8800bc5d1bc8 ffff8800bc29f9e8 ffffffff815b8dd4 ffff880000000000
| Call Trace:
|  [<ffffffff815b3a12>] dump_stack+0x4f/0x7c
|  [<ffffffff8109aa16>] __might_sleep+0x116/0x190
|  [<ffffffff815b8dd4>] rt_spin_lock+0x24/0x60
|  [<ffffffff810b6089>] __wake_up+0x29/0x60
|  [<ffffffff812ee06e>] blk_mq_usage_counter_release+0x1e/0x20
|  [<ffffffff81328966>] percpu_ref_kill_and_confirm+0x106/0x120
|  [<ffffffff812eff76>] blk_mq_freeze_queue_start+0x56/0x70
|  [<ffffffff812f0000>] blk_mq_update_tag_set_depth+0x40/0xd0
|  [<ffffffff812f0a1c>] blk_mq_init_queue+0x98c/0xa50
|  [<ffffffffa000dcf0>] scsi_mq_alloc_queue+0x20/0x60 [scsi_mod]
|  [<ffffffffa000ea35>] scsi_alloc_sdev+0x2f5/0x370 [scsi_mod]
|  [<ffffffffa000f494>] scsi_probe_and_add_lun+0x9e4/0xdd0 [scsi_mod]
|  [<ffffffffa000fb26>] __scsi_add_device+0x126/0x130 [scsi_mod]
|  [<ffffffffa013033f>] ata_scsi_scan_host+0xaf/0x200 [libata]
|  [<ffffffffa012b5b6>] async_port_probe+0x46/0x60 [libata]
|  [<ffffffff810978fb>] async_run_entry_fn+0x3b/0xf0
|  [<ffffffff8108ee81>] process_one_work+0x201/0x5e0

percpu_ref_kill_and_confirm() invokes blk_mq_usage_counter_release() in
a rcu-sched region. swait based wake queue can't be used due to
wake_up_all() usage and disabled interrupts in !RT configs (as reported
by Corey Minyard).
Uses work_queue() to invoke wake_up_all() in process context.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-core.c       | 13 ++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f9ac6f169c67..4db4051724ea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -814,12 +814,20 @@ void blk_queue_exit(struct request_queue *q)
 	percpu_ref_put(&q->q_usage_counter);
 }
 
+static void blk_queue_usage_counter_release_swork(struct swork_event *sev)
+{
+	struct request_queue *q =
+		container_of(sev, struct request_queue, mq_pcpu_wake);
+
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 {
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	wake_up_all(&q->mq_freeze_wq);
+	swork_queue(&q->mq_pcpu_wake);
 }
 
 static void blk_rq_timed_out_timer(unsigned long data)
@@ -896,6 +904,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
+	INIT_SWORK(&q->mq_pcpu_wake, blk_queue_usage_counter_release_swork);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
@@ -3623,6 +3632,8 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
+	BUG_ON(swork_get());
+
 	request_cachep = kmem_cache_create("blkdev_requests",
 			sizeof(struct request), 0, SLAB_PANIC, NULL);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b68752bfb645..49b53ad6d2d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/swork.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -599,6 +600,7 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
+	struct swork_event	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.16.2
