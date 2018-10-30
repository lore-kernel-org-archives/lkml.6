Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C030CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944F82075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944F82075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJaAfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:35:31 -0400
Received: from foss.arm.com ([217.140.101.70]:54834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJaAfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:35:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB2280D;
        Tue, 30 Oct 2018 08:41:33 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8383F5D3;
        Tue, 30 Oct 2018 08:41:31 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     davem@davemloft.net, Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, gregory.clement@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH] net: mvpp2: Fix affinity hint allocation
Date:   Tue, 30 Oct 2018 15:41:00 +0000
Message-Id: <20181030154100.78512-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvpp2 driver has the curious behaviour of passing a stack variable
to irq_set_affinity_hint(), which results in the kernel exploding
the first time anyone accesses this information. News flash: userspace
does, and irqbalance will happily take the machine down. Great stuff.

An easy fix is to track the mask within the queue_vector structure,
and to make sure it has the same lifetime as the interrupt itself.

Fixes: e531f76757eb ("net: mvpp2: handle cases where more CPUs are available than s/w threads")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
As requested in https://lore.kernel.org/lkml/20181030135354.GD3407@kwain/

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h     |  1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c    | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 176c6b56fdcc..398328f10743 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -796,6 +796,7 @@ struct mvpp2_queue_vector {
 	int nrxqs;
 	u32 pending_cause_rx;
 	struct mvpp2_port *port;
+	struct cpumask *mask;
 };
 
 struct mvpp2_port {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 14f9679c957c..7a37a37e3fb3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3298,24 +3298,30 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
 	for (i = 0; i < port->nqvecs; i++) {
 		struct mvpp2_queue_vector *qv = port->qvecs + i;
 
-		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE)
+		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
+			qv->mask = kzalloc(cpumask_size(), GFP_KERNEL);
+			if (!qv->mask) {
+				err = -ENOMEM;
+				goto err;
+			}
+
 			irq_set_status_flags(qv->irq, IRQ_NO_BALANCING);
+		}
 
 		err = request_irq(qv->irq, mvpp2_isr, 0, port->dev->name, qv);
 		if (err)
 			goto err;
 
 		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
-			unsigned long mask = 0;
 			unsigned int cpu;
 
 			for_each_present_cpu(cpu) {
 				if (mvpp2_cpu_to_thread(port->priv, cpu) ==
 				    qv->sw_thread_id)
-					mask |= BIT(cpu);
+					cpumask_set_cpu(cpu, qv->mask);
 			}
 
-			irq_set_affinity_hint(qv->irq, to_cpumask(&mask));
+			irq_set_affinity_hint(qv->irq, qv->mask);
 		}
 	}
 
@@ -3325,6 +3331,8 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
 		struct mvpp2_queue_vector *qv = port->qvecs + i;
 
 		irq_set_affinity_hint(qv->irq, NULL);
+		kfree(qv->mask);
+		qv->mask = NULL;
 		free_irq(qv->irq, qv);
 	}
 
@@ -3339,6 +3347,8 @@ static void mvpp2_irqs_deinit(struct mvpp2_port *port)
 		struct mvpp2_queue_vector *qv = port->qvecs + i;
 
 		irq_set_affinity_hint(qv->irq, NULL);
+		kfree(qv->mask);
+		qv->mask = NULL;
 		irq_clear_status_flags(qv->irq, IRQ_NO_BALANCING);
 		free_irq(qv->irq, qv);
 	}
-- 
2.19.1

