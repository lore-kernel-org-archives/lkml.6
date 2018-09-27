Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6AD21708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxauGOFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6AD21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeI0WTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeI0WTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:19:46 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7267F216FC;
        Thu, 27 Sep 2018 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538064050;
        bh=q/0n2xal8iUVSwhQM3d62SvEWpLTF0T5pSpWHeuxPmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxauGOFEeJhmHQlzcAQVP+uqjTPwq4n3huwmekx+H0YbkeFJcNzHOUPtDZy4rZmqe
         B+IEyTGbCnlqs1qiiB+H3P7wtx846NG2oHnI6AXTZ69JO5iR2phWFm3wLGWmuh4zSb
         uZY2JiIwTFParrQ3QdIkojjv0EHjKTllTBHj3cLY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/5] tracing/uprobes: Use dyn_event framework for uprobe events
Date:   Fri, 28 Sep 2018 01:00:27 +0900
Message-Id: <153806402739.18458.11554023544358723155.stgit@devbox>
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

Use dyn_event framework for uprobe events. This shows
uprobe events on "dynamic_events" file.
User can also define new uprobe events via dynamic_events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/uprobetracer.rst |    4 +
 kernel/trace/trace_uprobe.c          |  158 +++++++++++++++++++++++-----------
 2 files changed, 113 insertions(+), 49 deletions(-)

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
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a49583ece5fd..90d10ef02f6b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/rculist.h>
 
+#include "trace_dynevent.h"
 #include "trace_probe.h"
 
 #define UPROBE_EVENT_SYSTEM	"uprobes"
@@ -36,11 +37,23 @@ struct trace_uprobe_filter {
 	struct list_head	perf_events;
 };
 
+static int trace_uprobe_create(int argc, char **argv);
+static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_uprobe_release(struct dyn_event *ev);
+static bool trace_uprobe_is_busy(struct dyn_event *ev);
+
+static struct dyn_event_operations trace_uprobe_ops = {
+	.create = trace_uprobe_create,
+	.show = trace_uprobe_show,
+	.is_busy = trace_uprobe_is_busy,
+	.free = trace_uprobe_release,
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
@@ -52,6 +65,35 @@ struct trace_uprobe {
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
+/**
+ * for_each_trace_uprobe_safe - iterate over the trace_uprobe list safely
+ * @pos:	the struct trace_uprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ * @n:		another struct dyn_event * to use as  temporary storage
+ */
+#define for_each_trace_uprobe_safe(pos, dpos, n)	\
+	for_each_dyn_event_safe(dpos, n)		\
+		if (is_trace_uprobe(dpos) && (pos = to_trace_uprobe(dpos)))
+
 #define SIZEOF_TRACE_UPROBE(n)				\
 	(offsetof(struct trace_uprobe, tp.args) +	\
 	(sizeof(struct probe_arg) * (n)))
@@ -59,9 +101,6 @@ struct trace_uprobe {
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static DEFINE_MUTEX(uprobe_lock);
-static LIST_HEAD(uprobe_list);
-
 struct uprobe_dispatch_data {
 	struct trace_uprobe	*tu;
 	unsigned long		bp_addr;
@@ -230,6 +269,13 @@ static inline bool is_ret_probe(struct trace_uprobe *tu)
 	return tu->consumer.ret_handler != NULL;
 }
 
+static bool trace_uprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return trace_probe_is_enabled(&tu->tp);
+}
+
 /*
  * Allocate new trace_uprobe and initialize it (including uprobes).
  */
@@ -257,7 +303,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu->tp.class.system)
 		goto error;
 
-	INIT_LIST_HEAD(&tu->list);
+	dyn_event_init(&tu->devent, &trace_uprobe_ops);
 	INIT_LIST_HEAD(&tu->tp.files);
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
@@ -288,9 +334,10 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 
 static struct trace_uprobe *find_probe_event(const char *event, const char *group)
 {
+	struct dyn_event *pos;
 	struct trace_uprobe *tu;
 
-	list_for_each_entry(tu, &uprobe_list, list)
+	for_each_trace_uprobe(tu, pos)
 		if (strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
 		    strcmp(tu->tp.call.class->system, group) == 0)
 			return tu;
@@ -298,7 +345,7 @@ static struct trace_uprobe *find_probe_event(const char *event, const char *grou
 	return NULL;
 }
 
-/* Unregister a trace_uprobe and probe_event: call with locking uprobe_lock */
+/* Unregister a trace_uprobe and probe_event */
 static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
@@ -307,7 +354,7 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	if (ret)
 		return ret;
 
-	list_del(&tu->list);
+	dyn_event_remove(&tu->devent);
 	free_trace_uprobe(tu);
 	return 0;
 }
@@ -323,13 +370,14 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
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
@@ -347,7 +395,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	struct trace_uprobe *old_tu;
 	int ret;
 
-	mutex_lock(&uprobe_lock);
+	mutex_lock(&dyn_event_mutex);
 
 	/* register as an event */
 	old_tu = find_old_trace_uprobe(tu);
@@ -369,10 +417,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 		goto end;
 	}
 
