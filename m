Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeBGUbH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754670AbeBGU2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F5E217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202816.348135328@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:13 -0500
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
Subject: [PATCH 11/20 v2] tracing: Add symbol type to function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0011-tracing-Add-symbol-type-to-function-based-events.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a special type "symbol" that will use %pS to display the field of a
function based event.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 26 +++++++++++++++++++++++++-
 kernel/trace/trace_event_ftrace.c             | 13 ++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index bdb28f433bfb..f18c8f3ef330 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -98,7 +98,8 @@ as follows:
  ATOM := 'u8' | 'u16' | 'u32' | 'u64' |
          's8' | 's16' | 's32' | 's64' |
          'x8' | 'x16' | 'x32' | 'x64' |
-         'char' | 'short' | 'int' | 'long' | 'size_t'
+         'char' | 'short' | 'int' | 'long' | 'size_t' |
+	 'symbol'
 
  FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX
 
@@ -243,3 +244,26 @@ The above will take the parameter value, add it by 4, then index it by two
 8 byte words. It's the same in C as: (u64 *)((void *)param + 4)[2]
 
  Note: "int skb[32]" is the same as "int skb+4[31]".
+
+
+Symbols (function names)
+========================
+
+To display kallsyms "%pS" type of output, use the special type "symbol".
+
+Again, using gdb to find the offset of the "func" field of struct work_struct
+
+(gdb) printf "%d\n", &((struct work_struct *)0)->func
+24
+
+ Both "symbol func[3]" and "symbol func+24[0]" will work.
+
+ # echo '__queue_work(int cpu, x64 wq, symbol func[3])' > function_events
+
+ # echo 1 > events/functions/__queue_work/enable
+ # cat trace
+       bash-1641  [007] d..2  6241.171332: queue_work_on->__queue_work(cpu=128, wq=ffff88011a010e00, func=flush_to_ldisc+0x0/0xa0)
+       bash-1641  [007] d..2  6241.171460: queue_work_on->__queue_work(cpu=128, wq=ffff88011a010e00, func=flush_to_ldisc+0x0/0xa0)
+     <idle>-0     [000] dNs3  6241.172004: delayed_work_timer_fn->__queue_work(cpu=128, wq=ffff88011a010800, func=vmstat_shepherd+0x0/0xb0)
+ worker/0:2-1689  [000] d..2  6241.172026: __queue_delayed_work->__queue_work(cpu=7, wq=ffff88011a11da00, func=vmstat_update+0x0/0x70)
+     <idle>-0     [005] d.s3  6241.347996: queue_work_on->__queue_work(cpu=128, wq=ffff88011a011200, func=fb_flashcursor+0x0/0x110 [fb])
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 6e48361643c0..1359f714a1b1 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -76,6 +76,7 @@ typedef u64 x64;
 typedef u32 x32;
 typedef u16 x16;
 typedef u8 x8;
+typedef void * symbol;
 
 #define TYPE_TUPLE(type)			\
 	{ #type, sizeof(type), is_signed_type(type) }
@@ -97,7 +98,8 @@ typedef u8 x8;
 	TYPE_TUPLE(x16),			\
 	TYPE_TUPLE(u8),				\
 	TYPE_TUPLE(s8),				\
-	TYPE_TUPLE(x8)
+	TYPE_TUPLE(x8),				\
+	TYPE_TUPLE(symbol)
 
 static struct func_type {
 	char		*name;
@@ -264,7 +266,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	switch (state) {
 	case FUNC_STATE_INIT:
 		unsign = 0;
-		if (!isalpha(token[0]))
+		if (!isalpha(token[0]) && token[0] != '_')
 			break;
 		/* Do not allow wild cards */
 		if (strstr(token, "*") || strstr(token, "?"))
@@ -307,7 +309,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		return FUNC_STATE_TYPE;
 
 	case FUNC_STATE_TYPE:
-		if (!isalpha(token[0]))
+		if (!isalpha(token[0]) || token[0] == '_')
 			break;
 		if (WARN_ON(!fevent->last_arg))
 			break;
@@ -478,6 +480,11 @@ static void make_fmt(struct func_arg *arg, char *fmt)
 {
 	int c = 0;
 
+	if (arg->func_type == FUNC_TYPE_symbol) {
+		strcpy(fmt, "%pS");
+		return;
+	}
+
 	fmt[c++] = '%';
 
 	if (arg->size == 8) {
-- 
2.15.1
