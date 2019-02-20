Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97235C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9402146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfBTSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfBTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC94218C3;
        Wed, 20 Feb 2019 18:38:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWku-0006dC-0G; Wed, 20 Feb 2019 13:38:04 -0500
Message-Id: <20190220183803.890956792@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 07/29] tracing/doc: Add latency tracer funcgraph example
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

This add an example about how to use funcgraph with latency tracers.

Link: http://lkml.kernel.org/r/20190101154614.8887-6-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 0131df7f5968..6ce2763a2a3e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1396,6 +1396,57 @@ enabling function tracing, we incur an added overhead. This
 overhead may extend the latency times. But nevertheless, this
 trace has provided some very helpful debugging information.
 
+If we prefer function graph output instead of function, we can set
+display-graph option::
+ with echo 1 > options/display-graph
+
+  # tracer: irqsoff
+  #
+  # irqsoff latency trace v1.1.5 on 4.20.0-rc6+
+  # --------------------------------------------------------------------
+  # latency: 3751 us, #274/274, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:4)
+  #    -----------------
+  #    | task: bash-1507 (uid:0 nice:0 policy:0 rt_prio:0)
+  #    -----------------
+  #  => started at: free_debug_processing
+  #  => ended at:   return_to_handler
+  #
+  #
+  #                                       _-----=> irqs-off
+  #                                      / _----=> need-resched
+  #                                     | / _---=> hardirq/softirq
+  #                                     || / _--=> preempt-depth
+  #                                     ||| /
+  #   REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
+  #      |          |     |    |        ||||      |   |                     |   |   |   |
+          0 us |   0)   bash-1507    |  d... |   0.000 us    |  _raw_spin_lock_irqsave();
+          0 us |   0)   bash-1507    |  d..1 |   0.378 us    |    do_raw_spin_trylock();
+          1 us |   0)   bash-1507    |  d..2 |               |    set_track() {
+          2 us |   0)   bash-1507    |  d..2 |               |      save_stack_trace() {
+          2 us |   0)   bash-1507    |  d..2 |               |        __save_stack_trace() {
+          3 us |   0)   bash-1507    |  d..2 |               |          __unwind_start() {
+          3 us |   0)   bash-1507    |  d..2 |               |            get_stack_info() {
+          3 us |   0)   bash-1507    |  d..2 |   0.351 us    |              in_task_stack();
+          4 us |   0)   bash-1507    |  d..2 |   1.107 us    |            }
+  [...]
+       3750 us |   0)   bash-1507    |  d..1 |   0.516 us    |      do_raw_spin_unlock();
+       3750 us |   0)   bash-1507    |  d..1 |   0.000 us    |  _raw_spin_unlock_irqrestore();
+       3764 us |   0)   bash-1507    |  d..1 |   0.000 us    |  tracer_hardirqs_on();
+      bash-1507    0d..1 3792us : <stack trace>
+   => free_debug_processing
+   => __slab_free
+   => kmem_cache_free
+   => vm_area_free
+   => remove_vma
+   => exit_mmap
+   => mmput
+   => flush_old_exec
+   => load_elf_binary
+   => search_binary_handler
+   => __do_execve_file.isra.32
+   => __x64_sys_execve
+   => do_syscall_64
+   => entry_SYSCALL_64_after_hwframe
 
 preemptoff
 ----------
-- 
2.20.1


