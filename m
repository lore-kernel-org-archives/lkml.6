Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeC2W0N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:26:13 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62436 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751124AbeC2W0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:26:11 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] trace: Default to using trace_global_clock if sched_clock is unstable
Date: Thu, 29 Mar 2018 23:25:57 +0100
Message-Id: <20180329222557.6274-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.16.3
X-Originating-IP: 78.156.65.138
X-Country: code=GB country="United Kingdom" ip=78.156.65.138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Across suspend, we may see a very large drift in timestamps if the sched
clock is unstable, prompting the global trace's ringbuffer code to warn
and suggest switching to the global clock. Preempt this request by
detecting when the sched clock is unstable (determined during
late_initcall) and automatically switching the default clock over to
trace_global_clock.

This should prevent requiring user interaction to resolve warnings such
as:

    Delta way too big! 18446743856563626466 ts=18446744054496180323 write stamp = 197932553857
    If you just came from a suspend/resume,
    please switch to the trace global clock:
    echo global > /sys/kernel/debug/tracing/trace_clock

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 13baf85b27d8..c5462513db90 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -41,6 +41,7 @@
 #include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/trace.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -8505,3 +8506,15 @@ __init static int clear_boot_tracer(void)
 
 fs_initcall(tracer_init_tracefs);
 late_initcall_sync(clear_boot_tracer);
+
+#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+__init static int tracing_set_default_clock(void)
+{
+	/* sched_clock_stable() is determined in late_initcall */
+	if (!trace_boot_clock && !sched_clock_stable())
+		tracing_set_clock(&global_trace, "global");
+
+	return 0;
+}
+late_initcall_sync(tracing_set_default_clock);
+#endif
-- 
2.16.3
