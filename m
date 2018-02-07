Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbeBGUcd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeBGU2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4912217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202815.903071487@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:10 -0500
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
Subject: [PATCH 08/20 v2] tracing: Add "unsigned" to function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0008-tracing-Add-unsigned-to-function-based-events.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add "unsigned" to the format processing to creating dynamic function based
events. For example: "unsigned long" now works.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 47 ++++++++++++++++++++++++++-
 kernel/trace/trace_event_ftrace.c             | 23 ++++++++++---
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 2a002c8a500b..72e3e7730d63 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -93,7 +93,7 @@ as follows:
 
  ARG := TYPE FIELD | ARG '|' ARG
 
- TYPE := ATOM
+ TYPE := ATOM | 'unsigned' ATOM
 
  ATOM := 'u8' | 'u16' | 'u32' | 'u64' |
          's8' | 's16' | 's32' | 's64' |
@@ -176,3 +176,48 @@ an argument:
     <idle>-0     [003] ..s3   904.075848: __netif_receive_skb_core->ip_rcv(skb=ffff88011396e800, skb=52, dev=ffff880115204000)
     <idle>-0     [003] ..s3   904.725486: __netif_receive_skb_core->ip_rcv(skb=ffff88011396e800, skb=194, dev=ffff880115204000)
     <idle>-0     [003] ..s3   905.152537: __netif_receive_skb_core->ip_rcv(skb=ffff88011396f200, skb=88, dev=ffff880115204000)
+
+
+Unsigned usage
+==============
+
+One can also use "unsigned" to make some types unsigned. It works against
+"long", "int", "short" and "char". It doesn't error against other types but
+may not make any sense.
+
+ # echo 'ip_rcv(int skb[32])' > function_events
+ # cat events/functions/ip_rcv/format
+name: ip_rcv
+ID: 1397
+format:
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+	field:unsigned long __parent_ip;	offset:8;	size:8;	signed:0;
+	field:unsigned long __ip;	offset:16;	size:8;	signed:0;
+	field:int skb;	offset:24;	size:4;	signed:1;
+
+print fmt: "%pS->%pS(skb=%d)", REC->__ip, REC->__parent_ip, REC->skb
+
+
+Notice that REC->skb is printed with "%d". By adding "unsigned"
+
+ # echo 'ip_rcv(unsigned int skb[32])' > function_events
+ # cat events/functions/ip_rcv/format
+name: ip_rcv
+ID: 1398
+format:
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+	field:unsigned long __parent_ip;	offset:8;	size:8;	signed:0;
+	field:unsigned long __ip;	offset:16;	size:8;	signed:0;
+	field:unsigned int skb;	offset:24;	size:4;	signed:0;
+
+print fmt: "%pS->%pS(skb=%u)", REC->__ip, REC->__parent_ip, REC->skb
+
+It is now printed with a "%u".
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 666edd76b70f..8327346799eb 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -60,6 +60,7 @@ enum func_states {
 	FUNC_STATE_BRACKET,
 	FUNC_STATE_BRACKET_END,
 	FUNC_STATE_INDIRECT,
+	FUNC_STATE_UNSIGNED,
 	FUNC_STATE_PIPE,
 	FUNC_STATE_TYPE,
 	FUNC_STATE_VAR,
@@ -200,7 +201,7 @@ static char *next_token(char **ptr, char *last)
 	return arg;
 }
 
-static int add_arg(struct func_event *fevent, int ftype)
+static int add_arg(struct func_event *fevent, int ftype, int unsign)
 {
 	struct func_type *func_type = &func_types[ftype];
 	struct func_arg *arg;
@@ -213,13 +214,18 @@ static int add_arg(struct func_event *fevent, int ftype)
 	if (!arg)
 		return -ENOMEM;
 
-	arg->type = kstrdup(func_type->name, GFP_KERNEL);
+	if (unsign)
+		arg->type = kasprintf(GFP_KERNEL, "unsigned %s",
+				      func_type->name);
+	else
+		arg->type = kstrdup(func_type->name, GFP_KERNEL);
 	if (!arg->type) {
 		kfree(arg);
 		return -ENOMEM;
 	}
 	arg->size = func_type->size;
-	arg->sign = func_type->sign;
+	if (!unsign)
+		arg->sign = func_type->sign;
 	arg->offset = ALIGN(fevent->arg_offset, arg->size);
 	arg->arg = fevent->arg_cnt;
 	fevent->arg_offset = arg->offset + arg->size;
@@ -234,12 +240,14 @@ static int add_arg(struct func_event *fevent, int ftype)
 static enum func_states
 process_event(struct func_event *fevent, const char *token, enum func_states state)
 {
+	static int unsign;
 	long val;
 	int ret;
 	int i;
 
 	switch (state) {
 	case FUNC_STATE_INIT:
+		unsign = 0;
 		if (!isalpha(token[0]))
 			break;
 		/* Do not allow wild cards */
@@ -264,13 +272,20 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		/* Fall through */
 	case FUNC_STATE_COMMA:
  comma:
+		if (strcmp(token, "unsigned") == 0) {
+			unsign = 2;
+			return FUNC_STATE_UNSIGNED;
+		}
+		/* Fall through */
+	case FUNC_STATE_UNSIGNED:
 		for (i = 0; func_types[i].size; i++) {
 			if (strcmp(token, func_types[i].name) == 0)
 				break;
 		}
 		if (!func_types[i].size)
 			break;
-		ret = add_arg(fevent, i);
+		ret = add_arg(fevent, i, unsign);
+		unsign = 0;
 		if (ret < 0)
 			break;
 		return FUNC_STATE_TYPE;
-- 
2.15.1
