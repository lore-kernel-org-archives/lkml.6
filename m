Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeBUKhw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:37:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeBUKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:37:50 -0500
Date: Wed, 21 Feb 2018 02:36:21 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-22ab8bc02a5f6e8ffc418759894f7a6b0b632331@git.kernel.org>
Cc: efault@gmx.de, hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, lcapitulino@redhat.com,
        linux-kernel@vger.kernel.org, cmetcalf@mellanox.com,
        torvalds@linux-foundation.org, cl@linux.com, frederic@kernel.org,
        riel@redhat.com, kernellwp@gmail.com
Reply-To: kernellwp@gmail.com, riel@redhat.com, frederic@kernel.org,
        cmetcalf@mellanox.com, cl@linux.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        efault@gmx.de, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1519186649-3242-4-git-send-email-frederic@kernel.org>
References: <1519186649-3242-4-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] nohz: Allow to check if remote CPU tick is stopped
Git-Commit-ID: 22ab8bc02a5f6e8ffc418759894f7a6b0b632331
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

Commit-ID:  22ab8bc02a5f6e8ffc418759894f7a6b0b632331
Gitweb:     https://git.kernel.org/tip/22ab8bc02a5f6e8ffc418759894f7a6b0b632331
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:25 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:08 +0100

nohz: Allow to check if remote CPU tick is stopped

This check is racy but provides a good heuristic to determine whether
a CPU may need a remote tick or not.

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
Link: http://lkml.kernel.org/r/1519186649-3242-4-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/tick.h     | 2 ++
 kernel/time/tick-sched.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 86576d9..7f8c9a1 100644
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
