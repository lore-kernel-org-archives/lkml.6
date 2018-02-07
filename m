Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbeBGU3O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754700AbeBGU2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F286217B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202817.079707737@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:18 -0500
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
Subject: [PATCH 16/20 v2] tracing: Add NULL to skip args for function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0016-tracing-Add-NULL-to-skip-args-for-function-based-eve.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If args are to be skipped (only care about second, third or later arguments)
then add a NULL to ignore them. For example, if one only wants to record the
third argument of a function, they can perform:

 echo foo(NULL, NULL, u32 arg3) > function_events

Then only the third argument is saved in the function based event.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 28 +++++++++++++++++++++-
 kernel/trace/trace_event_ftrace.c             | 34 ++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 6c643ea749e7..b90b52b7061d 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -91,7 +91,7 @@ as follows:
 
  ARGS := ARG | ARG ',' ARGS | ''
 
- ARG := TYPE FIELD | TYPE <name> '=' ADDR | TYPE ADDR | ARG '|' ARG
+ ARG := TYPE FIELD | TYPE <name> '=' ADDR | TYPE ADDR | ARG '|' ARG | 'NULL'
 
  TYPE := ATOM | ATOM '[' <number> ']' | 'unsigned' TYPE
 
@@ -359,3 +359,29 @@ it will be truncated.
  # echo 'link_path_walk(string name)' > function_events
 
 Gives the same result as above, but does not waste buffer space.
+
+
+NULL arguments
+==============
+
+If you are only interested in the second, or later parameter of a function,
+you do not have to record the previous parameters. Just set them as NULL and
+they will not be recorded.
+
+If we only wanted the perm_addr of the net_device of ip_rcv() and not the
+sk_buff, we put a NULL into the first parameter when created the function
+based event.
+
+  # echo 'ip_rcv(NULL, x8[6] perm_addr+558)' > function_events
+
+  # echo 1 > events/functions/ip_rcv/enable
+  # cat trace
+    <idle>-0     [003] ..s3   165.617114: __netif_receive_skb_core->ip_rcv(perm_addr=b4,b5,2f,ce,18,65)
+    <idle>-0     [003] ..s3   165.617133: __netif_receive_skb_core->ip_rcv(perm_addr=b4,b5,2f,ce,18,65)
+    <idle>-0     [003] ..s3   166.412277: __netif_receive_skb_core->ip_rcv(perm_addr=b4,b5,2f,ce,18,65)
+    <idle>-0     [003] ..s3   166.412797: __netif_receive_skb_core->ip_rcv(perm_addr=b4,b5,2f,ce,18,65)
+
+
+NULL can appear in any argument, to have them ignored. Note, skipping arguments
+does not give you access to later arguments if they are not supported by the
+architecture. The architecture only supplies the first set of arguments.
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 50d0c4d32596..673e2d963319 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -75,6 +75,7 @@ enum func_states {
 	FUNC_STATE_ARRAY_END,
 	FUNC_STATE_VAR,
 	FUNC_STATE_COMMA,
+	FUNC_STATE_NULL,
 	FUNC_STATE_END,
 	FUNC_STATE_ERROR,
 };
@@ -117,6 +118,7 @@ static struct func_type {
 	int		sign;
 } func_types[] = {
 	FUNC_TYPES,
+	{ "NULL",	0,	0 },
 	{ NULL,		0,	0 }
 };
 
@@ -125,6 +127,7 @@ static struct func_type {
 
 enum {
 	FUNC_TYPES,
+	FUNC_TYPE_NULL,
 	FUNC_TYPE_MAX
 };
 
@@ -366,6 +369,8 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			fevent->arg_cnt++;
 		update_arg = false;
 	case FUNC_STATE_PIPE:
+		if (strcmp(token, "NULL") == 0)
+			return FUNC_STATE_NULL;
 		if (strcmp(token, "unsigned") == 0) {
 			unsign = 2;
 			return FUNC_STATE_UNSIGNED;
@@ -515,6 +520,19 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		fevent->last_arg->indirect = INDIRECT_FLAG;
 		return FUNC_STATE_ADDR;
 
+	case FUNC_STATE_NULL:
+		ret = add_arg(fevent, FUNC_TYPE_NULL, 0);
+		if (ret < 0)
+			break;
+		switch (token[0]) {
+		case ')':
+			goto end;
+		case ',':
+			update_arg = true;
+			return FUNC_STATE_COMMA;
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -691,6 +709,8 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	entry->parent_ip = parent_ip;
 
 	list_for_each_entry(arg, &func_event->args, list) {
+		if (arg->func_type == FUNC_TYPE_NULL)
+			continue;
 		if (arg->arg < nr_args)
 			val = get_arg(arg, args);
 		else
@@ -817,6 +837,8 @@ func_event_print(struct trace_iterator *iter, int flags,
 	trace_seq_printf(s, "%ps->%ps(",
 			 (void *)entry->parent_ip, (void *)entry->ip);
 	list_for_each_entry(arg, &func_event->args, list) {
+		if (arg->func_type == FUNC_TYPE_NULL)
+			continue;
 		if (comma)
 			trace_seq_puts(s, ", ");
 		comma = true;
@@ -864,6 +886,9 @@ static int func_event_define_fields(struct trace_event_call *event_call)
 	list_for_each_entry(arg, &fevent->args, list) {
 		int size = arg->size;
 
+		if (arg->func_type == FUNC_TYPE_NULL)
+			continue;
+
 		if (arg->array)
 			size *= arg->array;
 		ret = trace_define_field(event_call, arg->type,
@@ -966,6 +991,8 @@ static int __set_print_fmt(struct func_event *func_event,
 	r = snprintf(buf, len, "%s", fmt_start);
 	len = update_len(len, r);
 	list_for_each_entry(arg, &func_event->args, list) {
+		if (arg->func_type == FUNC_TYPE_NULL)
+			continue;
 		if (comma) {
 			i = snprintf(buf + r, len, ", ");
 			r += i;
@@ -1004,6 +1031,8 @@ static int __set_print_fmt(struct func_event *func_event,
 	len = update_len(len, i);
 
 	list_for_each_entry(arg, &func_event->args, list) {
+		if (arg->func_type == FUNC_TYPE_NULL)
+			continue;
 		/* Don't iterate for strings */
 		if (arg->array && arg->func_type != FUNC_TYPE_char) {
 			for (a = 0; a < arg->array; a++) {
@@ -1150,7 +1179,10 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 		}
 		last_arg = arg->arg;
 		comma = true;
-		seq_printf(m, "%s %s", arg->type, arg->name);
+		if (arg->func_type == FUNC_TYPE_NULL)
+			seq_puts(m, "NULL");
+		else
+			seq_printf(m, "%s %s", arg->type, arg->name);
 		if (arg->arg < 0) {
 			seq_printf(m, "=0x%lx", arg->index);
 		} else {
-- 
2.15.1
