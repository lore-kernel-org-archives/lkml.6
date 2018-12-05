Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D898C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE24020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE24020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeLEXux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbeLEXsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:31 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D385223C6;
        Wed,  5 Dec 2018 23:48:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu5-00009L-HN; Wed, 05 Dec 2018 18:48:29 -0500
Message-Id: <20181205234829.443473064@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 07/30] ftrace: Create new ftrace_internal.h header
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to move function graph infrastructure into its own file (fgraph.h)
it needs to access various functions and variables in ftrace.c that are
currently static. Create a new file called ftrace-internal.h that holds the
function prototypes and the extern declarations of the variables needed by
fgraph.c as well, and make them global in ftrace.c such that they can be
used outside that file.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c          | 76 +++++++---------------------------
 kernel/trace/ftrace_internal.h | 75 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 62 deletions(-)
 create mode 100644 kernel/trace/ftrace_internal.h

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 77734451cb05..52c89428b0db 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -40,6 +40,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 
+#include "ftrace_internal.h"
 #include "trace_output.h"
 #include "trace_stat.h"
 
@@ -77,7 +78,7 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-static struct ftrace_ops ftrace_list_end __read_mostly = {
+struct ftrace_ops ftrace_list_end __read_mostly = {
 	.func		= ftrace_stub,
 	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
 	INIT_OPS_HASH(ftrace_list_end)
@@ -112,11 +113,11 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops);
  */
 static int ftrace_disabled __read_mostly;
 
-static DEFINE_MUTEX(ftrace_lock);
+DEFINE_MUTEX(ftrace_lock);
 
-static struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
+struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
 ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
-static struct ftrace_ops global_ops;
+struct ftrace_ops global_ops;
 
 #if ARCH_SUPPORTS_FTRACE_OPS
 static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
@@ -127,26 +128,6 @@ static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
 #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
 #endif
 
-/*
- * Traverse the ftrace_global_list, invoking all entries.  The reason that we
- * can use rcu_dereference_raw_notrace() is that elements removed from this list
- * are simply leaked, so there is no need to interact with a grace-period
- * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
- * concurrent insertions into the ftrace_global_list.
- *
- * Silly Alpha and silly pointer-speculation compiler optimizations!
- */
-#define do_for_each_ftrace_op(op, list)			\
-	op = rcu_dereference_raw_notrace(list);			\
-	do
-
-/*
- * Optimized for just a single item in the list (as that is the normal case).
- */
-#define while_for_each_ftrace_op(op)				\
-	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
-	       unlikely((op) != &ftrace_list_end))
-
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -187,17 +168,11 @@ static void ftrace_sync_ipi(void *data)
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static void update_function_graph_func(void);
-
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 static bool fgraph_graph_time = true;
-
-#else
-static inline void update_function_graph_func(void) { }
 #endif
 
