Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB562080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB562080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJaRiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:38:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37258 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeJaRiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:38:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0DE341;
        Wed, 31 Oct 2018 01:41:43 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA8B3F557;
        Wed, 31 Oct 2018 01:41:42 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>, arm@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
Date:   Wed, 31 Oct 2018 08:41:34 +0000
Message-Id: <20181031084134.96289-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Keystone QMSS driver is pretty damaged, in the sense that it
does things like this:

	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));

where cpu_map is a local variable. As we leave the function, this
will point to nowhere-land, and things will end-up badly.

Instead, let's use a proper cpumask that gets allocated, giving
the driver a chance to actually work with things like irqbalance
as well as have a hypothetical 64bit future.

Cc: stable@vger.kernel.org
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v1:
  - Added Santosh's Ack
  - Cc stable
  - Directly sent to arm-soc for immediate pick-up
    (https://lore.kernel.org/lkml/0a20aaf3-65ce-a7ae-8a0e-877313483969@oracle.com/)

 drivers/soc/ti/knav_qmss.h       |  4 ++--
 drivers/soc/ti/knav_qmss_acc.c   | 10 +++++-----
 drivers/soc/ti/knav_qmss_queue.c | 22 +++++++++++++++-------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 3efc47e82973..bd040c29c4bf 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -329,8 +329,8 @@ struct knav_range_ops {
 };
 
 struct knav_irq_info {
-	int	irq;
-	u32	cpu_map;
+	int		irq;
+	struct cpumask	*cpu_mask;
 };
 
 struct knav_range_info {
diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 316e82e46f6c..2f7fb2dcc1d6 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -205,18 +205,18 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
 {
 	struct knav_device *kdev = range->kdev;
 	struct knav_acc_channel *acc;
-	unsigned long cpu_map;
+	struct cpumask *cpu_mask;
 	int ret = 0, irq;
 	u32 old, new;
 
 	if (range->flags & RANGE_MULTI_QUEUE) {
 		acc = range->acc;
 		irq = range->irqs[0].irq;
-		cpu_map = range->irqs[0].cpu_map;
+		cpu_mask = range->irqs[0].cpu_mask;
 	} else {
 		acc = range->acc + queue;
 		irq = range->irqs[queue].irq;
-		cpu_map = range->irqs[queue].cpu_map;
+		cpu_mask = range->irqs[queue].cpu_mask;
 	}
 
 	old = acc->open_mask;
@@ -239,8 +239,8 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
 			acc->name, acc->name);
 		ret = request_irq(irq, knav_acc_int_handler, 0, acc->name,
 				  range);
-		if (!ret && cpu_map) {
-			ret = irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
+		if (!ret && cpu_mask) {
+			ret = irq_set_affinity_hint(irq, cpu_mask);
 			if (ret) {
 				dev_warn(range->kdev->dev,
 					 "Failed to set IRQ affinity\n");
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index b5d5673c255c..8b418379272d 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -118,19 +118,17 @@ static int knav_queue_setup_irq(struct knav_range_info *range,
 			  struct knav_queue_inst *inst)
 {
 	unsigned queue = inst->id - range->queue_base;
-	unsigned long cpu_map;
 	int ret = 0, irq;
 
 	if (range->flags & RANGE_HAS_IRQ) {
 		irq = range->irqs[queue].irq;
-		cpu_map = range->irqs[queue].cpu_map;
 		ret = request_irq(irq, knav_queue_int_handler, 0,
 					inst->irq_name, inst);
 		if (ret)
 			return ret;
 		disable_irq(irq);
-		if (cpu_map) {
-			ret = irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
+		if (range->irqs[queue].cpu_mask) {
+			ret = irq_set_affinity_hint(irq, range->irqs[queue].cpu_mask);
 			if (ret) {
 				dev_warn(range->kdev->dev,
 					 "Failed to set IRQ affinity\n");
@@ -1262,9 +1260,19 @@ static int knav_setup_queue_range(struct knav_device *kdev,
 
 		range->num_irqs++;
 
-		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3)
-			range->irqs[i].cpu_map =
-				(oirq.args[2] & 0x0000ff00) >> 8;
+		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3) {
+			unsigned long mask;
+			int bit;
+
+			range->irqs[i].cpu_mask = devm_kzalloc(dev,
+							       cpumask_size(), GFP_KERNEL);
+			if (!range->irqs[i].cpu_mask)
+				return -ENOMEM;
+
+			mask = (oirq.args[2] & 0x0000ff00) >> 8;
+			for_each_set_bit(bit, &mask, BITS_PER_LONG)
+				cpumask_set_cpu(bit, range->irqs[i].cpu_mask);
+		}
 	}
 
 	range->num_irqs = min(range->num_irqs, range->num_queues);
-- 
2.19.1

