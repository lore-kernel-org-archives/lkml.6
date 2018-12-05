Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01827C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71FC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71FC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeLEXsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbeLEXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400BC20892;
        Wed,  5 Dec 2018 23:48:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu8-0000K0-9l; Wed, 05 Dec 2018 18:48:32 -0500
Message-Id: <20181205234832.204353045@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 25/30] tracing/uprobes: Use dyn_event framework for uprobe events
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Use dyn_event framework for uprobe events. This shows
uprobe events on "dynamic_events" file.
User can also define new uprobe events via dynamic_events.

Link: http://lkml.kernel.org/r/154140858481.17322.9091293846515154065.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/uprobetracer.rst |   4 +
 kernel/trace/Kconfig                 |   1 +
 kernel/trace/trace_uprobe.c          | 278 ++++++++++++++-------------
 3 files changed, 153 insertions(+), 130 deletions(-)

diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index d0822811527a..4c3bfde2ba47 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -18,6 +18,10 @@ current_tracer. Instead of that, add probe points via
 However unlike kprobe-event tracer, the uprobe event interface expects the
 user to calculate the offset of the probepoint in the object.
 
+You can also use /sys/kernel/debug/tracing/dynamic_events instead of
+uprobe_events. That interface will provide unified access to other
+dynamic events too.
+
 Synopsis of uprobe_tracer
 -------------------------
 ::
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c0f6b0105609..2cab3c5dfe2c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -501,6 +501,7 @@ config UPROBE_EVENTS
 	depends on PERF_EVENTS
 	select UPROBES
 	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
 	select TRACING
 	default y
 	help
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 6eaaa2150685..4a7b21c891f3 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/uprobes.h>
@@ -14,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/rculist.h>
 
+#include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
 
@@ -37,11 +39,26 @@ struct trace_uprobe_filter {
 	struct list_head	perf_events;
 };
 
+static int trace_uprobe_create(int argc, const char **argv);
+static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_uprobe_release(struct dyn_event *ev);
+static bool trace_uprobe_is_busy(struct dyn_event *ev);
+static bool trace_uprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev);
+
+static struct dyn_event_operations trace_uprobe_ops = {
+	.create = trace_uprobe_create,
+	.show = trace_uprobe_show,
+	.is_busy = trace_uprobe_is_busy,
+	.free = trace_uprobe_release,
+	.match = trace_uprobe_match,
+};
+
 /*
  * uprobe event core functions
  */
 struct trace_uprobe {
-	struct list_head		list;
+	struct dyn_event		devent;
 	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
 	struct path			path;
@@ -53,6 +70,25 @@ struct trace_uprobe {
 	struct trace_probe		tp;
 };
 
+static bool is_trace_uprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_uprobe_ops;
+}
+
+static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_uprobe, devent);
+}
+
+/**
+ * for_each_trace_uprobe - iterate over the trace_uprobe list
+ * @pos:	the struct trace_uprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ */
+#define for_each_trace_uprobe(pos, dpos)	\
+	for_each_dyn_event(dpos)		\
+		if (is_trace_uprobe(dpos) && (pos = to_trace_uprobe(dpos)))
+
 #define SIZEOF_TRACE_UPROBE(n)				\
 	(offsetof(struct trace_uprobe, tp.args) +	\
 	(sizeof(struct probe_arg) * (n)))
@@ -60,9 +96,6 @@ struct trace_uprobe {
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static DEFINE_MUTEX(uprobe_lock);
-static LIST_HEAD(uprobe_list);
-
 struct uprobe_dispatch_data {
 	struct trace_uprobe	*tu;
 	unsigned long		bp_addr;
@@ -209,6 +242,22 @@ static inline bool is_ret_probe(struct trace_uprobe *tu)
 	return tu->consumer.ret_handler != NULL;
 }
 
+static bool trace_uprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return trace_probe_is_enabled(&tu->tp);
+}
+
+static bool trace_uprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
+		(!system || strcmp(tu->tp.call.class->system, system) == 0);
+}
+
 /*
  * Allocate new trace_uprobe and initialize it (including uprobes).
  */
