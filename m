Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F73AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4463218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545960676;
	bh=PNdKjiejv1c3vuPKiJg74rlUNlPwA3twtEwJShES/JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sBbFskS6CTdJuC4tootVxnDuI4O5EnZVtYf9IgmUedLfKDKP/74YsKsf5Yg4SlFLX
	 QTlr2TANGpC4rLuuH+MA4rBD0uQtfMwmivJBbfBFAHwjaBYIGc9/AzVJw5Ro7k7CUM
	 +aUs9Jo/utAF/T7kGQ78uhdFtYZularQ4ikjCjn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeL1BbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeL1BbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:31:15 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408C021741;
        Fri, 28 Dec 2018 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545960673;
        bh=PNdKjiejv1c3vuPKiJg74rlUNlPwA3twtEwJShES/JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XddiK5ElwxSCYqhEdWRB1GOVXUXNhNisuQBXCc9+457f8he5jk+lNsK40GvK5vpWJ
         cXMhHWAw52bHpJyYAhvwbs3GvzUh4TKVVWCp1AI1Tk+a1he8Yb33hpi6obuD8bV8AO
         6kMa98ifHib5Q7IPLW3KbNmeDG3CV7rtccImlOIg=
Date:   Fri, 28 Dec 2018 02:31:10 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20181228013109.GB3749@lerouge>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
> 
> OK, did as you advised and here comes the trace. That's the related dmesg part:
> 
> [ 1479.025092] x86: Booting SMP configuration:
> [ 1479.025129] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 1479.094715] NOHZ: local_softirq_pending 202
> [ 1479.096557] smpboot: CPU 1 is now offline
> 
> Hope it helps.
> Heiner
> 
> 
> # tracer: nop
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
[...]
>           <idle>-0     [001] d.h2  1479.111017: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.111026: softirq_raise: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.111035: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.111040: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.111040: softirq_entry: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.111052: softirq_exit: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.111052: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] .Ns2  1479.111079: softirq_exit: vec=9 [action=RCU]
>          cpuhp/1-13    [001] dNh2  1479.112930: softirq_raise: vec=1 [action=TIMER]
>          cpuhp/1-13    [001] dNh2  1479.112935: softirq_raise: vec=9 [action=RCU]

Interesting, the softirq is raised from hardirq but it's not handled in the end of
the IRQ. Are you running threaded IRQS by any chance? If so I would expect ksoftirqd
to handle the pending work before we go idle. However I can imagine a small window
where such an expectation may not be met: if the softirq is raised after the ksoftirqd
thread is parked (CPUHP_AP_SMPBOOT_THREADS), which is right before we disable the CPU
(CPUHP_TEARDOWN_CPU).

I don't know if we can afford to ignore a softirq even at this late stage. We should
probably avoid leaking any. So here is a possible fix, if you don't mind trying:

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d288133..716096b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -56,6 +56,7 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+DEFINE_PER_CPU(int, ksoftirqd_parked);
 
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
@@ -363,7 +364,7 @@ static inline void invoke_softirq(void)
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
-	if (!force_irqthreads) {
+	if (!force_irqthreads || __this_cpu_read(ksoftirqd_parked)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
@@ -659,6 +660,22 @@ static void run_ksoftirqd(unsigned int cpu)
 	local_irq_enable();
 }
 
+static void ksoftirqd_park(unsigned int cpu)
+{
+	local_irq_disable();
+	__this_cpu_write(ksoftirqd_parked, 1);
+
+	if (local_softirq_pending())
+		run_ksoftirqd(cpu);
+
+	local_irq_enable();
+}
+
+static void ksoftirqd_unpark(unsigned int cpu)
+{
+	__this_cpu_write(ksoftirqd_parked, 0);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * tasklet_kill_immediate is called to remove a tasklet which can already be
@@ -724,6 +741,8 @@ static int takeover_tasklets(unsigned int cpu)
 static struct smp_hotplug_thread softirq_threads = {
 	.store			= &ksoftirqd,
 	.thread_should_run	= ksoftirqd_should_run,
+	.park			= ksoftirqd_park,
+	.unpark			= ksoftirqd_unpark,
 	.thread_fn		= run_ksoftirqd,
 	.thread_comm		= "ksoftirqd/%u",
 };
