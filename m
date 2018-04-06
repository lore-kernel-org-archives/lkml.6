Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeDFNFM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeDFNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3258521837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130112.118951478@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [for-next][PATCH 03/18] tracing: Default to using trace_global_clock if sched_clock is
 unstable
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-tracing-Default-to-using-trace_global_clock-if-sched.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

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

Link: http://lkml.kernel.org/r/20180330150132.16903-1-chris@chris-wilson.co.uk

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 551a7cd0d705..0f47e653ffd8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -41,6 +41,7 @@
 #include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/trace.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -8596,3 +8597,21 @@ __init static int clear_boot_tracer(void)
 
 fs_initcall(tracer_init_tracefs);
 late_initcall_sync(clear_boot_tracer);
+
+#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+__init static int tracing_set_default_clock(void)
+{
+	/* sched_clock_stable() is determined in late_initcall */
+	if (trace_boot_clock || sched_clock_stable()) {
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
2.15.1
