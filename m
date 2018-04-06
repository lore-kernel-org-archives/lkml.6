Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeDFNCZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeDFNBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB402183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130114.031019648@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 15/18] tracing: Hide global trace clock from lockdep
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0015-tracing-Hide-global-trace-clock-from-lockdep.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Function tracing can trace in NMIs and such. If the TSC is determined
to be unstable, the tracing clock will switch to the global clock on
boot up, unless "trace_clock" is specified on the kernel command line.

The global clock disables interrupts to access sched_clock_cpu(), and in
doing so can be done within lockdep internals (because of function
tracing and NMIs). This can trigger false lockdep splats.

The trace_clock_global() is special, best not to trace the irq logic
within it.

Link: http://lkml.kernel.org/r/20180404145015.77bde42d@gandalf.local.home

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 5fdc779f411d..d8a188e0418a 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -96,7 +96,7 @@ u64 notrace trace_clock_global(void)
 	int this_cpu;
 	u64 now;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	this_cpu = raw_smp_processor_id();
 	now = sched_clock_cpu(this_cpu);
@@ -122,7 +122,7 @@ u64 notrace trace_clock_global(void)
 	arch_spin_unlock(&trace_clock_struct.lock);
 
  out:
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return now;
 }
-- 
2.15.1
