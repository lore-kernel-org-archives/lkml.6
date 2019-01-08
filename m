Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8945DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7A6206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfAHN6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:58:46 -0500
Received: from foss.arm.com ([217.140.101.70]:51988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfAHN6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:58:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5819980D;
        Tue,  8 Jan 2019 05:58:45 -0800 (PST)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 455EF3F70D;
        Tue,  8 Jan 2019 05:58:44 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: irq: Add IRQ_SET_MASK_OK_DONE handling in migrate_one_irq()
Date:   Tue,  8 Jan 2019 13:58:05 +0000
Message-Id: <20190108135805.5535-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm TC2 (multi_v7_defconfig plus CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and
CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y) fails hotplug stress tests.

This issue was tracked down to a missing copy of the new affinity
cpumask of the vexpress-spc interrupt into struct
irq_common_data.affinity when the interrupt is migrated in
migrate_one_irq().

Commit 0407daceedfe ("irqchip/gic: Return IRQ_SET_MASK_OK_DONE in the
set_affinity method") changed the return value of the irq_set_affinity()
function of the GIC from IRQ_SET_MASK_OK to IRQ_SET_MASK_OK_DONE.

In migrate_one_irq() if the current irq affinity mask and the cpu
online mask do not share any CPU, the affinity mask is set to the cpu
online mask. In this case (ret == true) and when the irq chip
function irq_set_affinity() returns successfully (IRQ_SET_MASK_OK),
struct irq_common_data.affinity should also be updated.

Add IRQ_SET_MASK_OK_DONE next to IRQ_SET_MASK_OK when checking that the
irq chip function irq_set_affinity() returns successfully.

Commit 2cb625478f8c ("genirq: Add IRQ_SET_MASK_OK_DONE to support
stacked irqchip") only added IRQ_SET_MASK_OK_DONE handling to
irq_do_set_affinity() in the irq core and not to the Arm32 irq code.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

The hotplug issue on Arm TC2 happens because the vexpress-spc interrupt
(irq=22) is affine to CPU0. This occurs since it is setup early when the
cpu_online_mask is still 0.
But the problem with the missing copy of the affinity mask should occur
with every interrupt which is forced to migrate.

With additional debug in irq_setup_affinity():

[0.000619] irq_setup_affinity(): irq=17 mask=0 cpu_online_mask=0 set=0-4
[0.007065] irq_setup_affinity(): irq=22 mask=0 cpu_online_mask=0 set=0-4
[3.372907] irq_setup_affinity(): irq=47 mask=0-4 cpu_online_mask=0-4
set=0-4

cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4
22:        316          0          0          0          0     GIC-0 127
Level     vexpress-spc

cat /proc/irq/22/smp_affinity_list 
0

 arch/arm/kernel/irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 9908dacf9229..ddb828b0235b 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -117,6 +117,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
 	struct irq_chip *c;
 	bool ret = false;
+	int ret2;
 
 	/*
 	 * If this is a per-CPU interrupt, or the affinity does not
@@ -131,9 +132,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	}
 
 	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
+	if (!c->irq_set_affinity) {
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
+		return ret;
+	}
+
+	ret2 = c->irq_set_affinity(d, affinity, false);
+
+	if ((ret2 == IRQ_SET_MASK_OK || ret2 == IRQ_SET_MASK_OK_DONE) && ret)
 		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
 
 	return ret;
-- 
2.11.0

