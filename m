Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B7215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9B7215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeHCATk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeHCATj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:19:39 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E273A215E5;
        Thu,  2 Aug 2018 22:26:27 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com,
        Philipp Schrader <philipp@peloton-tech.com>,
        stable-rt@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 04/15] tracing: Fix rcu splat from idle CPU on boot
Date:   Thu,  2 Aug 2018 17:25:19 -0500
Message-Id: <22a1b5d78156e46ecd575079f9b7f29b117c26e7.1533242791.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Schrader <philipp@peloton-tech.com>

With PREEMPT_RT and most of the lockdep-related options enabled I
encountered this splat when booting our DRA7 evaluation module:

[    0.055073]
[    0.055076] ===============================
[    0.055079] [ INFO: suspicious RCU usage. ]
[    0.055084] 4.1.6+ #2 Not tainted
[    0.055086] -------------------------------
[    0.055090] include/trace/events/hist.h:31 suspicious
rcu_dereference_check() usage!
[    0.055093]
[    0.055093] other info that might help us debug this:
[    0.055093]
[    0.055097]
[    0.055097] RCU used illegally from idle CPU!
[    0.055097] rcu_scheduler_active = 1, debug_locks = 1
[    0.055100] RCU used illegally from extended quiescent state!
[    0.055104] no locks held by swapper/0/0.
[    0.055106]
[    0.055106] stack backtrace:
[    0.055112] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.6+ #2
[    0.055116] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.055130] [<c00196b8>] (unwind_backtrace) from [<c001515c>]
(show_stack+0x20/0x24)
[    0.055146] [<c001515c>] (show_stack) from [<c07bc408>]
(dump_stack+0x84/0xa0)
[    0.055160] [<c07bc408>] (dump_stack) from [<c009bc38>]
(lockdep_rcu_suspicious+0xb0/0x110)
[    0.055172] [<c009bc38>] (lockdep_rcu_suspicious) from [<c01246c4>]
(time_hardirqs_off+0x2b8/0x3c8)
[    0.055184] [<c01246c4>] (time_hardirqs_off) from [<c009a218>]
(trace_hardirqs_off_caller+0x2c/0xf4)
[    0.055194] [<c009a218>] (trace_hardirqs_off_caller) from
[<c009a2f4>] (trace_hardirqs_off+0x14/0x18)
[    0.055204] [<c009a2f4>] (trace_hardirqs_off) from [<c00c7ecc>]
(rcu_idle_enter+0x78/0xcc)
[    0.055213] [<c00c7ecc>] (rcu_idle_enter) from [<c0093eb0>]
(cpu_startup_entry+0x190/0x518)
[    0.055222] [<c0093eb0>] (cpu_startup_entry) from [<c07b95b4>]
(rest_init+0x13c/0x17c)
[    0.055231] [<c07b95b4>] (rest_init) from [<c0b32c74>]
(start_kernel+0x320/0x380)
[    0.055238] [<c0b32c74>] (start_kernel) from [<8000807c>] (0x8000807c)

As per Steve Rotstedt's suggestion I changed the trace_* calls to
trace_*_rcuidle calls. He pointed out that the trace points were getting
triggered when rcu wasn't watching.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: stable-rt@vger.kernel.org
(cherry picked from commit ac56e4167d84ada099f2af0d1d53f4742d577ce9)
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_irqsoff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d1940b095d85..9cbc38722905 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -452,7 +452,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_PROVE_LOCKING
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
 }
@@ -461,7 +461,7 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 
 #else /* !CONFIG_PROVE_LOCKING */
-- 
2.14.1

