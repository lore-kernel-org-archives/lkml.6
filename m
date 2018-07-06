Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91BC6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B960C24011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B960C24011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeGFBHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932380AbeGFBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0763240C4;
        Fri,  6 Jul 2018 01:06:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fbFCo-0007KO-Ve; Thu, 05 Jul 2018 21:06:38 -0400
Message-Id: <20180706010638.884757368@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Jul 2018 21:06:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 6/6] tracing: Fix missing return symbol in function_graph output
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The function_graph tracer does not show the interrupt return marker for the
leaf entry. On leaf entries, we see an unbalanced interrupt marker (the
interrupt was entered, but nevern left).

Before:
 1)               |  SyS_write() {
 1)               |    __fdget_pos() {
 1)   0.061 us    |      __fget_light();
 1)   0.289 us    |    }
 1)               |    vfs_write() {
 1)   0.049 us    |      rw_verify_area();
 1) + 15.424 us   |      __vfs_write();
 1)   ==========> |
 1)   6.003 us    |      smp_apic_timer_interrupt();
 1)   0.055 us    |      __fsnotify_parent();
 1)   0.073 us    |      fsnotify();
 1) + 23.665 us   |    }
 1) + 24.501 us   |  }

After:
 0)               |  SyS_write() {
 0)               |    __fdget_pos() {
 0)   0.052 us    |      __fget_light();
 0)   0.328 us    |    }
 0)               |    vfs_write() {
 0)   0.057 us    |      rw_verify_area();
 0)               |      __vfs_write() {
 0)   ==========> |
 0)   8.548 us    |      smp_apic_timer_interrupt();
 0)   <========== |
 0) + 36.507 us   |      } /* __vfs_write */
 0)   0.049 us    |      __fsnotify_parent();
 0)   0.066 us    |      fsnotify();
 0) + 50.064 us   |    }
 0) + 50.952 us   |  }

Link: http://lkml.kernel.org/r/1517413729-20411-1-git-send-email-changbin.du@intel.com

Cc: stable@vger.kernel.org
Fixes: f8b755ac8e0cc ("tracing/function-graph-tracer: Output arrows signal on hardirq call/return")
Signed-off-by: Changbin Du <changbin.du@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 23c0b0cb5fb9..169b3c44ee97 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -831,6 +831,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	struct ftrace_graph_ret *graph_ret;
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
+	int cpu = iter->cpu;
 	int i;
 
 	graph_ret = &ret_entry->ret;
@@ -839,7 +840,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
-		int cpu = iter->cpu;
 
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 
@@ -869,6 +869,9 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 	trace_seq_printf(s, "%ps();\n", (void *)call->func);
 
+	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
+			cpu, iter->ent->pid, flags);
+
 	return trace_handle_return(s);
 }
 
-- 
2.17.1


