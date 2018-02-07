Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754928AbeBGUaS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754695AbeBGU2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0020217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202816.931318809@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:17 -0500
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
Subject: [PATCH 15/20 v2] tracing: Add string type for dynamic strings in function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0015-tracing-Add-string-type-for-dynamic-strings-in-funct.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a "string" type that will create a dynamic length string for the
event, this is the same as the __string() field in normal TRACE_EVENTS.

[ missing 'static' found by Fengguang Wu's kbuild test robot ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst |  19 ++-
 kernel/trace/trace_event_ftrace.c             | 183 +++++++++++++++++++++++---
 2 files changed, 181 insertions(+), 21 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 99ae77cd59e6..6c643ea749e7 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -99,7 +99,7 @@ as follows:
          's8' | 's16' | 's32' | 's64' |
          'x8' | 'x16' | 'x32' | 'x64' |
          'char' | 'short' | 'int' | 'long' | 'size_t' |
-	 'symbol'
+	 'symbol' | 'string'
 
  FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX
 
@@ -342,3 +342,20 @@ the format "%s". If a nul is found, the output will stop. Use another type
       bash-1470  [003] ...2   980.678715: path_openat->link_path_walk(name=/lib64/ld-linux-x86-64.so.2)
       bash-1470  [003] ...2   980.678721: path_openat->link_path_walk(name=ld-2.24.so)
       bash-1470  [003] ...2   980.678978: path_lookupat->link_path_walk(name=/etc/ld.so.preload)
+
+
+Dynamic strings
+===============
+
+Static strings are fine, but they can waste a lot of memory in the ring buffer.
+The above allocated 64 bytes for a character array, but most of the output was
+less than 20 characters. Not wanting to truncate strings or waste space on
+the ring buffer, the dynamic string can help.
+
+Use the "string" type for strings that have a large range in size. The max
+size that will be recorded is 512 bytes. If a string is larger than that, then
+it will be truncated.
+
+ # echo 'link_path_walk(string name)' > function_events
+
+Gives the same result as above, but does not waste buffer space.
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index aa390339b571..50d0c4d32596 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -39,6 +39,7 @@ struct func_event {
 	struct func_arg			*last_arg;
 	int				arg_cnt;
 	int				arg_offset;
+	int				has_strings;
 };
 
 struct func_file {
@@ -83,6 +84,8 @@ typedef u32 x32;
 typedef u16 x16;
 typedef u8 x8;
 typedef void * symbol;
+/* 2 byte offset, 2 byte length */
+typedef u32 string;
 
 #define TYPE_TUPLE(type)			\
 	{ #type, sizeof(type), is_signed_type(type) }
@@ -105,7 +108,8 @@ typedef void * symbol;
 	TYPE_TUPLE(u8),				\
 	TYPE_TUPLE(s8),				\
 	TYPE_TUPLE(x8),				\
-	TYPE_TUPLE(symbol)
+	TYPE_TUPLE(symbol),			\
+	TYPE_TUPLE(string)
 
 static struct func_type {
 	char		*name;
@@ -124,6 +128,16 @@ enum {
 	FUNC_TYPE_MAX
 };
 
+#define MAX_STR		512
+
+/* Two contexts, normal and NMI, hence the " * 2" */
+struct func_string {
+	char		buf[MAX_STR * 2];
+};
+
+static struct func_string __percpu *str_buffer;
+static int nr_strings;
+
 static int max_args __read_mostly = -1;
 
 /**
@@ -165,6 +179,23 @@ int __weak arch_get_func_args(struct pt_regs *regs,
 	return 0;
 }
 
+static void free_arg(struct func_arg *arg)
+{
+	list_del(&arg->list);
+	if (arg->func_type == FUNC_TYPE_string) {
+		nr_strings--;
+		if (WARN_ON(nr_strings < 0))
+			nr_strings = 0;
+		if (!nr_strings) {
+			free_percpu(str_buffer);
+			str_buffer = NULL;
+		}
+	}
+	kfree(arg->name);
+	kfree(arg->type);
+	kfree(arg);
+}
+
 static void free_func_event(struct func_event *func_event)
 {
 	struct func_arg *arg, *n;
@@ -173,10 +204,7 @@ static void free_func_event(struct func_event *func_event)
 		return;
 
 	list_for_each_entry_safe(arg, n, &func_event->args, list) {
-		list_del(&arg->list);
-		kfree(arg->name);
-		kfree(arg->type);
-		kfree(arg);
+		free_arg(arg);
 	}
 	ftrace_free_filter(&func_event->ops);
 	kfree(func_event->call.print_fmt);
@@ -257,6 +285,17 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
 	list_add_tail(&arg->list, &fevent->args);
 	fevent->last_arg = arg;
 
+	if (ftype == FUNC_TYPE_string) {
+		fevent->has_strings++;
+		nr_strings++;
+		if (nr_strings == 1) {
+			str_buffer = alloc_percpu(struct func_string);
+			if (!str_buffer) {
+				free_arg(arg);
+				return -ENOMEM;
+			}
+		}
+	}
 	return 0;
 }
 
@@ -346,8 +385,19 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		return FUNC_STATE_TYPE;
 
 	case FUNC_STATE_TYPE:
-		if (token[0] == '[')
+		if (token[0] == '[') {
+			/* Strings are already arrays */
+			if (fevent->last_arg->func_type == FUNC_TYPE_string)
+				break;
 			return FUNC_STATE_ARRAY;
+		}
+		if (fevent->last_arg->func_type == FUNC_TYPE_string) {
+			type = kstrdup("__data_loc char[]", GFP_KERNEL);
+			if (!type)
+				break;
+			kfree(fevent->last_arg->type);
+			fevent->last_arg->type = type;
+		}
 		/* Fall through */
 	case FUNC_STATE_ARRAY_END:
 		if (WARN_ON(!fevent->last_arg))
@@ -475,7 +525,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	return FUNC_STATE_END;
 }
 
-static long long get_arg(struct func_arg *arg, unsigned long val)
+static long long __get_arg(struct func_arg *arg, unsigned long val)
 {
 	char buf[8];
 	int ret;
@@ -487,8 +537,8 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
 
 	val = val + (arg->indirect ^ INDIRECT_FLAG);
 
-	/* Arrays do their own indirect reads */
-	if (arg->array)
+	/* Arrays and strings do their own indirect reads */
+	if (arg->array || arg->func_type == FUNC_TYPE_string)
 		return val;
 
 	ret = probe_kernel_read(buf, (void *)val, arg->size);
@@ -512,6 +562,15 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
 	return val;
 }
 
+static long long get_arg(struct func_arg *arg, long *args)
+{
+	/* Is arg an address and not a parameter? */
+	if (arg->arg < 0)
+		return __get_arg(arg, 0);
+	else
+		return __get_arg(arg, args[arg->arg]);
+}
+
 static void get_array(void *dst, struct func_arg *arg, unsigned long val)
 {
 	void *ptr = (void *)val;
@@ -527,6 +586,67 @@ static void get_array(void *dst, struct func_arg *arg, unsigned long val)
 	}
 }
 
+static int read_string(char *str, unsigned long addr)
+{
+	unsigned long flags;
+	struct func_string *strbuf;
+	char *ptr = (void *)addr;
+	char *buf;
+	int ret;
+
+	if (!str_buffer)
+		return 0;
+
+	strbuf = this_cpu_ptr(str_buffer);
+	buf = &strbuf->buf[0];
+
+	if (in_nmi())
+		buf += MAX_STR;
+
+	local_irq_save(flags);
+	ret = strncpy_from_unsafe(buf, ptr, MAX_STR);
+	if (ret < 0)
+		ret = 0;
+	if (ret > 0 && str)
+		memcpy(str, buf, ret);
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static int calculate_strings(struct func_event *func_event, int nr_args, long *args)
+{
+	struct func_arg *arg;
+	unsigned long val;
+	int str_count = 0;
+	int size = 0;
+
+	list_for_each_entry(arg, &func_event->args, list) {
+		if (arg->func_type != FUNC_TYPE_string)
+			continue;
+		if (arg->arg < nr_args)
+			val = get_arg(arg, args);
+		else
+			goto skip;
+		size += read_string(NULL, val);
+ skip:
+		if (++str_count >= func_event->has_strings)
+			return size;
+	}
+	return size;
+}
+
+static int get_string(unsigned long addr, unsigned int idx,
+		      unsigned int *info, char *data)
+{
+	int len;
+
+	len = read_string(data, addr);
+	*info = len << 16 | idx;
+
+	return len;
+}
+
 static void func_event_trace(struct trace_event_file *trace_file,
 			     struct func_event *func_event,
 			     unsigned long ip, unsigned long parent_ip,
@@ -540,6 +660,8 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	long args[func_event->arg_cnt];
 	long long val = 1;
 	unsigned long irq_flags;
+	int str_offset;
+	int str_idx = 0;
 	int nr_args = 0;
 	int size;
 	int pc;
@@ -552,6 +674,12 @@ static void func_event_trace(struct trace_event_file *trace_file,
 
 	size = func_event->arg_offset + sizeof(*entry);
 
+	if (func_event->arg_cnt)
+		nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
+
+	if (func_event->has_strings)
+		size += calculate_strings(func_event, nr_args, args);
+
 	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
 						call->event.type,
 						size, irq_flags, pc);
@@ -561,21 +689,22 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 	entry->parent_ip = parent_ip;
-	if (func_event->arg_cnt)
-		nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
 
 	list_for_each_entry(arg, &func_event->args, list) {
-		if (arg->arg < nr_args) {
-			/* Is arg an address and not a parameter? */
-			if (arg->arg < 0)
-				val = get_arg(arg, 0);
-			else
-				val = get_arg(arg, args[arg->arg]);
-		} else
+		if (arg->arg < nr_args)
+			val = get_arg(arg, args);
+		else
 			val = 0;
 		if (arg->array)
 			get_array(&entry->data[arg->offset], arg, val);
-		else
+		else if (arg->func_type == FUNC_TYPE_string) {
+			str_offset = sizeof(struct func_event_hdr) +
+				func_event->arg_offset;
+
+			str_idx += get_string(val, str_offset + str_idx,
+					      (unsigned int *)&entry->data[arg->offset],
+					      &entry->data[func_event->arg_offset + str_idx]);
+		} else
 			memcpy(&entry->data[arg->offset], &val, arg->size);
 	}
 
@@ -616,6 +745,11 @@ static void make_fmt(struct func_arg *arg, char *fmt)
 
 	fmt[c++] = '%';
 
+	if (arg->func_type == FUNC_TYPE_string) {
+		fmt[c++] = 's';
+		goto out;
+	}
+
 	if (arg->func_type == FUNC_TYPE_char) {
 		if (arg->array)
 			fmt[c++] = 's';
@@ -673,6 +807,7 @@ func_event_print(struct trace_iterator *iter, int flags,
 	char fmt[FMT_SIZE];
 	void *data;
 	bool comma = false;
+	int info;
 	int a;
 
 	entry = (struct func_event_hdr *)iter->ent;
@@ -698,6 +833,11 @@ func_event_print(struct trace_iterator *iter, int flags,
 				comma = true;
 				write_data(s, arg, fmt, data);
 			}
+		} else if (arg->func_type == FUNC_TYPE_string) {
+			info = *(unsigned int *)data;
+			info = (info & 0xffff) - sizeof(struct func_event_hdr);
+			data = &entry->data[info];
+			trace_seq_printf(s, fmt, data);
 		} else
 			write_data(s, arg, fmt, data);
 	}
@@ -872,7 +1012,10 @@ static int __set_print_fmt(struct func_event *func_event,
 				len = update_len(len, i);
 			}
 		} else {
-			i = snprintf(buf + r, len, ", REC->%s", arg->name);
+			if (arg->func_type == FUNC_TYPE_string)
+				i = snprintf(buf + r, len, ", __get_str(%s)", arg->name);
+			else
+				i = snprintf(buf + r, len, ", REC->%s", arg->name);
 			r += i;
 			len = update_len(len, i);
 		}
-- 
2.15.1
