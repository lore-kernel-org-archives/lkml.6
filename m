Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE73ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39446206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39446206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeGPIHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED548CA1;
        Mon, 16 Jul 2018 07:41:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, jreck@google.com, tkjos@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 37/54] tracing: Reorder display of TGID to be after PID
Date:   Mon, 16 Jul 2018 09:35:34 +0200
Message-Id: <20180716073457.543597442@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes (Google) <joel@joelfernandes.org>

commit f8494fa3dd10b52eab47a9666a8bc34719a129aa upstream.

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

>From kernel v4.13 onwards, during which TGID was introduced, tracing
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c        |    8 ++++----
 kernel/trace/trace_output.c |    5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3359,8 +3359,8 @@ static void print_func_help_header(struc
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   CPU#   %s  TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |       |    %s     |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
+	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
 }
 
 static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file *m,
@@ -3380,9 +3380,9 @@ static void print_func_help_header_irq(s
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
 
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -594,8 +594,7 @@ int trace_print_context(struct trace_ite
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d [%03d] ",
-			       comm, entry->pid, iter->cpu);
+	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
@@ -606,6 +605,8 @@ int trace_print_context(struct trace_ite
 			trace_seq_printf(s, "(%5d) ", tgid);
 	}
 
+	trace_seq_printf(s, "[%03d] ", iter->cpu);
+
 	if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
 		trace_print_lat_fmt(s, entry);
 


