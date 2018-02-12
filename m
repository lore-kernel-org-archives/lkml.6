Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935727AbeBLNz6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:55:58 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:55980 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934690AbeBLNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:55:26 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/3] irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock handling
Date: Mon, 12 Feb 2018 14:55:11 +0100
Message-Id: <1518443713-1835-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 705bc96c2c15313c ("irqchip: renesas-intc-irqpin: Add
minimal runtime PM support"), when an IRQ is used for wakeup, the INTC
block's module clock (if exists) is manually kept running during system
suspend, to make sure the device stays active.

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
  - Mark intc_irqpin_suspend() __maybe_unused,

v2 (sent by Ulf Hanson):
  - Convert to use the WAKEUP_PATH driver PM flag (Ulf).
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 40 +++++++++++++------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index cee59fe1321c44f9..c6e6c9e9137ad1d2 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -78,16 +77,14 @@ struct intc_irqpin_priv {
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
+	atomic_t wakeup_path;
 	unsigned shared_irqs:1;
-	unsigned needs_clk:1;
 	u8 shared_irq_mask;
 };
 
 struct intc_irqpin_config {
 	unsigned int irlm_bit;
 	unsigned needs_irlm:1;
-	unsigned needs_clk:1;
 };
 
 static unsigned long intc_irqpin_read32(void __iomem *iomem)
@@ -287,14 +284,10 @@ static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
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
@@ -369,12 +362,10 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
 	.irlm_bit = 23, /* ICR0.IRLM0 */
 	.needs_irlm = 1,
-	.needs_clk = 0,
 };
 
 static const struct intc_irqpin_config intc_irqpin_rmobile = {
 	.needs_irlm = 0,
-	.needs_clk = 1,
 };
 
 static const struct of_device_id intc_irqpin_dt_ids[] = {
@@ -426,18 +417,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	config = of_device_get_match_data(dev);
-	if (config)
-		p->needs_clk = config->needs_clk;
-
-	p->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		if (p->needs_clk) {
-			dev_err(dev, "unable to get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err0;
-		}
-		p->clk = NULL;
-	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -606,12 +585,25 @@ static int intc_irqpin_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused intc_irqpin_suspend(struct device *dev)
+{
+	struct intc_irqpin_priv *p = dev_get_drvdata(dev);
+
+	if (atomic_read(&p->wakeup_path))
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
+
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
 	.remove		= intc_irqpin_remove,
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
 		.of_match_table = intc_irqpin_dt_ids,
+		.pm	= &intc_irqpin_pm_ops,
 	}
 };
 
-- 
2.7.4
