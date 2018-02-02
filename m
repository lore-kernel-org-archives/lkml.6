Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeBBXNx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeBBXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:10:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8FD2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180202231018.338259949@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 02 Feb 2018 18:05:07 -0500
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
Subject: [PATCH 09/18] tracing: Add indexing of arguments for function based events
References: <20180202230458.840252014@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0009-tracing-Add-indexing-of-arguments-for-function-based.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently reading of 8 byte words can only happen 8 bytes aligned from the
argument. But there may be cases that they are 4 bytes aligned. To make the
capturing of arguments more flexible, add a plus '+' operator that can index
the variable at arbitrary indexes to get any location.

 u64 arg+4[3]

Will get an 8 byte word at index 28 (3 * 8 + 4)

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 24 +++++++++++++++++++++++-
 kernel/trace/trace_event_ftrace.c             | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 72e3e7730d63..bdb28f433bfb 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -100,10 +100,12 @@ as follows:
          'x8' | 'x16' | 'x32' | 'x64' |
          'char' | 'short' | 'int' | 'long' | 'size_t'
 
- FIELD := <name> | <name> INDEX
+ FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX
 
  INDEX := '[' <number> ']'
 
+ OFFSET := '+' <number>
+
  Where <name> is a unique string starting with an alphabetic character
  and consists only of letters and numbers and underscores.
 
@@ -221,3 +223,23 @@ format:
 print fmt: "%pS->%pS(skb=%u)", REC->__ip, REC->__parent_ip, REC->skb
 
 It is now printed with a "%u".
+
+
+Offsets
+=======
+
+After the name of the variable, brackets '[' number ']' will index the value of
+the argument by the number given times the size of the field.
+
+ int field[5] will dereference the value of the argument 20 bytes away (4 * 5)
+  as sizeof(int) is 4.
+
+If there's a case where the type is of 8 bytes in size but is not 8 bytes
+alligned in the structure, an offset may be required.
+
+  For example: x64 param+4[2]
+
+The above will take the parameter value, add it by 4, then index it by two
+8 byte words. It's the same in C as: (u64 *)((void *)param + 4)[2]
+
+ Note: "int skb[32]" is the same as "int skb+4[31]".
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 9548b93eb8cd..4c23fa18453d 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -19,6 +19,7 @@ struct func_arg {
 	char				*type;
 	char				*name;
 	long				indirect;
+	long				index;
 	short				offset;
 	short				size;
 	s8				arg;
@@ -62,6 +63,7 @@ enum func_states {
 	FUNC_STATE_INDIRECT,
 	FUNC_STATE_UNSIGNED,
 	FUNC_STATE_PIPE,
+	FUNC_STATE_PLUS,
 	FUNC_STATE_TYPE,
 	FUNC_STATE_VAR,
 	FUNC_STATE_COMMA,
@@ -182,6 +184,7 @@ static char *next_token(char **ptr, char *last)
 		    *str == ']' ||
 		    *str == ',' ||
 		    *str == '|' ||
+		    *str == '+' ||
 		    *str == ')')
 			break;
 	}
@@ -323,6 +326,15 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		}
 		break;
 
+	case FUNC_STATE_PLUS:
+		if (WARN_ON(!fevent->last_arg))
+			break;
+		ret = kstrtol(token, 0, &val);
+		if (ret)
+			break;
+		fevent->last_arg->index += val;
+		return FUNC_STATE_VAR;
+
 	case FUNC_STATE_VAR:
 		switch (token[0]) {
 		case ')':
@@ -331,6 +343,8 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			return FUNC_STATE_COMMA;
 		case '|':
 			return FUNC_STATE_PIPE;
+		case '+':
+			return FUNC_STATE_PLUS;
 		case '[':
 			return FUNC_STATE_BRACKET;
 		}
@@ -347,6 +361,8 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
 	char buf[8];
 	int ret;
 
+	val += arg->index;
+
 	if (!arg->indirect)
 		return val;
 
@@ -779,6 +795,8 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 		last_arg = arg->arg;
 		comma = true;
 		seq_printf(m, "%s %s", arg->type, arg->name);
+		if (arg->index)
+			seq_printf(m, "+%ld", arg->index);
 		if (arg->indirect && arg->size)
 			seq_printf(m, "[%ld]",
 				   (arg->indirect ^ INDIRECT_FLAG) / arg->size);
-- 
2.15.1