@@ -236,7 +285,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu->tp.class.system)
 		goto error;
 
-	INIT_LIST_HEAD(&tu->list);
+	dyn_event_init(&tu->devent, &trace_uprobe_ops);
 	INIT_LIST_HEAD(&tu->tp.files);
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
@@ -255,6 +304,9 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 {
 	int i;
 
+	if (!tu)
+		return;
+
 	for (i = 0; i < tu->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tu->tp.args[i]);
 
@@ -267,9 +319,10 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 
 static struct trace_uprobe *find_probe_event(const char *event, const char *group)
 {
+	struct dyn_event *pos;
 	struct trace_uprobe *tu;
 
-	list_for_each_entry(tu, &uprobe_list, list)
+	for_each_trace_uprobe(tu, pos)
 		if (strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
 		    strcmp(tu->tp.call.class->system, group) == 0)
 			return tu;
@@ -277,7 +330,7 @@ static struct trace_uprobe *find_probe_event(const char *event, const char *grou
 	return NULL;
 }
 
-/* Unregister a trace_uprobe and probe_event: call with locking uprobe_lock */
+/* Unregister a trace_uprobe and probe_event */
 static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
@@ -286,7 +339,7 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	if (ret)
 		return ret;
 
-	list_del(&tu->list);
+	dyn_event_remove(&tu->devent);
 	free_trace_uprobe(tu);
 	return 0;
 }
@@ -302,13 +355,14 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
  */
 static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
 {
+	struct dyn_event *pos;
 	struct trace_uprobe *tmp, *old = NULL;
 	struct inode *new_inode = d_real_inode(new->path.dentry);
 
 	old = find_probe_event(trace_event_name(&new->tp.call),
 				new->tp.call.class->system);
 
-	list_for_each_entry(tmp, &uprobe_list, list) {
+	for_each_trace_uprobe(tmp, pos) {
 		if ((old ? old != tmp : true) &&
 		    new_inode == d_real_inode(tmp->path.dentry) &&
 		    new->offset == tmp->offset &&
@@ -326,7 +380,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	struct trace_uprobe *old_tu;
 	int ret;
 
-	mutex_lock(&uprobe_lock);
+	mutex_lock(&event_mutex);
 
 	/* register as an event */
 	old_tu = find_old_trace_uprobe(tu);
@@ -348,10 +402,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 		goto end;
 	}
 
-	list_add_tail(&tu->list, &uprobe_list);
+	dyn_event_add(&tu->devent);
 
 end:
-	mutex_unlock(&uprobe_lock);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 }
@@ -362,91 +416,49 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  *
  *  - Remove uprobe: -:[GRP/]EVENT
  */
-static int create_trace_uprobe(int argc, char **argv)
+static int trace_uprobe_create(int argc, const char **argv)
 {
 	struct trace_uprobe *tu;
-	char *arg, *event, *group, *filename, *rctr, *rctr_end;
+	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
+	char *arg, *filename, *rctr, *rctr_end, *tmp;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
 	unsigned long offset, ref_ctr_offset;
-	bool is_delete, is_return;
+	bool is_return = false;
 	int i, ret;
 
 	ret = 0;
-	is_delete = false;
-	is_return = false;
-	event = NULL;
-	group = NULL;
 	ref_ctr_offset = 0;
 
 	/* argc must be >= 1 */
-	if (argv[0][0] == '-')
-		is_delete = true;
-	else if (argv[0][0] == 'r')
+	if (argv[0][0] == 'r')
 		is_return = true;
-	else if (argv[0][0] != 'p') {
-		pr_info("Probe definition must be started with 'p', 'r' or '-'.\n");
-		return -EINVAL;
-	}
+	else if (argv[0][0] != 'p' || argc < 2)
+		return -ECANCELED;
 
-	if (argv[0][1] == ':') {
+	if (argv[0][1] == ':')
 		event = &argv[0][2];
-		arg = strchr(event, '/');
 
-		if (arg) {
-			group = event;
-			event = arg + 1;
-			event[-1] = '\0';
+	if (!strchr(argv[1], '/'))
+		return -ECANCELED;
 
-			if (strlen(group) == 0) {
-				pr_info("Group name is not specified\n");
-				return -EINVAL;
-			}
-		}
-		if (strlen(event) == 0) {
-			pr_info("Event name is not specified\n");
-			return -EINVAL;
-		}
-	}
-	if (!group)
-		group = UPROBE_EVENT_SYSTEM;
-
-	if (is_delete) {
-		int ret;
-
-		if (!event) {
-			pr_info("Delete command needs an event name.\n");
-			return -EINVAL;
-		}
-		mutex_lock(&uprobe_lock);
-		tu = find_probe_event(event, group);
-
-		if (!tu) {
-			mutex_unlock(&uprobe_lock);
-			pr_info("Event %s/%s doesn't exist.\n", group, event);
-			return -ENOENT;
-		}
-		/* delete an event */
-		ret = unregister_trace_uprobe(tu);
-		mutex_unlock(&uprobe_lock);
-		return ret;
-	}
+	filename = kstrdup(argv[1], GFP_KERNEL);
+	if (!filename)
+		return -ENOMEM;
 
-	if (argc < 2) {
-		pr_info("Probe point is not specified.\n");
-		return -EINVAL;
-	}
 	/* Find the last occurrence, in case the path contains ':' too. */
-	arg = strrchr(argv[1], ':');
-	if (!arg)
-		return -EINVAL;
+	arg = strrchr(filename, ':');
+	if (!arg || !isdigit(arg[1])) {
+		kfree(filename);
+		return -ECANCELED;
+	}
 
 	*arg++ = '\0';
-	filename = argv[1];
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
-	if (ret)
+	if (ret) {
+		kfree(filename);
 		return ret;
-
+	}
 	if (!d_is_reg(path.dentry)) {
 		ret = -EINVAL;
 		goto fail_address_parse;
@@ -480,7 +492,11 @@ static int create_trace_uprobe(int argc, char **argv)
 	argv += 2;
 
 	/* setup a probe */
-	if (!event) {
+	if (event) {
+		ret = traceprobe_parse_event_name(&event, &group, buf);
+		if (ret)
+			goto fail_address_parse;
+	} else {
 		char *tail;
 		char *ptr;
 
@@ -508,18 +524,19 @@ static int create_trace_uprobe(int argc, char **argv)
 	tu->offset = offset;
 	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->path = path;
-	tu->filename = kstrdup(filename, GFP_KERNEL);
-
-	if (!tu->filename) {
-		pr_info("Failed to allocate filename.\n");
-		ret = -ENOMEM;
-		goto error;
-	}
+	tu->filename = filename;
 
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i],
+		tmp = kstrdup(argv[i], GFP_KERNEL);
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		ret = traceprobe_parse_probe_arg(&tu->tp, i, tmp,
 					is_return ? TPARG_FL_RETURN : 0);
+		kfree(tmp);
 		if (ret)
 			goto error;
 	}
@@ -535,55 +552,35 @@ static int create_trace_uprobe(int argc, char **argv)
 
 fail_address_parse:
 	path_put(&path);
+	kfree(filename);
 
 	pr_info("Failed to parse address or file.\n");
 
 	return ret;
 }
 
-static int cleanup_all_probes(void)
+static int create_or_delete_trace_uprobe(int argc, char **argv)
 {
-	struct trace_uprobe *tu;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&uprobe_lock);
-	/* Ensure no probe is in use. */
-	list_for_each_entry(tu, &uprobe_list, list)
-		if (trace_probe_is_enabled(&tu->tp)) {
-			ret = -EBUSY;
-			goto end;
-		}
-	while (!list_empty(&uprobe_list)) {
-		tu = list_entry(uprobe_list.next, struct trace_uprobe, list);
-		ret = unregister_trace_uprobe(tu);
-		if (ret)
-			break;
-	}
-end:
-	mutex_unlock(&uprobe_lock);
-	return ret;
-}
+	if (argv[0][0] == '-')
+		return dyn_event_release(argc, argv, &trace_uprobe_ops);
 
-/* Probes listing interfaces */
-static void *probes_seq_start(struct seq_file *m, loff_t *pos)
-{
-	mutex_lock(&uprobe_lock);
-	return seq_list_start(&uprobe_list, *pos);
+	ret = trace_uprobe_create(argc, (const char **)argv);
+	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-static void *probes_seq_next(struct seq_file *m, void *v, loff_t *pos)
+static int trace_uprobe_release(struct dyn_event *ev)
 {
-	return seq_list_next(v, &uprobe_list, pos);
-}
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
-static void probes_seq_stop(struct seq_file *m, void *v)
-{
-	mutex_unlock(&uprobe_lock);
+	return unregister_trace_uprobe(tu);
 }
 
-static int probes_seq_show(struct seq_file *m, void *v)
+/* Probes listing interfaces */
+static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 {
-	struct trace_uprobe *tu = v;
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
@@ -601,11 +598,21 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int probes_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_trace_uprobe(ev))
+		return 0;
+
+	return trace_uprobe_show(m, ev);
+}
+
 static const struct seq_operations probes_seq_op = {
-	.start	= probes_seq_start,
-	.next	= probes_seq_next,
-	.stop	= probes_seq_stop,
-	.show	= probes_seq_show
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
+	.show   = probes_seq_show
 };
 
 static int probes_open(struct inode *inode, struct file *file)
@@ -613,7 +620,7 @@ static int probes_open(struct inode *inode, struct file *file)
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = cleanup_all_probes();
+		ret = dyn_events_release_all(&trace_uprobe_ops);
 		if (ret)
 			return ret;
 	}
@@ -624,7 +631,8 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return trace_parse_run_command(file, buffer, count, ppos, create_trace_uprobe);
+	return trace_parse_run_command(file, buffer, count, ppos,
+					create_or_delete_trace_uprobe);
 }
 
 static const struct file_operations uprobe_events_ops = {
@@ -639,17 +647,22 @@ static const struct file_operations uprobe_events_ops = {
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
-	struct trace_uprobe *tu = v;
+	struct dyn_event *ev = v;
+	struct trace_uprobe *tu;
+
+	if (!is_trace_uprobe(ev))
+		return 0;
 
+	tu = to_trace_uprobe(ev);
 	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
 			trace_event_name(&tu->tp.call), tu->nhit);
 	return 0;
 }
 
 static const struct seq_operations profile_seq_op = {
-	.start	= probes_seq_start,
-	.next	= probes_seq_next,
-	.stop	= probes_seq_stop,
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
 	.show	= probes_profile_seq_show
 };
 
@@ -1307,7 +1320,7 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 		return -ENODEV;
 	}
 
-	ret = trace_add_event_call(call);
+	ret = trace_add_event_call_nolock(call);
 
 	if (ret) {
 		pr_info("Failed to register uprobe event: %s\n",
@@ -1324,7 +1337,7 @@ static int unregister_uprobe_event(struct trace_uprobe *tu)
 	int ret;
 
 	/* tu->event is unregistered in trace_remove_event_call() */
-	ret = trace_remove_event_call(&tu->tp.call);
+	ret = trace_remove_event_call_nolock(&tu->tp.call);
 	if (ret)
 		return ret;
 	kfree(tu->tp.call.print_fmt);
@@ -1351,7 +1364,7 @@ create_local_trace_uprobe(char *name, unsigned long offs,
 	}
 
 	/*
-	 * local trace_kprobes are not added to probe_list, so they are never
+	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
 	 * duplicated name "DUMMY_EVENT" here.
 	 */
@@ -1399,6 +1412,11 @@ void destroy_local_trace_uprobe(struct trace_event_call *event_call)
 static __init int init_uprobe_trace(void)
 {
 	struct dentry *d_tracer;
+	int ret;
+
+	ret = dyn_event_register(&trace_uprobe_ops);
+	if (ret)
+		return ret;
 
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer))
-- 
2.19.1


