Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032567AbeBOAtg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032264AbeBOAsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:48:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DEB217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 3/6] sched/isolation: Isolate workqueues when "nohz_full=" is set
Date: Thu, 15 Feb 2018 01:48:11 +0100
Message-Id: <1518655694-8057-4-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518655694-8057-1-git-send-email-frederic@kernel.org>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we prepare for offloading the residual 1hz scheduler ticks to
workqueue, let's affine those to housekeepers so that they don't
interrupt the CPUs that don't want to be disturbed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
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
 
-- 
2.7.4
