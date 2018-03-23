Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeCWQfp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:35:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42851 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeCWQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:35:00 -0400
X-Google-Smtp-Source: AG47ELstUqe5vnhWEKfCuG5iNXcVG6ATmW9AhWvSiVfW0D6fMvkD20I3Ajuwt+Pwvkh7vNhmbDYqZA==
From: Stephen Boyd <swboyd@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/5] gpiolib: Support 'gpio-reserved-ranges' property
Date: Fri, 23 Mar 2018 09:34:52 -0700
Message-Id: <20180323163453.96495-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Some qcom platforms make some GPIOs or pins unavailable for use by
non-secure operating systems, and thus reading or writing the registers
for those pins will cause access control issues. Add support for a DT
property to describe the set of GPIOs that are available for use so that
higher level OSes are able to know what pins to avoid reading/writing.
Non-DT platforms can add support by directly updating the
chip->valid_mask.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib-of.c   | 24 +++++++++++++++++++
 drivers/gpio/gpiolib.c      | 46 +++++++++++++++++++++++++++++++++++++
 include/linux/gpio/driver.h | 16 +++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 84e5a9df2344..ed81d9a6316f 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -511,6 +511,28 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 }
 EXPORT_SYMBOL(of_mm_gpiochip_remove);
 
+static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
+{
+	int len, i;
+	u32 start, count;
+	struct device_node *np = chip->of_node;
+
+	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
+	if (len < 0 || len % 2 != 0)
+		return;
+
+	for (i = 0; i < len; i += 2) {
+		of_property_read_u32_index(np, "gpio-reserved-ranges",
+					   i, &start);
+		of_property_read_u32_index(np, "gpio-reserved-ranges",
+					   i + 1, &count);
+		if (start >= chip->ngpio || start + count >= chip->ngpio)
+			continue;
+
+		bitmap_clear(chip->valid_mask, start, count);
+	}
+};
+
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
@@ -615,6 +637,8 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (chip->of_gpio_n_cells > MAX_PHANDLE_ARGS)
 		return -EINVAL;
 
+	of_gpiochip_init_valid_mask(chip);
+
 	status = of_gpiochip_add_pin_range(chip);
 	if (status)
 		return status;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index db3788d17ba0..fecbb553e8a4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -351,6 +351,43 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
 	return p;
 }
 
+static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
+{
+#ifdef CONFIG_OF_GPIO
+	int size;
+	struct device_node *np = gpiochip->of_node;
+
+	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
+	if (size > 0 && size % 2 == 0)
+		gpiochip->need_valid_mask = true;
+#endif
+
+	if (!gpiochip->need_valid_mask)
+		return 0;
+
+	gpiochip->valid_mask = gpiochip_allocate_mask(gpiochip);
+	if (!gpiochip->valid_mask)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void gpiochip_free_valid_mask(struct gpio_chip *gpiochip)
+{
+	kfree(gpiochip->valid_mask);
+	gpiochip->valid_mask = NULL;
+}
+
+bool gpiochip_line_is_valid(const struct gpio_chip *gpiochip,
+				unsigned int offset)
+{
+	/* No mask means all valid */
+	if (likely(!gpiochip->valid_mask))
+		return true;
+	return test_bit(offset, gpiochip->valid_mask);
+}
+EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
+
 /*
  * GPIO line handle management
  */
@@ -1275,6 +1312,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_from_list;
 
+	status = gpiochip_init_valid_mask(chip);
+	if (status)
+		goto err_remove_irqchip_mask;
+
 	status = gpiochip_add_irqchip(chip, lock_key, request_key);
 	if (status)
 		goto err_remove_chip;
@@ -1304,6 +1345,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	acpi_gpiochip_remove(chip);
 	gpiochip_free_hogs(chip);
 	of_gpiochip_remove(chip);
+	gpiochip_free_valid_mask(chip);
+err_remove_irqchip_mask:
 	gpiochip_irqchip_free_valid_mask(chip);
 err_remove_from_list:
 	spin_lock_irqsave(&gpio_lock, flags);
@@ -1360,6 +1403,7 @@ void gpiochip_remove(struct gpio_chip *chip)
 	acpi_gpiochip_remove(chip);
 	gpiochip_remove_pin_ranges(chip);
 	of_gpiochip_remove(chip);
+	gpiochip_free_valid_mask(chip);
 	/*
 	 * We accept no more calls into the driver from this point, so
 	 * NULL the driver data pointer
@@ -1536,6 +1580,8 @@ static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gpiochip)
 bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
 				unsigned int offset)
 {
+	if (!gpiochip_line_is_valid(gpiochip, offset))
+		return false;
 	/* No mask means all valid */
 	if (likely(!gpiochip->irq.valid_mask))
 		return true;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 1ba9a331ec51..5382b5183b7e 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -288,6 +288,21 @@ struct gpio_chip {
 	struct gpio_irq_chip irq;
 #endif
 
+	/**
+	 * @need_valid_mask:
+	 *
+	 * If set core allocates @valid_mask with all bits set to one.
+	 */
+	bool need_valid_mask;
+
+	/**
+	 * @valid_mask:
+	 *
+	 * If not %NULL holds bitmask of GPIOs which are valid to be used
+	 * from the chip.
+	 */
+	unsigned long *valid_mask;
+
 #if defined(CONFIG_OF_GPIO)
 	/*
 	 * If CONFIG_OF is enabled, then all GPIO controllers described in the
@@ -384,6 +399,7 @@ bool gpiochip_line_is_open_source(struct gpio_chip *chip, unsigned int offset);
 
 /* Sleep persistence inquiry for drivers */
 bool gpiochip_line_is_persistent(struct gpio_chip *chip, unsigned int offset);
+bool gpiochip_line_is_valid(const struct gpio_chip *chip, unsigned int offset);
 
 /* get driver data */
 void *gpiochip_get_data(struct gpio_chip *chip);
-- 
Sent by a computer through tubes
