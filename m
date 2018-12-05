Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6F4C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9064A20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9064A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeLEXtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbeLEXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6445E21508;
        Wed,  5 Dec 2018 23:48:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu8-0000KX-Ek; Wed, 05 Dec 2018 18:48:32 -0500
Message-Id: <20181205234832.350078956@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 26/30] tracing: Use dyn_event framework for synthetic events
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Use dyn_event framework for synthetic events. This shows
synthetic events on "tracing/dynamic_events" file in addition
to tracing/synthetic_events interface.

User can also define new events via tracing/dynamic_events
with "s:" prefix. So, the new syntax is below;

  s:[synthetic/]EVENT_NAME TYPE ARG; [TYPE ARG;]...

To remove events via tracing/dynamic_events, you can use
"-:" prefix as same as other events.

Link: http://lkml.kernel.org/r/154140861301.17322.15454611233735614508.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig             |   1 +
 kernel/trace/trace.c             |   8 +
 kernel/trace/trace_events_hist.c | 265 +++++++++++++++++++------------
 3 files changed, 176 insertions(+), 98 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2cab3c5dfe2c..fa8b1fe824f3 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -635,6 +635,7 @@ config HIST_TRIGGERS
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select TRACING_MAP
 	select TRACING
+	select DYNAMIC_EVENTS
 	default n
 	help
 	  Hist triggers allow one or more arbitrary trace event fields
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7e0332f90ed4..911470ad9e94 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4620,6 +4620,9 @@ static const char readme_msg[] =
 	"\t  accepts: event-definitions (one definition per line)\n"
 	"\t   Format: p[:[<group>/]<event>] <place> [<args>]\n"
 	"\t           r[maxactive][:[<group>/]<event>] <place> [<args>]\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t           s:[synthetic/]<event> <field> [<field>]\n"
+#endif
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
@@ -4638,6 +4641,11 @@ static const char readme_msg[] =
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
 	"\t           <type>\\[<array-size>\\]\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t    field: <stype> <name>;\n"
+	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
+	"\t           [unsigned] char/int/long\n"
+#endif
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0feb7f460123..414aabd67d1f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -15,6 +15,7 @@
 
 #include "tracing_map.h"
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	16
@@ -292,6 +293,21 @@ struct hist_trigger_data {
 	unsigned int			n_max_var_str;
 };
 
