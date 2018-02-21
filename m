Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeBUKid (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:38:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeBUKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:38:29 -0500
Date: Wed, 21 Feb 2018 02:36:52 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-1bda3f8087fce9063da0b8aef87f17a3fe541aca@git.kernel.org>
Cc: tglx@linutronix.de, efault@gmx.de, mingo@kernel.org,
        torvalds@linux-foundation.org, kernellwp@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, riel@redhat.com,
        frederic@kernel.org, lcapitulino@redhat.com, peterz@infradead.org,
        cmetcalf@mellanox.com, cl@linux.com, paulmck@linux.vnet.ibm.com
Reply-To: cl@linux.com, paulmck@linux.vnet.ibm.com, cmetcalf@mellanox.com,
        frederic@kernel.org, lcapitulino@redhat.com, riel@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, efault@gmx.de,
        torvalds@linux-foundation.org, kernellwp@gmail.com
In-Reply-To: <1519186649-3242-5-git-send-email-frederic@kernel.org>
References: <1519186649-3242-5-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/isolation: Isolate workqueues when
 "nohz_full=" is set
Git-Commit-ID: 1bda3f8087fce9063da0b8aef87f17a3fe541aca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1bda3f8087fce9063da0b8aef87f17a3fe541aca
Gitweb:     https://git.kernel.org/tip/1bda3f8087fce9063da0b8aef87f17a3fe541aca
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:26 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:08 +0100

sched/isolation: Isolate workqueues when "nohz_full=" is set

As we prepare for offloading the residual 1hz scheduler ticks to
workqueue, let's affine those to housekeepers so that they don't
interrupt the CPUs that don't want to be disturbed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Link: http://lkml.kernel.org/r/1519186649-3242-5-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 3 ++-
 kernel/workqueue.c              | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d849431..4a6582c 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -12,6 +12,7 @@ enum hk_flags {
 	HK_FLAG_SCHED		= (1 << 3),
 	HK_FLAG_TICK		= (1 << 4),
 	HK_FLAG_DOMAIN		= (1 << 5),
+	HK_FLAG_WQ		= (1 << 6),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b71b436..a2500c4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -3,6 +3,7 @@
  *  any CPU: unbound workqueues, timers, kthreads and any offloadable work.
  *
  * Copyright (C) 2017 Red Hat, Inc., Frederic Weisbecker
+ * Copyright (C) 2017-2018 SUSE, Frederic Weisbecker
  *
  */
 
@@ -119,7 +120,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned int flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
+	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
 
 	return housekeeping_setup(str, flags);
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 017044c..593dbe7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5565,12 +5565,13 @@ static void __init wq_numa_init(void)
 int __init workqueue_init_early(void)
 {
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
+	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	int i, cpu;
 
 	WARN_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
-	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_DOMAIN));
+	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
