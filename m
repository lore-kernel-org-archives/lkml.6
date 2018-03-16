Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeCPOzY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:55:24 -0400
Received: from foss.arm.com ([217.140.101.70]:57192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753917AbeCPOzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:55:22 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 1/2] irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE
Date: Fri, 16 Mar 2018 14:55:10 +0000
Message-Id: <20180316145511.28362-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180316145511.28362-1-marc.zyngier@arm.com>
References: <20180316145511.28362-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a huge number of broken device trees out there. Just
grepping through the tree for the use of IRQ_TYPE_NONE in conjunction
with the GIC is scary.

People just don't realise that IRQ_TYPE_NONE just doesn't exist, and
you just get whatever junk was there before. So let's make them aware
of the issue.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 79801c24800b..ac2e62d613d1 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1011,6 +1011,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 			*hwirq += 16;
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+		/* Make it clear that broken DTs are... broken */
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -1020,6 +1023,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
+
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
-- 
2.14.2
