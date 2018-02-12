Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935614AbeBLNz2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:55:28 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:33018 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934522AbeBLNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:55:25 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/3] irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling
Date: Mon, 12 Feb 2018 14:55:12 +0100
Message-Id: <1518443713-1835-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6f46aedb9c85873b ("irqchip: renesas-irqc: Add wake-up
support"), when an IRQ is used for wakeup, the INTC
block's module clock is manually kept running during system suspend, to
make sure the device stays active.

However, this explicit clock handling is merely a workaround for a
failure to properly communicate wakeup information to the device core.

Instead, set the device's power.wakeup_path field, to indicate this
device is part of the wakeup path.  Depending on the PM Domain's
active_wakeup configuration, the genpd core code will keep the device
enabled (and the clock running) during system suspend when needed.
This allows for the removal of all explicit clock handling code from the
driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Revert to v1, as WAKEUP_PATH didn't make it,
  - Use an atomic_t instead of a boolean flag, as the boolean tracked
    only the status of the last configured GPIO, while multiple
    interrupt pins on the same interrupt controller may be involved with
    wake-up,
  - Use new helper device_set_wakeup_path(),
  - Drop checks for CONFIG_PM_SLEEP, as device_set_wakeup_path() is
    always available, unlike dev_pm_info.wakeup_path,
  - Mark irqc_suspend() __maybe_unused,
  - Drop RFC state, now the dependencies are upstream.

v2 (sent by Ulf Hanson):
  - Convert to use the WAKEUP_PATH driver PM flag (Ulf).
---
 drivers/irqchip/irq-renesas-irqc.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 52304b139aa46a60..a4f11124024dcf32 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -64,7 +63,7 @@ struct irqc_priv {
 	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
+	atomic_t wakeup_path;
 };
 
 static struct irqc_priv *irq_data_to_priv(struct irq_data *data)
@@ -111,14 +110,10 @@ static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
 	int hw_irq = irqd_to_hwirq(d);
 
 	irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
-
-	if (!p->clk)
-		return 0;
-
 	if (on)
-		clk_enable(p->clk);
+		atomic_inc(&p->wakeup_path);
 	else
-		clk_disable(p->clk);
+		atomic_dec(&p->wakeup_path);
 
 	return 0;
 }
@@ -159,12 +154,6 @@ static int irqc_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(p->clk)) {
-		dev_warn(&pdev->dev, "unable to get clock\n");
-		p->clk = NULL;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -276,6 +265,18 @@ static int irqc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused irqc_suspend(struct device *dev)
+{
+	struct irqc_priv *p = dev_get_drvdata(dev);
+
+	if (atomic_read(&p->wakeup_path))
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+
 static const struct of_device_id irqc_dt_ids[] = {
 	{ .compatible = "renesas,irqc", },
 	{},
@@ -288,6 +289,7 @@ static struct platform_driver irqc_device_driver = {
 	.driver		= {
 		.name	= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
+		.pm	= &irqc_pm_ops,
 	}
 };
 
-- 
2.7.4
