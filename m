Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbeBGUeQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754397AbeBGU2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06953217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202815.018714200@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:05 -0500
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
Subject: [PATCH 03/20 v2] tracing: Add simple arguments to function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-tracing-Add-simple-arguments-to-function-based-event.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function based events can now have arguments passed in. A weak function
arch_get_func_args() is created so that archs can fill in the arguments
based on pt_regs. Currently no arch implements this function, so no
arguments are returned. Passing NULL for pt_regs into this function returns
the number of supported args that can be processed, and the format will
only allow the user to add valid args. Which currently are all arguments
until an arch implements the arg_get_func_args() function.

[ missing 'static' found by Fengguang Wu's kbuild test robot ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst |  57 +++++
 kernel/trace/trace_event_ftrace.c             | 324 ++++++++++++++++++++++++--
 2 files changed, 367 insertions(+), 14 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 843a1bf76459..94c2c975295a 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -67,3 +67,60 @@ print fmt: "%pS->%pS()", REC->__ip, REC->__parent_ip
 The above shows that the format is very close to the function trace
 except that it displays the parent function followed by the called
 function.
+
+
+Number of arguments
+===================
+
+The number of arguments that can be specified is dependent on the
+architecture. An architecture may not allow any arguments, or it
+may limit to just three or six. If more arguments are used than
+supported, it will fail with -EINVAL.
+
+Parameters
+==========
+
+Adding parameters creates fields within the events. The format is
+as follows:
+
+ # echo EVENT > function_events
+
+ EVENT := <function> '(' ARGS ')'
+
+ Where <function> is any function that the function tracer can trace.
+
+ ARGS := ARG | ARG ',' ARGS | ''
+
+ ARG := TYPE FIELD
+
+ TYPE := ATOM
+
+ ATOM := 'u8' | 'u16' | 'u32' | 'u64' |
+         's8' | 's16' | 's32' | 's64' |
+         'char' | 'short' | 'int' | 'long' | 'size_t'
+
+ FIELD := <name>
+
+ Where <name> is a unique string starting with an alphabetic character
+ and consists only of letters and numbers and underscores.
+
+
+Simple arguments
+================
+
+Looking at kernel code, we can see something like:
+
+ v4.15: net/ipv4/ip_input.c:
+
+int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt, struct net_device *orig_dev)
+
+If we are only interested in the first argument (skb):
+
+ # echo 'ip_rcv(u64 skb, u64 dev)' > function_events
+
+ # echo 1 > events/functions/ip_rcv/enable
+ # cat trace
+     <idle>-0     [003] ..s3  2119.041935: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
+     <idle>-0     [003] ..s3  2119.041944: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
+     <idle>-0     [003] ..s3  2119.288337: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
+     <idle>-0     [003] ..s3  2119.288960: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index fb8e03e663e8..e915f70e2fd5 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -13,6 +13,16 @@
 #define FUNC_EVENT_SYSTEM "functions"
 #define WRITE_BUFSIZE  4096
 
