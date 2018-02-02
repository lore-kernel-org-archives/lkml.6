Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeBBXNi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752071AbeBBXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:10:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4FB217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180202231018.481870614@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 02 Feb 2018 18:05:08 -0500
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
Subject: [PATCH 10/18] tracing: Make func_type enums for easier comparing of arg types
References: <20180202230458.840252014@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0010-tracing-Make-func_type-enums-for-easier-comparing-of.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

For the function based event args, knowing quickly what type they are is
advantageous, as decisions can be made quickly based on them. Having an
enum for the types is useful for this purpose.

Use macros to create both the func_type array as well as enums that
match the type to the index into that array.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_ftrace.c | 47 +++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 4c23fa18453d..0f2650e97e49 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -24,6 +24,7 @@ struct func_arg {
 	short				size;
 	s8				arg;
 	u8				sign;
+	u8				func_type;
 };
 
 struct func_event {
@@ -79,31 +80,42 @@ typedef u8 x8;
 #define TYPE_TUPLE(type)			\
 	{ #type, sizeof(type), is_signed_type(type) }
 
+#define FUNC_TYPES				\
+	TYPE_TUPLE(long),			\
+	TYPE_TUPLE(int),			\
+	TYPE_TUPLE(short),			\
+	TYPE_TUPLE(char),			\
+	TYPE_TUPLE(size_t),			\
+	TYPE_TUPLE(u64),			\
+	TYPE_TUPLE(s64),			\
+	TYPE_TUPLE(x64),			\
+	TYPE_TUPLE(u32),			\
+	TYPE_TUPLE(s32),			\
+	TYPE_TUPLE(x32),			\
+	TYPE_TUPLE(u16),			\
+	TYPE_TUPLE(s16),			\
+	TYPE_TUPLE(x16),			\
+	TYPE_TUPLE(u8),				\
+	TYPE_TUPLE(s8),				\
+	TYPE_TUPLE(x8)
+
 static struct func_type {
 	char		*name;
 	int		size;
 	int		sign;
 } func_types[] = {
-	TYPE_TUPLE(long),
-	TYPE_TUPLE(int),
-	TYPE_TUPLE(short),
-	TYPE_TUPLE(char),
-	TYPE_TUPLE(size_t),
-	TYPE_TUPLE(u64),
-	TYPE_TUPLE(s64),
-	TYPE_TUPLE(x64),
-	TYPE_TUPLE(u32),
-	TYPE_TUPLE(s32),
-	TYPE_TUPLE(x32),
-	TYPE_TUPLE(u16),
-	TYPE_TUPLE(s16),
-	TYPE_TUPLE(x16),
-	TYPE_TUPLE(u8),
-	TYPE_TUPLE(s8),
-	TYPE_TUPLE(x8),
+	FUNC_TYPES,
 	{ NULL,		0,	0 }
 };
 
+#undef TYPE_TUPLE
+#define TYPE_TUPLE(type)	FUNC_TYPE_##type
+
+enum {
+	FUNC_TYPES,
+	FUNC_TYPE_MAX
+};
+
 /**
  * arch_get_func_args - retrieve function arguments via pt_regs
  * @regs: The registers at the moment the function is called
@@ -228,6 +240,7 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
 	if (!unsign)
 		arg->sign = func_type->sign;
 	arg->offset = ALIGN(fevent->arg_offset, arg->size);
+	arg->func_type = ftype;
 	arg->arg = fevent->arg_cnt;
 	fevent->arg_offset = arg->offset + arg->size;
 
-- 
2.15.1
