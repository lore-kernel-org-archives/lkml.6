Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeEKL6v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:58:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48357 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbeEKL6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:58:49 -0400
To: sergey.senozhatsky.work@gmail.com, dvyukov@google.com
Cc: pmladek@suse.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: [PATCH] printk: inject caller information into the body of message
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180511014515.GA895@jagdpanzerIV>
        <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
        <20180511062151.GA18160@jagdpanzerIV>
        <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
        <20180511095004.GA6575@jagdpanzerIV>
In-Reply-To: <20180511095004.GA6575@jagdpanzerIV>
Message-Id: <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 11 May 2018 20:58:44 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From b7b0e56e06db1107f781b4cb5178fbdc99240901 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 11 May 2018 20:45:31 +0900
Subject: [PATCH] printk: inject caller information into the body of message

Since syzbot frequently makes printk() flooding (e.g. memory allocation
fault injection), it is always difficult to distinguish which line is from
which event.

This patch tries to help grouping concurrent printk() lines, without
touching any struct so that we don't break userspace tools (e.g. crash)
which depend on in-kernel data structures.

If printk() is called from process context, "(T%u)" (where %u is
current->pid) is injected. If printk() is called from interrupt context,
"(C%u)" (where %u is raw_smp_processor_id()) is injected.



Example 1: SysRq-h from keyboard operation.
----------
[   57.688156] (C3) sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) show-blocked-tasks(w)
----------

Example 2: SysRq-h from /proc/sysrq-trigger interface.
----------
[   64.592273] (T2768) sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) show-blocked-tasks(w)
----------