-	list_add_tail(&tu->list, &uprobe_list);
+	dyn_event_add(&tu->devent);
 
 end:
-	mutex_unlock(&uprobe_lock);
+	mutex_unlock(&dyn_event_mutex);
 
 	return ret;
 }
@@ -383,7 +431,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  *
  *  - Remove uprobe: -:[GRP/]EVENT
  */
-static int create_trace_uprobe(int argc, char **argv)
+static int trace_uprobe_create(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
 	char *arg, *event, *group, *filename, *rctr, *rctr_end;
@@ -439,17 +487,17 @@ static int create_trace_uprobe(int argc, char **argv)
 			pr_info("Delete command needs an event name.\n");
 			return -EINVAL;
 		}
-		mutex_lock(&uprobe_lock);
+		mutex_lock(&dyn_event_mutex);
 		tu = find_probe_event(event, group);
 
 		if (!tu) {
-			mutex_unlock(&uprobe_lock);
+			mutex_unlock(&dyn_event_mutex);
 			pr_info("Event %s/%s doesn't exist.\n", group, event);
 			return -ENOENT;
 		}
 		/* delete an event */
 		ret = unregister_trace_uprobe(tu);
-		mutex_unlock(&uprobe_lock);
+		mutex_unlock(&dyn_event_mutex);
 		return ret;
 	}
 
@@ -603,49 +651,40 @@ static int create_trace_uprobe(int argc, char **argv)
 	return ret;
 }
 
+static int trace_uprobe_release(struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return unregister_trace_uprobe(tu);
+}
+
 static int cleanup_all_probes(void)
 {
+	struct dyn_event *pos, *n;
 	struct trace_uprobe *tu;
 	int ret = 0;
 
-	mutex_lock(&uprobe_lock);
+	mutex_lock(&dyn_event_mutex);
 	/* Ensure no probe is in use. */
-	list_for_each_entry(tu, &uprobe_list, list)
+	for_each_trace_uprobe(tu, pos)
 		if (trace_probe_is_enabled(&tu->tp)) {
 			ret = -EBUSY;
 			goto end;
 		}
-	while (!list_empty(&uprobe_list)) {
-		tu = list_entry(uprobe_list.next, struct trace_uprobe, list);
+	for_each_trace_uprobe_safe(tu, pos, n) {
 		ret = unregister_trace_uprobe(tu);
 		if (ret)
 			break;
 	}
 end:
-	mutex_unlock(&uprobe_lock);
+	mutex_unlock(&dyn_event_mutex);
 	return ret;
 }
 
 /* Probes listing interfaces */
-static void *probes_seq_start(struct seq_file *m, loff_t *pos)
+static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 {
-	mutex_lock(&uprobe_lock);
-	return seq_list_start(&uprobe_list, *pos);
-}
-
-static void *probes_seq_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	return seq_list_next(v, &uprobe_list, pos);
-}
-
-static void probes_seq_stop(struct seq_file *m, void *v)
-{
-	mutex_unlock(&uprobe_lock);
-}
-
-static int probes_seq_show(struct seq_file *m, void *v)
-{
-	struct trace_uprobe *tu = v;
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
@@ -663,11 +702,21 @@ static int probes_seq_show(struct seq_file *m, void *v)
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
@@ -686,7 +735,8 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return trace_parse_run_command(file, buffer, count, ppos, create_trace_uprobe);
+	return trace_parse_run_command(file, buffer, count, ppos,
+					trace_uprobe_create);
 }
 
 static const struct file_operations uprobe_events_ops = {
@@ -701,17 +751,22 @@ static const struct file_operations uprobe_events_ops = {
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
-	struct trace_uprobe *tu = v;
+	struct dyn_event *ev = v;
+	struct trace_uprobe *tu;
 
+	if (!is_trace_uprobe(ev))
+		return 0;
+
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
 
@@ -1428,7 +1483,7 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 	}
 
 	/*
-	 * local trace_kprobes are not added to probe_list, so they are never
+	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
 	 * duplicated name "DUMMY_EVENT" here.
 	 */
@@ -1475,6 +1530,11 @@ void destroy_local_trace_uprobe(struct trace_event_call *event_call)
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

