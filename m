Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeBBXNQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbeBBXKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:10:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3549217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180202231018.828677654@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 02 Feb 2018 18:05:10 -0500
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
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 12/18] tracing: Add accessing direct address from function based events
References: <20180202230458.840252014@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0012-tracing-Add-accessing-direct-address-from-function-b.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow referencing any address during the function based event. The syntax is
to use <type> <name>=<addr> For example:

 # echo 'do_IRQ(long total_forks=0xffffffffa2a4b4c0)' > function_events
 # echo 1 > events/function/enable
 # cat trace
            sshd-832   [000] d... 221639.210845: ret_from_intr->do_IRQ(total_forks=855)
            sshd-832   [000] d... 221639.211114: ret_from_intr->do_IRQ(total_forks=855)
          <idle>-0     [000] d... 221639.211198: ret_from_intr->do_IRQ(total_forks=855)

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst |  40 +++++++-
 kernel/trace/trace_event_ftrace.c             | 129 +++++++++++++++++++++-----
 2 files changed, 143 insertions(+), 26 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index f18c8f3ef330..b0e6725f3032 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -91,7 +91,7 @@ as follows:
 
  ARGS := ARG | ARG ',' ARGS | ''
 
- ARG := TYPE FIELD | ARG '|' ARG
+ ARG := TYPE FIELD | TYPE <name> '=' ADDR | TYPE ADDR | ARG '|' ARG
 
  TYPE := ATOM | 'unsigned' ATOM
 
@@ -107,6 +107,8 @@ as follows:
 
  OFFSET := '+' <number>
 
+ ADDR := A hexidecimal address starting with '0x'
+
  Where <name> is a unique string starting with an alphabetic character
  and consists only of letters and numbers and underscores.
 
@@ -267,3 +269,39 @@ Again, using gdb to find the offset of the "func" field of struct work_struct
      <idle>-0     [000] dNs3  6241.172004: delayed_work_timer_fn->__queue_work(cpu=128, wq=ffff88011a010800, func=vmstat_shepherd+0x0/0xb0)
  worker/0:2-1689  [000] d..2  6241.172026: __queue_delayed_work->__queue_work(cpu=7, wq=ffff88011a11da00, func=vmstat_update+0x0/0x70)
      <idle>-0     [005] d.s3  6241.347996: queue_work_on->__queue_work(cpu=128, wq=ffff88011a011200, func=fb_flashcursor+0x0/0x110 [fb])
+
+
+Direct memory access
+====================
+
+Function arguments are not the only thing that can be recorded from a function
+based event. Memory addresses can also be examined. If there's a global variable
+that you want to monitor via an interrupt, you can put in the address directly.
+
+  # grep total_forks /proc/kallsyms
+ffffffff82354c18 B total_forks
+
+  # echo 'do_IRQ(int total_forks=0xffffffff82354c18)' > function_events
+
+  # echo 1 events/functions/do_IRQ/enable
+  # cat trace
+    <idle>-0     [003] d..3   337.076709: ret_from_intr->do_IRQ(total_forks=1419)
+    <idle>-0     [003] d..3   337.077046: ret_from_intr->do_IRQ(total_forks=1419)
+    <idle>-0     [003] d..3   337.077076: ret_from_intr->do_IRQ(total_forks=1420)
+
+Note, address notations do not affect the argument count. For instance, with
+
+__visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
+
+  # echo 'do_IRQ(int total_forks=0xffffffff82354c18, symbol regs[16])' > function_events
+
+Is the same as
+
+  # echo 'do_IRQ(int total_forks=0xffffffff82354c18 | symbol regs[16])' > function_events
+
+  # cat trace
+    <idle>-0     [003] d..3   653.839546: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
+    <idle>-0     [003] d..3   653.906011: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
+    <idle>-0     [003] d..3   655.823498: ret_from_intr->do_IRQ(total_forks=1504, regs=tick_nohz_idle_enter+0x4c/0x50)
+    <idle>-0     [003] d..3   655.954096: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
+
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index ba10177b9bd6..206114f192be 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -63,6 +63,8 @@ enum func_states {
 	FUNC_STATE_BRACKET_END,
 	FUNC_STATE_INDIRECT,
 	FUNC_STATE_UNSIGNED,
+	FUNC_STATE_ADDR,
+	FUNC_STATE_EQUAL,
 	FUNC_STATE_PIPE,
 	FUNC_STATE_PLUS,
 	FUNC_STATE_TYPE,
@@ -199,6 +201,7 @@ static char *next_token(char **ptr, char *last)
 		    *str == ',' ||
 		    *str == '|' ||
 		    *str == '+' ||
+		    *str == '=' ||
 		    *str == ')')
 			break;
 	}
