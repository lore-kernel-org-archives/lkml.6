Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeEMOGf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:06:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:06:33 -0400
Date: Sun, 13 May 2018 07:06:21 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-b2425b51bed7437c08c11ce71bb0f308f4516451@git.kernel.org>
Cc: hpa@zytor.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        miquel.raynal@bootlin.com, robh@kernel.org, tglx@linutronix.de,
        thomas.petazzoni@bootlin.com, jason@lakedaemon.net,
        srinivas.kandagatla@linaro.org
Reply-To: srinivas.kandagatla@linaro.org, jason@lakedaemon.net,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, robh@kernel.org, miquel.raynal@bootlin.com,
        mingo@kernel.org, ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        hpa@zytor.com
In-Reply-To: <20180508121438.11301-7-marc.zyngier@arm.com>
References: <20180508121438.11301-7-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip/gic-v3: Mark the base irq domain as
 DOMAIN_BUS_WIRED
Git-Commit-ID: b2425b51bed7437c08c11ce71bb0f308f4516451
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b2425b51bed7437c08c11ce71bb0f308f4516451
Gitweb:     https://git.kernel.org/tip/b2425b51bed7437c08c11ce71bb0f308f4516451
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:35 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:59:01 +0200

irqchip/gic-v3: Mark the base irq domain as DOMAIN_BUS_WIRED

As we're about to introduce MSI domains based on top of the GICv3
domain, we must make sure nothing the new domains do not alias
with the core domain.

So let's tag that core domain with the DOMAIN_BUS_WIRED attribute,
ensuring it gets picked up by other drivers that use irq_find_host().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-7-marc.zyngier@arm.com

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
