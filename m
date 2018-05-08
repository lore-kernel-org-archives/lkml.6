Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932353AbeEHMQS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:16:18 -0400
Received: from foss.arm.com ([217.140.101.70]:57542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932082AbeEHMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:15:10 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] irqchip/gic-v3: Mark the base irq domain as DOMAIN_BUS_WIRED
Date: Tue,  8 May 2018 13:14:35 +0100
Message-Id: <20180508121438.11301-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180508121438.11301-1-marc.zyngier@arm.com>
References: <20180508121438.11301-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're about to introduce MSI domains based on top of the GICv3
domain, we must make sure nothing the new domains do not alias
with the core domain.

So let's tag that core domain with the DOMAIN_BUS_WIRED attribute,
ensuring it gets picked up by other drivers that use irq_find_host().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e5d101418390..94164d7b87a6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1099,6 +1099,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
+	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
-- 
2.14.2