+static int synth_event_create(int argc, const char **argv);
+static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
+static int synth_event_release(struct dyn_event *ev);
+static bool synth_event_is_busy(struct dyn_event *ev);
+static bool synth_event_match(const char *system, const char *event,
+			      struct dyn_event *ev);
+
+static struct dyn_event_operations synth_event_ops = {
+	.create = synth_event_create,
+	.show = synth_event_show,
+	.is_busy = synth_event_is_busy,
+	.free = synth_event_release,
+	.match = synth_event_match,
+};
+
 struct synth_field {
 	char *type;
 	char *name;
@@ -301,7 +317,7 @@ struct synth_field {
 };
 
 struct synth_event {
-	struct list_head			list;
+	struct dyn_event			devent;
 	int					ref;
 	char					*name;
 	struct synth_field			**fields;
@@ -312,6 +328,32 @@ struct synth_event {
 	struct tracepoint			*tp;
 };
 
+static bool is_synth_event(struct dyn_event *ev)
+{
+	return ev->ops == &synth_event_ops;
+}
+
+static struct synth_event *to_synth_event(struct dyn_event *ev)
+{
+	return container_of(ev, struct synth_event, devent);
+}
+
+static bool synth_event_is_busy(struct dyn_event *ev)
+{
+	struct synth_event *event = to_synth_event(ev);
+
+	return event->ref != 0;
+}
+
+static bool synth_event_match(const char *system, const char *event,
+			      struct dyn_event *ev)
+{
+	struct synth_event *sev = to_synth_event(ev);
+
+	return strcmp(sev->name, event) == 0 &&
+		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
+}
+
 struct action_data;
 
 typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
@@ -402,7 +444,6 @@ static bool have_hist_err(void)
 	return false;
 }
 
-static LIST_HEAD(synth_event_list);
 static DEFINE_MUTEX(synth_event_mutex);
 
 struct synth_trace_event {
@@ -738,14 +779,12 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, char **argv,
+static struct synth_field *parse_synth_field(int argc, const char **argv,
 					     int *consumed)
 {
 	struct synth_field *field;
-	const char *prefix = NULL;
-	char *field_type = argv[0], *field_name;
+	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	int len, ret = 0;
-	char *array;
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -762,20 +801,31 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		*consumed = 2;
 	}
 
-	len = strlen(field_name);
-	if (field_name[len - 1] == ';')
-		field_name[len - 1] = '\0';
-
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field)
 		return ERR_PTR(-ENOMEM);
 
-	len = strlen(field_type) + 1;
+	len = strlen(field_name);
 	array = strchr(field_name, '[');
+	if (array)
+		len -= strlen(array);
+	else if (field_name[len - 1] == ';')
+		len--;
+
+	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
+	if (!field->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	if (field_type[0] == ';')
+		field_type++;
+	len = strlen(field_type) + 1;
 	if (array)
 		len += strlen(array);
 	if (prefix)
 		len += strlen(prefix);
+
 	field->type = kzalloc(len, GFP_KERNEL);
 	if (!field->type) {
 		ret = -ENOMEM;
@@ -786,7 +836,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	strcat(field->type, field_type);
 	if (array) {
 		strcat(field->type, array);
-		*array = '\0';
+		if (field->type[len - 1] == ';')
+			field->type[len - 1] = '\0';
 	}
 
 	field->size = synth_field_size(field->type);
@@ -800,11 +851,6 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 
 	field->is_signed = synth_field_signed(field->type);
 
-	field->name = kstrdup(field_name, GFP_KERNEL);
-	if (!field->name) {
-		ret = -ENOMEM;
-		goto free;
-	}
  out:
 	return field;
  free:
@@ -868,9 +914,13 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 
 static struct synth_event *find_synth_event(const char *name)
 {
+	struct dyn_event *pos;
 	struct synth_event *event;
 
-	list_for_each_entry(event, &synth_event_list, list) {
+	for_each_dyn_event(pos) {
+		if (!is_synth_event(pos))
+			continue;
+		event = to_synth_event(pos);
 		if (strcmp(event->name, name) == 0)
 			return event;
 	}
@@ -921,7 +971,7 @@ static int register_synth_event(struct synth_event *event)
 
 	ret = set_synth_event_print_fmt(call);
 	if (ret < 0) {
-		trace_remove_event_call(call);
+		trace_remove_event_call_nolock(call);
 		goto err;
 	}
  out:
@@ -959,7 +1009,7 @@ static void free_synth_event(struct synth_event *event)
 	kfree(event);
 }
 
-static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
+static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 					     struct synth_field **fields)
 {
 	struct synth_event *event;
@@ -971,7 +1021,7 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 		goto out;
 	}
 
-	event->name = kstrdup(event_name, GFP_KERNEL);
+	event->name = kstrdup(name, GFP_KERNEL);
 	if (!event->name) {
 		kfree(event);
 		event = ERR_PTR(-ENOMEM);
@@ -985,6 +1035,8 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 		goto out;
 	}
 
+	dyn_event_init(&event->devent, &synth_event_ops);
+
 	for (i = 0; i < n_fields; i++)
 		event->fields[i] = fields[i];
 
@@ -1008,16 +1060,11 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
-static int create_synth_event(int argc, char **argv)
+static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
-	bool delete_event = false;
 	int i, consumed = 0, n_fields = 0, ret = 0;
-	char *name;
-
-	mutex_lock(&event_mutex);
-	mutex_lock(&synth_event_mutex);
 
 	/*
 	 * Argument syntax:
@@ -1025,43 +1072,20 @@ static int create_synth_event(int argc, char **argv)
 	 *  - Remove synthetic event: !<event_name> field[;field] ...
 	 *      where 'field' = type field_name
 	 */
-	if (argc < 1) {
-		ret = -EINVAL;
-		goto out;
-	}
 
-	name = argv[0];
-	if (name[0] == '!') {
-		delete_event = true;
-		name++;
-	}
+	if (name[0] == '\0' || argc < 1)
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&synth_event_mutex);
 
 	event = find_synth_event(name);
 	if (event) {
-		if (delete_event) {
-			if (event->ref) {
-				ret = -EBUSY;
-				goto out;
-			}
-			ret = unregister_synth_event(event);
-			if (!ret) {
-				list_del(&event->list);
-				free_synth_event(event);
-			}
-		} else
-			ret = -EEXIST;
-		goto out;
-	} else if (delete_event) {
-		ret = -ENOENT;
+		ret = -EEXIST;
 		goto out;
 	}
 
-	if (argc < 2) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	for (i = 1; i < argc - 1; i++) {
+	for (i = 0; i < argc - 1; i++) {
 		if (strcmp(argv[i], ";") == 0)
 			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
@@ -1091,7 +1115,7 @@ static int create_synth_event(int argc, char **argv)
 	}
 	ret = register_synth_event(event);
 	if (!ret)
-		list_add(&event->list, &synth_event_list);
+		dyn_event_add(&event->devent);
 	else
 		free_synth_event(event);
  out:
@@ -1106,57 +1130,77 @@ static int create_synth_event(int argc, char **argv)
 	goto out;
 }
 
-static int release_all_synth_events(void)
+static int create_or_delete_synth_event(int argc, char **argv)
 {
-	struct synth_event *event, *e;
-	int ret = 0;
-
-	mutex_lock(&event_mutex);
-	mutex_lock(&synth_event_mutex);
-
-	list_for_each_entry(event, &synth_event_list, list) {
-		if (event->ref) {
-			mutex_unlock(&synth_event_mutex);
-			return -EBUSY;
-		}
-	}
+	const char *name = argv[0];
+	struct synth_event *event = NULL;
+	int ret;
 
-	list_for_each_entry_safe(event, e, &synth_event_list, list) {
-		ret = unregister_synth_event(event);
-		if (!ret) {
-			list_del(&event->list);
-			free_synth_event(event);
+	/* trace_run_command() ensures argc != 0 */
+	if (name[0] == '!') {
+		mutex_lock(&event_mutex);
+		mutex_lock(&synth_event_mutex);
+		event = find_synth_event(name + 1);
+		if (event) {
+			if (event->ref)
+				ret = -EBUSY;
+			else {
+				ret = unregister_synth_event(event);
+				if (!ret) {
+					dyn_event_remove(&event->devent);
+					free_synth_event(event);
+				}
+			}
 		} else
-			break;
+			ret = -ENOENT;
+		mutex_unlock(&synth_event_mutex);
+		mutex_unlock(&event_mutex);
+		return ret;
 	}
-	mutex_unlock(&synth_event_mutex);
-	mutex_unlock(&event_mutex);
 
-	return ret;
+	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-
-static void *synth_events_seq_start(struct seq_file *m, loff_t *pos)
+static int synth_event_create(int argc, const char **argv)
 {
-	mutex_lock(&synth_event_mutex);
+	const char *name = argv[0];
+	int len;
 
-	return seq_list_start(&synth_event_list, *pos);
-}
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
+	name += 2;
 
-static void *synth_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	return seq_list_next(v, &synth_event_list, pos);
+	/* This interface accepts group name prefix */
+	if (strchr(name, '/')) {
+		len = sizeof(SYNTH_SYSTEM "/") - 1;
+		if (strncmp(name, SYNTH_SYSTEM "/", len))
+			return -EINVAL;
+		name += len;
+	}
+	return __create_synth_event(argc - 1, name, argv + 1);
 }
 
-static void synth_events_seq_stop(struct seq_file *m, void *v)
+static int synth_event_release(struct dyn_event *ev)
 {
-	mutex_unlock(&synth_event_mutex);
+	struct synth_event *event = to_synth_event(ev);
+	int ret;
+
+	if (event->ref)
+		return -EBUSY;
+
+	ret = unregister_synth_event(event);
+	if (ret)
+		return ret;
+
+	dyn_event_remove(ev);
+	free_synth_event(event);
+	return 0;
 }
 
-static int synth_events_seq_show(struct seq_file *m, void *v)
+static int __synth_event_show(struct seq_file *m, struct synth_event *event)
 {
 	struct synth_field *field;
-	struct synth_event *event = v;
 	unsigned int i;
 
 	seq_printf(m, "%s\t", event->name);
@@ -1174,11 +1218,30 @@ static int synth_events_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int synth_event_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct synth_event *event = to_synth_event(ev);
+
+	seq_printf(m, "s:%s/", event->class.system);
+
+	return __synth_event_show(m, event);
+}
+
+static int synth_events_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_synth_event(ev))
+		return 0;
+
+	return __synth_event_show(m, to_synth_event(ev));
+}
+
 static const struct seq_operations synth_events_seq_op = {
-	.start  = synth_events_seq_start,
-	.next   = synth_events_seq_next,
-	.stop   = synth_events_seq_stop,
-	.show   = synth_events_seq_show
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= synth_events_seq_show,
 };
 
 static int synth_events_open(struct inode *inode, struct file *file)
@@ -1186,7 +1249,7 @@ static int synth_events_open(struct inode *inode, struct file *file)
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = release_all_synth_events();
+		ret = dyn_events_release_all(&synth_event_ops);
 		if (ret < 0)
 			return ret;
 	}
@@ -1199,7 +1262,7 @@ static ssize_t synth_events_write(struct file *file,
 				  size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_synth_event);
+				       create_or_delete_synth_event);
 }
 
 static const struct file_operations synth_events_fops = {
@@ -5791,6 +5854,12 @@ static __init int trace_events_hist_init(void)
 	struct dentry *d_tracer;
 	int err = 0;
 
+	err = dyn_event_register(&synth_event_ops);
+	if (err) {
+		pr_warn("Could not register synth_event_ops\n");
+		return err;
+	}
+
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer)) {
 		err = PTR_ERR(d_tracer);
-- 
2.19.1