+struct func_arg {
+	struct list_head		list;
+	char				*type;
+	char				*name;
+	short				offset;
+	short				size;
+	char				arg;
+	char				sign;
+};
+
 struct func_event {
 	struct list_head		list;
 	char				*func;
@@ -20,6 +30,10 @@ struct func_event {
 	struct trace_event_call		call;
 	struct ftrace_ops		ops;
 	struct list_head		files;
+	struct list_head		args;
+	struct func_arg			*last_arg;
+	int				arg_cnt;
+	int				arg_offset;
 };
 
 struct func_file {
@@ -31,6 +45,7 @@ struct func_event_hdr {
 	struct trace_entry	ent;
 	unsigned long		ip;
 	unsigned long		parent_ip;
+	char			data[0];
 };
 
 static DEFINE_MUTEX(func_event_mutex);
@@ -40,15 +55,91 @@ enum func_states {
 	FUNC_STATE_INIT,
 	FUNC_STATE_FUNC,
 	FUNC_STATE_PARAM,
+	FUNC_STATE_TYPE,
+	FUNC_STATE_VAR,
+	FUNC_STATE_COMMA,
 	FUNC_STATE_END,
 	FUNC_STATE_ERROR,
 };
 
+#define TYPE_TUPLE(type)			\
+	{ #type, sizeof(type), is_signed_type(type) }
+
+static struct func_type {
+	char		*name;
+	int		size;
+	int		sign;
+} func_types[] = {
+	TYPE_TUPLE(long),
+	TYPE_TUPLE(int),
+	TYPE_TUPLE(short),
+	TYPE_TUPLE(char),
+	TYPE_TUPLE(size_t),
+	TYPE_TUPLE(u64),
+	TYPE_TUPLE(s64),
+	TYPE_TUPLE(u32),
+	TYPE_TUPLE(s32),
+	TYPE_TUPLE(u16),
+	TYPE_TUPLE(s16),
+	TYPE_TUPLE(u8),
+	TYPE_TUPLE(s8),
+	{ NULL,		0,	0 }
+};
+
+static int max_args __read_mostly = -1;
+
+/**
+ * arch_get_func_args - retrieve function arguments via pt_regs
+ * @regs: The registers at the moment the function is called
+ * @start: The first argument to retrieve (usually zero)
+ * @end: The last argument to retrive (end - start arguments to get)
+ * @args: The array to store the arguments in
+ *
+ * This is to be implemented by architecture code.
+ *
+ * If @regs is NULL, return the number of supported arguments that
+ * can be retrieved (this default function supports no arguments,
+ * and returns zero). The other parameters are ignored when @regs
+ * is NULL.
+ *
+ * If the function can support 6 arguments, then it should return
+ * 6 if @regs is NULL. If @regs is not NULL and it should start
+ * loading the arguments into @args. If @start is 2 and @end is 4,
+ * @args[0] would get the third argument (0 is the first argument)
+ * and @args[1] would get the forth argument. The function would
+ * return 2 (@end - @start).
+ *
+ * If @start is 5 and @end is 7, as @end is greater than the number
+ * of supported arguments, @args[0] would get the sixth argument,
+ * and 1 would be returned. The function does not error if more
+ * than the supported arguments is asked for. It only load what it
+ * can into @args, and return the number of arguments copied.
+ *
+ * Returns:
+ *  If @regs is NULL, the number of supported arguments it can handle.
+ *
+ *  Otherwise, it returns the number of arguments copied to @args.
+ */
+int __weak arch_get_func_args(struct pt_regs *regs,
+			      int start, int end,
+			      long *args)
+{
+	return 0;
+}
+
 static void free_func_event(struct func_event *func_event)
 {
+	struct func_arg *arg, *n;
+
 	if (!func_event)
 		return;
 
+	list_for_each_entry_safe(arg, n, &func_event->args, list) {
+		list_del(&arg->list);
+		kfree(arg->name);
+		kfree(arg->type);
+		kfree(arg);
+	}
 	ftrace_free_filter(&func_event->ops);
 	kfree(func_event->call.print_fmt);
 	kfree(func_event->func);
@@ -73,6 +164,7 @@ static char *next_token(char **ptr, char *last)
 
 	for (str = arg; *str; str++) {
 		if (*str == '(' ||
+		    *str == ',' ||
 		    *str == ')')
 			break;
 	}
@@ -90,34 +182,99 @@ static char *next_token(char **ptr, char *last)
 	return arg;
 }
 
+static int add_arg(struct func_event *fevent, int ftype)
+{
+	struct func_type *func_type = &func_types[ftype];
+	struct func_arg *arg;
+
+	/* Make sure the arch can support this many args */
+	if (fevent->arg_cnt >= max_args)
+		return -EINVAL;
+
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg)
+		return -ENOMEM;
+
+	arg->type = kstrdup(func_type->name, GFP_KERNEL);
+	if (!arg->type) {
+		kfree(arg);
+		return -ENOMEM;
+	}
+	arg->size = func_type->size;
+	arg->sign = func_type->sign;
+	arg->offset = ALIGN(fevent->arg_offset, arg->size);
+	arg->arg = fevent->arg_cnt;
+	fevent->arg_offset = arg->offset + arg->size;
+
+	list_add_tail(&arg->list, &fevent->args);
+	fevent->last_arg = arg;
+	fevent->arg_cnt++;
+
+	return 0;
+}
+
 static enum func_states
 process_event(struct func_event *fevent, const char *token, enum func_states state)
 {
+	int ret;
+	int i;
+
 	switch (state) {
 	case FUNC_STATE_INIT:
 		if (!isalpha(token[0]))
-			return FUNC_STATE_ERROR;
+			break;
 		/* Do not allow wild cards */
 		if (strstr(token, "*") || strstr(token, "?"))
-			return FUNC_STATE_ERROR;
+			break;
 		fevent->func = kstrdup(token, GFP_KERNEL);
 		if (!fevent->func)
-			return FUNC_STATE_ERROR;
+			break;
 		return FUNC_STATE_FUNC;
 
 	case FUNC_STATE_FUNC:
 		if (token[0] != '(')
-			return FUNC_STATE_ERROR;
+			break;
 		return FUNC_STATE_PARAM;
 
 	case FUNC_STATE_PARAM:
-		if (token[0] != ')')
-			return FUNC_STATE_ERROR;
-		return FUNC_STATE_END;
+		if (token[0] == ')')
+			return FUNC_STATE_END;
+		/* Fall through */
+	case FUNC_STATE_COMMA:
+		for (i = 0; func_types[i].size; i++) {
+			if (strcmp(token, func_types[i].name) == 0)
+				break;
+		}
+		if (!func_types[i].size)
+			break;
+		ret = add_arg(fevent, i);
+		if (ret < 0)
+			break;
+		return FUNC_STATE_TYPE;
+
+	case FUNC_STATE_TYPE:
+		if (!isalpha(token[0]))
+			break;
+		if (WARN_ON(!fevent->last_arg))
+			break;
+		fevent->last_arg->name = kstrdup(token, GFP_KERNEL);
+		if (!fevent->last_arg->name)
+			break;
+		return FUNC_STATE_VAR;
+
+	case FUNC_STATE_VAR:
+		switch (token[0]) {
+		case ')':
+			return FUNC_STATE_END;
+		case ',':
+			return FUNC_STATE_COMMA;
+		}
+		break;
 
 	default:
-		return FUNC_STATE_ERROR;
+		break;
 	}
+	return FUNC_STATE_ERROR;
 }
 
 static void func_event_trace(struct trace_event_file *trace_file,
@@ -129,9 +286,14 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	struct trace_event_call *call = &func_event->call;
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
+	struct func_arg *arg;
+	long args[func_event->arg_cnt];
+	long long val = 1;
 	unsigned long irq_flags;
+	int nr_args;
 	int size;
 	int pc;
+	int i = 0;
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
@@ -139,7 +301,7 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	local_save_flags(irq_flags);
 	pc = preempt_count();
 
-	size = sizeof(*entry);
+	size = func_event->arg_offset + sizeof(*entry);
 
 	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
 						call->event.type,
@@ -150,6 +312,15 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 	entry->parent_ip = parent_ip;
+	nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
+
+	list_for_each_entry(arg, &func_event->args, list) {
+		if (i < nr_args)
+			val = args[i];
+		else
+			val = 0;
+		memcpy(&entry->data[arg->offset], &val, arg->size);
+	}
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, pt_regs);
@@ -175,7 +346,26 @@ func_event_call(unsigned long ip, unsigned long parent_ip,
 	rcu_irq_exit_irqson();
 }
 
+#define FMT_SIZE	8
+
+static void make_fmt(struct func_arg *arg, char *fmt)
+{
+	int c = 0;
 
+	fmt[c++] = '%';
+
+	if (arg->size == 8) {
+		fmt[c++] = 'l';
+		fmt[c++] = 'l';
+	}
+
+	if (arg->sign)
+		fmt[c++] = 'd';
+	else
+		fmt[c++] = 'u';
+
+	fmt[c++] = '\0';
+}
 
 static enum print_line_t
 func_event_print(struct trace_iterator *iter, int flags,
@@ -183,12 +373,43 @@ func_event_print(struct trace_iterator *iter, int flags,
 {
 	struct func_event_hdr *entry;
 	struct trace_seq *s = &iter->seq;
+	struct func_event *func_event;
+	struct func_arg *arg;
+	char fmt[FMT_SIZE];
+	void *data;
+	bool comma = false;
 
 	entry = (struct func_event_hdr *)iter->ent;
 
-	trace_seq_printf(s, "%ps->%ps()",
+	func_event = container_of(event, struct func_event, call.event);
+
+	trace_seq_printf(s, "%ps->%ps(",
 			 (void *)entry->parent_ip, (void *)entry->ip);
-	trace_seq_putc(s, '\n');
+	list_for_each_entry(arg, &func_event->args, list) {
+		if (comma)
+			trace_seq_puts(s, ", ");
+		comma = true;
+		trace_seq_printf(s, "%s=", arg->name);
+		data = &entry->data[arg->offset];
+
+		make_fmt(arg, fmt);
+
+		switch (arg->size) {
+		case 8:
+			trace_seq_printf(s, fmt, *(unsigned long long *)data);
+			break;
+		case 4:
+			trace_seq_printf(s, fmt, *(unsigned *)data);
+			break;
+		case 2:
+			trace_seq_printf(s, fmt, *(unsigned short *)data);
+			break;
+		case 1:
+			trace_seq_printf(s, fmt, *(unsigned char *)data);
+			break;
+		}
+	}
+	trace_seq_puts(s, ")\n");
 	return trace_handle_return(s);
 }
 
@@ -198,12 +419,25 @@ static struct trace_event_functions func_event_funcs = {
 
 static int func_event_define_fields(struct trace_event_call *event_call)
 {
+	struct func_event *fevent;
 	struct func_event_hdr field;
+	struct func_arg *arg;
 	int ret;
 
+	fevent = (struct func_event *)event_call->data;
+
 	DEFINE_FIELD(unsigned long, ip, "__parent_ip", 0);
 	DEFINE_FIELD(unsigned long, parent_ip, "__ip", 0);
 
+	list_for_each_entry(arg, &fevent->args, list) {
+		ret = trace_define_field(event_call, arg->type,
+					 arg->name,
+					 sizeof(field) + arg->offset,
+					 arg->size, arg->sign,
+					 FILTER_OTHER);
+		if (ret < 0)
+			return ret;
+	}
 	return 0;
 }
 
@@ -276,13 +510,61 @@ static int func_event_register(struct trace_event_call *event,
 	return 0;
 }
 
+static int update_len(int len, int i)
+{
+	len -= i;
+	if (len < 0)
+		return 0;
+	return len;
+}
+
+static int __set_print_fmt(struct func_event *func_event,
+			   char *buf, int len)
+{
+	struct func_arg *arg;
+	const char *fmt_start = "\"%pS->%pS(";
+	const char *fmt_end = ")\", REC->__ip, REC->__parent_ip";
+	char fmt[FMT_SIZE];
+	int r, i;
+	bool comma = false;
+
+	r = snprintf(buf, len, "%s", fmt_start);
+	len = update_len(len, r);
+	list_for_each_entry(arg, &func_event->args, list) {
+		if (comma) {
+			i = snprintf(buf + r, len, ", ");
+			r += i;
+			len = update_len(len, i);
+		}
+		comma = true;
+		make_fmt(arg, fmt);
+		i = snprintf(buf + r, len, "%s=%s", arg->name, fmt);
+		r += i;
+		len = update_len(len, i);
+	}
+	i = snprintf(buf + r, len, "%s", fmt_end);
+	r += i;
+	len = update_len(len, i);
+
+	list_for_each_entry(arg, &func_event->args, list) {
+		i = snprintf(buf + r, len, ", REC->%s", arg->name);
+		r += i;
+		len = update_len(len, i);
+	}
+
+	return r;
+}
+
 static int set_print_fmt(struct func_event *func_event)
 {
-	const char *fmt = "\"%pS->%pS()\", REC->__ip, REC->__parent_ip";
+	int len;
 
-	func_event->call.print_fmt = kstrdup(fmt, GFP_KERNEL);
+	/* Get required length */
+	len = __set_print_fmt(func_event, NULL, 0) + 1;
+	func_event->call.print_fmt = kmalloc(len, GFP_KERNEL);
 	if (!func_event->call.print_fmt)
 		return -ENOMEM;
+	__set_print_fmt(func_event, func_event->call.print_fmt, len);
 
 	return 0;
 }
@@ -330,6 +612,7 @@ static int create_function_event(int argc, char **argv)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&func_event->files);
+	INIT_LIST_HEAD(&func_event->args);
 	func_event->ops.func = func_event_call;
 	func_event->ops.flags = FTRACE_OPS_FL_SAVE_REGS;
 
@@ -383,8 +666,18 @@ static void func_event_seq_stop(struct seq_file *m, void *v)
 static int func_event_seq_show(struct seq_file *m, void *v)
 {
 	struct func_event *func_event = v;
+	struct func_arg *arg;
+	bool comma = false;
 
-	seq_printf(m, "%s()\n", func_event->func);
+	seq_printf(m, "%s(", func_event->func);
+
+	list_for_each_entry(arg, &func_event->args, list) {
+		if (comma)
+			seq_puts(m, ", ");
+		comma = true;
+		seq_printf(m, "%s %s", arg->type, arg->name);
+	}
+	seq_puts(m, ")\n");
 
 	return 0;
 }
@@ -417,6 +710,9 @@ static int func_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	if (max_args < 0)
+		max_args = arch_get_func_args(NULL, 0, 0, NULL);
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = release_all_func_events();
 		if (ret < 0)
-- 
2.15.1
