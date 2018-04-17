Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDQEIP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:08:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37461 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeDQEIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:08:11 -0400
X-Google-Smtp-Source: AIpwx488lqyn8fskdszIswHS3uujJUYI/y2bEHQ3sV/p8NKhpvpTezcVX0l/AXmSsbCztm78PzkafQ==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>
Subject: [RFC v4 1/4] tracepoint: Add API to not do lockdep checks during RCU ops
Date: Mon, 16 Apr 2018 21:07:45 -0700
Message-Id: <20180417040748.212236-2-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180417040748.212236-1-joelaf@google.com>
References: <20180417040748.212236-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes lockdeps use the trace irqs on/off tracepoints. Lets
introduce an API where lockdep checks are not done so that we don't get
false lockdep splats. This API introduction will not affect any of the
existing users of the tracepoint API and the new call will only be used
by the IRQs on/off tracepoints.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Fenguang Wu <fengguang.wu@intel.com>
Cc: Baohong Liu <baohong.liu@intel.com>
Cc: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 include/linux/tracepoint.h | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..0b6d7d1a16e2 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -119,6 +119,14 @@ extern void syscall_unregfunc(void);
 
 #ifdef TRACEPOINTS_ENABLED
 
+#define LOCKDEP_CHECKS_ON(lockdep)			\
+	if (IS_ENABLED(CONFIG_LOCKDEP) && !lockdep)	\
+		lockdep_on();
+
+#define LOCKDEP_CHECKS_OFF(lockdep)			\
+	if (IS_ENABLED(CONFIG_LOCKDEP) && !lockdep)	\
+		lockdep_off();
+
 /*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
@@ -129,7 +137,7 @@ extern void syscall_unregfunc(void);
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
+#define __DO_TRACE(tp, proto, args, cond, rcucheck, lockdep)		\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
@@ -137,10 +145,14 @@ extern void syscall_unregfunc(void);
 									\
 		if (!(cond))						\
 			return;						\
+									\
+		LOCKDEP_CHECKS_OFF(lockdep)				\
 		if (rcucheck)						\
 			rcu_irq_enter_irqson();				\
 		rcu_read_lock_sched_notrace();				\
 		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
+		LOCKDEP_CHECKS_ON(lockdep)				\
+									\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -148,9 +160,12 @@ extern void syscall_unregfunc(void);
 				((void(*)(proto))(it_func))(args);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
+									\
+		LOCKDEP_CHECKS_OFF(lockdep)				\
 		rcu_read_unlock_sched_notrace();			\
 		if (rcucheck)						\
 			rcu_irq_exit_irqson();				\
+		LOCKDEP_CHECKS_ON(lockdep)				\
 	} while (0)
 
 #ifndef MODULE
@@ -161,7 +176,16 @@ extern void syscall_unregfunc(void);
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond), 1);			\
+				TP_CONDITION(cond), 1, 1);		\
+	}								\
+									\
+	static inline void trace_##name##_rcuidle_nolockdep(proto)	\
+	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(&__tracepoint_##name,		\
+				TP_PROTO(data_proto),			\
+				TP_ARGS(data_args),			\
+				TP_CONDITION(cond), 1, 0);		\
 	}
 #else
 #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args)
@@ -187,7 +211,7 @@ extern void syscall_unregfunc(void);
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond), 0, 1);		\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			rcu_read_lock_sched_notrace();			\
 			rcu_dereference_sched(__tracepoint_##name.funcs);\
@@ -254,6 +278,8 @@ extern void syscall_unregfunc(void);
 	{ }								\
 	static inline void trace_##name##_rcuidle(proto)		\
 	{ }								\
+	static inline void trace_##name##_rcuidle_nolockdep(proto)	\
+	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
-- 
2.17.0.484.g0c8726318c-goog
