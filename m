Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F79C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6D7208AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6D7208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeHWFRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeHWFRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:17:05 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F83C208AF;
        Thu, 23 Aug 2018 01:49:48 +0000 (UTC)
Date:   Wed, 22 Aug 2018 21:49:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: gcov and fixes to no kprobes on notrace
 functions
Message-ID: <20180822214946.6522d57c@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Masami found an off by one bug in the code that keeps "notrace" functions
from being traced by kprobes. During my testing, I found that there's places
that we may want to add kprobes to notrace, thus we may end up changing this
code before 4.19 is released. The history behind this change is that we
found that adding kprobes to various notrace functions caused the kernel to
crashed. We took the safe route and decided not to allow kprobes to trace
any notrace function. But because notrace is added to functions that just
cause weird side effects to the function tracer, but are still safe,
preventing kprobes for all notrace functions may be too much of a big
hammer. One such place is __schedule() is marked notrace, to keep
function tracer from doing strange recursive loops when it gets traced
with NEED_RESCHED set. With this change, one can not add kprobes to the
scheduler.

Masami also added code to use gcov on ftrace.


Please pull the latest trace-v4.19-1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-1

Tag SHA1: 808ce93b6ef6d4949eee7c48ab5e002142367393
Head SHA1: 9161a864ff88e800de50494da095af19832e9583


Masami Hiramatsu (2):
      tracing: Allow gcov profiling on only ftrace subsystem
      tracing/kprobes: Fix to check notrace function with correct range

----
 kernel/trace/Kconfig        | 12 ++++++++++++
 kernel/trace/Makefile       |  5 +++++
 kernel/trace/trace_kprobe.c |  9 ++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fd6754b88f87..aec44d838283 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,18 @@ config TRACING_EVENTS_GPIO
 	help
 	  Enable tracing events for gpio subsystem
 
+config GCOV_PROFILE_FTRACE
+	bool "Enable GCOV profiling on ftrace subsystem"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on ftrace subsystem for checking
+	  which functions/lines are tested.
+
+	  If unsure, say N.
+
+	  Note that on a kernel compiled with this config, ftrace will
+	  run significantly slower.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 98d53b39a8ee..f81dadbc7c4a 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -23,6 +23,11 @@ ifdef CONFIG_TRACING_BRANCHES
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 endif
 
+# for GCOV coverage profiling
+ifdef CONFIG_GCOV_PROFILE_FTRACE
+GCOV_PROFILE := y
+endif
+
 CFLAGS_trace_benchmark.o := -I$(src)
 CFLAGS_trace_events_filter.o := -I$(src)
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 65a4157af851..ad384b31fe01 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -513,7 +513,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 	if (!addr || !kallsyms_lookup_size_offset(addr, &size, &offset))
 		return false;
 
-	return !ftrace_location_range(addr - offset, addr - offset + size);
+	/* Get the entry address of the target function */
+	addr -= offset;
+
+	/*
+	 * Since ftrace_location_range() does inclusive range check, we need
+	 * to subtract 1 byte from the end address.
+	 */
+	return !ftrace_location_range(addr, addr + size - 1);
 }
 #else
 #define within_notrace_func(tk)	(false)
