Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBUERy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 23:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeBUERw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 23:17:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9CB21796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Wanpeng Li <kernellwp@gmail.com>,
        Mike Galbraith <efault@gmx.de>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 3/7] nohz: Allow to check if remote CPU tick is stopped
Date: Wed, 21 Feb 2018 05:17:25 +0100
Message-Id: <1519186649-3242-4-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519186649-3242-1-git-send-email-frederic@kernel.org>
References: <1519186649-3242-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check is racy but provides a good heuristic to determine whether
a CPU may need a remote tick or not.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
 include/linux/tick.h     | 2 ++
 kernel/time/tick-sched.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 86576d9..7f8c9a12 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -114,6 +114,7 @@ enum tick_dep_bits {
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
 extern bool tick_nohz_tick_stopped(void);
+extern bool tick_nohz_tick_stopped_cpu(int cpu);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
@@ -125,6 +126,7 @@ extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
+static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 0aba041..d479b21 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -486,6 +486,13 @@ bool tick_nohz_tick_stopped(void)
 	return __this_cpu_read(tick_cpu_sched.tick_stopped);
 }
 
+bool tick_nohz_tick_stopped_cpu(int cpu)
+{
+	struct tick_sched *ts = per_cpu_ptr(&tick_cpu_sched, cpu);
+
+	return ts->tick_stopped;
+}
+
 /**
  * tick_nohz_update_jiffies - update jiffies when idle was interrupted
  *
-- 
2.7.4
