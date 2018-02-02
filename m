Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeBBXPI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeBBXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:10:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F121F217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180202231018.043996474@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 02 Feb 2018 18:05:05 -0500
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
Subject: [PATCH 07/18] tracing: Add dereferencing multiple fields per arg
References: <20180202230458.840252014@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0007-tracing-Add-dereferencing-multiple-fields-per-arg.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As an argument may be a structure or an array, we may want to dereference
more than one field per argument. Create a pipe '|' token to the parsing
that allows to reference multipe dereference fields per function argument.

Change func_arg fields from char to s8 or u8 to allow them to be
subscripts to arrays.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 20 +++++++++++++++++-
 kernel/trace/trace_event_ftrace.c             | 29 ++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 7d67229e8e88..2a002c8a500b 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -91,7 +91,7 @@ as follows:
 
  ARGS := ARG | ARG ',' ARGS | ''
 
- ARG := TYPE FIELD
+ ARG := TYPE FIELD | ARG '|' ARG
 
  TYPE := ATOM
 
@@ -158,3 +158,21 @@ As 128 / 4 (length of int) is 32, we can see the length of the skb with:
     <idle>-0     [003] ..s3   280.807023: __netif_receive_skb_core->ip_rcv(skb=52, dev=ffff8801092f9400)
 
 Now we see the length of the sk_buff per event.
+
+
+Multiple fields per argument
+============================
+
+
+If we still want to see the skb pointer value along with the length of the
+skb, then using the '|' option allows us to add more than one option to
+an argument:
+
+ # echo 'ip_rcv(x64 skb | int skb[32], x64 dev)' > function_events
+
+ # echo 1 > events/functions/ip_rcv/enable
+ # cat trace
+    <idle>-0     [003] ..s3   904.075838: __netif_receive_skb_core->ip_rcv(skb=ffff88011396e800, skb=52, dev=ffff880115204000)
+    <idle>-0     [003] ..s3   904.075848: __netif_receive_skb_core->ip_rcv(skb=ffff88011396e800, skb=52, dev=ffff880115204000)
+    <idle>-0     [003] ..s3   904.725486: __netif_receive_skb_core->ip_rcv(skb=ffff88011396e800, skb=194, dev=ffff880115204000)
+    <idle>-0     [003] ..s3   905.152537: __netif_receive_skb_core->ip_rcv(skb=ffff88011396f200, skb=88, dev=ffff880115204000)
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 5d37498d1c6b..8c9d4a92deab 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -21,8 +21,8 @@ struct func_arg {
 	long				indirect;
 	short				offset;
 	short				size;
-	char				arg;
-	char				sign;
+	s8				arg;
+	u8				sign;
 };
 
 struct func_event {
@@ -60,6 +60,7 @@ enum func_states {
 	FUNC_STATE_BRACKET,
 	FUNC_STATE_BRACKET_END,
 	FUNC_STATE_INDIRECT,
+	FUNC_STATE_PIPE,
 	FUNC_STATE_TYPE,
 	FUNC_STATE_VAR,
 	FUNC_STATE_COMMA,
@@ -179,6 +180,7 @@ static char *next_token(char **ptr, char *last)
 		    *str == '[' ||
 		    *str == ']' ||
 		    *str == ',' ||
+		    *str == '|' ||
 		    *str == ')')
 			break;
 	}
@@ -251,11 +253,15 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			break;
 		return FUNC_STATE_PARAM;
 
+	case FUNC_STATE_PIPE:
+		fevent->arg_cnt--;
+		goto comma;
 	case FUNC_STATE_PARAM:
 		if (token[0] == ')')
 			return FUNC_STATE_END;
 		/* Fall through */
 	case FUNC_STATE_COMMA:
+ comma:
 		for (i = 0; func_types[i].size; i++) {
 			if (strcmp(token, func_types[i].name) == 0)
 				break;
@@ -297,6 +303,8 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			return FUNC_STATE_END;
 		case ',':
 			return FUNC_STATE_COMMA;
+		case '|':
+			return FUNC_STATE_PIPE;
 		}
 		break;
 
@@ -306,6 +314,8 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			return FUNC_STATE_END;
 		case ',':
 			return FUNC_STATE_COMMA;
+		case '|':
+			return FUNC_STATE_PIPE;
 		case '[':
 			return FUNC_STATE_BRACKET;
 		}
@@ -364,7 +374,6 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	int nr_args;
 	int size;
 	int pc;
-	int i = 0;
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
@@ -386,8 +395,8 @@ static void func_event_trace(struct trace_event_file *trace_file,
 	nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
 
 	list_for_each_entry(arg, &func_event->args, list) {
-		if (i < nr_args)
-			val = get_arg(arg, args[i]);
+		if (arg->arg < nr_args)
+			val = get_arg(arg, args[arg->arg]);
 		else
 			val = 0;
 		memcpy(&entry->data[arg->offset], &val, arg->size);
@@ -741,12 +750,18 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 	struct func_event *func_event = v;
 	struct func_arg *arg;
 	bool comma = false;
+	int last_arg = 0;
 
 	seq_printf(m, "%s(", func_event->func);
 
 	list_for_each_entry(arg, &func_event->args, list) {
-		if (comma)
-			seq_puts(m, ", ");
+		if (comma) {
+			if (last_arg == arg->arg)
+				seq_puts(m, " | ");
+			else
+				seq_puts(m, ", ");
+		}
+		last_arg = arg->arg;
 		comma = true;
 		seq_printf(m, "%s %s", arg->type, arg->name);
 		if (arg->indirect && arg->size)
-- 
2.15.1
