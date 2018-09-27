Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC78C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC1A216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy7OtjCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC1A216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeI0WTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeI0WTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:19:18 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2804021547;
        Thu, 27 Sep 2018 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538064022;
        bh=Vgf0RSPIGa0OsfJ3q/1/uEvopuVjltasqQSFSRxDL5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yy7OtjCUPRUru+lcnvV24+jQxpDgZl5Bk1jiarRNJ182Pw2gFA5Gg/y30fs7nzJnC
         bOCfmZjuKthdeT4Ek1mBnfwLcnnebqverP2tvJG+lWBntfe6mg+Yre2FFLGq1yNSya
         PeQWbiomDDyIAdHMnjG7iaqSXmsipRIarLU0GjSI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/5] tracing/kprobes: Use dyn_event framework for kprobe events
Date:   Fri, 28 Sep 2018 00:59:59 +0900
Message-Id: <153806399918.18458.8855598599792282888.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153806391326.18458.3927382953014694981.stgit@devbox>
References: <153806391326.18458.3927382953014694981.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dyn_event framework for kprobe events. This shows
kprobe events on "tracing/dynamic_events" file.

User can also define new events via tracing/dynamic_events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/kprobetrace.rst |    3 +
 kernel/trace/Kconfig                |    1 
 kernel/trace/trace_kprobe.c         |  179 +++++++++++++++++++++++------------
 3 files changed, 124 insertions(+), 59 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 8bfc75c90806..96cc071b7103 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -20,6 +20,9 @@ current_tracer. Instead of that, add probe points via
 /sys/kernel/debug/tracing/kprobe_events, and enable it via
 /sys/kernel/debug/tracing/events/kprobes/<EVENT>/enable.
 
+You can also use /sys/kernel/debug/tracing/dynamic_events instead of
+kprobe_events. That interface will provide unified access to other
+dynamic events too.
 
 Synopsis of kprobe_events
 -------------------------
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index bf2e8a5a91f1..c0f6b0105609 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -461,6 +461,7 @@ config KPROBE_EVENTS
 	bool "Enable kprobes-based dynamic events"
 	select TRACING
 	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
 	default y
 	help
 	  This allows the user to add tracing events (similar to tracepoints)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 508396edc56a..421b9d71fedf 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -12,23 +12,65 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
 
+static int trace_kprobe_create(int argc, char **argv);
+static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_kprobe_release(struct dyn_event *ev);
+static bool trace_kprobe_is_busy(struct dyn_event *ev);
+
+static struct dyn_event_operations trace_kprobe_ops = {
+	.create = trace_kprobe_create,
+	.show = trace_kprobe_show,
+	.is_busy = trace_kprobe_is_busy,
+	.free = trace_kprobe_release,
+};
+
 /**
  * Kprobe event core functions
  */
 struct trace_kprobe {
-	struct list_head	list;
+	struct dyn_event	devent;
 	struct kretprobe	rp;	/* Use rp.kp for kprobe use */
 	unsigned long __percpu *nhit;
 	const char		*symbol;	/* symbol name */
 	struct trace_probe	tp;
 };
 
+static bool is_trace_kprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_kprobe_ops;
+}
+
+static struct trace_kprobe *to_trace_kprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_kprobe, devent);
+}
+
+/**
+ * for_each_trace_kprobe - iterate over the trace_kprobe list
+ * @pos:	the struct trace_kprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ */
+#define for_each_trace_kprobe(pos, dpos)	\
+	for_each_dyn_event(dpos)		\
+		if (is_trace_kprobe(dpos) && (pos = to_trace_kprobe(dpos)))
+
+/**
+ * for_each_trace_kprobe_safe - iterate over the trace_kprobe list safely
+ * @pos:	the struct trace_kprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ * @n:		another struct dyn_event * to use as  temporary storage
+ */
+#define for_each_trace_kprobe_safe(pos, dpos, n)	\
+	for_each_dyn_event_safe(dpos, n)		\
+		if (is_trace_kprobe(dpos) && (pos = to_trace_kprobe(dpos)))
+
 #define SIZEOF_TRACE_KPROBE(n)				\
 	(offsetof(struct trace_kprobe, tp.args) +	\
 	(sizeof(struct probe_arg) * (n)))
@@ -66,6 +108,13 @@ static nokprobe_inline bool trace_kprobe_is_on_module(struct trace_kprobe *tk)
 	return !!strchr(trace_kprobe_symbol(tk), ':');
 }
 
