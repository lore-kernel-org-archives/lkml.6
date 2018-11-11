Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514D020871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514D020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeKLFuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:50:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730781AbeKLFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:33 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvst-0000tu-KX; Sun, 11 Nov 2018 19:59:03 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001fh-Dr; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Changbin Du" <changbin.du@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.840652693@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 225/366] tracing: Fix missing return symbol in
 function_graph output
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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

Fixes: f8b755ac8e0cc ("tracing/function-graph-tracer: Output arrows signal on hardirq call/return")
Signed-off-by: Changbin Du <changbin.du@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bwh: Backported to 3.16: Propagate return of TRACE_TYPE_PARTIAL_LINE from
 print_graph_irq()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_functions_graph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -828,6 +828,7 @@ print_graph_entry_leaf(struct trace_iter
 	struct ftrace_graph_ret *graph_ret;
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
+	int cpu = iter->cpu;
 	int ret;
 	int i;
 
@@ -837,7 +838,6 @@ print_graph_entry_leaf(struct trace_iter
 
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
-		int cpu = iter->cpu;
 
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 
@@ -874,6 +874,11 @@ print_graph_entry_leaf(struct trace_iter
 	if (!ret)
 		return TRACE_TYPE_PARTIAL_LINE;
 
+	ret = print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
+			      cpu, iter->ent->pid, flags);
+	if (ret == TRACE_TYPE_PARTIAL_LINE)
+		return ret;
+
 	return TRACE_TYPE_HANDLED;
 }
 

