Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB21C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A615320855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A615320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeIBNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:44:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53952 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:44:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwOgg-0008MI-88; Sun, 02 Sep 2018 11:28:54 +0200
Subject: [GIT pull] core updates for 4.19
Message-ID: <153588048102.6192.18075264253310979408.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Sun, 02 Sep 2018 11:28:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

A small set of updates for core code:

 - Prevent tracing in functions which are called from trace patching via
   stop_machine() to prevent executing half patched function trace entries.

 - Remove old GCC workarounds

 - Remove pointless includes of notifier.h

Thanks,

	tglx

------------------>
Masahiro Yamada (1):
      objtool: Remove workaround for unreachable warnings from old GCC

Mukesh Ojha (1):
      notifier: Remove notifier header file wherever not used

Vincent Whitchurch (1):
      watchdog: Mark watchdog touch functions as notrace


 fs/buffer.c            | 1 -
 kernel/printk/printk.c | 1 -
 kernel/watchdog.c      | 4 ++--
 kernel/watchdog_hld.c  | 2 +-
 kernel/workqueue.c     | 2 +-
 lib/percpu_counter.c   | 1 -
 mm/page-writeback.c    | 1 -
 mm/page_alloc.c        | 1 -
 mm/slub.c              | 1 -
 net/core/dev.c         | 1 -
 scripts/Makefile.build | 2 --
 11 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4cc679d5bf58..6f1ae3ac9789 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -39,7 +39,6 @@
 #include <linux/buffer_head.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/bio.h>
-#include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/mpage.h>
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 924e37fb1620..fd6f8ed28e01 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -38,7 +38,6 @@
 #include <linux/kmsg_dump.h>
 #include <linux/syslog.h>
 #include <linux/cpu.h>
-#include <linux/notifier.h>
 #include <linux/rculist.h>
 #include <linux/poll.h>
 #include <linux/irq_work.h>
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5470dce212c0..977918d5d350 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -261,7 +261,7 @@ static void __touch_watchdog(void)
  * entering idle state.  This should only be used for scheduler events.
  * Use touch_softlockup_watchdog() for everything else.
  */
-void touch_softlockup_watchdog_sched(void)
+notrace void touch_softlockup_watchdog_sched(void)
 {
 	/*
 	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
@@ -270,7 +270,7 @@ void touch_softlockup_watchdog_sched(void)
 	raw_cpu_write(watchdog_touch_ts, 0);
 }
 
-void touch_softlockup_watchdog(void)
+notrace void touch_softlockup_watchdog(void)
 {
 	touch_softlockup_watchdog_sched();
 	wq_watchdog_touch(raw_smp_processor_id());
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 1f7020d65d0a..71381168dede 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -29,7 +29,7 @@ static struct cpumask dead_events_mask;
 static unsigned long hardlockup_allcpu_dumped;
 static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
-void arch_touch_nmi_watchdog(void)
+notrace void arch_touch_nmi_watchdog(void)
 {
 	/*
 	 * Using __raw here because some code paths have
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 60e80198c3df..0280deac392e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5574,7 +5574,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
 
-void wq_watchdog_touch(int cpu)
+notrace void wq_watchdog_touch(int cpu)
 {
 	if (cpu >= 0)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index c72577e472f2..a66595ba5543 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/percpu_counter.h>
-#include <linux/notifier.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6551d3b0dc30..84ae9bf5858a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -27,7 +27,6 @@
 #include <linux/mpage.h>
 #include <linux/rmap.h>
 #include <linux/percpu.h>
-#include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e75865d58ba7..05e983f42316 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/oom.h>
-#include <linux/notifier.h>
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
diff --git a/mm/slub.c b/mm/slub.c
index ce2b9e5cea77..8da34a8af53d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include "slab.h"
 #include <linux/proc_fs.h>
-#include <linux/notifier.h>
 #include <linux/seq_file.h>
 #include <linux/kasan.h>
 #include <linux/cpu.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 325fc5088370..82114e1111e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -93,7 +93,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/notifier.h>
 #include <linux/skbuff.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1c48572223d1..5a2d1c9578a0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -246,8 +246,6 @@ objtool_args += --no-fp
 endif
 ifdef CONFIG_GCOV_KERNEL
 objtool_args += --no-unreachable
-else
-objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
 ifneq ($(RETPOLINE_CFLAGS),)