+static bool trace_kprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
+
+	return trace_probe_is_enabled(&tk->tp);
+}
+
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 {
 	unsigned long nhit = 0;
@@ -113,9 +162,6 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
 static int register_kprobe_event(struct trace_kprobe *tk);
 static int unregister_kprobe_event(struct trace_kprobe *tk);
 
-static DEFINE_MUTEX(probe_lock);
-static LIST_HEAD(probe_list);
-
 static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs);
 static int kretprobe_dispatcher(struct kretprobe_instance *ri,
 				struct pt_regs *regs);
@@ -355,7 +401,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	if (!tk->tp.class.system)
 		goto error;
 
-	INIT_LIST_HEAD(&tk->list);
+	dyn_event_init(&tk->devent, &trace_kprobe_ops);
 	INIT_LIST_HEAD(&tk->tp.files);
 	return tk;
 error:
@@ -383,9 +429,10 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
 static struct trace_kprobe *find_trace_kprobe(const char *event,
 					      const char *group)
 {
+	struct dyn_event *pos;
 	struct trace_kprobe *tk;
 
-	list_for_each_entry(tk, &probe_list, list)
+	for_each_trace_kprobe(tk, pos)
 		if (strcmp(trace_event_name(&tk->tp.call), event) == 0 &&
 		    strcmp(tk->tp.call.class->system, group) == 0)
 			return tk;
@@ -484,7 +531,7 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	 * created with perf_event_open. We don't need to wait for these
 	 * trace_kprobes
 	 */
-	if (list_empty(&tk->list))
+	if (list_empty(&tk->devent.list))
 		wait = 0;
  out:
 	if (wait) {
@@ -585,7 +632,7 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 	}
 }
 
-/* Unregister a trace_probe and probe_event: call with locking probe_lock */
+/* Unregister a trace_probe and probe_event */
 static int unregister_trace_kprobe(struct trace_kprobe *tk)
 {
 	/* Enabled event can not be unregistered */
@@ -597,7 +644,7 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 		return -EBUSY;
 
 	__unregister_trace_kprobe(tk);
-	list_del(&tk->list);
+	dyn_event_remove(&tk->devent);
 
 	return 0;
 }
@@ -608,7 +655,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	struct trace_kprobe *old_tk;
 	int ret;
 
-	mutex_lock(&probe_lock);
+	mutex_lock(&dyn_event_mutex);
 
 	/* Delete old (same name) event if exist */
 	old_tk = find_trace_kprobe(trace_event_name(&tk->tp.call),
@@ -632,10 +679,10 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret < 0)
 		unregister_kprobe_event(tk);
 	else
-		list_add_tail(&tk->list, &probe_list);
+		dyn_event_add(&tk->devent);
 
 end:
-	mutex_unlock(&probe_lock);
+	mutex_unlock(&dyn_event_mutex);
 	return ret;
 }
 
@@ -644,6 +691,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
 {
 	struct module *mod = data;
+	struct dyn_event *pos;
 	struct trace_kprobe *tk;
 	int ret;
 
@@ -651,8 +699,8 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/* Update probes on coming module */
-	mutex_lock(&probe_lock);
-	list_for_each_entry(tk, &probe_list, list) {
+	mutex_lock(&dyn_event_mutex);
+	for_each_trace_kprobe(tk, pos) {
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
 			__unregister_trace_kprobe(tk);
@@ -663,7 +711,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 					mod->name, ret);
 		}
 	}
-	mutex_unlock(&probe_lock);
+	mutex_unlock(&dyn_event_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -681,7 +729,7 @@ static inline void sanitize_event_name(char *name)
 			*name = '_';
 }
 
