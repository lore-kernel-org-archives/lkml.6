Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeCIKt6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:49:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCIKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:49:55 -0500
Date: Fri, 9 Mar 2018 02:49:46 -0800
From: tip-bot for Bartosz Golaszewski <tipbot@zytor.com>
Message-ID: <tip-f09777fa891327ee0dd892e83619f156bf1c37e6@git.kernel.org>
Cc: brgl@bgdev.pl, tglx@linutronix.de, mingo@kernel.org,
        marc.zyngier@arm.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        brgl@bgdev.pl, mingo@kernel.org, marc.zyngier@arm.com
In-Reply-To: <20180304121018.640-4-brgl@bgdev.pl>
References: <20180304121018.640-4-brgl@bgdev.pl>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irq_sim: Return the base of the irq range
 from irq_sim_init()
Git-Commit-ID: f09777fa891327ee0dd892e83619f156bf1c37e6
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

Commit-ID:  f09777fa891327ee0dd892e83619f156bf1c37e6
Gitweb:     https://git.kernel.org/tip/f09777fa891327ee0dd892e83619f156bf1c37e6
Author:     Bartosz Golaszewski <brgl@bgdev.pl>
AuthorDate: Sun, 4 Mar 2018 13:10:18 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Mar 2018 11:44:03 +0100

genirq/irq_sim: Return the base of the irq range from irq_sim_init()

Returning the base of the allocated interrupt range from irq_sim_init() and
devm_irq_sim_init() allows users to handle the logic of associating irq
numbers with any other driver-specific resources without having to use
irq_sim_irqnum().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20180304121018.640-4-brgl@bgdev.pl

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
 