Example 3: SysRq-f from keyboard operation.
----------
[   70.792068] (C3) sysrq: SysRq : Manual OOM execution
[   70.797444] (T245) kworker/0:2 invoked oom-killer: gfp_mask=0x14000c0(GFP_KERNEL), nodemask=(null), order=-1, oom_score_adj=0
[   70.807690] (T245) kworker/0:2 cpuset=/ mems_allowed=0
[   70.812738] (T245) CPU: 0 PID: 245 Comm: kworker/0:2 Kdump: loaded Not tainted 4.17.0-rc4+ #396
[   70.819886] (T245) Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[   70.828924] (T245) Workqueue: events moom_callback
[   70.830554] (T245) Call Trace:
[   70.831518] (T245)  dump_stack+0x5e/0x8b
[   70.832754] (T245)  dump_header+0x6f/0x454
[   70.834045] (T245)  ? _raw_spin_unlock_irqrestore+0x42/0x60
[   70.835764] (T245)  oom_kill_process+0x223/0x690
[   70.837257] (T245)  ? out_of_memory+0x2c2/0x530
[   70.838669] (T245)  out_of_memory+0x120/0x530
[   70.840016] (T245)  ? out_of_memory+0x1f7/0x530
[   70.841433] (T245)  moom_callback+0x68/0x90
[   70.842735] (T245)  process_one_work+0x19f/0x370
[   70.844162] (T245)  ? process_one_work+0x13c/0x370
[   70.845681] (T245)  worker_thread+0x45/0x3e0
[   70.846985] (T245)  kthread+0xf6/0x130
[   70.848127] (T245)  ? process_one_work+0x370/0x370
[   70.849587] (T245)  ? kthread_create_on_node+0x40/0x40
[   70.851146] (T245)  ret_from_fork+0x24/0x30
[   70.855706] (T245) Mem-Info:
[   70.856674] (T245) active_anon:11880 inactive_anon:2122 isolated_anon:0
[   70.856674]  active_file:11521 inactive_file:18259 isolated_file:0
[   70.856674]  unevictable:0 dirty:4 writeback:0 unstable:0
[   70.856674]  slab_reclaimable:7216 slab_unreclaimable:14300
[   70.856674]  mapped:11981 shmem:2198 pagetables:1743 bounce:0
[   70.856674]  free:853866 free_pcp:566 free_cma:0
[   70.868764] (T245) Node 0 active_anon:47520kB inactive_anon:8488kB active_file:46084kB inactive_file:73036kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:47924kB dirty:16kB writeback:0kB shmem:8792kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 8192kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[   70.880127] (T245) Node 0 DMA free:15872kB min:284kB low:352kB high:420kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15988kB managed:15904kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   70.889522] (T245) lowmem_reserve[]: 0 2683 3633 3633
[   70.891285] (T245) Node 0 DMA32 free:2746612kB min:49696kB low:62120kB high:74544kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129216kB managed:2748008kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:340kB local_pcp:116kB free_cma:0kB
[   70.899460] (T245) lowmem_reserve[]: 0 0 950 950
[   70.901212] (T245) Node 0 Normal free:652980kB min:17596kB low:21992kB high:26388kB active_anon:47520kB inactive_anon:8488kB active_file:46084kB inactive_file:73036kB unevictable:0kB writepending:16kB present:1048576kB managed:972972kB mlocked:0kB kernel_stack:3664kB pagetables:6972kB bounce:0kB free_pcp:1920kB local_pcp:644kB free_cma:0kB
[   70.909865] (T245) lowmem_reserve[]: 0 0 0 0
[   70.911646] (T245) Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15872kB
[   70.915231] (T245) Node 0 DMA32: 3*4kB (UM) 3*8kB (UM) 1*16kB (M) 2*32kB (M) 2*64kB (M) 4*128kB (UM) 4*256kB (M) 5*512kB (UM) 2*1024kB (M) 4*2048kB (UM) 667*4096kB (M) = 2746612kB
[   70.920274] (T245) Node 0 Normal: 243*4kB (UM) 51*8kB (UM) 19*16kB (UM) 5*32kB (M) 4*64kB (UME) 1*128kB (M) 2*256kB (ME) 2*512kB (UE) 6*1024kB (UE) 6*2048kB (UME) 154*4096kB (M) = 652980kB
[   70.925188] (T245) Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[   70.927860] (T245) Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[   70.930431] (T245) 31978 total pagecache pages
[   70.932166] (T245) 0 pages in swap cache
[   70.933803] (T245) Swap cache stats: add 0, delete 0, find 0/0
[   70.935841] (T245) Free swap  = 0kB
[   70.937315] (T245) Total swap = 0kB
[   70.938957] (T245) 1048445 pages RAM
[   70.940486] (T245) 0 pages HighMem/MovableOnly
[   70.942158] (T245) 114224 pages reserved
[   70.943767] (T245) 0 pages hwpoisoned
[   70.945267] (T245) Out of memory: Kill process 2474 (tuned) score 6 or sacrifice child
[   70.947863] (T245) Killed process 2474 (tuned) total-vm:573828kB, anon-rss:13072kB, file-rss:10716kB, shmem-rss:0kB
----------



This patch does not distinguish in_nmi()/in_irq()/in_serving_softirq(),
for I guess that it is not too difficult to distinguish them as long as
we can pick up messages from same CPU based on "(C%u)" part. We could
change to use "(C%u%c)" (where %c is type of interrupt context) if needed.

For long term, we might want to touch in-kernel data structures so that
userspace tools can do better processing. But for now, I think that this
patch can help a lot.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++
 kernel/printk/internal.h                        |  1 +
 kernel/printk/printk.c                          | 49 +++++++++++++++++++++++--
 kernel/printk/printk_safe.c                     | 22 ++++++++++-
 lib/Kconfig.debug                               | 13 +++++++
 5 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28e..10e716e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3288,6 +3288,12 @@
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 			default: disabled
 
+	printk.caller_info=
+			Show which task (if in process context) or CPU (if not
+			in process context) generated each message.
+			Useful for environments where printk() floods.
+			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
+
 	printk.devkmsg={on,off,ratelimit}
 			Control writing to /dev/kmsg.
 			on - unlimited logging to /dev/kmsg from userspace
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a7d040..0b30457 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -23,6 +23,7 @@
 #define PRINTK_NMI_CONTEXT_MASK		 0x80000000
 
 extern raw_spinlock_t logbuf_lock;
+extern bool printk_caller_info;
 
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af21..9040a16 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1733,6 +1733,37 @@ static inline void printk_delay(void)
 	}
 }
 