-static int create_trace_kprobe(int argc, char **argv)
+static int trace_kprobe_create(int argc, char **argv)
 {
 	/*
 	 * Argument syntax:
@@ -774,10 +822,10 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Delete command needs an event name.\n");
 			return -EINVAL;
 		}
-		mutex_lock(&probe_lock);
+		mutex_lock(&dyn_event_mutex);
 		tk = find_trace_kprobe(event, group);
 		if (!tk) {
-			mutex_unlock(&probe_lock);
+			mutex_unlock(&dyn_event_mutex);
 			pr_info("Event %s/%s doesn't exist.\n", group, event);
 			return -ENOENT;
 		}
@@ -785,7 +833,7 @@ static int create_trace_kprobe(int argc, char **argv)
 		ret = unregister_trace_kprobe(tk);
 		if (ret == 0)
 			free_trace_kprobe(tk);
-		mutex_unlock(&probe_lock);
+		mutex_unlock(&dyn_event_mutex);
 		return ret;
 	}
 
@@ -894,53 +942,46 @@ static int create_trace_kprobe(int argc, char **argv)
 	return ret;
 }
 
+static int trace_kprobe_release(struct dyn_event *ev)
+{
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
+	int ret = unregister_trace_kprobe(tk);
+
+	if (!ret)
+		free_trace_kprobe(tk);
+	return ret;
+}
+
 static int release_all_trace_kprobes(void)
 {
+	struct dyn_event *pos, *n;
 	struct trace_kprobe *tk;
 	int ret = 0;
 
-	mutex_lock(&probe_lock);
+	mutex_lock(&dyn_event_mutex);
 	/* Ensure no probe is in use. */
-	list_for_each_entry(tk, &probe_list, list)
+	for_each_trace_kprobe(tk, pos) {
 		if (trace_probe_is_enabled(&tk->tp)) {
 			ret = -EBUSY;
 			goto end;
 		}
+	}
 	/* TODO: Use batch unregistration */
-	while (!list_empty(&probe_list)) {
-		tk = list_entry(probe_list.next, struct trace_kprobe, list);
-		ret = unregister_trace_kprobe(tk);
+	for_each_trace_kprobe_safe(tk, pos, n) {
+		ret = trace_kprobe_release(&tk->devent);
 		if (ret)
-			goto end;
-		free_trace_kprobe(tk);
+			break;
 	}
 
 end:
-	mutex_unlock(&probe_lock);
+	mutex_unlock(&dyn_event_mutex);
 
 	return ret;
 }
 
-/* Probes listing interfaces */
-static void *probes_seq_start(struct seq_file *m, loff_t *pos)
-{
-	mutex_lock(&probe_lock);
-	return seq_list_start(&probe_list, *pos);
-}
-
-static void *probes_seq_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	return seq_list_next(v, &probe_list, pos);
-}
-
-static void probes_seq_stop(struct seq_file *m, void *v)
+static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)
 {
-	mutex_unlock(&probe_lock);
-}
-
-static int probes_seq_show(struct seq_file *m, void *v)
-{
-	struct trace_kprobe *tk = v;
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
 	int i;
 
 	seq_putc(m, trace_kprobe_is_return(tk) ? 'r' : 'p');
@@ -962,10 +1003,20 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int probes_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_trace_kprobe(ev))
+		return 0;
+
+	return trace_kprobe_show(m, ev);
+}
+
 static const struct seq_operations probes_seq_op = {
-	.start  = probes_seq_start,
-	.next   = probes_seq_next,
-	.stop   = probes_seq_stop,
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
 	.show   = probes_seq_show
 };
 
@@ -986,7 +1037,7 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_trace_kprobe);
+				       trace_kprobe_create);
 }
 
 static const struct file_operations kprobe_events_ops = {
@@ -1001,8 +1052,13 @@ static const struct file_operations kprobe_events_ops = {
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
-	struct trace_kprobe *tk = v;
+	struct dyn_event *ev = v;
+	struct trace_kprobe *tk;
 
+	if (!is_trace_kprobe(ev))
+		return 0;
+
+	tk = to_trace_kprobe(ev);
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_event_name(&tk->tp.call),
 		   trace_kprobe_nhit(tk),
@@ -1012,9 +1068,9 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 }
 
 static const struct seq_operations profile_seq_op = {
-	.start  = probes_seq_start,
-	.next   = probes_seq_next,
-	.stop   = probes_seq_stop,
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
 	.show   = probes_profile_seq_show
 };
 
@@ -1499,7 +1555,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	char *event;
 
 	/*
-	 * local trace_kprobes are not added to probe_list, so they are never
+	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
 	 * duplicated name here.
 	 */
@@ -1557,6 +1613,11 @@ static __init int init_kprobe_trace(void)
 {
 	struct dentry *d_tracer;
 	struct dentry *entry;
+	int ret;
+
+	ret = dyn_event_register(&trace_kprobe_ops);
+	if (ret)
+		return ret;
 
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
@@ -1616,7 +1677,7 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target "
 				"$stack $stack0 +0($stack)",
-				create_trace_kprobe);
+				trace_kprobe_create);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function entry.\n");
 		warn++;
@@ -1637,7 +1698,7 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target "
-				"$retval", create_trace_kprobe);
+				"$retval", trace_kprobe_create);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function return.\n");
 		warn++;
@@ -1707,13 +1768,13 @@ static __init int kprobe_trace_self_tests_init(void)
 			disable_trace_kprobe(tk, file);
 	}
 
-	ret = trace_run_command("-:testprobe", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe", trace_kprobe_create);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
-	ret = trace_run_command("-:testprobe2", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe2", trace_kprobe_create);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;

