Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeC3V2Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:28:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752811AbeC3V2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:28:13 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 3/3] lib/Kconfig.debug: Restructure the lock debugging menu
Date: Fri, 30 Mar 2018 17:28:00 -0400
Message-Id: <1522445280-7767-4-git-send-email-longman@redhat.com>
In-Reply-To: <1522445280-7767-1-git-send-email-longman@redhat.com>
References: <1522445280-7767-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two config options in the lock debugging menu that are probably the most
frequently used, as far as I am concerned, is the PROVE_LOCKING and
LOCK_STAT. From a UI perspective, they should be front and center. So
these two options are now moved to the top of the lock debugging menu.

The DEBUG_WW_MUTEX_SLOWPATH option is also added to the PROVE_LOCKING
umbrella.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
---
 lib/Kconfig.debug | 135 +++++++++++++++++++++++++++---------------------------
 1 file changed, 68 insertions(+), 67 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0db85f5..dc9ffe2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1039,6 +1039,74 @@ config LOCK_DEBUGGING_SUPPORT
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	default y
 
+config PROVE_LOCKING
+	bool "Lock debugging: prove locking correctness"
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+	select LOCKDEP
+	select DEBUG_SPINLOCK
+	select DEBUG_MUTEXES
+	select DEBUG_RT_MUTEXES if RT_MUTEXES
+	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
+	select DEBUG_WW_MUTEX_SLOWPATH
+	select DEBUG_LOCK_ALLOC
+	select TRACE_IRQFLAGS
+	default n
+	help
+	 This feature enables the kernel to prove that all locking
+	 that occurs in the kernel runtime is mathematically
+	 correct: that under no circumstance could an arbitrary (and
+	 not yet triggered) combination of observed locking
+	 sequences (on an arbitrary number of CPUs, running an
+	 arbitrary number of tasks and interrupt contexts) cause a
+	 deadlock.
+
+	 In short, this feature enables the kernel to report locking
+	 related deadlocks before they actually occur.
+
+	 The proof does not depend on how hard and complex a
+	 deadlock scenario would be to trigger: how many
+	 participant CPUs, tasks and irq-contexts would be needed
+	 for it to trigger. The proof also does not depend on
+	 timing: if a race and a resulting deadlock is possible
+	 theoretically (no matter how unlikely the race scenario
+	 is), it will be proven so and will immediately be
+	 reported by the kernel (once the event is observed that
+	 makes the deadlock theoretically possible).
+
+	 If a deadlock is impossible (i.e. the locking rules, as
+	 observed by the kernel, are mathematically correct), the
+	 kernel reports nothing.
+
+	 NOTE: this feature can also be enabled for rwlocks, mutexes
+	 and rwsems - in which case all dependencies between these
+	 different locking variants are observed and mapped too, and
+	 the proof of observed correctness is also maintained for an
+	 arbitrary combination of these separate locking variants.
+
+	 For more details, see Documentation/locking/lockdep-design.txt.
+
+config LOCK_STAT
+	bool "Lock usage statistics"
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+	select LOCKDEP
+	select DEBUG_SPINLOCK
+	select DEBUG_MUTEXES
+	select DEBUG_RT_MUTEXES if RT_MUTEXES
+	select DEBUG_LOCK_ALLOC
+	default n
+	help
+	 This feature enables tracking lock contention points
+
+	 For more details, see Documentation/locking/lockstat.txt
+
+	 This also enables lock events required by "perf lock",
+	 subcommand of perf.
+	 If you want to use "perf lock", you also need to turn on
+	 CONFIG_EVENT_TRACING.
+
+	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
+	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
+
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	depends on DEBUG_KERNEL && RT_MUTEXES
@@ -1102,51 +1170,6 @@ config DEBUG_LOCK_ALLOC
 	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
 	 held during task exit.
 
-config PROVE_LOCKING
-	bool "Lock debugging: prove locking correctness"
-	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
-	select LOCKDEP
-	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
-	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
-	select DEBUG_LOCK_ALLOC
-	select TRACE_IRQFLAGS
-	default n
-	help
-	 This feature enables the kernel to prove that all locking
-	 that occurs in the kernel runtime is mathematically
-	 correct: that under no circumstance could an arbitrary (and
-	 not yet triggered) combination of observed locking
-	 sequences (on an arbitrary number of CPUs, running an
-	 arbitrary number of tasks and interrupt contexts) cause a
-	 deadlock.
-
-	 In short, this feature enables the kernel to report locking
-	 related deadlocks before they actually occur.
-
-	 The proof does not depend on how hard and complex a
-	 deadlock scenario would be to trigger: how many
-	 participant CPUs, tasks and irq-contexts would be needed
-	 for it to trigger. The proof also does not depend on
-	 timing: if a race and a resulting deadlock is possible
-	 theoretically (no matter how unlikely the race scenario
-	 is), it will be proven so and will immediately be
-	 reported by the kernel (once the event is observed that
-	 makes the deadlock theoretically possible).
-
-	 If a deadlock is impossible (i.e. the locking rules, as
-	 observed by the kernel, are mathematically correct), the
-	 kernel reports nothing.
-
-	 NOTE: this feature can also be enabled for rwlocks, mutexes
-	 and rwsems - in which case all dependencies between these
-	 different locking variants are observed and mapped too, and
-	 the proof of observed correctness is also maintained for an
-	 arbitrary combination of these separate locking variants.
-
-	 For more details, see Documentation/locking/lockdep-design.txt.
-
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
@@ -1158,28 +1181,6 @@ config LOCKDEP
 config LOCKDEP_SMALL
 	bool
 
-config LOCK_STAT
-	bool "Lock usage statistics"
-	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
-	select LOCKDEP
-	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
-	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_LOCK_ALLOC
-	default n
-	help
-	 This feature enables tracking lock contention points
-
-	 For more details, see Documentation/locking/lockstat.txt
-
-	 This also enables lock events required by "perf lock",
-	 subcommand of perf.
-	 If you want to use "perf lock", you also need to turn on
-	 CONFIG_EVENT_TRACING.
-
-	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
-	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
-
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
-- 
1.8.3.1
