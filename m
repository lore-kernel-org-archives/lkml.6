Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C97ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9BC2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9BC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGSOU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:20:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48774 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbeGSOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:20:58 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6JDbfVr006537;
        Thu, 19 Jul 2018 22:37:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 19 Jul 2018 22:37:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6JDbbho006468
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 22:37:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH] sched/debug: Use terse backtrace for idly sleeping threads.
Date:   Thu, 19 Jul 2018 22:37:23 +0900
Message-Id: <1532007443-3538-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzbot is hitting crashes too frequently to capture vmcore for later
analysis, currently we need to rely on printk()-based analysis. And I'm
planning to add a kernel config option for additional printk() etc. for
testing under syzbot environment.

One of missing printk() is in khungtaskd. When khungtaskd fires, it is not
rare that someone who was not reported by khungtaskd is relevant to the
hung up. To help analyze such case, I'm planning to allow khungtaskd to
dump all threads like SysRq-t using abovementioned kernel config option.

This patch can be applied before proposing abovementioned changes.
Since there are many kernel threads whose backtrace is boring due to idly
waiting for an event inside the main loop, this patch introduces a kernel
config option (which allows SysRq-t to use one-liner backtrace for threads
idly waiting for an event) and simple helpers (which allow current thread
to declare that current thread is about to start/end idly waiting).

Before:
----------
sysrq: SysRq : Show State
  task                        PC stack   pid father
systemd         S12192     1      0 0x00000000
Call Trace:
 ? __schedule+0x24e/0x810
 schedule+0x2a/0x80
 schedule_hrtimeout_range_clock+0x13e/0x150
 ep_poll+0x2c8/0x3f0
 ? wake_up_q+0x60/0x60
 do_epoll_wait+0xb5/0xd0
 __x64_sys_epoll_wait+0x15/0x20
 do_syscall_64+0x55/0x250
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7efdb8555183
Code: Bad RIP value.
RSP: 002b:00007ffc0a69c4c0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffc0a69c4d0 RCX: 00007efdb8555183
RDX: 0000000000000028 RSI: 00007ffc0a69c4d0 RDI: 0000000000000004
RBP: 00007ffc0a69c7a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000293 R12: 0000000000000001
R13: ffffffffffffffff R14: 00000000000008bc R15: 000055970cacb3a0
kthreadd        S13976     2      0 0x80000000
Call Trace:
 ? __schedule+0x24e/0x810
 ? kthreadd+0x2a4/0x370
 ? kthreadd+0x268/0x370
 schedule+0x2a/0x80
 kthreadd+0x357/0x370
 ? kthread_create_on_cpu+0xa0/0xa0
 ret_from_fork+0x24/0x30
rcu_gp          I15064     3      2 0x80000000
Call Trace:
 ? __schedule+0x24e/0x810
 schedule+0x2a/0x80
 rescuer_thread+0x30c/0x360
 ? cancel_delayed_work+0xc0/0xc0
 kthread+0x115/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x24/0x30
rcu_par_gp      I15064     4      2 0x80000000
Call Trace:
 ? __schedule+0x24e/0x810
 schedule+0x2a/0x80
 rescuer_thread+0x30c/0x360
 ? cancel_delayed_work+0xc0/0xc0
 kthread+0x115/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x24/0x30
kworker/0:0     I14528     5      2 0x80000000
Workqueue:            (null) (rcu_gp)
Call Trace:
 ? __schedule+0x24e/0x810
 schedule+0x2a/0x80
 worker_thread+0xbe/0x3f0
 ? process_one_work+0x4c0/0x4c0
 kthread+0x115/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x24/0x30
----------

After:
----------
sysrq: SysRq : Show State
  task                        PC stack   pid father
