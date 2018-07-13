Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DCDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30502087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30502087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeGMMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeGMMzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:55:52 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2475A20873;
        Fri, 13 Jul 2018 12:41:22 +0000 (UTC)
Date:   Fri, 13 Jul 2018 08:41:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        jreck@google.com, tkjos@google.com
Subject: [GIT PULL][PATCH] tracing: Reorder display of TGID to be after PID
Message-ID: <20180713084120.5b9c2d08@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Joel Fernandes asked to add a feature in tracing that Android had its
own patch internally for. I took it back in 4.13. Now he realizes that
he had a mistake, and swapped the values from what Android had. This
means that the old Android tools will break when using a new kernel
that has the new feature on it.

The options are:

 1. To swap it back to what Android wants.
 2. Add a command line option or something to do the swap
 3. Just let Android carry a patch that swaps it back

Since it requires setting a tracing option to enable this anyway,
I doubt there are other users of this than Android. Thus, I've
decided to take option 1. If someone else is actually depending on the
order that is in the kernel, then we will have to revert this change
and go to option 2 or 3.


Please pull the latest trace-v4.18-rc3-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.18-rc3-3

Tag SHA1: 98d877a3a308950afaaf28a0b55699726b45ad7a
Head SHA1: f8494fa3dd10b52eab47a9666a8bc34719a129aa


Joel Fernandes (Google) (1):
      tracing: Reorder display of TGID to be after PID

----
 kernel/trace/trace.c        | 8 ++++----
 kernel/trace/trace_output.c | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)
---------------------------
commit f8494fa3dd10b52eab47a9666a8bc34719a129aa
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Mon Jun 25 17:08:22 2018 -0700

    tracing: Reorder display of TGID to be after PID
    
    Currently ftrace displays data in trace output like so:
    
                                           _-----=> irqs-off
                                          / _----=> need-resched
                                         | / _---=> hardirq/softirq
                                         || / _--=> preempt-depth
                                         ||| /     delay
                TASK-PID   CPU    TGID   ||||    TIMESTAMP  FUNCTION
                   | |       |      |    ||||       |         |
                bash-1091  [000] ( 1091) d..2    28.313544: sched_switch:
    
    However Android's trace visualization tools expect a slightly different
    format due to an out-of-tree patch patch that was been carried for a
    decade, notice that the TGID and CPU fields are reversed:
    
                                           _-----=> irqs-off
                                          / _----=> need-resched
                                         | / _---=> hardirq/softirq
                                         || / _--=> preempt-depth
                                         ||| /     delay
                TASK-PID    TGID   CPU   ||||    TIMESTAMP  FUNCTION
                   | |        |      |   ||||       |         |
                bash-1091  ( 1091) [002] d..2    64.965177: sched_switch:
    
    From kernel v4.13 onwards, during which TGID was introduced, tracing
    with systrace on all Android kernels will break (most Android kernels
    have been on 4.9 with Android patches, so this issues hasn't been seen
    yet). From v4.13 onwards things will break.
    
    The chrome browser's tracing tools also embed the systrace viewer which
    uses the legacy TGID format and updates to that are known to be
    difficult to make.
    
    Considering this, I suggest we make this change to the upstream kernel
    and backport it to all Android kernels. I believe this feature is merged
    recently enough into the upstream kernel that it shouldn't be a problem.
    Also logically, IMO it makes more sense to group the TGID with the
    TASK-PID and the CPU after these.
    
    Link: http://lkml.kernel.org/r/20180626000822.113931-1-joel@joelfernandes.org
    
    Cc: jreck@google.com
    Cc: tkjos@google.com
    Cc: stable@vger.kernel.org
    Fixes: 441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f054bd6a1c66..87cf25171fb8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3365,8 +3365,8 @@ static void print_func_help_header(struct trace_buffer *buf, struct seq_file *m,
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   CPU#   %s  TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |       |    %s     |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
+	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
 }
 
 static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file *m,
@@ -3386,9 +3386,9 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 		   tgid ? tgid_space : space);
 	seq_printf(m, "#                          %s||| /     delay\n",
 		   tgid ? tgid_space : space);
-	seq_printf(m, "#           TASK-PID   CPU#%s||||    TIMESTAMP  FUNCTION\n",
+	seq_printf(m, "#           TASK-PID %sCPU#  ||||    TIMESTAMP  FUNCTION\n",
 		   tgid ? "   TGID   " : space);
-	seq_printf(m, "#              | |       | %s||||       |         |\n",
+	seq_printf(m, "#              | |   %s  |   ||||       |         |\n",
 		   tgid ? "     |    " : space);
 }
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 90db994ac900..1c8e30fda46a 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -594,8 +594,7 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d [%03d] ",
-			       comm, entry->pid, iter->cpu);
+	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
@@ -606,6 +605,8 @@ int trace_print_context(struct trace_iterator *iter)
 			trace_seq_printf(s, "(%5d) ", tgid);
 	}
 
+	trace_seq_printf(s, "[%03d] ", iter->cpu);
+
 	if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
 		trace_print_lat_fmt(s, entry);
 
