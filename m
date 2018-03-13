Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeCMVoB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:44:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41405 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbeCMVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:43:43 -0400
X-Google-Smtp-Source: AG47ELtbUdqG6laEcf650wgm6iLcRo89m5VKwI5+5qbWc2fYe9NbYKYrH4F0J34+rzVjMJz71ghaIQ==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v1 2/2] tracepoint: Prevent false-positive lockdep warnings
Date: Tue, 13 Mar 2018 14:43:27 -0700
Message-Id: <20180313214327.37475-3-joelaf@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313214327.37475-1-joelaf@google.com>
References: <20180313214327.37475-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the last patch, lockdep hooks for irqs on/off will use the
tracepoint infrastructure. This can however cause false lockdep
warnings triggered by RCU code that does lockdep asserts.

There are 2 cases:
1) trace_hardirqs_off calls the lockdep_hardirqs_off hook, however
this call happens only after rcu_irq_enter_irqsoff. Due to this,
the lockdep assert that happens in the RCU path will think that
IRQs are kept on and will print a warning.

[    0.001000] ------------[ cut here ]------------
[    0.001000] IRQs not disabled as expected
[    0.001000] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:1039
				rcu_irq_enter+0x56/0x5d
[    0.001000] Call Trace:
[    0.001000]  rcu_irq_enter_irqson+0x21/0x47
[    0.001000]  trace_hardirqs_off+0x53/0xcc
[    0.001000]  __down_trylock_console_sem+0x27/0x9d
[    0.001000]  console_trylock+0x10/0x50
[    0.001000]  vprintk_emit+0x2a8/0x400
[    0.001000]  printk+0x43/0x4b
[    0.001000]  lockdep_init+0x38/0xe3
[    0.001000]  start_kernel+0x326/0x446
[    0.001000]  secondary_startup_64+0xa5/0xb0

2) trace_hardirqs_on calls the lockdep_hardirqs_on hook, however
interrupts are enabled only after trace_hardirqs_on. In the meanwhile
lockdep falsely sets its state to hardirqs are enabled. For this reason,
rcu_irq_enter_irqson prints the following false warning claiming IRQs
are not disabled:

[    0.001000] ------------[ cut here ]------------
[    0.001000] IRQs not disabled as expected
[    0.001000] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:886
rcu_irq_exit+0x56/0x5d
[    0.001000] Call Trace:
[    0.001000]  rcu_irq_exit_irqson+0x21/0x47
[    0.001000]  trace_hardirqs_on+0xb9/0xd7
[    0.001000]  vprintk_emit+0x287/0x400
[    0.001000]  printk+0x43/0x4b
[    0.001000]  lockdep_init+0x38/0xe3
[    0.001000]  start_kernel+0x326/0x446
[    0.001000]  secondary_startup_64+0xa5/0xb0

To fix it, just disable lockdep checks before and enable it after
rcu_irq_exit_irqson.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 include/linux/tracepoint.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..81eac3562787 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -137,8 +137,17 @@ extern void syscall_unregfunc(void);
 									\
 		if (!(cond))						\
 			return;						\
-		if (rcucheck)						\
+									\
+		/*							\
+		 * lockdep hook for irqsoff may run only after		\
+		 * rcu_irq_enter_irqson so in the meanwhile don't do	\
+		 * lockdep checks to prevent false lockdep warnings	\
+		 */							\
+		if (rcucheck) {						\
+			lockdep_off();					\
 			rcu_irq_enter_irqson();				\
+			lockdep_on();					\
+		}							\
 		rcu_read_lock_sched_notrace();				\
 		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
 		if (it_func_ptr) {					\
@@ -149,8 +158,18 @@ extern void syscall_unregfunc(void);
 			} while ((++it_func_ptr)->func);		\
 		}							\
 		rcu_read_unlock_sched_notrace();			\
-		if (rcucheck)						\
+									\
+		/*							\
+		 * Turn off lockdep before calling rcu_irq_exit_irqson  \
+		 * since the lockdep irqson hook may have just run	\
+		 * but irqs are only after trace_hardirqs_off returns.  \
+		 * This can cause false lockdep warnings.		\
+		 */							\
+		if (rcucheck) {						\
+			lockdep_off();					\
 			rcu_irq_exit_irqson();				\
+			lockdep_on();					\
+		}							\
 	} while (0)
 
 #ifndef MODULE
-- 
2.16.2.660.g709887971b-goog
