Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeBIWHo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:07:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeBIWHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:07:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB04C2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Feb 2018 17:07:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 12/18] tracing: Add accessing direct address from
 function based events
Message-ID: <20180209170737.5921ea0f@gandalf.local.home>
In-Reply-To: <20180209003436.GB28206@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.828677654@goodmis.org>
        <20180209003436.GB28206@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 09:34:36 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Couldn't we use the symbol name directly?  Maybe it needs a syntax to
> indicate global variable.  Like this?
> 
>   # echo 'do_IRQ(int $total_forks)' > function_events


I decided to stick with "$".

-- Steve

>From ed303534dac5b2d9af7b4db9f042d7941c997288 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Fri, 9 Feb 2018 17:03:06 -0500
Subject: [PATCH] tracing: Add direct kallsym access to function based events

Instead of searching for the address via kallsyms to print the variable in a
function based event, have "$<symbol>" be a way to tell the function based
event to look up the symbol for you.

Instead of:

   # grep total_forks /proc/kallsyms
ffffffff82354c18 B total_forks

  # echo 'do_IRQ(int forks=0xffffffff82354c18)' > function_events

One can do either:

  # echo 'do_IRQ(int forks=$total_forks)' > function_events

or simply

  # echo 'do_IRQ(int $total_forks)' > function_events

The latter will say "total_forks=" in the output where the formal says
"forks=".

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 25 ++++++++++++++++++-
 kernel/trace/trace_event_ftrace.c             | 35 ++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 606981b876a0..9a30aee338f4 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -112,13 +112,19 @@ as follows:
 
  INDIRECT := INDEX | OFFSET | INDIRECT INDIRECT | ''
 
- ADDR := A hexidecimal address starting with '0x'
+ ADDR := <symbol> | <hexnumber>
 
  Where <name> is a unique string starting with an alphabetic character
  and consists only of letters and numbers and underscores.
 
  Where <number> is a number that can be read by kstrtol() (hex, decimal, etc).
 
+ Where <hexnumber> is an address starting with '0x'
+
+ Where <symbol> is a valid symbol name from kallsyms starting with "$".
+ For example: $total_forks
+
+
 
 Simple arguments
 ================
@@ -317,6 +323,23 @@ Is the same as
     <idle>-0     [003] d..3   655.823498: ret_from_intr->do_IRQ(total_forks=1504, regs=tick_nohz_idle_enter+0x4c/0x50)
     <idle>-0     [003] d..3   655.954096: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
 
+You can also accomplish the same thing above using the kallsym name following
+a "$" symbol. That is:
+
+  # echo 'do_IRQ(int $total_forks)' > function_events
+
+is the same as the above command using the "0xffffffff82354c18" address.
+
+You can rename the variable by using "=":
+
+  # echo 'do_IRQ(int forks=$total_forks)' > function_events
+
+  # cat trace
+    <idle>-0     [003] d..3   698.226763: ret_from_intr->do_IRQ(forks=1475)
+    <idle>-0     [003] d..3   698.226810: ret_from_intr->do_IRQ(forks=1475)
+    <idle>-0     [003] d..3   698.227046: ret_from_intr->do_IRQ(forks=1475)
+    <idle>-0     [003] d..3   698.502222: ret_from_intr->do_IRQ(forks=1475)
+
 
 Array types
 ===========
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 376c9324d65c..39abda19d5d2 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -92,6 +92,7 @@ static LIST_HEAD(func_events);
 	C(ARRAY_END),				\
 	C(REDIRECT_PLUS),			\
 	C(REDIRECT_BRACKET),			\
+	C(SYMBOL),				\
 	C(VAR),					\
 	C(COMMA),				\
 	C(NULL),				\
@@ -281,6 +282,7 @@ static char *next_token(char **ptr, char *last)
 		    *str == '|' ||
 		    *str == '+' ||
 		    *str == '=' ||
+		    *str == '$' ||
 		    *str == ')')
 			break;
 	}
@@ -393,6 +395,14 @@ static int add_arg_redirect(struct func_arg *arg, long index, long indirect)
 	return 0;
 }
 
+static int get_symbol(const char *symbol, unsigned long *val)
+{
+	*val = kallsyms_lookup_name(symbol);
+	if (!*val)
+		return -1;
+	return 0;
+}
+
 static enum func_states
 process_event(struct func_event *fevent, const char *token, enum func_states state)
 {
@@ -469,6 +479,8 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	case FUNC_STATE_ARRAY_END:
 		if (WARN_ON(!fevent->last_arg))
 			break;
+		if (token[0] == '$')
+			return FUNC_STATE_SYMBOL;
 		if (update_arg_name(fevent, token) < 0)
 			break;
 		if (strncmp(token, "0x", 2) == 0)
@@ -542,6 +554,11 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		fevent->last_arg->index += val;
 		return FUNC_STATE_VAR;
 
+	case FUNC_STATE_SYMBOL:
+		if (!isalpha(token[0]) && token[0] != '_')
+			break;
+		goto equal;
+
 	case FUNC_STATE_ADDR:
 		switch (token[0]) {
 		case ')':
@@ -599,14 +616,26 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		break;
 
 	case FUNC_STATE_EQUAL:
+		if (token[0] == '$')
+			return FUNC_STATE_SYMBOL;
 		if (strncmp(token, "0x", 2) != 0)
 			break;
  equal:
 		if (WARN_ON(!fevent->last_arg))
 			break;
-		ret = kstrtoul(token, 0, &val);
-		if (ret < 0)
-			break;
+		if (isalpha(token[0]) || token[0] != '_') {
+			ret = get_symbol(token, &val);
+			if (ret < 0)
+				break;
+			if (!fevent->last_arg->name) {
+				if (update_arg_name(fevent, token) < 0)
+					break;
+			}
+		} else {
+			ret = kstrtoul(token, 0, &val);
+			if (ret < 0)
+				break;
+		}
 		update_arg = false;
 		fevent->last_arg->index = val;
 		fevent->last_arg->arg = -1;
-- 
2.13.6
