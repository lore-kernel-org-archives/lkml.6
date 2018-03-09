Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeCIGxD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:53:03 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50769 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCIGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:53:02 -0500
X-Google-Smtp-Source: AG47ELsdwlRn1h379fkGTvKEVDzYQxppJdgO9Mq9joRwhhbO1FzHjzqfiNbIgnVUM+w2Yo62EEmkkA==
X-ME-Sender: <xms:SC-iWuCs7Kn1wq2ngMjKxVAq0OY_4VInRdoq7hGrxLiMCz7wfU3Pew>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Subject: [RFC] rtmutex: Make rt_mutex_futex_unlock() safe at irq-off callsites
Date: Fri,  9 Mar 2018 14:56:28 +0800
Message-Id: <20180309065630.8283-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running rcutorture with TREE03 config, CONFIG_PROVE_LOCKING=y, and
kernel cmdline argument "rcutorture.gp_exp=1", lockdep reported a
HARDIRQ-safe->HARDIRQ-unsafe deadlock:

| [  467.250290] ================================
| [  467.250825] WARNING: inconsistent lock state
| [  467.251341] 4.16.0-rc4+ #1 Not tainted
| [  467.251835] --------------------------------
| [  467.252347] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
| [  467.253056] rcu_torture_rea/724 [HC0[0]:SC0[0]:HE1:SE1] takes:
| [  467.253794]  (&rq->lock){?.-.}, at: [<00000000a16d33c8>] __schedule+0xbe/0xaf0
| [  467.254651] {IN-HARDIRQ-W} state was registered at:
| [  467.255232]   _raw_spin_lock+0x2a/0x40
| [  467.255725]   scheduler_tick+0x47/0xf0
...
| [  467.268331] other info that might help us debug this:
| [  467.268959]  Possible unsafe locking scenario:
| [  467.268959]
| [  467.269589]        CPU0
| [  467.269830]        ----
| [  467.270071]   lock(&rq->lock);
| [  467.270373]   <Interrupt>
| [  467.270630]     lock(&rq->lock);
| [  467.270945]
| [  467.270945]  *** DEADLOCK ***
| [  467.270945]
| [  467.271574] 1 lock held by rcu_torture_rea/724:
| [  467.272013]  #0:  (rcu_read_lock){....}, at: [<00000000786ae051>] rcu_torture_read_lock+0x0/0x70
| [  467.272853]
| [  467.272853] stack backtrace:
| [  467.273276] CPU: 2 PID: 724 Comm: rcu_torture_rea Not tainted 4.16.0-rc4+ #1
| [  467.274008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
| [  467.274979] Call Trace:
| [  467.275229]  dump_stack+0x67/0x95
| [  467.275615]  print_usage_bug+0x1bd/0x1d7
| [  467.275996]  mark_lock+0x4aa/0x540
| [  467.276332]  ? print_shortest_lock_dependencies+0x190/0x190
| [  467.276867]  __lock_acquire+0x587/0x1300
| [  467.277251]  ? try_to_wake_up+0x4f/0x620
| [  467.277686]  ? wake_up_q+0x3a/0x70
| [  467.278018]  ? rt_mutex_postunlock+0xf/0x30
| [  467.278425]  ? rt_mutex_futex_unlock+0x4d/0x70
| [  467.278854]  ? lock_acquire+0x90/0x200
| [  467.279223]  lock_acquire+0x90/0x200
| [  467.279625]  ? __schedule+0xbe/0xaf0
| [  467.279977]  _raw_spin_lock+0x2a/0x40
| [  467.280336]  ? __schedule+0xbe/0xaf0
| [  467.280682]  __schedule+0xbe/0xaf0
| [  467.281014]  preempt_schedule_irq+0x2f/0x60
| [  467.281480]  retint_kernel+0x1b/0x2d
| [  467.281828] RIP: 0010:rcu_read_unlock_special+0x0/0x680
| [  467.282336] RSP: 0000:ffff9413802abe40 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff12
| [  467.283060] RAX: 0000000000000001 RBX: ffff8d8a9e3f95c0 RCX: 0000000000000001
| [  467.283806] RDX: 0000000000000002 RSI: ffffffff974cdff9 RDI: ffff8d8a9e3f95c0
| [  467.284491] RBP: ffff9413802abf00 R08: ffffffff962da130 R09: 0000000000000002
| [  467.285176] R10: ffff9413802abe58 R11: c7ba480e8ad8512d R12: 0000006cd41183ab
| [  467.285913] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000ab0f
| [  467.286602]  ? rcu_torture_read_unlock+0x60/0x60
| [  467.287049]  __rcu_read_unlock+0x64/0x70
| [  467.287491]  rcu_torture_read_unlock+0x17/0x60
| [  467.287919]  rcu_torture_reader+0x275/0x450
| [  467.288328]  ? rcutorture_booster_init+0x110/0x110
| [  467.288789]  ? rcu_torture_stall+0x230/0x230
| [  467.289213]  ? kthread+0x10e/0x130
| [  467.289604]  kthread+0x10e/0x130
| [  467.289922]  ? kthread_create_worker_on_cpu+0x70/0x70
| [  467.290414]  ? call_usermodehelper_exec_async+0x11a/0x150
| [  467.290932]  ret_from_fork+0x3a/0x50

This happens with the following even sequence:

	preempt_schedule_irq();
	  local_irq_enable();
	  __schedule():
	    local_irq_disable(); // irq off
	    ...
	    rcu_note_context_switch():
	      rcu_note_preempt_context_switch():
	        rcu_read_unlock_special():
	          local_irq_save(flags);
	          ...
		  raw_spin_unlock_irqrestore(...,flags); // irq remains off
	          rt_mutex_futex_unlock():
	            raw_spin_lock_irq();
	            ...
	            raw_spin_unlock_irq(); // accidentally set irq on

	    <return to __schedule()>
	    rq_lock():
	      raw_spin_lock(); // acquiring rq->lock with irq on

, which means rq->lock a HARDIRQ-unsafe lock, and that can cause
deadlocks in scheduler code.

This problem was introduced by commit 02a7c234e540 ("rcu: Suppress
lockdep false-positive ->boost_mtx complaints"). That brought the user
of rt_mutex_futex_unlock() with irq off.

To fix this, replace the *lock_irq() in rt_mutex_futex_unlock() with
*lock_irq{save,restore}() to make safe to call rt_mutex_futex_unlock()
with irq off.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Fixes: 02a7c234e540 ("rcu: Suppress lockdep false-positive ->boost_mtx complaints")
---
 kernel/locking/rtmutex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 65cc0cb984e6..04bb467dbde1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1617,10 +1617,11 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 {
 	DEFINE_WAKE_Q(wake_q);
 	bool postunlock;
+	unsigned long flags;
 
-	raw_spin_lock_irq(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	postunlock = __rt_mutex_futex_unlock(lock, &wake_q);
-	raw_spin_unlock_irq(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	if (postunlock)
 		rt_mutex_postunlock(&wake_q);
-- 
2.16.2
