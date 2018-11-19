Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D514C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D696520823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="03CDGpF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D696520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbeKTDNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389110AbeKTDNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:13:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B96520823;
        Mon, 19 Nov 2018 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646149;
        bh=gzsVuOOu7pXz93uoIvuZKMtRCGBJUf638TliymDHQ+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03CDGpF4YwwjLINqXfLjJo9QIX+eqXRSu5473BJUHynP7J9rUKVNGVp8/G453fOc4
         ODV0glvBMFsQBAl1u2+EHDcnaGwPkpXQthPuewdzZ4I3vzjFw19jFVHj5TQ44/SOP7
         qd6+AHgKP3IvG2rakJZF6uetLVenRtCXxeQEU1Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.14 055/124] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
Date:   Mon, 19 Nov 2018 17:28:29 +0100
Message-Id: <20181119162624.183294404@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 832ad0e3da4510fd17f98804abe512ea9a747035 upstream.

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
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/ti/knav_qmss.h       |    4 ++--
 drivers/soc/ti/knav_qmss_acc.c   |   10 +++++-----
 drivers/soc/ti/knav_qmss_queue.c |   22 +++++++++++++++-------
 3 files changed, 22 insertions(+), 14 deletions(-)

--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -321,8 +321,8 @@ struct knav_range_ops {
 };
 
 struct knav_irq_info {
-	int	irq;
-	u32	cpu_map;
+	int		irq;
+	struct cpumask	*cpu_mask;
 };
 
 struct knav_range_info {
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -205,18 +205,18 @@ static int knav_range_setup_acc_irq(stru
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
@@ -239,8 +239,8 @@ static int knav_range_setup_acc_irq(stru
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
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -102,19 +102,17 @@ static int knav_queue_setup_irq(struct k
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
@@ -1222,9 +1220,19 @@ static int knav_setup_queue_range(struct
 
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


