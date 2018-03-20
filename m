Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCTXgJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:36:09 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:53753 "EHLO smtp.polymtl.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeCTXgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:36:07 -0400
Date: Tue, 20 Mar 2018 23:35:46 +0000
Message-ID: <20180320233546.Horde.R7YJoHwgHhxvd5TuazyH3GI@www.imp.polymtl.ca>
From: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: support boot level tracing
References: <1521570176.31676.3.camel@polymtl.ca>
 <20180320180104.70e3eacd@gandalf.local.home>
In-Reply-To: <20180320180104.70e3eacd@gandalf.local.home>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Poly-FromMTA: (horde5.polymtl.ca [132.207.4.156]) at Tue, 20 Mar 2018 23:35:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> a écrit :

> On Tue, 20 Mar 2018 14:22:56 -0400
> Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca> wrote:
>
> Would something like this work for you?

Yes this is working great. I have also instrumented console and security
initcalls, I used your previous patch, changes are below.

> +	trace_initcall_level("pre_smp_initcalls");

This should be "early" I guess : trace_initcall_level("ealry");


output of : trace_event=initcall_level

[    0.327032]   <idle>-0       0.... 89576us : initcall_level: level=console
[    0.327454]   <idle>-0       0.... 135819us : initcall_level:  
level=security
[    0.327887] swapper/-1       0.... 261166us : initcall_level: level=early
[    0.328306] swapper/-1       0.... 265248us : initcall_level: level=early
[    0.328742] swapper/-1       0.... 267969us : initcall_level: level=core
[    0.329158] swapper/-1       0.... 270111us : initcall_level:  
level=postcore
[    0.329590] swapper/-1       0.... 271111us : initcall_level: level=arch
[    0.330007] swapper/-1       0.... 272217us : initcall_level: level=subsys
[    0.330429] swapper/-1       0.... 316236us : initcall_level: level=fs
[    0.330833] swapper/-1       0.... 340523us : initcall_level: level=device
[    0.331254] swapper/-1       0.... 388737us : initcall_level: level=late

PATCH with security and console instrumented

---
  include/trace/events/boot.h | 66  
+++++++++++++++++++++++++++++++++++++++++++++
  init/main.c                 |  7 +++++
  kernel/printk/printk.c      |  7 ++++-
  security/security.c         |  8 +++++-
  4 files changed, 86 insertions(+), 2 deletions(-)
  create mode 100644 include/trace/events/boot.h

diff --git a/include/trace/events/boot.h b/include/trace/events/boot.h
new file mode 100644
index 000000000000..ba0272a95813
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
+        TP_PROTO(const char *level),
+
+        TP_ARGS(level),
+
+        TP_STRUCT__entry(
+                __string(level, level)
+        ),
+
+        TP_fast_assign(
+                __assign_str(level, level);
+        ),
+
+        TP_printk("level=%s", __get_str(level))
+);
+
+TRACE_EVENT(initcall_start,
+
+        TP_PROTO(initcall_t func),
+
+        TP_ARGS(func),
+
+        TP_STRUCT__entry(
+                __field(initcall_t, func)
+        ),
+
+        TP_fast_assign(
+                __entry->func = func;
+        ),
+
+        TP_printk("func=%pS", __entry->func)
+);
+
+TRACE_EVENT(initcall_finish,
+
+        TP_PROTO(initcall_t func, int ret),
+
+        TP_ARGS(func, ret),
+
+        TP_STRUCT__entry(
+                __field(initcall_t,        func)
+                __field(int,                ret)
+        ),
+
+        TP_fast_assign(
+                __entry->func = func;
+                __entry->ret = ret;
+        ),
+
+        TP_printk("func=%pS ret=%d", __entry->func, __entry->ret)
+);
+
+#endif /* if !defined(_TRACE_GPIO_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
\ No newline at end of file
diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..765189b3a92e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -97,6 +97,9 @@
  #include <asm/sections.h>
  #include <asm/cacheflush.h>

+#define CREATE_TRACE_POINTS
+#include <trace/events/boot.h>
+
  static int kernel_init(void *);

  extern void init_IRQ(void);
@@ -827,10 +830,12 @@ int __init_or_module do_one_initcall(initcall_t fn)
  	if (initcall_blacklisted(fn))
  		return -EPERM;

+	trace_initcall_start(fn);
  	if (initcall_debug)
  		ret = do_one_initcall_debug(fn);
  	else
  		ret = fn();
+	trace_initcall_finish(fn, ret);

  	msgbuf[0] = 0;

@@ -895,6 +900,7 @@ static void __init do_initcall_level(int level)
  		   level, level,
  		   NULL, &repair_env_string);

+	trace_initcall_level(initcall_level_names[level]);
  	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
  		do_one_initcall(*fn);
  }
@@ -929,6 +935,7 @@ static void __init do_pre_smp_initcalls(void)
  {
  	initcall_t *fn;

+	trace_initcall_level(initcall_level_names[0]);
  	for (fn = __initcall_start; fn < __initcall0_start; fn++)
  		do_one_initcall(*fn);
  }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbef821d..0f10cfd1588e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -52,6 +52,7 @@
  #include <linux/uaccess.h>
  #include <asm/sections.h>

+#include <trace/events/boot.h>
  #define CREATE_TRACE_POINTS
  #include <trace/events/printk.h>

@@ -2781,6 +2782,7 @@ EXPORT_SYMBOL(unregister_console);
   */
  void __init console_init(void)
  {
+	int ret;
  	initcall_t *call;

  	/* Setup the default TTY line discipline. */
@@ -2791,8 +2793,11 @@ void __init console_init(void)
  	 * inform about problems etc..
  	 */
  	call = __con_initcall_start;
+	trace_initcall_level("console");
  	while (call < __con_initcall_end) {
-		(*call)();
+		trace_initcall_start((*call));
+		ret = (*call)();
+		trace_initcall_finish((*call), ret);
  		call++;
  	}
  }
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..9de51d599bb4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,8 @@
  #include <linux/string.h>
  #include <net/flow.h>

+#include <trace/events/boot.h>
+
  #define MAX_LSM_EVM_XATTR	2

  /* Maximum number of letters for an LSM name string */
@@ -45,10 +47,14 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =

  static void __init do_security_initcalls(void)
  {
+	int ret;
  	initcall_t *call;
  	call = __security_initcall_start;
+	trace_initcall_level("security");
  	while (call < __security_initcall_end) {
-		(*call) ();
+		trace_initcall_start((*call));
+		ret = (*call) ();
+		trace_initcall_finish((*call), ret);
  		call++;
  	}
  }
-- 
