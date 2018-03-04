Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeCDMKj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:10:39 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41778 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeCDMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:10:26 -0500
X-Google-Smtp-Source: AG47ELvrXO/NbYQ5UtP0yMRLP95yF6DoPZ0ZEyljBrxnawqiJq6/9DGoCa1mh8uSg4r4tghwZmRUXA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/3] irq/irq_sim: return the base of the irq range from irq_sim_init()
Date: Sun,  4 Mar 2018 13:10:18 +0100
Message-Id: <20180304121018.640-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180304121018.640-1-brgl@bgdev.pl>
References: <20180304121018.640-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning the base of the allocated interrupt range from irq_sim_init()
and devm_irq_sim_init() will allow users to handle the logic of
associating irq numbers with any other driver-specific resources
without having to use irq_sim_irqnum().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 kernel/irq/irq_sim.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 05f0d7c1698a..85690859a2a8 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -50,7 +50,8 @@ static void irq_sim_handle_irq(struct irq_work *work)
  * @sim:        The interrupt simulator object to initialize.
  * @num_irqs:   Number of interrupts to allocate
  *
- * Returns 0 on success and a negative error number on failure.
+ * On success: return the base of the allocated interrupt range.
+ * On failure: a negative errno.
  */
 int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 {
@@ -79,7 +80,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
 	sim->irq_count = num_irqs;
 
-	return 0;
+	return sim->irq_base;
 }
 EXPORT_SYMBOL_GPL(irq_sim_init);
 
@@ -111,7 +112,8 @@ static void devm_irq_sim_release(struct device *dev, void *res)
  * @sim:        The interrupt simulator object to initialize.
  * @num_irqs:   Number of interrupts to allocate
  *
- * Returns 0 on success and a negative error number on failure.
+ * On success: return the base of the allocated interrupt range.
+ * On failure: a negative errno.
  */
 int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 		      unsigned int num_irqs)
@@ -132,7 +134,7 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 	dr->sim = sim;
 	devres_add(dev, dr);
 
-	return 0;
+	return rv;
 }
 EXPORT_SYMBOL_GPL(devm_irq_sim_init);
 
-- 
2.16.1
