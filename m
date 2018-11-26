Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B775C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF31220817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF31220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeK0Azd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeK0Azd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:55:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 823F98AE40;
        Mon, 26 Nov 2018 14:01:16 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D978D100190B;
        Mon, 26 Nov 2018 14:01:11 +0000 (UTC)
Date:   Mon, 26 Nov 2018 08:01:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/4] Static calls
Message-ID: <20181126140105.f4jdk6lmgabqaikq@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1543200841.git.jpoimboe@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Nov 2018 14:01:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:54:56AM -0600, Josh Poimboeuf wrote:
> v2:
> - fix STATIC_CALL_TRAMP() macro by using __PASTE() [Ard]
> - rename optimized/unoptimized -> inline/out-of-line [Ard]
> - tweak arch interfaces for PLT and add key->tramp field [Ard]
> - rename 'poison' to 'defuse' and do it after all sites have been patched [Ard]
> - fix .init handling [Ard, Steven]
> - add CONFIG_HAVE_STATIC_CALL [Steven]
> - make interfaces more consistent across configs to allow tracepoints to
>   use them [Steven]
> - move __ADDRESSABLE() to static_call() macro [Steven]
> - prevent 2-byte jumps [Steven]
> - add offset to asm-offsets.c instead of hard coding key->func offset
> - add kernel_text_address() sanity check
> - make __ADDRESSABLE() symbols truly unique
> 
> TODO:
> - port Ard's arm64 patches to the new arch interfaces
> - tracepoint performance testing

Below is the patch Steve gave me for converting tracepoints to use
static calls.

Steve, if you want me to do the performance testing, send me the test
details and I can give it a try this week.



diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 49ba9cde7e4b..ae16672bea61 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -11,6 +11,8 @@
 #include <linux/atomic.h>
 #include <linux/static_key.h>
 
+struct static_call_key;
+
 struct trace_print_flags {
 	unsigned long		mask;
 	const char		*name;
@@ -30,6 +32,8 @@ struct tracepoint_func {
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
+	struct static_call_key *static_call_key;
+	void *iterator;
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 538ba1a58f5b..bddaf6043027 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/static_call.h>
 
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
@@ -161,12 +164,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -186,14 +188,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
+			static_call(__tp_func_##name, args);		\
 		}							\
 									\
 		if (rcuidle) {						\
@@ -209,7 +208,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 1);			\
@@ -231,11 +230,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	extern int __tracepoint_iter_##name(data_proto);		\
+	DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 0);			\
@@ -281,21 +282,43 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(name, reg, unreg)				 \
-	static const char __tpstrtab_##name[]				 \
-	__attribute__((section("__tracepoints_strings"))) = #name;	 \
-	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"), used)) =		 \
-		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	__TRACEPOINT_ENTRY(name);
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)			\
+	static const char __tpstrtab_##name[]				\
+	__attribute__((section("__tracepoints_strings"))) = #name;	\
+	extern struct static_call_key __tp_func_##name;			\
+	int __tracepoint_iter_##name(void *__data, proto);		\
+	struct tracepoint __tracepoint_##name				\
+	__attribute__((section("__tracepoints"), used)) =		\
+		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE,		\
+		  &__tp_func_##name, __tracepoint_iter_##name,		\
+		  reg, unreg, NULL };					\
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
+	DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
 
-#define DEFINE_TRACE(name)						\
-	DEFINE_TRACE_FN(name, NULL, NULL);
+#define DEFINE_TRACE(name, proto, args)		\
+	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
-	EXPORT_SYMBOL_GPL(__tracepoint_##name)
+	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
+	EXPORT_STATIC_CALL_GPL(__tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
-	EXPORT_SYMBOL(__tracepoint_##name)
+	EXPORT_SYMBOL(__tracepoint_##name);				\
+	EXPORT_STATIC_CALL(__tp_func_##name)
+
 
 #else /* !TRACEPOINTS_ENABLED */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
@@ -324,8 +347,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
index a3be42304485..55ccf794f4d3 100644
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
@@ -266,6 +268,12 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	if (!static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
+
+	if (probes == 1)
+		__static_call_update(tp->static_call_key, tp_funcs->func);
+	else
+		__static_call_update(tp->static_call_key, tp->iterator);
+
 	release_probes(old);
 	return 0;
 }
@@ -280,10 +288,11 @@ static int tracepoint_remove_func(struct tracepoint *tp,
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
@@ -297,6 +306,12 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		if (static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
+
+	if (probes_left == 1)
+		__static_call_update(tp->static_call_key, tp_funcs->func);
+	else
+		__static_call_update(tp->static_call_key, tp->iterator);
+
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	release_probes(old);
 	return 0;
