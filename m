Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDDSuT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeDDSuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:50:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF58520CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 14:50:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC][PATCH] tracing: Hide global trace clock from lockdep
Message-ID: <20180404145015.77bde42d@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Function tracing can trace in NMIs and such. If the TSC is determined
to be unstable, the tracing clock will switch to the global clock on
boot up, unless "trace_clock" is specified on the kernel command line.

The global clock disables interrupts to access sched_clock_cpu(), and in
doing so can be done within lockdep internals (because of function
tracing and NMIs). This can trigger false lockdep splats.

The trace_clock_global() is special, best not to trace the irq logic
within it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
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
