Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C5FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C43214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="I+DbVC7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfBLMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:53:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36029 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfBLMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:53:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1271757plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuVNCLAmtNZ7nQGEdg5l4VKoYRRZRzHCCstiWr3/9CU=;
        b=I+DbVC7/okKpwAiJJcB1GATjESetKUgkI0BoI3+DjMgrS8FUYAuRtMHAxn3ESb6CQH
         IuEHvlLhzRPqo4FOvyWlGTZJomz++sVlyCakfoWx/3yER5xlZxZ62KrZ0QbmF96PO+27
         iHllMe7JB5y3RhqJSAio49yAL1FaJzwKGBghC9PP+S+k4ygCHo+cEQfMIlwJzaQUlwM0
         fpdp0Fw5h0pKS+DR0DdanPrtIpneNmnNEb5o8o67kjCCZNFD0eUhEZp7rsur/IXxd4xR
         D7JKYoG3gTzBSvcbkIcPQebLGMI0M5voyRNUMMqnVjMGYqSMbn3exMOadC3jqbIEo1qN
         O4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuVNCLAmtNZ7nQGEdg5l4VKoYRRZRzHCCstiWr3/9CU=;
        b=PkCZ9RZUPiwcHUWJIMrMl+sPO/AQIz6bzNm3bZVgXu/bo2SyuSxyUhGK0mfe82R1KT
         zWB6Fxwkgaf2Gpk+dGOe8yaw4NCw9ajCFr55H/2p0Ta6IkYgX6ZPmRegZvp0oQJVGoY5
         jVzqiTKdWLV+Nit076s9l8ot6UZaQBkij+DJ4D9kSpjpFqxuiG/Nfe1Ll9O8Be5VUrh7
         ewRPBmGS99V5ZDux2rO5Nj5/PQPWUZ2hiJ+Wb5RE+CErjZlYu2eIo93ALwZhff9hC0QE
         sTgFhznLszej3mYu9fbaRDZN3orbsKDuBFgw2MIPiUzmK4JMiXmbDqtONpyNAjNDAqjP
         lHLA==
X-Gm-Message-State: AHQUAubUwkZALtwy2VrhN5/bj6I9LdYbWUKlegMfcaYuuYV0XqwP838T
        ZPVdNiyps/T0XRwMY5WZ4sLcQ4xw4rW3ZQ==
X-Google-Smtp-Source: AHgI3IYLdLL+MySfql0HYFYy9zD1GRJ8Mh86SWC5YPd157Wu6QBnP+sEFlqPdwT5SvSAuutd7b39Bw==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr3992870plf.202.1549976000057;
        Tue, 12 Feb 2019 04:53:20 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.205])
        by smtp.gmail.com with ESMTPSA id z67sm27894828pfd.188.2019.02.12.04.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:53:19 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v6 4/4] irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
Date:   Tue, 12 Feb 2019 18:22:46 +0530
Message-Id: <20190212125246.69239-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212125246.69239-1-anup@brainfault.org>
References: <20190212125246.69239-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on SMP host, all CPUs take external interrupts routed via
PLIC. All CPUs will try to claim a given external interrupt but only
one of them will succeed while other CPUs would simply resume whatever
they were doing before. This means if we have N CPUs then for every
external interrupt N-1 CPUs will always fail to claim it and waste
their CPU time.

Instead of above, external interrupts should be taken by only one CPU
and we should have provision to explicitly specify IRQ affinity from
kernel-space or user-space.

This patch provides irq_set_affinity() implementation for PLIC driver.
It also updates irq_enable() such that PLIC interrupts are only enabled
for one of CPUs specified in IRQ affinity mask.

With this patch in-place, we can change IRQ affinity at any-time from
user-space using procfs.

Example:

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  8:         44          0          0          0  SiFive PLIC   8  virtio0
 10:         48          0          0          0  SiFive PLIC  10  ttyS0
IPI0:        55        663         58        363  Rescheduling interrupts
IPI1:         0          1          3         16  Function call interrupts
/ #
/ #
/ # echo 4 > /proc/irq/10/smp_affinity
/ #
/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  8:         45          0          0          0  SiFive PLIC   8  virtio0
 10:        160          0         17          0  SiFive PLIC  10  ttyS0
IPI0:        68        693         77        410  Rescheduling interrupts
IPI1:         0          2          3         16  Function call interrupts

Signed-off-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 45 ++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 542a9e4c47fc..5eba0713b2e1 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -83,29 +83,59 @@ static inline void plic_toggle(struct plic_handler *handler,
 	raw_spin_unlock(&handler->enable_lock);
 }
 
-static inline void plic_irq_toggle(struct irq_data *d, int enable)
+static inline void plic_irq_toggle(const struct cpumask *mask,
+				   int hwirq, int enable)
 {
 	int cpu;
 
-	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
-	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
+	writel(enable, plic_regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
-			plic_toggle(handler, d->hwirq, enable);
+			plic_toggle(handler, hwirq, enable);
 	}
 }
 
 static void plic_irq_enable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 1);
+	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
+					   cpu_online_mask);
+	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+		return;
+	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
 }
 
 static void plic_irq_disable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 0);
+	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
 }
 
+#ifdef CONFIG_SMP
+static int plic_set_affinity(struct irq_data *d,
+			     const struct cpumask *mask_val, bool force)
+{
+	unsigned int cpu;
+
+	if (force)
+		cpu = cpumask_first(mask_val);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!irqd_irq_disabled(d)) {
+		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
+		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+	}
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	/*
@@ -114,6 +144,9 @@ static struct irq_chip plic_chip = {
 	 */
 	.irq_enable	= plic_irq_enable,
 	.irq_disable	= plic_irq_disable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
 };
 
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
-- 
2.17.1

