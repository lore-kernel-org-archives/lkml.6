Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032468AbeBOAsd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:48:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032447AbeBOAs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:48:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5FA217A0
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
Subject: [PATCH 2/6] nohz: Allow to check if remote CPU tick is stopped
Date: Thu, 15 Feb 2018 01:48:10 +0100
Message-Id: <1518655694-8057-3-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518655694-8057-1-git-send-email-frederic@kernel.org>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check is racy but provides a good heuristic to determine whether
a CPU may need a remote tick or not.

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
index 7cc3592..944c829 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -114,6 +114,7 @@ enum tick_dep_bits {
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
 extern int tick_nohz_tick_stopped(void);
+extern int tick_nohz_tick_stopped_cpu(int cpu);
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
index 29a5733..b517485 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -486,6 +486,13 @@ int tick_nohz_tick_stopped(void)
 	return __this_cpu_read(tick_cpu_sched.tick_stopped);
 }
 
+int tick_nohz_tick_stopped_cpu(int cpu)
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
