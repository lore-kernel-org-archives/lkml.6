Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDJUag (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:30:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36069 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeDJUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:30:34 -0400
X-Google-Smtp-Source: AIpwx4+WoF7i35wc57TvPWTUra0GvoSUvYPiCrcWmDgWVywKpiR4qW3tynM5IyBMhzqu3hVrItghIQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2] gpiolib: add hogs support for machine code
Date: Tue, 10 Apr 2018 22:30:28 +0200
Message-Id: <20180410203028.11412-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Board files constitute a significant part of the users of the legacy
GPIO framework. In many cases they only export a line and set its
desired value. We could use GPIO hogs for that like we do for DT and
ACPI but there's no support for that in machine code.

This patch proposes to extend the machine.h API with support for
registering hog tables in board files.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
v1 -> v2:
- kbuild bot complains about enum gpiod_flags having incomplete type
  although it builds fine for me locally: change the type of dflags
  to int

 Documentation/driver-api/gpio/board.rst | 16 ++++++
 drivers/gpio/gpiolib.c                  | 67 +++++++++++++++++++++++++
 include/linux/gpio/machine.h            | 31 ++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index 25d62b2e9fd0..2c112553df84 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -177,3 +177,19 @@ mapping and is thus transparent to GPIO consumers.
 
 A set of functions such as gpiod_set_value() is available to work with
 the new descriptor-oriented interface.
+
+Boards using platform data can also hog GPIO lines by defining GPIO hog tables.
+
+.. code-block:: c
+
+        struct gpiod_hog gpio_hog_table[] = {
+                GPIO_HOG("gpio.0", 10, "foo", GPIO_ACTIVE_LOW, GPIOD_OUT_HIGH),
+                { }
+        };
+
+And the table can be added to the board code as follows::
+
+        gpiod_add_hogs(gpio_hog_table);
+
+The line will be hogged as soon as the gpiochip is created or - in case the
+chip was created earlier - when the hog table is registered.
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43aeb07343ec..547adc149b62 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -71,6 +71,9 @@ static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
 LIST_HEAD(gpio_devices);
 
+static DEFINE_MUTEX(gpio_machine_hogs_mutex);
+static LIST_HEAD(gpio_machine_hogs);
+
 static void gpiochip_free_hogs(struct gpio_chip *chip);
 static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 				struct lock_class_key *lock_key,
@@ -1171,6 +1174,41 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	return status;
 }
 
+static void gpiochip_machine_hog(struct gpio_chip *chip, struct gpiod_hog *hog)
+{
+	struct gpio_desc *desc;
+	int rv;
+
+	desc = gpiochip_get_desc(chip, hog->chip_hwnum);
+	if (IS_ERR(desc)) {
+		pr_err("%s: unable to get GPIO desc: %ld\n",
+		       __func__, PTR_ERR(desc));
+		return;
+	}
+
+	if (desc->flags & FLAG_IS_HOGGED)
+		return;
+
+	rv = gpiod_hog(desc, hog->line_name, hog->lflags, hog->dflags);
+	if (rv)
+		pr_err("%s: unable to hog GPIO line (%s:%u): %d\n",
+		       __func__, chip->label, hog->chip_hwnum, rv);
+}
+
+static void machine_gpiochip_add(struct gpio_chip *chip)
+{
+	struct gpiod_hog *hog;
+
+	mutex_lock(&gpio_machine_hogs_mutex);
+
+	list_for_each_entry(hog, &gpio_machine_hogs, list) {
+		if (!strcmp(chip->label, hog->chip_label))
+			gpiochip_machine_hog(chip, hog);
+	}
+
+	mutex_unlock(&gpio_machine_hogs_mutex);
+}
+
 static void gpiochip_setup_devs(void)
 {
 	struct gpio_device *gdev;
@@ -1326,6 +1364,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	acpi_gpiochip_add(chip);
 
+	machine_gpiochip_add(chip);
+
 	/*
 	 * By first adding the chardev, and then adding the device,
 	 * we get a device node entry in sysfs under
@@ -3462,6 +3502,33 @@ void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
 }
 EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
 
+/**
+ * gpiod_add_hogs() - register a set of GPIO hogs from machine code
+ * @hogs: table of gpio hog entries with a zeroed sentinel at the end
+ */
+void gpiod_add_hogs(struct gpiod_hog *hogs)
+{
+	struct gpio_chip *chip;
+	struct gpiod_hog *hog;
+
+	mutex_lock(&gpio_machine_hogs_mutex);
+
+	for (hog = &hogs[0]; hog->chip_label; hog++) {
+		list_add_tail(&hog->list, &gpio_machine_hogs);
+
+		/*
+		 * The chip may have been registered earlier, so check if it
+		 * exists and, if so, try to hog the line now.
+		 */
+		chip = find_chip_by_name(hog->chip_label);
+		if (chip)
+			gpiochip_machine_hog(chip, hog);
+	}
+
+	mutex_unlock(&gpio_machine_hogs_mutex);
+}
+EXPORT_SYMBOL_GPL(gpiod_add_hogs);
+
 static struct gpiod_lookup_table *gpiod_find_lookup_table(struct device *dev)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index b2f2dc638463..daa44eac9241 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -39,6 +39,23 @@ struct gpiod_lookup_table {
 	struct gpiod_lookup table[];
 };
 
+/**
+ * struct gpiod_hog - GPIO line hog table
+ * @chip_label: name of the chip the GPIO belongs to
+ * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
+ * @line_name: consumer name for the hogged line
+ * @lflags: mask of GPIO lookup flags
+ * @dflags: GPIO flags used to specify the direction and value
+ */
+struct gpiod_hog {
+	struct list_head list;
+	const char *chip_label;
+	u16 chip_hwnum;
+	const char *line_name;
+	enum gpio_lookup_flags lflags;
+	int dflags;
+};
+
 /*
  * Simple definition of a single GPIO under a con_id
  */
@@ -59,10 +76,23 @@ struct gpiod_lookup_table {
 	.flags = _flags,                                                  \
 }
 
+/*
+ * Simple definition of a single GPIO hog in an array.
+ */
+#define GPIO_HOG(_chip_label, _chip_hwnum, _line_name, _lflags, _dflags)  \
+{                                                                         \
+	.chip_label = _chip_label,                                        \
+	.chip_hwnum = _chip_hwnum,                                        \
+	.line_name = _line_name,                                          \
+	.lflags = _lflags,                                                \
+	.dflags = _dflags,                                                \
+}
+
 #ifdef CONFIG_GPIOLIB
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table);
 void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n);
 void gpiod_remove_lookup_table(struct gpiod_lookup_table *table);
+void gpiod_add_hogs(struct gpiod_hog *hogs);
 #else
 static inline
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table) {}
@@ -70,6 +100,7 @@ static inline
 void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n) {}
 static inline
 void gpiod_remove_lookup_table(struct gpiod_lookup_table *table) {}
+static inline void gpiod_add_hogs(struct gpiod_hog *hogs) {}
 #endif
 
 #endif /* __LINUX_GPIO_MACHINE_H */
-- 
2.17.0
