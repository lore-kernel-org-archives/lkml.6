Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934687AbeBLNz5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:55:57 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:55970 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934685AbeBLNz0 (ORCPT
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
Subject: [PATCH v3 3/3] gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
Date: Mon, 12 Feb 2018 14:55:13 +0100
Message-Id: <1518443713-1835-4-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO
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
  - Use an atomic_t instead of a boolean flag, as the latter tracked
    only the status of the last configured GPIO, while multiple GPIOs on
    the same GPIO controller may be involved with wake-up,
  - Use new helper device_set_wakeup_path(),
  - Drop checks for CONFIG_PM_SLEEP, as device_set_wakeup_path() is
    always available, unlike dev_pm_info.wakeup_path,
  - Mark gpio_rcar_suspend() __maybe_unused,
  - Drop RFC state, now the dependencies are upstream.

v2 (sent by Ulf Hanson):
  - Convert to use the WAKEUP_PATH driver PM flag (Ulf).
---
 drivers/gpio/gpio-rcar.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e76de57dd617d7e2..ebaea8b1594b7fc4 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -14,7 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -37,10 +36,9 @@ struct gpio_rcar_priv {
 	struct platform_device *pdev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
-	struct clk *clk;
 	unsigned int irq_parent;
+	atomic_t wakeup_path;
 	bool has_both_edge_trigger;
-	bool needs_clk;
 };
 
 #define IOINTSEL 0x00	/* General IO/Interrupt Switching Register */
@@ -186,13 +184,10 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
 		}
 	}
 
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
@@ -330,17 +325,14 @@ static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
 
 struct gpio_rcar_info {
 	bool has_both_edge_trigger;
-	bool needs_clk;
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
 	.has_both_edge_trigger = false,
-	.needs_clk = false,
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
 	.has_both_edge_trigger = true,
-	.needs_clk = true,
 };
 
 static const struct of_device_id gpio_rcar_of_table[] = {
@@ -403,7 +395,6 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
 	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
 	p->has_both_edge_trigger = info->has_both_edge_trigger;
-	p->needs_clk = info->needs_clk;
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(&p->pdev->dev,
@@ -440,16 +431,6 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
-	p->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		if (p->needs_clk) {
-			dev_err(dev, "unable to get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err0;
-		}
-		p->clk = NULL;
-	}
-
 	pm_runtime_enable(dev);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -531,11 +512,24 @@ static int gpio_rcar_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused gpio_rcar_suspend(struct device *dev)
+{
+	struct gpio_rcar_priv *p = dev_get_drvdata(dev);
+
+	if (atomic_read(&p->wakeup_path))
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(gpio_rcar_pm_ops, gpio_rcar_suspend, NULL);
+
 static struct platform_driver gpio_rcar_device_driver = {
 	.probe		= gpio_rcar_probe,
 	.remove		= gpio_rcar_remove,
 	.driver		= {
 		.name	= "gpio_rcar",
+		.pm     = &gpio_rcar_pm_ops,
 		.of_match_table = of_match_ptr(gpio_rcar_of_table),
 	}
 };
-- 
2.7.4
