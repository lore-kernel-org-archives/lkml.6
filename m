Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeDFTOo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeDFTNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:13:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7976521834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406191334.357550809@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 15:08:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: [PATCH 3/4 v2] init, tracing: Have printk come through the trace events for
 initcall_debug
References: <20180406190854.875810797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-init-tracing-Have-printk-come-through-the-trace-even.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

With trace events set before and after the initcall function calls, instead
of having a separate routine for printing out the initcalls when
initcall_debug is specified on the kernel command line, have the code
register a callback to the tracepoints where the initcall trace events are.

This removes the need for having a separate function to do the initcalls as
the tracepoint callbacks can handle the printk. It also includes other
initcalls that are not called by the do_one_initcall() which includes
console and security initcalls.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2af8f2bb5ca8..589d1226016e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -494,6 +494,10 @@ void __init __weak thread_stack_cache_init(void)
 
 void __init __weak mem_encrypt_init(void) { }
 
+bool initcall_debug;
+core_param(initcall_debug, initcall_debug, bool, 0644);
+static void __init initcall_debug_enable(void);
+
 /*
  * Set up kernel memory allocators
  */
@@ -615,6 +619,9 @@ asmlinkage __visible void __init start_kernel(void)
 	/* Trace events are available after this */
 	trace_init();
 
+	if (initcall_debug)
+		initcall_debug_enable();
+
 	context_tracking_init();
 	/* init some links before init_ISA_irqs() */
 	early_irq_init();
@@ -731,9 +738,6 @@ static void __init do_ctors(void)
 #endif
 }
 
-bool initcall_debug;
-core_param(initcall_debug, initcall_debug, bool, 0644);
-
 #ifdef CONFIG_KALLSYMS
 struct blacklist_entry {
 	struct list_head next;
@@ -803,38 +807,53 @@ static bool __init_or_module initcall_blacklisted(initcall_t fn)
 #endif
 __setup("initcall_blacklist=", initcall_blacklist);
 
-static int __init_or_module do_one_initcall_debug(initcall_t fn)
+static __init_or_module void
+trace_initcall_start_cb(void *data, initcall_t fn)
 {
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
-	int ret;
+	ktime_t *calltime = (ktime_t *)data;
 
 	printk(KERN_DEBUG "calling  %pF @ %i\n", fn, task_pid_nr(current));
-	calltime = ktime_get();
-	ret = fn();
+	*calltime = ktime_get();
+}
+
+static __init_or_module void
+trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
+{
+	ktime_t *calltime = (ktime_t *)data;
+	ktime_t delta, rettime;
+	unsigned long long duration;
+
 	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
+	delta = ktime_sub(rettime, *calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 	printk(KERN_DEBUG "initcall %pF returned %d after %lld usecs\n",
 		 fn, ret, duration);
+}
 
-	return ret;
+static ktime_t initcall_calltime;
+
+static void __init initcall_debug_enable(void)
+{
+	int ret;
+
+	ret = register_trace_initcall_start(trace_initcall_start_cb,
+					    &initcall_calltime);
+	ret |= register_trace_initcall_finish(trace_initcall_finish_cb,
+					      &initcall_calltime);
+	WARN(ret, "Failed to register initcall tracepoints\n");
 }
 
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
-	int ret;
 	char msgbuf[64];
+	int ret;
 
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
 	trace_initcall_start(fn);
-	if (initcall_debug)
-		ret = do_one_initcall_debug(fn);
-	else
-		ret = fn();
+	ret = fn();
 	trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
-- 
2.15.1