+bool printk_caller_info = IS_ENABLED(CONFIG_PRINTK_CALLER_INFO);
+module_param_named(caller_info, printk_caller_info, bool, 0644);
+
+static char *printk_inject_caller_info(const char *text, size_t *text_len)
+{
+	static char buf[LOG_LINE_MAX + 128];
+	int len;
+	unsigned int v;
+	char c;
+
+	if (!printk_caller_info)
+		return (char *) text;
+
+	if (in_task()) {
+		v = current->pid;
+		c = 'T';
+	} else {
+		/* Use raw version not to generate warning messages. */
+		v = raw_smp_processor_id();
+		c = 'C';
+	}
+	len = snprintf(buf, sizeof(buf), "(%c%u) ", c, v);
+	/* This should not happen though... */
+	if (unlikely(len + *text_len >= sizeof(buf)))
+		return (char *) text;
+	memmove(buf + len, text, *text_len);
+	*text_len += len;
+	/* "buf" remains valid because it is protected by "logbuf_lock". */
+	return buf;
+}
+
 /*
  * Continuation lines are buffered, and not committed to the record buffer
  * until the line is complete, or a race forces it. The line fragments
@@ -1763,10 +1794,19 @@ static bool cont_add(int facility, int level, enum log_flags flags, const char *
 {
 	/*
 	 * If ext consoles are present, flush and skip in-kernel
-	 * continuation.  See nr_ext_console_drivers definition.  Also, if
-	 * the line gets too long, split it up in separate records.
+	 * continuation. See nr_ext_console_drivers definition.
 	 */
-	if (nr_ext_console_drivers || cont.len + len > sizeof(cont.buf)) {
+	if (nr_ext_console_drivers) {
+		cont_flush();
+		return false;
+	}
+
+	/* Inject before memcpy() in order to avoid overflow. */
+	if (!cont.len)
+		text = printk_inject_caller_info(text, &len);
+
+	/* If the line gets too long, split it up in separate records. */
+	if (cont.len + len > sizeof(cont.buf)) {
 		cont_flush();
 		return false;
 	}
@@ -1820,6 +1860,9 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 			return text_len;
 	}
 
+	/* Inject caller info. */
+	text = printk_inject_caller_info(text, &text_len);
+
 	/* Store it in the record log */
 	return log_store(facility, level, lflags, 0, dict, dictlen, text, text_len);
 }
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 449d67e..02d080a 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/irq_work.h>
 #include <linux/printk.h>
+#include <linux/sched.h>
 
 #include "internal.h"
 
@@ -83,6 +84,17 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
 	int add;
 	size_t len;
 	va_list ap;
+	unsigned int v;
+	char c;
+
+	if (in_task()) {
+		v = current->pid;
+		c = 't';
+	} else {
+		/* Use raw version not to generate warning messages. */
+		v = raw_smp_processor_id();
+		c = 'c';
+	}
 
 again:
 	len = atomic_read(&s->len);
@@ -102,7 +114,15 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
 		smp_rmb();
 
 	va_copy(ap, args);
-	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, ap);
+	if (printk_caller_info) {
+		struct va_format vaf = { .fmt = fmt, .va = &ap };
+
+		add = scnprintf(s->buffer + len, sizeof(s->buffer) - len,
+				"(%c%u) %pV", c, v, &vaf);
+	} else {
+		add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len,
+				 fmt, ap);
+	}
 	va_end(ap);
 	if (!add)
 		return 0;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b7..9e8ea4e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -15,6 +15,19 @@ config PRINTK_TIME
 	  The behavior is also controlled by the kernel command line
 	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
 
+config PRINTK_CALLER_INFO
+	bool "Show caller information on printks"
+	depends on PRINTK
+	help
+	  Selecting this option causes thread id (if in process context) or CPU
+	  id (if not in process context) of the printk() messages to be added
+	  to the output of the syslog() system call and at the console.
+	  Useful for environments where multiple threads constantly call
+	  printk() (e.g. fault injection fuzzing tests).
+
+	  The behavior is also controlled by printk.caller_info= kernel command
+	  line parameter or /sys/module/printk/parameters/caller_info file.
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
-- 
1.8.3.1
