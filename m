Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeBGU3K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754715AbeBGU2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2EA217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202817.516188137@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 19/20 v2] tracing: Add error messages for failed writes to function_events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0019-tracing-Add-error-messages-for-failed-writes-to-func.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When a write to function_events fails to parse, produce an error message to
help the user know why it failed. The error message will display at the end
of reading the function_events file the next time.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_ftrace.c | 288 ++++++++++++++++++++++++++++++++------
 1 file changed, 244 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 303a56c3339a..314d025dc676 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -38,6 +38,7 @@ struct func_arg {
 struct func_event {
 	struct list_head		list;
 	char				*func;
+	/* The above must match func_event_err below */
 	struct trace_event_class	class;
 	struct trace_event_call		call;
 	struct ftrace_ops		ops;
@@ -49,6 +50,15 @@ struct func_event {
 	int				has_strings;
 };
 
+#define ERR_SIZE	(256 - (sizeof(struct list_head) + sizeof(char *)))
+
+struct func_event_err {
+	struct list_head		list;
+	char				*func;
+	/* The above must match func_event above */
+	char				err_str[ERR_SIZE];
+};
+
 struct func_file {
 	struct list_head		list;
 	struct trace_event_file		*file;
@@ -64,29 +74,42 @@ struct func_event_hdr {
 static DEFINE_MUTEX(func_event_mutex);
 static LIST_HEAD(func_events);
 
+#define FUNC_STATES				\
+	C(INIT),				\
+	C(FUNC),				\
+	C(PARAM),				\
+	C(BRACKET),				\
+	C(BRACKET_END),				\
+	C(INDIRECT),				\
+	C(UNSIGNED),				\
+	C(ADDR),				\
+	C(EQUAL),				\
+	C(PIPE),				\
+	C(PLUS),				\
+	C(TYPE),				\
+	C(ARRAY),				\
+	C(ARRAY_SIZE),				\
+	C(ARRAY_END),				\
+	C(REDIRECT_PLUS),			\
+	C(REDIRECT_BRACKET),			\
+	C(VAR),					\
+	C(COMMA),				\
+	C(NULL),				\
+	C(END),					\
+	C(ERROR)
+
+#undef C
+#define C(x)	FUNC_STATE_##x
+
 enum func_states {
-	FUNC_STATE_INIT,
-	FUNC_STATE_FUNC,
-	FUNC_STATE_PARAM,
-	FUNC_STATE_BRACKET,
-	FUNC_STATE_BRACKET_END,
-	FUNC_STATE_INDIRECT,
-	FUNC_STATE_UNSIGNED,
-	FUNC_STATE_ADDR,
-	FUNC_STATE_EQUAL,
-	FUNC_STATE_PIPE,
-	FUNC_STATE_PLUS,
-	FUNC_STATE_TYPE,
-	FUNC_STATE_ARRAY,
-	FUNC_STATE_ARRAY_SIZE,
-	FUNC_STATE_ARRAY_END,
-	FUNC_STATE_REDIRECT_PLUS,
-	FUNC_STATE_REDIRECT_BRACKET,
-	FUNC_STATE_VAR,
-	FUNC_STATE_COMMA,
-	FUNC_STATE_NULL,
-	FUNC_STATE_END,
-	FUNC_STATE_ERROR,
+	FUNC_STATES
+};
+
+#undef C
+#define C(x)	#x
+
+static char *func_state_names[] = {
+	FUNC_STATES
 };
 
 typedef u64 x64;
@@ -215,6 +238,16 @@ static void free_func_event(struct func_event *func_event)
 	if (!func_event)
 		return;
 
+	/*
+	 * If func is NULL then this is a func_event_err, or
+	 * nothing else has been allocated for the func_event.
+	 * In either case, it is safe just to free the func_event.
+	 */
+	if (!func_event->func) {
+		kfree(func_event);
+		return;
+	}
+
 	list_for_each_entry_safe(arg, n, &func_event->args, list) {
 		free_arg(arg);
 	}
@@ -438,8 +471,11 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			break;
 		if (strncmp(token, "0x", 2) == 0)
 			goto equal;
-		if (!isalpha(token[0]) && token[0] != '_')
+		if (!isalpha(token[0]) && token[0] != '_') {
+			kfree(fevent->last_arg->name);
+			fevent->last_arg->name = NULL;
 			break;
+		}
 		update_arg = true;
 		return FUNC_STATE_VAR;
 
@@ -1249,10 +1285,121 @@ static int func_event_create(struct func_event *func_event)
 	return ret;
 }
 
+static void show_func_event(struct trace_seq *s, struct func_event *func_event);
+
+static void add_failure(struct func_event *func_event, char *token,
+			enum func_states state, char *ptr, char last,
+			int i, int argc, char **argv)
+{
+	struct func_event_err *func_err;
+	struct trace_seq *s;
+	char *save_token = NULL;
+	int len;
+
+	/* Don't do anything if we were not able to get the first field */
+	if (!func_event->func)
+		return;
+
+	func_err = kzalloc(sizeof(*func_err), GFP_KERNEL);
+	if (!func_err)
+		return;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s) {
+		kfree(func_err);
+		return;
+	}
+	trace_seq_init(s);
+	show_func_event(s, func_event);
+
+	/*
+	 * show_func_event() doesn't print some tokens if it crashed
+	 * at a certain state.
+	 */
+	switch (state) {
+	case FUNC_STATE_PIPE:
+		trace_seq_puts(s, " | ");
+		break;
+	case FUNC_STATE_COMMA:
+		trace_seq_puts(s, ", ");
+		break;
+	case FUNC_STATE_PLUS:
+	case FUNC_STATE_REDIRECT_PLUS:
+		trace_seq_putc(s, '+');
+		break;
+	case FUNC_STATE_BRACKET:
+	case FUNC_STATE_ARRAY:
+		trace_seq_putc(s, '[');
+		break;
+	case FUNC_STATE_UNSIGNED:
+		trace_seq_puts(s, "unsigned ");
+		break;
+	case FUNC_STATE_INDIRECT:
+	case FUNC_STATE_ARRAY_SIZE:
+		/* show_func_event() adds a ']' for these */
+		s->seq.len--;
+		break;
+	default:
+		break;
+	}
+	trace_seq_putc(s, ' ');
+	len = s->seq.len + 1;
+
+	if (!token) {
+		/* Parser didn't end properly */
+		trace_seq_printf(s, "\n%*s\nUnexpected ending",
+				 len, "^");
+		goto finish;
+	}
+
+	save_token = kstrdup(token, GFP_KERNEL);
+	if (!save_token) {
+		kfree(func_err);
+		kfree(s);
+		return;
+	}
+
+	trace_seq_puts(s, token);
+	trace_seq_putc(s, ' ');
+
+	/* Finish parsing the tokens */
+	for (token = next_token(&ptr, &last); token;
+	     token = next_token(&ptr, &last)) {
+		if (token[0] == '|')
+			trace_seq_putc(s, ' ');
+		trace_seq_puts(s, token);
+		if (token[0] == ',' || token[0] == '|')
+			trace_seq_putc(s, ' ');
+	}
+
+	/* Add the rest of the line */
+	for (i++; i < argc; i++) {
+		trace_seq_puts(s, argv[i]);
+		trace_seq_putc(s, ' ');
+	}
+
+	trace_seq_printf(s, "\n%*s\n", len, "^");
+
+	trace_seq_printf(s, "Unexpected token '%s' for %s state",
+			 save_token, func_state_names[state]);
+
+ finish:
+	len = min(ERR_SIZE-1, s->seq.len);
+	strncpy(func_err->err_str, s->buffer, len);
+	func_err->err_str[len] = 0;
+
+	mutex_lock(&func_event_mutex);
+	list_add_tail(&func_err->list, &func_events);
+	mutex_unlock(&func_event_mutex);
+
+	kfree(save_token);
+	kfree(s);
+}
+
 static int create_function_event(int argc, char **argv)
 {
 	struct func_event *func_event;
-	enum func_states state = FUNC_STATE_INIT;
+	enum func_states last_state, state = FUNC_STATE_INIT;
 	char *token;
 	char *ptr;
 	char last;
@@ -1268,11 +1415,13 @@ static int create_function_event(int argc, char **argv)
 	func_event->ops.func = func_event_call;
 	func_event->ops.flags = FTRACE_OPS_FL_SAVE_REGS;
 
+	last_state = state;
 	for (i = 0; i < argc; i++) {
 		ptr = argv[i];
 		last = 0;
 		for (token = next_token(&ptr, &last); token;
 		     token = next_token(&ptr, &last)) {
+			last_state = state;
 			state = process_event(func_event, token, state);
 			if (state == FUNC_STATE_ERROR)
 				goto fail;
@@ -1295,6 +1444,9 @@ static int create_function_event(int argc, char **argv)
 	mutex_unlock(&func_event_mutex);
 	return 0;
  fail:
+	if (state != FUNC_STATE_END)
+		add_failure(func_event, token, last_state, ptr,
+			    last, i, argc, argv);
 	free_func_event(func_event);
 	return ret;
 }
@@ -1315,46 +1467,71 @@ static void func_event_seq_stop(struct seq_file *m, void *v)
 	mutex_unlock(&func_event_mutex);
 }
 
-static int func_event_seq_show(struct seq_file *m, void *v)
+static int show_error (struct seq_file *m, struct func_event *func_event)
+{
+	struct func_event_err *func_err = (struct func_event_err *)func_event;
+
+	seq_puts(m, func_err->err_str);
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static void show_func_event(struct trace_seq *s, struct func_event *func_event)
 {
-	struct func_event *func_event = v;
 	struct func_arg_redirect *redirect;
 	struct func_arg *arg;
 	bool comma = false;
 	int last_arg = 0;
 
-	seq_printf(m, "%s(", func_event->func);
+	trace_seq_printf(s, "%s(", func_event->func);
 
 	list_for_each_entry(arg, &func_event->args, list) {
 		if (comma) {
 			if (last_arg == arg->arg)
-				seq_puts(m, " | ");
+				trace_seq_puts(s, " | ");
 			else
-				seq_puts(m, ", ");
+				trace_seq_puts(s, ", ");
 		}
 		last_arg = arg->arg;
 		comma = true;
 		if (arg->func_type == FUNC_TYPE_NULL)
-			seq_puts(m, "NULL");
-		else
-			seq_printf(m, "%s %s", arg->type, arg->name);
+			trace_seq_puts(s, "NULL");
+		else {
+			if (arg->type)
+				trace_seq_puts(s, arg->type);
+			if (arg->name)
+				trace_seq_printf(s, " %s", arg->name);
+		}
 		if (arg->arg < 0) {
-			seq_printf(m, "=0x%lx", arg->index);
+			trace_seq_printf(s, "=0x%lx", arg->index);
 		} else {
 			if (arg->index)
-				seq_printf(m, "+%ld", arg->index);
+				trace_seq_printf(s, "+%ld", arg->index);
 			if (arg->indirect && arg->size)
-				seq_printf(m, "[%ld]",
+				trace_seq_printf(s, "[%ld]",
 					   (arg->indirect ^ INDIRECT_FLAG) / arg->size);
 		}
 		list_for_each_entry(redirect, &arg->redirects, list) {
 			if (redirect->index)
-				seq_printf(m, "+%ld", redirect->index);
+				trace_seq_printf(s, "+%ld", redirect->index);
 			if (redirect->indirect)
-				seq_printf(m, "[%ld]",
+				trace_seq_printf(s, "[%ld]",
 					   (redirect->indirect ^ INDIRECT_FLAG) / arg->size);
 		}
 	}
+}
+
+static int func_event_seq_show(struct seq_file *m, void *v)
+{
+	static struct trace_seq s;
+	struct func_event *func_event = v;
+
+	if (!func_event->func)
+		return show_error(m, func_event);
+
+	trace_seq_init(&s);
+	show_func_event(&s, func_event);
+	trace_print_seq(m, &s);
 	seq_puts(m, ")\n");
 
 	return 0;
@@ -1374,9 +1551,12 @@ static int release_all_func_events(void)
 
 	mutex_lock(&func_event_mutex);
 	list_for_each_entry_safe(func_event, n, &func_events, list) {
-		ret = trace_remove_event_call(&func_event->call);
-		if (ret < 0)
-			break;
+		/* NULL func means it is a func_event_err message */
+		if (func_event->func) {
+			ret = trace_remove_event_call(&func_event->call);
+			if (ret < 0)
+				return ret;
+		}
 		list_del(&func_event->list);
 		free_func_event(func_event);
 	}
@@ -1384,6 +1564,21 @@ static int release_all_func_events(void)
 	return ret;
 }
 
+static void remove_func_errors(void)
+{
+	struct func_event *func_event, *n;
+
+	mutex_lock(&func_event_mutex);
+	list_for_each_entry_safe(func_event, n, &func_events, list) {
+		/* NULL func means it is a func_event_err message */
+		if (func_event->func)
+			continue;
+		list_del(&func_event->list);
+		free_func_event(func_event);
+	}
+	mutex_unlock(&func_event_mutex);
+}
+
 static int func_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
@@ -1391,10 +1586,15 @@ static int func_event_open(struct inode *inode, struct file *file)
 	if (max_args < 0)
 		max_args = arch_get_func_args(NULL, 0, 0, NULL);
 
-	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = release_all_func_events();
-		if (ret < 0)
-			return ret;
+	if ((file->f_mode & FMODE_WRITE)) {
+		if (file->f_flags & O_TRUNC) {
+			ret = release_all_func_events();
+			if (ret < 0)
+				return ret;
+		} else {
+			/* Only keep one error per write */
+			remove_func_errors();
+		}
 	}
 
 	return seq_open(file, &func_event_seq_op);
-- 
2.15.1
