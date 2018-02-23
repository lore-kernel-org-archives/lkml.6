Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeBWWGP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:06:15 -0500
Received: from muru.com ([72.249.23.125]:58110 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbeBWWGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:06:14 -0500
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCHv2] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Fri, 23 Feb 2018 14:06:12 -0800
Message-Id: <20180223220612.35181-1-tony@atomide.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easy to grep :wakeup /proc/interrupts.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/power.h   |  1 +
 drivers/base/power/wakeirq.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -31,6 +31,7 @@ struct wake_irq {
 	struct device *dev;
 	unsigned int status;
 	int irq;
+	char *name;
 };
 
 extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -112,6 +112,7 @@ void dev_pm_clear_wake_irq(struct device *dev)
 		free_irq(wirq->irq, wirq);
 		wirq->status &= ~WAKE_IRQ_DEDICATED_MASK;
 	}
+	kfree(wirq->name);
 	kfree(wirq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
@@ -184,6 +185,14 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	if (!wirq)
 		return -ENOMEM;
 
+	wirq->name = kasprintf(GFP_KERNEL, "%s:%s",
+			       dev_name(dev),
+			       "wakeup");
+	if (!wirq->name) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+
 	wirq->dev = dev;
 	wirq->irq = irq;
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
@@ -196,9 +205,9 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	 * so we use a threaded irq.
 	 */
 	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-				   IRQF_ONESHOT, dev_name(dev), wirq);
+				   IRQF_ONESHOT, wirq->name, wirq);
 	if (err)
-		goto err_free;
+		goto err_free_name;
 
 	err = dev_pm_attach_wake_irq(dev, irq, wirq);
 	if (err)
@@ -210,6 +219,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
 err_free_irq:
 	free_irq(irq, wirq);
+err_free_name:
+	kfree(wirq->name);
 err_free:
 	kfree(wirq);
 
-- 
2.16.2
