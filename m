Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeCTWBI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeCTWBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:01:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D2B21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 20 Mar 2018 18:01:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        anis.benbachir@gmail.com
Subject: Re: [RFC PATCH] ftrace: support boot level tracing
Message-ID: <20180320180104.70e3eacd@gandalf.local.home>
In-Reply-To: <1521570176.31676.3.camel@polymtl.ca>
References: <1521570176.31676.3.camel@polymtl.ca>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018 14:22:56 -0400
Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca> wrote:

> Hi Steve.
> 
> Initcall's tracing support have been recently added to ftrace, which enables 
> detecting latencies within each initcall function. The main concern here is,
> enabling initcall's tracing (which is fine-grained) will add a lots of overhead
> during boot-up. So with boot level tracing we can get the overall picture, with
> low overhead, then we can use function tracing with filters to dig into more
> specific path. 
> 
> This is an example of boot level sequence, with the first initcall and the last
> initcall that were retrieved dynamically at runtime:

Hmm, we had something like this when ftrace was first introduced:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d13744cd6e3fef373a3fe656ac349b4e7c49ff79

But was removed because it appeared to be useless...

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30dbb20e68e6f7df974b77d2350ebad5eb6f6c9e

> 
> 0,console,  first=con_init,			last=univ8250_console_init
> 1,security, first=selinux_init,			last=integrity_iintcache_init
> 2,early,    first=trace_init_flags_sys_exit,	last=initialize_ptr_random
> 3,pure,     first=ipc_ns_init,			last=net_ns_init
> 4,core,     first=xen_pvh_gnttab_setup,		last=__gnttab_init
> 5,postcore, first=irq_sysfs_init,		last=kobject_uevent_init
> 6,arch,     first=bts_init,			last=pci_arch_init
> 7,subsys,   first=init_vdso,			last=watchdog_init
> 8,fs, 	    first=nmi_warning_debugfs,		last=acpi_reserve_resources
> 9,rootfs,   first=populate_rootfs,		last=ir_dev_scope_init
> 10,device,  first=ia32_binfmt_init,		last=mcheck_init_device
> 11,late,    first=tboot_late_init,		last=regulator_init_complete
> 
> To make it properly work, the idea is to register at boot time function based 
> events on the first and the last initcall of each boot level.
> 
> The created events will be recycled when the last sequence is reached. 
> 
> This patch is only a proof of concept, I didn't use function based events 
> mechanism, I only changed the first and last initcalls to point to some
> handlers, which worked fine, but need to changed:
> +	(*first_initcall_fn) = trace_bootlevel_start_handler;
> +	(*last_initcall_fn) = trace_bootlevel_end_handler;
> 
> I made this patch to get some feedbacks, and to know if this could be an
> interresting feature to have in ftrace ?
> 

What about instead just adding trace_events to the start and stop of
init calls, and enable them with trace_event=boot during boot up.

Where the output would be:

       swapper/0-1     [000] ....     0.126563: initcall_level: level=pre_smp_initcalls
       swapper/0-1     [000] ....     0.126566: initcall_start: func=trace_init_flags_sys_exit+0x0/0x14
[..]
       swapper/0-1     [000] ....     0.178691: initcall_finish: func=initialize_ptr_random+0x0/0x3b ret=0
       swapper/0-1     [000] ....     0.307805: initcall_level: level=early
       swapper/0-1     [000] ....     0.307807: initcall_start: func=ipc_ns_init+0x0/0x5c
[..]
       swapper/0-1     [000] ....     0.307877: initcall_finish: func=net_ns_init+0x0/0x15e ret=0
       swapper/0-1     [000] ....     0.307908: initcall_level: level=core
       swapper/0-1     [000] ....     0.307909: initcall_start: func=e820__register_nvs_regions+0x0/0x3d
[..]
       swapper/0-1     [000] ....     0.358655: initcall_finish: func=__gnttab_init+0x0/0x30 ret=-19
       swapper/0-1     [000] ....     0.358686: initcall_level: level=postcore
       swapper/0-1     [000] ....     0.358686: initcall_start: func=irq_sysfs_init+0x0/0x9b
