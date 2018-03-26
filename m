Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCZOey (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeCZOew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:34:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317AE2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 10:34:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?UTF-8?B?QW3Dg8Kpcmljbw==?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
Message-ID: <20180326103449.74d8e790@gandalf.local.home>
In-Reply-To: <20180326084242.GJ4043@hirez.programming.kicks-ass.net>
References: <20180323150241.878778199@goodmis.org>
        <20180323125016.270ea1558fe2499b1a12bfd7@linux-foundation.org>
        <20180323160441.3217664d@vmware.local.home>
        <20180326084242.GJ4043@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 10:42:42 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Mar 23, 2018 at 04:04:41PM -0400, Steven Rostedt wrote:
> > I would even argue that we remove the printks and use the trace events
> > instead. There's already an option to make trace events be sent to
> > printk(). I could have initcall_debug enable the trace events and send
> > them to printk.  
> 
> Those printk()'s are so ever much more useful when you fail to boot and
> can't get the trace buffer out.

That's why I said have initcall_debug send the trace events to printk.
It would go to both the trace buffer and out to printk at the time of
the trace event execution. You wouldn't notice a difference even if the
system crashed at boot up.

The kernel command line parameter "tp_printk" will cause any tracepoint
to be printed via printk() at the time of event execution. Of course
this could be dangerous, because some trace events could cause a live
lock if you enabled printk on them (scheduler and interrupt trace
events). Thus, I would recommend instead just hooking to the trace
events if initcall_debug is added. Then from the initcall handler, do
the printks.

This patch below (on top of the three here), replaces initcall_debug
with using tracepoints, but keeps the same functionality. In fact, it
actually adds more, because the original initcall_debug ignored console
and security initcalls. We now have this:

[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] NR_IRQS: 8448, nr_irqs: 488, preallocated irqs: 16
[    0.000000] calling  con_init+0x0/0x224 @ 0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] initcall con_init+0x0/0x224 returned 0 after 0 usecs
[    0.000000] calling  hvc_console_init+0x0/0x19 @ 0
[    0.000000] initcall hvc_console_init+0x0/0x19 returned 0 after 0 usecs
[    0.000000] calling  xen_cons_init+0x0/0x60 @ 0
[    0.000000] initcall xen_cons_init+0x0/0x60 returned 0 after 0 usecs
[    0.000000] calling  univ8250_console_init+0x0/0x2d @ 0
[    0.000000] console [ttyS0] enabled
[..]
[    0.012001] pid_max: default: 32768 minimum: 301
[    0.013053] Security Framework initialized
[    0.014004] calling  selinux_init+0x0/0x17c @ 0
[    0.014005] SELinux:  Disabled at boot.
[    0.015001] initcall selinux_init+0x0/0x17c returned 0 after 976 usecs
[    0.015003] calling  integrity_iintcache_init+0x0/0x33 @ 0
[    0.015008] initcall integrity_iintcache_init+0x0/0x33 returned 0 after 0 usecs
[    0.016154] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[..]

Yes, the timing of the consoles is useless, but we still get to see
them.

-- Steve

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
