Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeBGUch (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754461AbeBGU2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7499F217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202815.465458548@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:08 -0500
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
Subject: [PATCH 06/20 v2] tracing: Add indirect offset to args of ftrace based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0006-tracing-Add-indirect-offset-to-args-of-ftrace-based-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add '[' ']' syntex to allow to get values indirectly from the arguments.
For example:

 echo replenish_dl_entity(s64 dl_se[4]) > function_events

Will get the 4th long long word from the first parameter like an array.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 32 +++++++++++-
 kernel/trace/trace_event_ftrace.c             | 73 +++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index f27a0c4e829c..7d67229e8e88 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -100,11 +100,15 @@ as follows:
          'x8' | 'x16' | 'x32' | 'x64' |
          'char' | 'short' | 'int' | 'long' | 'size_t'
 
- FIELD := <name>
+ FIELD := <name> | <name> INDEX
+
+ INDEX := '[' <number> ']'
 
  Where <name> is a unique string starting with an alphabetic character
  and consists only of letters and numbers and underscores.
 
+ Where <number> is a number that can be read by kstrtol() (hex, decimal, etc).
+
 
 Simple arguments
 ================
@@ -128,3 +132,29 @@ If we are only interested in the first argument (skb):
 
 We use "x64" in order to make sure that the data is displayed in hex.
 This is on a x86_64 machine, and we know the pointer sizes are 8 bytes.
+
+
+Indexing
+========
+
+The pointers of the skb and the dev isn't that interesting. But if we want the
+length "len" field of skb, we could index it with an index operator '[' and ']'.
+
+Using gdb, we can find the offset of 'len' from the sk_buff type:
+
+ $ gdb vmlinux
+ (gdb) printf "%d\n", &((struct sk_buff *)0)->len
+128
+
+As 128 / 4 (length of int) is 32, we can see the length of the skb with:
+
+ # echo 'ip_rcv(int skb[32], x64 dev)' > function_events
+
+ # echo 1 > events/functions/ip_rcv/enable
+ # cat trace
+    <idle>-0     [003] ..s3   280.167137: __netif_receive_skb_core->ip_rcv(skb=52, dev=ffff8801092f9400)
+    <idle>-0     [003] ..s3   280.167152: __netif_receive_skb_core->ip_rcv(skb=52, dev=ffff8801092f9400)
+    <idle>-0     [003] ..s3   280.806629: __netif_receive_skb_core->ip_rcv(skb=88, dev=ffff8801092f9400)
+    <idle>-0     [003] ..s3   280.807023: __netif_receive_skb_core->ip_rcv(skb=52, dev=ffff8801092f9400)
+
+Now we see the length of the sk_buff per event.
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index be7f5bc416cc..b622634062db 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -10,13 +10,15 @@
 
 #include "trace.h"
 
-#define FUNC_EVENT_SYSTEM "functions"
-#define WRITE_BUFSIZE  4096
+#define FUNC_EVENT_SYSTEM	"functions"
+#define WRITE_BUFSIZE		4096
+#define INDIRECT_FLAG		0x10000000
 
 struct func_arg {
 	struct list_head		list;
 	char				*type;
 	char				*name;
+	long				indirect;
 	short				offset;
 	short				size;
 	char				arg;
@@ -55,6 +57,9 @@ enum func_states {
 	FUNC_STATE_INIT,
 	FUNC_STATE_FUNC,
 	FUNC_STATE_PARAM,
+	FUNC_STATE_BRACKET,
+	FUNC_STATE_BRACKET_END,
+	FUNC_STATE_INDIRECT,
 	FUNC_STATE_TYPE,
 	FUNC_STATE_VAR,
 	FUNC_STATE_COMMA,
@@ -173,6 +178,8 @@ static char *next_token(char **ptr, char *last)
 
 	for (str = arg; *str; str++) {
 		if (*str == '(' ||
+		    *str == '[' ||
+		    *str == ']' ||
 		    *str == ',' ||
 		    *str == ')')
 			break;
@@ -225,6 +232,7 @@ static int add_arg(struct func_event *fevent, int ftype)
 static enum func_states
 process_event(struct func_event *fevent, const char *token, enum func_states state)
 {
+	long val;
 	int ret;
 	int i;
 
@@ -271,12 +279,37 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			break;
 		return FUNC_STATE_VAR;
 
+	case FUNC_STATE_BRACKET:
+		WARN_ON(!fevent->last_arg);
+		ret = kstrtol(token, 0, &val);
+		if (ret)
+			break;
+		val *= fevent->last_arg->size;
+		fevent->last_arg->indirect = val ^ INDIRECT_FLAG;
+		return FUNC_STATE_INDIRECT;
+
+	case FUNC_STATE_INDIRECT:
+		if (token[0] != ']')
+			break;
+		return FUNC_STATE_BRACKET_END;
+
+	case FUNC_STATE_BRACKET_END:
+		switch (token[0]) {
+		case ')':
+			return FUNC_STATE_END;
+		case ',':
+			return FUNC_STATE_COMMA;
+		}
+		break;
+
 	case FUNC_STATE_VAR:
 		switch (token[0]) {
 		case ')':
 			return FUNC_STATE_END;
 		case ',':
 			return FUNC_STATE_COMMA;
+		case '[':
+			return FUNC_STATE_BRACKET;
 		}
 		break;
 
@@ -286,6 +319,37 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	return FUNC_STATE_ERROR;
 }
 
+static long long get_arg(struct func_arg *arg, unsigned long val)
+{
+	char buf[8];
+	int ret;
+
+	if (!arg->indirect)
+		return val;
+
+	val = val + (arg->indirect ^ INDIRECT_FLAG);
+
+	ret = probe_kernel_read(buf, (void *)val, arg->size);
+	if (ret)
+		return 0;
+
+	switch (arg->size) {
+		case 8:
+			val = *(unsigned long long *)buf;
+			break;
+		case 4:
+			val = *(unsigned int *)buf;
+			break;
+		case 2:
+			val = *(unsigned short *)buf;
+			break;
+		case 1:
+			val = *(unsigned char *)buf;
+			break;
+	}
+	return val;
+}
+
 static void func_event_trace(struct trace_event_file *trace_file,
 			     struct func_event *func_event,
 			     unsigned long ip, unsigned long parent_ip,
@@ -325,7 +389,7 @@ static void func_event_trace(struct trace_event_file *trace_file,
 
 	list_for_each_entry(arg, &func_event->args, list) {
 		if (i < nr_args)
-			val = args[i];
+			val = get_arg(arg, args[i]);
 		else
 			val = 0;
 		memcpy(&entry->data[arg->offset], &val, arg->size);
@@ -687,6 +751,9 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 			seq_puts(m, ", ");
 		comma = true;
 		seq_printf(m, "%s %s", arg->type, arg->name);
+		if (arg->indirect && arg->size)
+			seq_printf(m, "[%ld]",
+				   (arg->indirect ^ INDIRECT_FLAG) / arg->size);
 	}
 	seq_puts(m, ")\n");
 
-- 
2.15.1
