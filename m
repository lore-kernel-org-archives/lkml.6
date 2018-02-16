Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965111AbeBPLav convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:30:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964874AbeBPLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:30:50 -0500
Date: Fri, 16 Feb 2018 12:30:46 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v4.14-rt][report] arm: just another rcu_note_context_switch
Message-ID: <20180216113045.4zzay3oluuc2altu@linutronix.de>
References: <6f2e005d-26c1-19ca-283a-5f5e441e2f80@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <6f2e005d-26c1-19ca-283a-5f5e441e2f80@ti.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-14 16:12:42 [-0600], Grygorii Strashko wrote:
> Hi All,
Hi,

> I can see below warning during boot on few TI boards am437x-idk, am335x-evm, am335x-ice
> All of them are non-SMP

I somehow missed the !SMP kernel… What about this:

Subject: [PATCH] RCU: skip the "schedule() in RCU section" warning on UP, too

In "RCU: we need to skip that warning but only on sleeping locks" we
skipped a warning on SMP systems in case we schedule out in a RCU
section while attempt to obtain a sleeping lock. This is also required
on UP systems.
In order to do so, I introduce a tiny version of migrate_disable() +
_enable() which only update the counters which we then can check against
on RT && !SMP.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/preempt.h  |  9 +++++++++
 include/linux/sched.h    |  6 ++++++
 kernel/rcu/tree_plugin.h |  2 +-
 kernel/sched/core.c      | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b0e6248c8a3c..0591df500e9d 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -231,6 +231,15 @@ extern void migrate_enable(void);
 
 int __migrate_disabled(struct task_struct *p);
 
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+static inline int __migrate_disabled(struct task_struct *p)
+{
+	return 0;
+}
+
 #else
 #define migrate_disable()		barrier()
 #define migrate_enable()		barrier()
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 33bedd733d00..9a8974fcb95c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -593,6 +593,12 @@ struct task_struct {
 # ifdef CONFIG_SCHED_DEBUG
 	int				migrate_disable_atomic;
 # endif
+
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+	int				migrate_disable;
+# ifdef CONFIG_SCHED_DEBUG
+	int				migrate_disable_atomic;
+# endif
 #endif
 
 #ifdef CONFIG_PREEMPT_RCU
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 36e44ecd576e..3315ebad932f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -304,7 +304,7 @@ static void rcu_preempt_note_context_switch(bool preempt)
 	int mg_counter = 0;
 
 	RCU_LOCKDEP_WARN(!irqs_disabled(), "rcu_preempt_note_context_switch() invoked with interrupts enabled!!!\n");
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_PREEMPT_RT_BASE)
 	mg_counter = t->migrate_disable;
 #endif
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !mg_counter);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ab422da7706..ea8bfeddcea0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7047,4 +7047,49 @@ void migrate_enable(void)
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
+
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+void migrate_disable(void)
+{
+	struct task_struct *p = current;
+
+	if (in_atomic() || irqs_disabled()) {
+#ifdef CONFIG_SCHED_DEBUG
+		p->migrate_disable_atomic++;
+#endif
+		return;
+	}
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(p->migrate_disable_atomic)) {
+		tracing_off();
+		WARN_ON_ONCE(1);
+	}
+#endif
+
+	p->migrate_disable++;
+}
+EXPORT_SYMBOL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+	if (in_atomic() || irqs_disabled()) {
+#ifdef CONFIG_SCHED_DEBUG
+		p->migrate_disable_atomic--;
+#endif
+		return;
+	}
+
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(p->migrate_disable_atomic)) {
+		tracing_off();
+		WARN_ON_ONCE(1);
+	}
+#endif
+
+	WARN_ON_ONCE(p->migrate_disable <= 0);
+	p->migrate_disable--;
+}
+EXPORT_SYMBOL(migrate_enable);
 #endif
-- 
2.16.1


Sebastian
