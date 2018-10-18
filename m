Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3162148E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiJFefVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3162148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeJSCGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJSCGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D662148D;
        Thu, 18 Oct 2018 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885845;
        bh=Pn8iHZ0PHvRdQjFf7haZN2vk+Xmot2dWXORE9acQwcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiJFefVz+krTENBmp5xoHxKDY2GKtC6uZnTYmWHza3gpbLX5KgwewrKKRSm0AgaUG
         Ks1eT2CN+ep98194ZbbSvQNbKH/ChwF6p42lzaCYhspxuQK1qcLmSHdH+w0QLeY2oC
         6N0gF3Il2NgoEuEPuSZEZnlHyaxe0C7RbojtVq10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ivan Delalande <colona@arista.com>
Subject: [PATCH 4.9 33/35] sched/cputime: Fix ksoftirqd cputime accounting regression
Date:   Thu, 18 Oct 2018 19:55:02 +0200
Message-Id: <20181018175427.156878860@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <fweisbec@gmail.com>

commit 25e2d8c1b9e327ed260edd13169cc22bc7a78bc6 upstream.

irq_time_read() returns the irqtime minus the ksoftirqd time. This
is necessary because irq_time_read() is used to substract the IRQ time
from the sum_exec_runtime of a task. If we were to include the softirq
time of ksoftirqd, this task would substract its own CPU time everytime
it updates ksoftirqd->sum_exec_runtime which would therefore never
progress.

But this behaviour got broken by:

  a499a5a14db ("sched/cputime: Increment kcpustat directly on irqtime account")

... which now includes ksoftirqd softirq time in the time returned by
irq_time_read().

This has resulted in wrong ksoftirqd cputime reported to userspace
through /proc/stat and thus "top" not showing ksoftirqd when it should
after intense networking load.

ksoftirqd->stime happens to be correct but it gets scaled down by
sum_exec_runtime through task_cputime_adjusted().

To fix this, just account the strict IRQ time in a separate counter and
use it to report the IRQ time.

Reported-and-tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Reviewed-by: Rik van Riel <riel@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Link: http://lkml.kernel.org/r/1493129448-5356-1-git-send-email-fweisbec@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/cputime.c |   27 ++++++++++++++++-----------
 kernel/sched/sched.h   |    9 +++++++--
 2 files changed, 23 insertions(+), 13 deletions(-)

--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -37,6 +37,18 @@ void disable_sched_clock_irqtime(void)
 	sched_clock_irqtime = 0;
 }
 
+static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
+				  enum cpu_usage_stat idx)
+{
+	u64 *cpustat = kcpustat_this_cpu->cpustat;
+
+	u64_stats_update_begin(&irqtime->sync);
+	cpustat[idx] += delta;
+	irqtime->total += delta;
+	irqtime->tick_delta += delta;
+	u64_stats_update_end(&irqtime->sync);
+}
+
 /*
  * Called before incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
@@ -44,7 +56,6 @@ void disable_sched_clock_irqtime(void)
 void irqtime_account_irq(struct task_struct *curr)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
-	u64 *cpustat = kcpustat_this_cpu->cpustat;
 	s64 delta;
 	int cpu;
 
@@ -55,22 +66,16 @@ void irqtime_account_irq(struct task_str
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
 
-	u64_stats_update_begin(&irqtime->sync);
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
 	 * We want to continue accounting softirq time to ksoftirqd thread
 	 * in that case, so as not to confuse scheduler with a special task
 	 * that do not consume any time, but still wants to run.
 	 */
-	if (hardirq_count()) {
-		cpustat[CPUTIME_IRQ] += delta;
-		irqtime->tick_delta += delta;
-	} else if (in_serving_softirq() && curr != this_cpu_ksoftirqd()) {
-		cpustat[CPUTIME_SOFTIRQ] += delta;
-		irqtime->tick_delta += delta;
-	}
-
-	u64_stats_update_end(&irqtime->sync);
+	if (hardirq_count())
+		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
+	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 EXPORT_SYMBOL_GPL(irqtime_account_irq);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1743,6 +1743,7 @@ static inline void nohz_balance_exit_idl
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 struct irqtime {
+	u64			total;
 	u64			tick_delta;
 	u64			irq_start_time;
 	struct u64_stats_sync	sync;
@@ -1750,16 +1751,20 @@ struct irqtime {
 
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
 
+/*
+ * Returns the irqtime minus the softirq time computed by ksoftirqd.
+ * Otherwise ksoftirqd's sum_exec_runtime is substracted its own runtime
+ * and never move forward.
+ */
 static inline u64 irq_time_read(int cpu)
 {
 	struct irqtime *irqtime = &per_cpu(cpu_irqtime, cpu);
-	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
 	unsigned int seq;
 	u64 total;
 
 	do {
 		seq = __u64_stats_fetch_begin(&irqtime->sync);
-		total = cpustat[CPUTIME_SOFTIRQ] + cpustat[CPUTIME_IRQ];
+		total = irqtime->total;
 	} while (__u64_stats_fetch_retry(&irqtime->sync, seq));
 
 	return total;


