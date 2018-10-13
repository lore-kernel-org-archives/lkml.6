Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF8BC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1DA20877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1DA20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeJMNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:46:18 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50833 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbeJMNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:46:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438239|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.D1Pm9vs_1539411013;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D1Pm9vs_1539411013)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sat, 13 Oct 2018 14:10:13 +0800
Date:   Sat, 13 Oct 2018 14:10:03 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH V8 16/21] csky: SMP support
Message-ID: <20181013060901.GA633@guoren-Inspiron-7460>
References: <cover.1539315390.git.ren_guo@c-sky.com>
 <608ece7942caa7c4b677b3cedd699e1a85b39d0f.1539315391.git.ren_guo@c-sky.com>
 <50781e74-e19b-e0e0-8ce5-d906878e249d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50781e74-e19b-e0e0-8ce5-d906878e249d@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
Thx for the review.

On Fri, Oct 12, 2018 at 12:09:52PM +0100, Marc Zyngier wrote:
> On 12/10/18 05:42, Guo Ren wrote:
> > This patch adds boot, ipi, hotplug code for SMP.

> > +static struct {
> > +	unsigned long bits ____cacheline_aligned;
> > +} ipi_data[NR_CPUS] __cacheline_aligned;
> 
> Why isn't this a per-cpu variable?
Ok, use per-cpu.


> > +void *__cpu_up_stack_pointer[NR_CPUS];
> > +void *__cpu_up_task_pointer[NR_CPUS];
> 
> Why aren't these per-cpu variables? More importantly, what are they used
> for? None of the patches in this series are using them.
No use at all, remove them :-P

> > +void __init enable_smp_ipi(void)
> > +{
> > +	enable_percpu_irq(ipi_irq, 0);
> > +}
> 
> Why isn't this function static?
Ok, static. and remove the declaration in asm/smp.h

> > +volatile unsigned int secondary_hint;
> > +volatile unsigned int secondary_ccr;
> > +volatile unsigned int secondary_stack;
> 
> This looks pretty dodgy.
It's not dodgy. They are used to pass hint,ccr,sp regs value for
seconardy CPU in smp.c:csky_start_secondary().

> Shouldn't you be using READ_ONCE/WRITE_ONCE instead?
The most problem is all other CPUs is in reset state not running and
CIU just fake signal for MESI. So we must flush all data into the
DRAM/L2cache. When secondary CPUs bootup from reset, they could see
right value in RAM.

So barrier is no use at all, we must flush dcache here and I'll add a
comment for explain.

Here is my modification with your feedback:

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 5ea9516..36ebaf9 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -22,9 +22,10 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-static struct {
+struct ipi_data_struct {
 	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+};
+static DEFINE_PER_CPU(struct ipi_data_struct, ipi_data);
 
 enum ipi_message_type {
 	IPI_EMPTY,
@@ -35,12 +36,10 @@ enum ipi_message_type {
 
 static irqreturn_t handle_ipi(int irq, void *dev)
 {
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-
 	while (true) {
 		unsigned long ops;
 
-		ops = xchg(pending_ipis, 0);
+		ops = xchg(&this_cpu_ptr(&ipi_data)->bits, 0);
 		if (ops == 0)
 			return IRQ_HANDLED;
 
@@ -74,7 +73,7 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	int i;
 
 	for_each_cpu(i, to_whom)
-		set_bit(operation, &ipi_data[i].bits);
+		set_bit(operation, &per_cpu_ptr(&ipi_data, i)->bits);
 
 	smp_mb();
 	send_arch_ipi(to_whom);
@@ -105,9 +104,6 @@ void smp_send_reschedule(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
-void *__cpu_up_stack_pointer[NR_CPUS];
-void *__cpu_up_task_pointer[NR_CPUS];
-
 void __init smp_prepare_boot_cpu(void)
 {
 }
@@ -116,7 +112,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-void __init enable_smp_ipi(void)
+static void __init enable_smp_ipi(void)
 {
 	enable_percpu_irq(ipi_irq, 0);
 }
@@ -173,7 +169,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 
 	secondary_ccr  = mfcr("cr18");
 
-	/* Flush dcache */
+	/*
+	 * Because other CPUs are in reset status, we must flush data
+	 * from cache to out and secondary CPUs use them in
+	 * csky_start_secondary(void)
+	 */
 	mtcr("cr17", 0x22);
 
 	/* Enable cpu in SMP reset ctrl reg */

Best Regards
 Guo Ren