systemd         S12192     1      0 0x00000000
Call Trace:
 ? __schedule+0x24e/0x810
 schedule+0x2a/0x80
 schedule_hrtimeout_range_clock+0x13e/0x150
 ep_poll+0x2c8/0x3f0
 ? wake_up_q+0x60/0x60
 do_epoll_wait+0xb5/0xd0
 __x64_sys_epoll_wait+0x15/0x20
 do_syscall_64+0x55/0x250
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f96c3fd6163
Code: Bad RIP value.
RSP: 002b:00007ffd1df96ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffd1df96cb0 RCX: 00007f96c3fd6163
RDX: 000000000000002a RSI: 00007ffd1df96cb0 RDI: 0000000000000004
RBP: 00007ffd1df96fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: ffffffffffffffff R14: 000000000000085c R15: 0000564757cd03a0
kthreadd        S13976     2      0 0x80000000
 Idle at kthreadd+0x360/0x3a0
rcu_gp          I15064     3      2 0x80000000
 Idle at rescuer_thread+0x307/0x380
rcu_par_gp      I15064     4      2 0x80000000
 Idle at rescuer_thread+0x307/0x380
kworker/0:0     I14544     5      2 0x80000000
Workqueue:            (null) (rcu_gp)
 Idle at worker_thread+0x85/0x3e0
kworker/0:0H    I14568     6      2 0x80000000
 Idle at worker_thread+0x85/0x3e0
kworker/u256:0  I13616     7      2 0x80000000
Workqueue:            (null) (scsi_tmf_1)
 Idle at worker_thread+0x85/0x3e0
mm_percpu_wq    I15064     8      2 0x80000000
 Idle at rescuer_thread+0x307/0x380
ksoftirqd/0     S14584     9      2 0x80000000
 Idle at smpboot_thread_fn+0x1bd/0x1f0
rcu_sched       I14296    10      2 0x80000000
 Idle at rcu_gp_kthread+0x49c/0x930
----------

Since there is no need to insert start_idle_sleeping()/end_idle_sleeping()
into all such callers at once, this patch modifies only functions which
helped reducing the output in my environment.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/base/devtmpfs.c   |  2 ++
 drivers/scsi/scsi_error.c |  2 ++
 include/linux/sched.h     | 17 +++++++++++++++++
 kernel/audit.c            |  2 ++
 kernel/hung_task.c        |  2 ++
 kernel/irq/manage.c       |  2 ++
 kernel/kthread.c          | 10 ++++++++--
 kernel/rcu/tree.c         |  4 ++++
 kernel/sched/core.c       |  8 +++++++-
 kernel/smpboot.c          |  2 ++
 kernel/workqueue.c        |  4 ++++
 lib/Kconfig.debug         | 11 +++++++++++
 mm/compaction.c           |  2 ++
 mm/khugepaged.c           |  7 ++++++-
 mm/ksm.c                  |  4 ++++
 mm/oom_kill.c             |  2 ++
 mm/vmscan.c               |  5 ++++-
 17 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index f776807..6b8c8bd 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -406,7 +406,9 @@ static int devtmpfsd(void *p)
 		}
 		__set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock(&req_lock);
+		start_idle_sleeping();
 		schedule();
+		end_idle_sleeping();
 	}
 	return 0;
 out:
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8932ae8..b709599 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2160,7 +2160,9 @@ int scsi_error_handler(void *data)
 				shost_printk(KERN_INFO, shost,
 					     "scsi_eh_%d: sleeping\n",
 					     shost->host_no));
+			start_idle_sleeping();
 			schedule();