-
 static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
 {
 	/*
@@ -334,7 +309,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
 
 static void ftrace_update_trampoline(struct ftrace_ops *ops);
 
-static int __register_ftrace_function(struct ftrace_ops *ops)
+int __register_ftrace_function(struct ftrace_ops *ops)
 {
 	if (ops->flags & FTRACE_OPS_FL_DELETED)
 		return -EINVAL;
@@ -375,7 +350,7 @@ static int __register_ftrace_function(struct ftrace_ops *ops)
 	return 0;
 }
 
-static int __unregister_ftrace_function(struct ftrace_ops *ops)
+int __unregister_ftrace_function(struct ftrace_ops *ops)
 {
 	int ret;
 
@@ -1022,9 +997,7 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 #endif /* CONFIG_FUNCTION_PROFILER */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static int ftrace_graph_active;
-#else
-# define ftrace_graph_active 0
+int ftrace_graph_active;
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1067,7 +1040,7 @@ static const struct ftrace_hash empty_hash = {
 };
 #define EMPTY_HASH	((struct ftrace_hash *)&empty_hash)
 
-static struct ftrace_ops global_ops = {
+struct ftrace_ops global_ops = {
 	.func				= ftrace_stub,
 	.local_hash.notrace_hash	= EMPTY_HASH,
 	.local_hash.filter_hash		= EMPTY_HASH,
@@ -1503,7 +1476,7 @@ static bool hash_contains_ip(unsigned long ip,
  * This needs to be called with preemption disabled as
  * the hashes are freed with call_rcu_sched().
  */
-static int
+int
 ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 {
 	struct ftrace_ops_hash hash;
@@ -2682,7 +2655,7 @@ static void ftrace_startup_all(int command)
 	update_all_ops = false;
 }
 
-static int ftrace_startup(struct ftrace_ops *ops, int command)
+int ftrace_startup(struct ftrace_ops *ops, int command)
 {
 	int ret;
 
@@ -2724,7 +2697,7 @@ static int ftrace_startup(struct ftrace_ops *ops, int command)
 	return 0;
 }
 
-static int ftrace_shutdown(struct ftrace_ops *ops, int command)
+int ftrace_shutdown(struct ftrace_ops *ops, int command)
 {
 	int ret;
 
@@ -6177,7 +6150,7 @@ void ftrace_init_trace_array(struct trace_array *tr)
 }
 #else
 
-static struct ftrace_ops global_ops = {
+struct ftrace_ops global_ops = {
 	.func			= ftrace_stub,
 	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
 				  FTRACE_OPS_FL_INITIALIZED |
@@ -6194,31 +6167,10 @@ core_initcall(ftrace_nodyn_init);
 static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
 static inline void ftrace_startup_enable(int command) { }
 static inline void ftrace_startup_all(int command) { }
-/* Keep as macros so we do not need to define the commands */
-# define ftrace_startup(ops, command)					\
-	({								\
-		int ___ret = __register_ftrace_function(ops);		\
-		if (!___ret)						\
-			(ops)->flags |= FTRACE_OPS_FL_ENABLED;		\
-		___ret;							\
-	})
-# define ftrace_shutdown(ops, command)					\
-	({								\
-		int ___ret = __unregister_ftrace_function(ops);		\
-		if (!___ret)						\
-			(ops)->flags &= ~FTRACE_OPS_FL_ENABLED;		\
-		___ret;							\
-	})
 
 # define ftrace_startup_sysctl()	do { } while (0)
 # define ftrace_shutdown_sysctl()	do { } while (0)
 
-static inline int
-ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
-{
-	return 1;
-}
-
 static void ftrace_update_trampoline(struct ftrace_ops *ops)
 {
 }
@@ -6930,7 +6882,7 @@ static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
  * function against the global ops, and not just trace any function
  * that any ftrace_ops registered.
  */
-static void update_function_graph_func(void)
+void update_function_graph_func(void)
 {
 	struct ftrace_ops *op;
 	bool do_test = false;
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
new file mode 100644
index 000000000000..0515a2096f90
--- /dev/null
+++ b/kernel/trace/ftrace_internal.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_FTRACE_INTERNAL_H
+#define  _LINUX_KERNEL_FTRACE_INTERNAL_H
+
+#ifdef CONFIG_FUNCTION_TRACER
+
+/*
+ * Traverse the ftrace_global_list, invoking all entries.  The reason that we
+ * can use rcu_dereference_raw_notrace() is that elements removed from this list
+ * are simply leaked, so there is no need to interact with a grace-period
+ * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
+ * concurrent insertions into the ftrace_global_list.
+ *
+ * Silly Alpha and silly pointer-speculation compiler optimizations!
+ */
+#define do_for_each_ftrace_op(op, list)			\
+	op = rcu_dereference_raw_notrace(list);			\
+	do
+
+/*
+ * Optimized for just a single item in the list (as that is the normal case).
+ */
+#define while_for_each_ftrace_op(op)				\
+	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
+	       unlikely((op) != &ftrace_list_end))
+
+extern struct ftrace_ops __rcu *ftrace_ops_list;
+extern struct ftrace_ops ftrace_list_end;
+extern struct mutex ftrace_lock;
+extern struct ftrace_ops global_ops;
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+int ftrace_startup(struct ftrace_ops *ops, int command);
+int ftrace_shutdown(struct ftrace_ops *ops, int command);
+int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
+
+#else /* !CONFIG_DYNAMIC_FTRACE */
+
+int __register_ftrace_function(struct ftrace_ops *ops);
+int __unregister_ftrace_function(struct ftrace_ops *ops);
+/* Keep as macros so we do not need to define the commands */
+# define ftrace_startup(ops, command)					\
+	({								\
+		int ___ret = __register_ftrace_function(ops);		\
+		if (!___ret)						\
+			(ops)->flags |= FTRACE_OPS_FL_ENABLED;		\
+		___ret;							\
+	})
+# define ftrace_shutdown(ops, command)					\
+	({								\
+		int ___ret = __unregister_ftrace_function(ops);		\
+		if (!___ret)						\
+			(ops)->flags &= ~FTRACE_OPS_FL_ENABLED;		\
+		___ret;							\
+	})
+static inline int
+ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
+{
+	return 1;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern int ftrace_graph_active;
+void update_function_graph_func(void);
+#else /* !CONFIG_FUNCTION_GRAPH_TRACER */
+# define ftrace_graph_active 0
+static inline void update_function_graph_func(void) { }
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#else /* !CONFIG_FUNCTION_TRACER */
+#endif /* CONFIG_FUNCTION_TRACER */
+
+#endif
-- 
2.19.1


