Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BD8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D6D20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D6D20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbeGJS13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbeGJS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6061BDB4;
        Tue, 10 Jul 2018 18:27:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 17/47] tracing: Fix missing return symbol in function_graph output
Date:   Tue, 10 Jul 2018 20:24:41 +0200
Message-Id: <20180710182337.860032759@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Changbin Du <changbin.du@intel.com>

commit 1fe4293f4b8de75824935f8d8e9a99c7fc6873da upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_functions_graph.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -768,6 +768,7 @@ print_graph_entry_leaf(struct trace_iter
 	struct ftrace_graph_ret *graph_ret;
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
+	int cpu = iter->cpu;
 	int i;
 
 	graph_ret = &ret_entry->ret;
@@ -776,7 +777,6 @@ print_graph_entry_leaf(struct trace_iter
 
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
-		int cpu = iter->cpu;
 
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 
@@ -806,6 +806,9 @@ print_graph_entry_leaf(struct trace_iter
 
 	trace_seq_printf(s, "%ps();\n", (void *)call->func);
 
+	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
+			cpu, iter->ent->pid, flags);
+
 	return trace_handle_return(s);
 }
 


