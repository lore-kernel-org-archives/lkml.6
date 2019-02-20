Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE1CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBTSj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfBTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DDA21841;
        Wed, 20 Feb 2019 18:38:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWkt-0006ci-QW; Wed, 20 Feb 2019 13:38:03 -0500
Message-Id: <20190220183803.719429618@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 06/29] tracing: Put a margin between flags and duration for wakeup tracers
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Don't mix context flags with function duration info.

Instead of this:

 # tracer: wakeup_rt
 #
 # wakeup_rt latency trace v1.1.5 on 5.0.0-rc1-test+
 # --------------------------------------------------------------------
 # latency: 177 us, #545/545, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:8)
 #    -----------------
 #    | task: migration/0-11 (uid:0 nice:0 policy:1 rt_prio:99)
 #    -----------------
 #
 #                                       _-----=> irqs-off
 #                                      / _----=> need-resched
 #                                     | / _---=> hardirq/softirq
 #                                     || / _--=> preempt-depth
 #                                     ||| /
 #   REL TIME      CPU  TASK/PID       ||||  DURATION                  FUNCTION CALLS
 #      |          |     |    |        ||||   |   |                     |   |   |   |
         0 us |   0)    <idle>-0    |  dNh5              |  /*      0:120:R   + [000]    11:  0:R migration/0 */
         2 us |   0)    <idle>-0    |  dNh5  0.000 us    |            (null)();
         4 us |   0)    <idle>-0    |  dNh4              |  _raw_spin_unlock() {
         4 us |   0)    <idle>-0    |  dNh4  0.304 us    |    preempt_count_sub();
         5 us |   0)    <idle>-0    |  dNh3  1.063 us    |  }
         5 us |   0)    <idle>-0    |  dNh3  0.266 us    |  ttwu_stat();
         6 us |   0)    <idle>-0    |  dNh3              |  _raw_spin_unlock_irqrestore() {
         6 us |   0)    <idle>-0    |  dNh3  0.273 us    |    preempt_count_sub();
         6 us |   0)    <idle>-0    |  dNh2  0.818 us    |  }

Show this:

 # tracer: wakeup
 #
 # wakeup latency trace v1.1.5 on 4.20.0+
 # --------------------------------------------------------------------
 # latency: 593 us, #674/674, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:4)
 #    -----------------
 #    | task: kworker/0:1H-339 (uid:0 nice:-20 policy:0 rt_prio:0)
 #    -----------------
 #
 #                                      _-----=> irqs-off
 #                                     / _----=> need-resched
 #                                    | / _---=> hardirq/softirq
 #                                    || / _--=> preempt-depth
 #                                    ||| /
 #  REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
 #     |          |     |    |        ||||      |   |                     |   |   |   |
        0 us |   0)    <idle>-0    |  dNs. |               |  /*      0:120:R   + [000]   339:100:R kworker/0:1H */
        3 us |   0)    <idle>-0    |  dNs. |   0.000 us    |            (null)();
       67 us |   0)    <idle>-0    |  dNs. |   0.721 us    |  ttwu_stat();
       69 us |   0)    <idle>-0    |  dNs. |   0.607 us    |  _raw_spin_unlock_irqrestore();
       71 us |   0)    <idle>-0    |  .Ns. |   0.598 us    |  _raw_spin_lock_irq();
       72 us |   0)    <idle>-0    |  .Ns. |   0.584 us    |  _raw_spin_lock_irq();
       73 us |   0)    <idle>-0    |  dNs. | + 11.118 us   |  __next_timer_interrupt();
       75 us |   0)    <idle>-0    |  dNs. |               |  call_timer_fn() {
       76 us |   0)    <idle>-0    |  dNs. |               |    delayed_work_timer_fn() {
       76 us |   0)    <idle>-0    |  dNs. |               |      __queue_work() {
       ...

Link: http://lkml.kernel.org/r/20190101154614.8887-4-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 16ebbdd7b22e..69ebf3c2f1b5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -380,6 +380,7 @@ static void print_graph_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 {
 	trace_seq_putc(s, ' ');
 	trace_print_lat_fmt(s, entry);
+	trace_seq_puts(s, " | ");
 }
 
 /* If the pid changed since the last trace, output this event */
@@ -1153,7 +1154,7 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	if (flags & TRACE_GRAPH_PRINT_PROC)
 		seq_puts(s, "  TASK/PID       ");
 	if (lat)
-		seq_puts(s, "||||");
+		seq_puts(s, "||||   ");
 	if (flags & TRACE_GRAPH_PRINT_DURATION)
 		seq_puts(s, "  DURATION   ");
 	seq_puts(s, "               FUNCTION CALLS\n");
@@ -1169,7 +1170,7 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	if (flags & TRACE_GRAPH_PRINT_PROC)
 		seq_puts(s, "   |    |        ");
 	if (lat)
-		seq_puts(s, "||||");
+		seq_puts(s, "||||   ");
 	if (flags & TRACE_GRAPH_PRINT_DURATION)
 		seq_puts(s, "   |   |      ");
 	seq_puts(s, "               |   |   |   |\n");
-- 
2.20.1


