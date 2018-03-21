Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeCUQ7X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:59:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41689 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeCUQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:58:54 -0400
X-Google-Smtp-Source: AG47ELs7hLz4Lg7ZCBQLbMa7YhHj4qu+Nc9gOCl26K7mn/Pw9316i3ORNauNLF5U+caB3MWssRqKQw==
From: Stephen Boyd <swboyd@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be requested
Date: Wed, 21 Mar 2018 09:58:48 -0700
Message-Id: <20180321165848.89751-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180321165848.89751-1-swboyd@chromium.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Some qcom platforms make some GPIOs or pins unavailable for use
by non-secure operating systems, and thus reading or writing the
registers for those pins will cause access control issues and
reset the device. With a DT/ACPI property to describe the set of
pins that are available for use, parse the available pins and set
the irq valid bits for gpiolib to know what to consider 'valid'.
This should avoid any issues with gpiolib. Furthermore, implement
the pinmux_ops::request function so that pinmux can also make
sure to not use pins that are unavailable.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 69 ++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 495432f3341b..bc9cda0da886 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -105,6 +105,17 @@ static const struct pinctrl_ops msm_pinctrl_ops = {
 	.dt_free_map		= pinctrl_utils_free_map,
 };
 
+static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)
+{
+	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	struct gpio_chip *chip = &pctrl->chip;
+
+	if (gpiochip_line_is_valid(chip, offset))
+		return 0;
+
+	return -EINVAL;
+}
+
 static int msm_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -166,6 +177,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinmux_ops msm_pinmux_ops = {
+	.request		= msm_pinmux_request,
 	.get_functions_count	= msm_get_functions_count,
 	.get_function_name	= msm_get_function_name,
 	.get_function_groups	= msm_get_function_groups,
@@ -506,6 +518,9 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 		"pull up"
 	};
 
+	if (!gpiochip_line_is_valid(chip, offset))
+		return;
+
 	g = &pctrl->soc->groups[offset];
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
@@ -516,7 +531,7 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
-	seq_printf(s, " %s", pulls[pull]);
+	seq_printf(s, " %s\n", pulls[pull]);
 }
 
 static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -524,10 +539,8 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	unsigned gpio = chip->base;
 	unsigned i;
 
-	for (i = 0; i < chip->ngpio; i++, gpio++) {
+	for (i = 0; i < chip->ngpio; i++, gpio++)
 		msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
-		seq_puts(s, "\n");
-	}
 }
 
 #else
@@ -808,6 +821,46 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
+				    struct msm_pinctrl *pctrl)
+{
+	int ret;
+	unsigned int len, i;
+	unsigned int max_gpios = pctrl->soc->ngpios;
+
+	/* The number of GPIOs in the ACPI tables */
+	ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
+	if (ret > 0 && ret < max_gpios) {
+		u16 *tmp;
+
+		len = ret;
+		tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
+						     len);
+		if (ret < 0) {
+			dev_err(pctrl->dev, "could not read list of GPIOs\n");
+			kfree(tmp);
+			return ret;
+		}
+
+		bitmap_zero(chip->valid_mask, max_gpios);
+		for (i = 0; i < len; i++)
+			set_bit(tmp[i], chip->valid_mask);
+
+		return 0;
+	}
+
+	return 0;
+}
+
+static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
+{
+	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
+}
+
 static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
@@ -824,6 +877,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->parent = pctrl->dev;
 	chip->owner = THIS_MODULE;
 	chip->of_node = pctrl->dev->of_node;
+	chip->need_valid_mask = msm_gpio_needs_valid_mask(pctrl);
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
@@ -831,6 +885,13 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		return ret;
 	}
 
+	ret = msm_gpio_init_valid_mask(chip, pctrl);
+	if (ret) {
+		dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
+		gpiochip_remove(&pctrl->chip);
+		return ret;
+	}
+
 	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
 	if (ret) {
 		dev_err(pctrl->dev, "Failed to add pin range\n");
-- 
Sent by a computer through tubes