@@ -243,12 +246,39 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
 		arg->sign = func_type->sign;
 	arg->offset = ALIGN(fevent->arg_offset, arg->size);
 	arg->func_type = ftype;
-	arg->arg = fevent->arg_cnt;
 	fevent->arg_offset = arg->offset + arg->size;
 
 	list_add_tail(&arg->list, &fevent->args);
 	fevent->last_arg = arg;
-	fevent->arg_cnt++;
+
+	return 0;
+}
+
+static int update_arg_name(struct func_event *fevent, const char *name)
+{
+	struct func_arg *arg = fevent->last_arg;
+
+	if (WARN_ON(!arg))
+		return -EINVAL;
+
+	arg->name = kstrdup(name, GFP_KERNEL);
+	if (!arg->name)
+		return -ENOMEM;
+	return 0;
+}
+
+static int update_arg_arg(struct func_event *fevent)
+{
+	struct func_arg *arg = fevent->last_arg;
+
+	if (WARN_ON(!arg))
+		return -EINVAL;
+
+	/* Make sure the arch can support this many args */
+	if (fevent->arg_cnt >= arch_get_func_args(NULL, 0, 0, NULL))
+		return -EINVAL;
+
+	arg->arg = fevent->arg_cnt;
 
 	return 0;
 }