[..]
       swapper/0-1     [002] ....     0.382277: initcall_finish: func=kobject_uevent_init+0x0/0x12 ret=0
       swapper/0-1     [002] ....     0.382308: initcall_level: level=arch
       swapper/0-1     [002] ....     0.382309: initcall_start: func=bts_init+0x0/0xc2
[..]
       swapper/0-1     [002] ....     0.422657: initcall_finish: func=pci_arch_init+0x0/0x6b ret=0
       swapper/0-1     [002] ....     0.422688: initcall_level: level=subsys
       swapper/0-1     [002] ....     0.422688: initcall_start: func=init_vdso+0x0/0x3a
[..]
       swapper/0-1     [005] ....     0.995475: initcall_finish: func=watchdog_init+0x0/0x9f ret=0
       swapper/0-1     [005] ....     0.995509: initcall_level: level=fs
       swapper/0-1     [005] ....     0.995510: initcall_start: func=nmi_warning_debugfs+0x0/0x2c
[..]
       swapper/0-1     [001] ....     1.625378: initcall_finish: func=ir_dev_scope_init+0x0/0x38 ret=0
       swapper/0-1     [001] ....     1.625416: initcall_level: level=device
       swapper/0-1     [001] ....     1.625416: initcall_start: func=ia32_binfmt_init+0x0/0x19
[..]
       swapper/0-1     [003] ....     2.922618: initcall_finish: func=mcheck_init_device+0x0/0x13b ret=0
       swapper/0-1     [003] ....     2.922651: initcall_level: level=late
       swapper/0-1     [003] ....     2.922651: initcall_start: func=tboot_late_init+0x0/0x292
[..]
       swapper/0-1     [000] ....    13.501018: initcall_finish: func=pci_sysfs_init+0x0/0x5a ret=0

And you could even get what tests ran the longest. Like above, if you
are wondering about that 13 second timestamp, it's because I had my
ring buffer test enabled, which runs for some time:

       swapper/0-1     [003] ....     2.985688: initcall_start: func=test_ringbuffer+0x0/0x49c
       swapper/0-1     [000] ....    13.495516: initcall_finish: func=test_ringbuffer+0x0/0x49c ret=0

Would something like this work for you?

-- Steve

diff --git a/include/trace/events/boot.h b/include/trace/events/boot.h
new file mode 100644
index 000000000000..0a1d53a848ae
--- /dev/null
+++ b/include/trace/events/boot.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM boot
+
+#if !defined(_TRACE_BOOT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BOOT_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(initcall_level,
+
+	TP_PROTO(const char *level),
+
+	TP_ARGS(level),
+
+	TP_STRUCT__entry(
+		__string(level, level)
+	),
+
+	TP_fast_assign(
+		__assign_str(level, level);
+	),
+
+	TP_printk("level=%s", __get_str(level))
+);
+
+TRACE_EVENT(initcall_start,
+
+	TP_PROTO(initcall_t func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(initcall_t, func)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+	),
+
+	TP_printk("func=%pS", __entry->func)
+);
+
+TRACE_EVENT(initcall_finish,
+
+	TP_PROTO(initcall_t func, int ret),
+
+	TP_ARGS(func, ret),
+
+	TP_STRUCT__entry(
+		__field(initcall_t,	func)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+		__entry->ret = ret;
+	),
+
+	TP_printk("func=%pS ret=%d", __entry->func, __entry->ret)
+);
+
+#endif /* if !defined(_TRACE_GPIO_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/init/main.c b/init/main.c
index a8100b954839..498e08237569 100644
--- a/init/main.c
+++ b/init/main.c
@@ -96,6 +96,9 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/boot.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -826,10 +829,12 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
+	trace_initcall_start(fn);
 	if (initcall_debug)
 		ret = do_one_initcall_debug(fn);
 	else
 		ret = fn();
+	trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
 
@@ -894,6 +899,7 @@ static void __init do_initcall_level(int level)
 		   level, level,
 		   NULL, &repair_env_string);
 
+	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
 		do_one_initcall(*fn);
 }
@@ -928,6 +934,7 @@ static void __init do_pre_smp_initcalls(void)
 {
 	initcall_t *fn;
 
+	trace_initcall_level("pre_smp_initcalls");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
 		do_one_initcall(*fn);
 }
