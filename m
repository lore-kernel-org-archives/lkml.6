Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A52C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C282147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C282147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeJFI6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbeJFI6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:58:47 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6D92147C;
        Sat,  6 Oct 2018 01:57:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1g8bqK-0006BE-Rw; Fri, 05 Oct 2018 21:57:20 -0400
Message-Id: <20181006015720.765274258@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 05 Oct 2018 21:51:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [POC][RFC][PATCH 2/2] tracepoints: Implement it with dynamic functions
References: <20181006015110.653946300@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0002-tracepoints-Implement-it-with-dynamic-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint-defs.h |  3 ++
 include/linux/tracepoint.h      | 65 ++++++++++++++++++++++-----------
 include/trace/define_trace.h    | 14 +++----
 kernel/tracepoint.c             | 29 +++++++++++++--
 4 files changed, 79 insertions(+), 32 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 22c5a46e9693..a9d267be98de 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -11,6 +11,8 @@
 #include <linux/atomic.h>
 #include <linux/static_key.h>
 
+struct dynfunc_struct;
+
 struct trace_print_flags {
 	unsigned long		mask;
 	const char		*name;
@@ -30,6 +32,7 @@ struct tracepoint_func {
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
+	struct dynfunc_struct *dynfunc;
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 041f7e56a289..800c1b025e1f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/jump_function.h>
 
 struct module;
 struct tracepoint;
@@ -94,7 +95,9 @@ extern int syscall_regfunc(void);
 extern void syscall_unregfunc(void);
 #endif /* CONFIG_HAVE_SYSCALL_TRACEPOINTS */
 
+#ifndef PARAMS
 #define PARAMS(args...) args
+#endif
 
 #define TRACE_DEFINE_ENUM(x)
 #define TRACE_DEFINE_SIZEOF(x)
@@ -138,12 +141,11 @@ extern void syscall_unregfunc(void);
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(name, proto, args, cond, rcuidle)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
-		void *it_func;						\
-		void *__data;						\
 		int __maybe_unused idx = 0;				\
+		void *__data;						\
 									\
 		if (!(cond))						\
 			return;						\
@@ -163,14 +165,11 @@ extern void syscall_unregfunc(void);
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
-		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
-									\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
 		if (it_func_ptr) {					\
-			do {						\
-				it_func = (it_func_ptr)->func;		\
-				__data = (it_func_ptr)->data;		\
-				((void(*)(proto))(it_func))(args);	\
-			} while ((++it_func_ptr)->func);		\
+			__data = (it_func_ptr)->data;			\
+			dynfunc_tp_func_##name(args);			\
 		}							\
 									\
 		if (rcuidle) {						\
@@ -186,7 +185,7 @@ extern void syscall_unregfunc(void);
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 1);			\
@@ -208,11 +207,13 @@ extern void syscall_unregfunc(void);
  * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	DECLARE_DYNAMIC_FUNCTION(tp_func_##name, PARAMS(data_proto),	\
+				 PARAMS(data_args));			\
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 0);			\
@@ -271,21 +272,43 @@ extern void syscall_unregfunc(void);
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(name, reg, unreg)				 \
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)			\
 	static const char __tpstrtab_##name[]				 \
 	__attribute__((section("__tracepoints_strings"))) = #name;	 \
 	struct tracepoint __tracepoint_##name				 \
 	__attribute__((section("__tracepoints"), used)) =		 \
-		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	__TRACEPOINT_ENTRY(name);
+		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE,		\
+		  &___dyn_func__tp_func_##name, reg, unreg, NULL };	\
+	__TRACEPOINT_ENTRY(name);					\
+	int __tracepoint_iter_##name(void *__data, proto)		\
+	{								\
+		struct tracepoint_func *it_func_ptr;			\
+		void *it_func;						\
+									\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
+		do {							\
+			it_func = (it_func_ptr)->func;			\
+			__data = (it_func_ptr)->data;			\
+			((void(*)(void *, proto))(it_func))(__data, args); \
+		} while ((++it_func_ptr)->func);			\
+		return 0;						\
+	}								\
+	DEFINE_DYNAMIC_FUNCTION(tp_func_##name, __tracepoint_iter_##name, \
+				PARAMS(void *__data, proto))
 
