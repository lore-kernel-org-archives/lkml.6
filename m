Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeC0VjG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:39:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751220AbeC0Vio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:38:44 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/2] locking/debug: Add a master lock debugging switch
Date: Tue, 27 Mar 2018 17:38:10 -0400
Message-Id: <1522186690-10526-3-git-send-email-longman@redhat.com>
In-Reply-To: <1522186690-10526-1-git-send-email-longman@redhat.com>
References: <1522186690-10526-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new master LOCK_DEBUGGING Kconfig option to turn on all the lock
debugging options except the selftests and the torture tests.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/Kconfig.debug | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0958192..817d78d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1034,6 +1034,28 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config LOCK_DEBUGGING_SUPPORT
+	bool
+	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	default y
+
+config LOCK_DEBUGGING
+	bool "Turn on all lock debugging"
+	depends on DEBUG_KERNEL
+	select DEBUG_SPINLOCK
+	select DEBUG_MUTEXES
+	select DEBUG_RT_MUTEXES if RT_MUTEXES
+	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
+	select DEBUG_WW_MUTEX_SLOWPATH if LOCK_DEBUGGING_SUPPORT
+	select DEBUG_LOCK_ALLOC if LOCK_DEBUGGING_SUPPORT
+	select PROVE_LOCKING if LOCK_DEBUGGING_SUPPORT
+	select LOCK_STAT if LOCK_DEBUGGING_SUPPORT
+	select DEBUG_LOCKDEP if LOCK_DEBUGGING_SUPPORT
+	select DEBUG_ATOMIC_SLEEP
+	help
+	  This turns on all the lock debugging code in the kernel except
+	  the selftests and the torture tests.
+
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	depends on DEBUG_KERNEL && RT_MUTEXES
@@ -1060,7 +1082,7 @@ config DEBUG_MUTEXES
 
 config DEBUG_WW_MUTEX_SLOWPATH
 	bool "Wait/wound mutex debugging: Slowpath testing"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_LOCK_ALLOC
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
@@ -1084,7 +1106,7 @@ config DEBUG_RWSEMS
 
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
@@ -1099,7 +1121,7 @@ config DEBUG_LOCK_ALLOC
 
 config PROVE_LOCKING
 	bool "Lock debugging: prove locking correctness"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
@@ -1143,7 +1165,7 @@ config PROVE_LOCKING
 
 config LOCKDEP
 	bool
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
 	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !SCORE && !X86
 	select KALLSYMS
@@ -1154,7 +1176,7 @@ config LOCKDEP_SMALL
 
 config LOCK_STAT
 	bool "Lock usage statistics"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
-- 
1.8.3.1
