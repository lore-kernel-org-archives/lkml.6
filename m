Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeCSKwG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:52:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53727 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932823AbeCSKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:52:05 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: Pass desc to __irq_free instead of irq number
Date: Mon, 19 Mar 2018 11:52:02 +0100
Message-Id: <20180319105202.9794-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that irq_to_desc() is a radix_tree_lookup and the reverse
operation is only a pointer dereference and that all callers of
__free_irq already have the desc, pass the desc instead of the irq
number.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is a micro optimisation I noticed while looking at the irq code.

Best regards
Uwe

 kernel/irq/manage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0f922729bab9..a08ba9a8da14 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1519,9 +1519,9 @@ EXPORT_SYMBOL_GPL(setup_irq);
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
  */
-static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
+static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	unsigned irq = desc->irq_data.irq;
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
@@ -1651,7 +1651,7 @@ void remove_irq(unsigned int irq, struct irqaction *act)
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc && !WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		__free_irq(irq, act->dev_id);
+		__free_irq(desc, act->dev_id);
 }
 EXPORT_SYMBOL_GPL(remove_irq);
 
@@ -1685,7 +1685,7 @@ const void *free_irq(unsigned int irq, void *dev_id)
 		desc->affinity_notify = NULL;
 #endif
 
-	action = __free_irq(irq, dev_id);
+	action = __free_irq(desc, dev_id);
 
 	if (!action)
 		return NULL;
-- 
2.16.2