+			end_idle_sleeping();
 			continue;
 		}
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 43731fe..737fd3c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1179,6 +1179,9 @@ struct task_struct {
 	/* Used by LSM modules for access restriction: */
 	void				*security;
 #endif
+#ifdef CONFIG_DEBUG_USE_TERSE_TRACE_FOR_IDLE_THREADS
+	unsigned long			idle_sleeping_at;
+#endif
 
 	/*
 	 * New fields for task_struct should be added above here, so that
@@ -1898,4 +1901,18 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+static inline void start_idle_sleeping(void)
+{
+#ifdef CONFIG_DEBUG_USE_TERSE_TRACE_FOR_IDLE_THREADS
+	current->idle_sleeping_at = _THIS_IP_;
+#endif
+}
+
+static inline void end_idle_sleeping(void)
+{
+#ifdef CONFIG_DEBUG_USE_TERSE_TRACE_FOR_IDLE_THREADS
+	current->idle_sleeping_at = 0;
+#endif
+}
+
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index e7478cb..f593ed3 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -889,8 +889,10 @@ static int kauditd_thread(void *dummy)
 		 *       regardless of if an auditd is connected, as we need to
 		 *       do the multicast send and rotate records from the
 		 *       main queue to the retry/hold queues */
+		start_idle_sleeping();
 		wait_event_freezable(kauditd_wait,
 				     (skb_queue_len(&audit_queue) ? 1 : 0));
+		end_idle_sleeping();
 	}
 
 	return 0;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 32b4794..3665e5d 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -253,7 +253,9 @@ static int watchdog(void *dummy)
 			hung_last_checked = jiffies;
 			continue;
 		}
+		start_idle_sleeping();
 		schedule_timeout_interruptible(t);
+		end_idle_sleeping();
 	}
 
 	return 0;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index daeabd7..3fa6535 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -799,7 +799,9 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 			__set_current_state(TASK_RUNNING);
 			return 0;
 		}
+		start_idle_sleeping();
 		schedule();
+		end_idle_sleeping();
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 750cb80..c4827f0 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -563,8 +563,11 @@ int kthreadd(void *unused)
 
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (list_empty(&kthread_create_list))
+		if (list_empty(&kthread_create_list)) {
+			start_idle_sleeping();
 			schedule();
+			end_idle_sleeping();
+		}
 		__set_current_state(TASK_RUNNING);
 
 		spin_lock(&kthread_create_lock);
@@ -652,8 +655,11 @@ int kthread_worker_fn(void *worker_ptr)
 	if (work) {
 		__set_current_state(TASK_RUNNING);
 		work->func(work);
-	} else if (!freezing(current))
+	} else if (!freezing(current)) {
+		start_idle_sleeping();
 		schedule();
+		end_idle_sleeping();
+	}
 
 	try_to_freeze();
 	cond_resched();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa7cade..773fc03 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2144,8 +2144,10 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gpnum),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
+			start_idle_sleeping();
 			swait_event_idle(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
 						     RCU_GP_FLAG_INIT);
+			end_idle_sleeping();
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init(rsp))
@@ -2176,8 +2178,10 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gpnum),
 					       TPS("fqswait"));
 			rsp->gp_state = RCU_GP_WAIT_FQS;
+			start_idle_sleeping();
 			ret = swait_event_idle_timeout(rsp->gp_wq,
 					rcu_gp_fqs_check_wake(rsp, &gf), j);
+			end_idle_sleeping();
 			rsp->gp_state = RCU_GP_DOING_FQS;
 			/* Locking provides needed memory barriers. */
 			/* If grace period done, leave loop. */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9..5f7e40f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5321,7 +5321,13 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
-	show_stack(p, NULL);
+#ifdef CONFIG_DEBUG_USE_TERSE_TRACE_FOR_IDLE_THREADS
+	free = p->idle_sleeping_at;
+	if (free)
+		printk(KERN_DEFAULT " Idle at %pS\n", (void *) free);
+	else
+#endif
+		show_stack(p, NULL);
 	put_task_stack(p);
 }
 EXPORT_SYMBOL_GPL(sched_show_task);
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 5043e74..13a5f36 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -157,7 +157,9 @@ static int smpboot_thread_fn(void *data)
 
 		if (!ht->thread_should_run(td->cpu)) {
 			preempt_enable_no_resched();
+			start_idle_sleeping();
 			schedule();
+			end_idle_sleeping();
 		} else {
 			__set_current_state(TASK_RUNNING);
 			preempt_enable();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78b1920..1270203 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2314,7 +2314,9 @@ static int worker_thread(void *__worker)
 	worker_enter_idle(worker);
 	__set_current_state(TASK_IDLE);
 	spin_unlock_irq(&pool->lock);
+	start_idle_sleeping();
 	schedule();
+	end_idle_sleeping();
 	goto woke_up;
 }
 
