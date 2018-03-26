Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeCZTKs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:10:48 -0400
Received: from mail.efficios.com ([167.114.142.138]:41502 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeCZTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:10:47 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH] tracepoint: Provide tracepoint_kernel_find_by_name
Date: Mon, 26 Mar 2018 15:10:31 -0400
Message-Id: <20180326191031.14939-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an API allowing eBPF to lookup core kernel tracepoints by name.

Given that a lookup by name explicitly requires tracepoint definitions
to be unique for a given name (no duplicate keys), include a
WARN_ON_ONCE() check that only a single match is encountered at runtime.
This should always be the case, given that a DEFINE_TRACE emits a
__tracepoint_##name symbol, which would cause a link-time error if more
than one instance is found. Nevertheless, check this at runtime with
WARN_ON_ONCE() to stay on the safe side.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@kernel.org>
---
 include/linux/tracepoint.h |  1 +
 kernel/tracepoint.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..1b4ae64b7c6a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -43,6 +43,7 @@ tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv);
+extern struct tracepoint *tracepoint_kernel_find_by_name(const char *name);
 
 #ifdef CONFIG_MODULES
 struct tp_module {
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..0a59f988055a 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -60,6 +60,11 @@ struct tp_probes {
 	struct tracepoint_func probes[0];
 };
 
+struct tp_find_args {
+	const char *name;
+	struct tracepoint *tp;
+};
+
 static inline void *allocate_probes(int count)
 {
 	struct tp_probes *p  = kmalloc(count * sizeof(struct tracepoint_func)
@@ -528,6 +533,36 @@ void for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 }
 EXPORT_SYMBOL_GPL(for_each_kernel_tracepoint);
 
+static void find_tp(struct tracepoint *tp, void *priv)
+{
+	struct tp_find_args *args = priv;
+
+	if (!strcmp(tp->name, args->name)) {
+		WARN_ON_ONCE(args->tp);
+		args->tp = tp;
+	}
+}
+
+/**
+ * tracepoint_kernel_find_by_name - lookup a core kernel tracepoint by name
+ * @name: tracepoint name
+ *
+ * Returns the tracepoint structure associated with the name received as
+ * parameter, or NULL if not found. Lookup is only performed throughout
+ * core kernel tracepoints.
+ */
+struct tracepoint *tracepoint_kernel_find_by_name(const char *name)
+{
+	struct tp_find_args args = {
+		.name = name,
+		.tp = NULL,
+	};
+
+	for_each_tracepoint_range(__start___tracepoints_ptrs,
+		__stop___tracepoints_ptrs, find_tp, &args);
+	return args.tp;
+}
+
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 
 /* NB: reg/unreg are called while guarded with the tracepoints_mutex */
-- 
2.11.0