@@ -256,14 +286,16 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
 static enum func_states
 process_event(struct func_event *fevent, const char *token, enum func_states state)
 {
+	static bool update_arg;
 	static int unsign;
-	long val;
+	unsigned long val;
 	int ret;
 	int i;
 
 	switch (state) {
 	case FUNC_STATE_INIT:
 		unsign = 0;
+		update_arg = false;
 		if (!isalpha(token[0]) && token[0] != '_')
 			break;
 		/* Do not allow wild cards */
@@ -279,15 +311,15 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			break;
 		return FUNC_STATE_PARAM;
 
-	case FUNC_STATE_PIPE:
-		fevent->arg_cnt--;
-		goto comma;
 	case FUNC_STATE_PARAM:
 		if (token[0] == ')')
 			return FUNC_STATE_END;
 		/* Fall through */
 	case FUNC_STATE_COMMA:
- comma:
+		if (update_arg)
+			fevent->arg_cnt++;
+		update_arg = false;
+	case FUNC_STATE_PIPE:
 		if (strcmp(token, "unsigned") == 0) {
 			unsign = 2;
 			return FUNC_STATE_UNSIGNED;
@@ -307,18 +339,20 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		return FUNC_STATE_TYPE;
 
 	case FUNC_STATE_TYPE:
-		if (!isalpha(token[0]) || token[0] == '_')
-			break;
 		if (WARN_ON(!fevent->last_arg))
 			break;
-		fevent->last_arg->name = kstrdup(token, GFP_KERNEL);
-		if (!fevent->last_arg->name)
+		if (update_arg_name(fevent, token) < 0)
+			break;
+		if (strncmp(token, "0x", 2) == 0)
+			goto equal;
+		if (!isalpha(token[0]) && token[0] != '_')
 			break;
+		update_arg = true;
 		return FUNC_STATE_VAR;
 
 	case FUNC_STATE_BRACKET:
 		WARN_ON(!fevent->last_arg);
-		ret = kstrtol(token, 0, &val);
+		ret = kstrtoul(token, 0, &val);
 		if (ret)
 			break;
 		val *= fevent->last_arg->size;
@@ -333,7 +367,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	case FUNC_STATE_BRACKET_END:
 		switch (token[0]) {
 		case ')':
-			return FUNC_STATE_END;
+			goto end;
 		case ',':
 			return FUNC_STATE_COMMA;
 		case '|':
@@ -344,16 +378,33 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	case FUNC_STATE_PLUS:
 		if (WARN_ON(!fevent->last_arg))
 			break;
-		ret = kstrtol(token, 0, &val);
+		ret = kstrtoul(token, 0, &val);
 		if (ret)
 			break;
 		fevent->last_arg->index += val;
 		return FUNC_STATE_VAR;
 
+	case FUNC_STATE_ADDR:
+		switch (token[0]) {
+		case ')':
+			goto end;
+		case ',':
+			return FUNC_STATE_COMMA;
+		case '|':
+			return FUNC_STATE_PIPE;
+		}
+		break;
+
 	case FUNC_STATE_VAR:
+		if (token[0] == '=')
+			return FUNC_STATE_EQUAL;
+		if (WARN_ON(!fevent->last_arg))
+			break;
+		update_arg_arg(fevent);
+		update_arg = true;
 		switch (token[0]) {
 		case ')':
-			return FUNC_STATE_END;
+			goto end;
 		case ',':
 			return FUNC_STATE_COMMA;
 		case '|':
@@ -365,10 +416,29 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		}
 		break;
 
+	case FUNC_STATE_EQUAL:
+		if (strncmp(token, "0x", 2) != 0)
+			break;
+ equal:
+		if (WARN_ON(!fevent->last_arg))
+			break;
+		ret = kstrtoul(token, 0, &val);
+		if (ret < 0)
+			break;
+		update_arg = false;
+		fevent->last_arg->index = val;
+		fevent->last_arg->arg = -1;
+		fevent->last_arg->indirect = INDIRECT_FLAG;
+		return FUNC_STATE_ADDR;
+
 	default:
 		break;
 	}
 	return FUNC_STATE_ERROR;
+ end:
+	if (update_arg)
+		fevent->arg_cnt++;
+	return FUNC_STATE_END;
 }
 
 static long long get_arg(struct func_arg *arg, unsigned long val)
@@ -417,7 +487,7 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	long args[func_event->arg_cnt];
 	long long val = 1;
 	unsigned long irq_flags;
-	int nr_args;
+	int nr_args = 0;
 	int size;
 	int pc;
 
@@ -438,12 +508,17 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 	entry->parent_ip = parent_ip;
-	nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
+	if (func_event->arg_cnt)
+		nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
 
 	list_for_each_entry(arg, &func_event->args, list) {
-		if (arg->arg < nr_args)
-			val = get_arg(arg, args[arg->arg]);
-		else
+		if (arg->arg < nr_args) {
+			/* Is arg an address and not a parameter? */
+			if (arg->arg < 0)
+				val = get_arg(arg, 0);
+			else
+				val = get_arg(arg, args[arg->arg]);
+		} else
 			val = 0;
 		memcpy(&entry->data[arg->offset], &val, arg->size);
 	}
@@ -815,11 +890,15 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 		last_arg = arg->arg;
 		comma = true;
 		seq_printf(m, "%s %s", arg->type, arg->name);
-		if (arg->index)
-			seq_printf(m, "+%ld", arg->index);
-		if (arg->indirect && arg->size)
-			seq_printf(m, "[%ld]",
-				   (arg->indirect ^ INDIRECT_FLAG) / arg->size);
+		if (arg->arg < 0) {
+			seq_printf(m, "=0x%lx", arg->index);
+		} else {
+			if (arg->index)
+				seq_printf(m, "+%ld", arg->index);
+			if (arg->indirect && arg->size)
+				seq_printf(m, "[%ld]",
+					   (arg->indirect ^ INDIRECT_FLAG) / arg->size);
+		}
 	}
 	seq_puts(m, ")\n");
 
-- 
2.15.1