-#define DEFINE_TRACE(name)						\
-	DEFINE_TRACE_FN(name, NULL, NULL);
+#define DEFINE_TRACE(name, proto, args)		\
+	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
-	EXPORT_SYMBOL_GPL(__tracepoint_##name)
+	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
+	EXPORT_SYMBOL_GPL(___dyn_func__tp_func_##name);			\
+	EXPORT_SYMBOL_GPL(dynfunc_tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
-	EXPORT_SYMBOL(__tracepoint_##name)
+	EXPORT_SYMBOL(__tracepoint_##name);				\
+	EXPORT_SYMBOL(___dyn_func__tp_func_##name);			\
+	EXPORT_SYMBOL(dynfunc_tp_func_##name)
+
 
 #else /* !TRACEPOINTS_ENABLED */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
@@ -314,8 +337,8 @@ extern void syscall_unregfunc(void);
 		return false;						\
 	}
 
-#define DEFINE_TRACE_FN(name, reg, unreg)
-#define DEFINE_TRACE(name)
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
+#define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)
 
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index cb30c5532144..c19aea44efb2 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -25,7 +25,7 @@
 
 #undef TRACE_EVENT
 #define TRACE_EVENT(name, proto, args, tstruct, assign, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_CONDITION
 #define TRACE_EVENT_CONDITION(name, proto, args, cond, tstruct, assign, print) \
@@ -39,24 +39,24 @@
 #undef TRACE_EVENT_FN
 #define TRACE_EVENT_FN(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_FN
 #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg) \
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_CONDITION
 #define DEFINE_EVENT_CONDITION(template, name, proto, args, cond) \
@@ -64,7 +64,7 @@
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index bf2c06ef9afc..b141f25d4b3a 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -140,7 +140,7 @@ static void debug_print_probes(struct tracepoint_func *funcs)
 
 static struct tracepoint_func *
 func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
-	 int prio)
+	 int prio, int *tot_probes)
 {
 	struct tracepoint_func *old, *new;
 	int nr_probes = 0;
@@ -183,11 +183,12 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	new[nr_probes + 1].func = NULL;
 	*funcs = new;
 	debug_print_probes(*funcs);
+	*tot_probes = nr_probes + 1;
 	return old;
 }
 
 static void *func_remove(struct tracepoint_func **funcs,
-		struct tracepoint_func *tp_func)
+		struct tracepoint_func *tp_func, int *left)
 {
 	int nr_probes = 0, nr_del = 0, i;
 	struct tracepoint_func *old, *new;
@@ -241,6 +242,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			       struct tracepoint_func *func, int prio)
 {
 	struct tracepoint_func *old, *tp_funcs;
+	int probes = 0;
 	int ret;
 
 	if (tp->regfunc && !static_key_enabled(&tp->key)) {
@@ -251,7 +253,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 
 	tp_funcs = rcu_dereference_protected(tp->funcs,
 			lockdep_is_held(&tracepoints_mutex));
-	old = func_add(&tp_funcs, func, prio);
+	old = func_add(&tp_funcs, func, prio, &probes);
 	if (IS_ERR(old)) {
 		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
@@ -266,6 +268,15 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	if (!static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
+
+	if (probes == 1) {
+//		printk("make direct call to %pS\n", tp_funcs->func);
+		assign_dynamic_function(tp->dynfunc, tp_funcs->func);
+	} else {
+//		printk("[%d] make call to iterator %pS\n", probes, tp->dynfunc->func);
+		assign_dynamic_function(tp->dynfunc, tp->dynfunc->func);
+	}
+
 	release_probes(old);
 	return 0;
 }
@@ -280,10 +291,11 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		struct tracepoint_func *func)
 {
 	struct tracepoint_func *old, *tp_funcs;
+	int probes_left = 0;
 
 	tp_funcs = rcu_dereference_protected(tp->funcs,
 			lockdep_is_held(&tracepoints_mutex));
-	old = func_remove(&tp_funcs, func);
+	old = func_remove(&tp_funcs, func, &probes_left);
 	if (IS_ERR(old)) {
 		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
@@ -297,6 +309,15 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		if (static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
+
+	if (probes_left == 1) {
+//		printk("make direct call to %pS\n", tp_funcs->func);
+		assign_dynamic_function(tp->dynfunc, tp_funcs->func);
+	} else {
+//		printk("[%d] make call to iterator %pS\n", probes_left, tp->dynfunc->func);
+		assign_dynamic_function(tp->dynfunc, tp->dynfunc->func);
+	}
+
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	release_probes(old);
 	return 0;
-- 
2.19.0


