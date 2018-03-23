Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeCWQfE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:35:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38199 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeCWQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:35:01 -0400
X-Google-Smtp-Source: AG47ELvBr8g6qCyZc377NQ+7QEg4tDWEQvf3kObsZb+XYGv+6WzgMwxsEkGGYk5iCqBGO/kRf/QzJQ==
From: Stephen Boyd <swboyd@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/5] pinctrl: qcom: Don't allow protected pins to be requested
Date: Fri, 23 Mar 2018 09:34:53 -0700
Message-Id: <20180323163453.96495-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
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
 drivers/pinctrl/qcom/pinctrl-msm.c | 65 ++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 495432f3341b..e7abc8ba222b 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -105,6 +105,14 @@ static const struct pinctrl_ops msm_pinctrl_ops = {
 	.dt_free_map		= pinctrl_utils_free_map,
 };
 
+static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)
+{
+	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	struct gpio_chip *chip = &pctrl->chip;
+
+	return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;
+}
+
 static int msm_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -166,6 +174,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinmux_ops msm_pinmux_ops = {
+	.request		= msm_pinmux_request,
 	.get_functions_count	= msm_get_functions_count,
 	.get_function_name	= msm_get_function_name,
 	.get_function_groups	= msm_get_function_groups,
@@ -506,6 +515,9 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 		"pull up"
 	};
 
+	if (!gpiochip_line_is_valid(chip, offset))
+		return;
+
 	g = &pctrl->soc->groups[offset];
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
@@ -517,6 +529,7 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
 	seq_printf(s, " %s", pulls[pull]);
+	seq_puts(s, "\n");
 }
 
 static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -524,10 +537,8 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	unsigned gpio = chip->base;
 	unsigned i;
 
-	for (i = 0; i < chip->ngpio; i++, gpio++) {
+	for (i = 0; i < chip->ngpio; i++, gpio++)
 		msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
-		seq_puts(s, "\n");
-	}
 }
 
 #else
@@ -808,6 +819,46 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
+				    struct msm_pinctrl *pctrl)
+{
+	int ret;
+	unsigned int len, i;
+	unsigned int max_gpios = pctrl->soc->ngpios;
+	u16 *tmp;
+
+	/* The number of GPIOs in the ACPI tables */
+	len = ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
+	if (ret < 0)
+		return 0;
+
+	if (ret > max_gpios)
+		return -EINVAL;
+
+	tmp = kmalloc_array(len, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp, len);
+	if (ret < 0) {
+		dev_err(pctrl->dev, "could not read list of GPIOs\n");
+		goto out;
+	}
+
+	bitmap_zero(chip->valid_mask, max_gpios);
+	for (i = 0; i < len; i++)
+		set_bit(tmp[i], chip->valid_mask);
+
+out:
+	kfree(tmp);
+	return ret;
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
@@ -824,6 +875,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->parent = pctrl->dev;
 	chip->owner = THIS_MODULE;
 	chip->of_node = pctrl->dev->of_node;
+	chip->need_valid_mask = msm_gpio_needs_valid_mask(pctrl);
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
@@ -831,6 +883,13 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
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
