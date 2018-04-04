Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeDDUvS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:51:18 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51934 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751849AbeDDUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:51:17 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3] trace: Default to using trace_global_clock if sched_clock is unstable
Date: Wed,  4 Apr 2018 21:51:02 +0100
Message-Id: <20180404205102.20816-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330150132.16903-1-chris@chris-wilson.co.uk>
References: <20180330150132.16903-1-chris@chris-wilson.co.uk>
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
v2: Tell the user what's happening and what they can do to correct it.
v3: Restore the correct logic to switch only if the default trace clock
(no override) is found to be *not* stable.
---
 kernel/trace/trace.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 13baf85b27d8..a1810b053f65 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -41,6 +41,7 @@
 #include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/trace.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -8505,3 +8506,21 @@ __init static int clear_boot_tracer(void)
 
 fs_initcall(tracer_init_tracefs);
 late_initcall_sync(clear_boot_tracer);
+
+#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+__init static int tracing_set_default_clock(void)
+{
+	/* sched_clock_stable() is determined in late_initcall */
+	if (!trace_boot_clock && !sched_clock_stable()) {
+		printk(KERN_WARNING
+		       "Unstable clock detected, switching default tracing clock to \"global\"\n"
+		       "If you want to keep using the local clock, then add:\n"
+		       "  \"trace_clock=local\"\n"
+		       "on the kernel command line\n");
+		tracing_set_clock(&global_trace, "global");
+	}
+
+	return 0;
+}
+late_initcall_sync(tracing_set_default_clock);
+#endif
-- 
2.16.3
