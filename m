Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeCPOzo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:55:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57206 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754038AbeCPOzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:55:23 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 2/2] irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE
Date: Fri, 16 Mar 2018 14:55:11 +0000
Message-Id: <20180316145511.28362-3-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-gic-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3e9eeb6cb294..5bb7bb22f1c1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -916,6 +916,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		}
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+		/* Make it clear that broken DTs are... broken */
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -925,6 +928,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
+
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
-- 
2.14.2