@@ -2450,7 +2452,9 @@ static int rescuer_thread(void *__rescuer)
 
 	/* rescuers should never participate in concurrency management */
 	WARN_ON_ONCE(!(rescuer->flags & WORKER_NOT_RUNNING));
+	start_idle_sleeping();
 	schedule();
+	end_idle_sleeping();
 	goto repeat;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d11..87f0fd5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -426,6 +426,17 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config DEBUG_USE_TERSE_TRACE_FOR_IDLE_THREADS
+	bool "Use terse backtrace for idly sleeping threads"
+	depends on PRINTK
+	default n
+	help
+	  When dumping backtrace of all threads (e.g. via SysRq-t), you will
+	  notice that there are many threads with boring backtrace which is
+	  idly waiting. This option reduces amount of messages by using
+	  one-liner format for idly waiting threads (by allowing threads to
+	  declare that they are idly waiting).
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
diff --git a/mm/compaction.c b/mm/compaction.c
index faca45e..1d40e84 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2069,8 +2069,10 @@ static int kcompactd(void *p)
 
 	while (!kthread_should_stop()) {
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
+		start_idle_sleeping();
 		wait_event_freezable(pgdat->kcompactd_wait,
 				kcompactd_work_requested(pgdat));
+		end_idle_sleeping();
 
 		kcompactd_do_work(pgdat);
 	}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d7b2a4b..ed28ab3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1839,14 +1839,19 @@ static void khugepaged_wait_work(void)
 			return;
 
 		khugepaged_sleep_expire = jiffies + scan_sleep_jiffies;
+		start_idle_sleeping();
 		wait_event_freezable_timeout(khugepaged_wait,
 					     khugepaged_should_wakeup(),
 					     scan_sleep_jiffies);
+		end_idle_sleeping();
 		return;
 	}
 
-	if (khugepaged_enabled())
+	if (khugepaged_enabled()) {
+		start_idle_sleeping();
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
+		end_idle_sleeping();
+	}
 }
 
 static int khugepaged(void *none)
diff --git a/mm/ksm.c b/mm/ksm.c
index a6d43cf..5a15172 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2404,11 +2404,15 @@ static int ksm_scan_thread(void *nothing)
 		try_to_freeze();
 
 		if (ksmd_should_run()) {
+			start_idle_sleeping();
 			schedule_timeout_interruptible(
 				msecs_to_jiffies(ksm_thread_sleep_millisecs));
+			end_idle_sleeping();
 		} else {
+			start_idle_sleeping();
 			wait_event_freezable(ksm_thread_wait,
 				ksmd_should_run() || kthread_should_stop());
+			end_idle_sleeping();
 		}
 	}
 	return 0;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e7..c3f106e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -622,7 +622,9 @@ static int oom_reaper(void *unused)
 	while (true) {
 		struct task_struct *tsk = NULL;
 
+		start_idle_sleeping();
 		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
+		end_idle_sleeping();
 		spin_lock(&oom_reaper_lock);
 		if (oom_reaper_list != NULL) {
 			tsk = oom_reaper_list;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..e9b7e20 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3528,8 +3528,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 */
 		set_pgdat_percpu_threshold(pgdat, calculate_normal_threshold);
 
-		if (!kthread_should_stop())
+		if (!kthread_should_stop()) {
+			start_idle_sleeping();
 			schedule();
+			end_idle_sleeping();
+		}
 
 		set_pgdat_percpu_threshold(pgdat, calculate_pressure_threshold);
 	} else {
-- 
1.8.3.1

