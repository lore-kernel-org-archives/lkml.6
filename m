Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeCHTU5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:20:57 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41239 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeCHTU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:20:56 -0500
X-Google-Smtp-Source: AG47ELuBqaoVZpxc1h5srI/Rd6q5L9icgpx5qaF5sjFuXZ0VhXDfUrgU0hGsfbN3O154HWKrFcPl5w==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: [PATCH v2 1/2] backlight: Add RAVE SP backlight driver
Date: Thu,  8 Mar 2018 11:20:45 -0800
Message-Id: <20180308192046.27670-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides access to RAVE SP backlight control
functionality.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Aleksander Morgado <aleksander@aleksander.es>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]:

 - Collected various Acked-by form Lee and Daniel

 - Changes BACKLIGHT_FIRMARE to BACKLIGHT_PLATFORM

[v1] https://lkml.kernel.org/r/20180307024011.25033-1-andrew.smirnov@gmail.com

 drivers/video/backlight/Kconfig             |  6 +++
 drivers/video/backlight/Makefile            |  1 +
 drivers/video/backlight/rave-sp-backlight.c | 82 +++++++++++++++++++++++++++++
 include/linux/mfd/rave-sp.h                 |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/video/backlight/rave-sp-backlight.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 4e1d2ad50ba1..5d2d0d7e8100 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -467,6 +467,12 @@ config BACKLIGHT_ARCXCNN
 	  If you have an ARCxCnnnn family backlight say Y to enable
 	  the backlight driver.
 
+config BACKLIGHT_RAVE_SP
+	tristate "RAVE SP Backlight driver"
+	depends on RAVE_SP_CORE
+	help
+	  Support for backlight control on RAVE SP device.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 5e28f01c8391..19da71d518bf 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
 obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
 obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
+obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
new file mode 100644
index 000000000000..462f14a1b19d
--- /dev/null
+++ b/drivers/video/backlight/rave-sp-backlight.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * LCD Backlight driver for RAVE SP
+ *
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ *
+ */
+
+#include <linux/backlight.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/rave-sp.h>
+#include <linux/platform_device.h>
+
+#define	RAVE_SP_BACKLIGHT_LCD_EN	BIT(7)
+
+static int rave_sp_backlight_update_status(struct backlight_device *bd)
+{
+	const struct backlight_properties *p = &bd->props;
+	const u8 intensity =
+		(p->power == FB_BLANK_UNBLANK) ? p->brightness : 0;
+	struct rave_sp *sp = dev_get_drvdata(&bd->dev);
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_SET_BACKLIGHT,
+		[1] = 0,
+		[2] = intensity ? RAVE_SP_BACKLIGHT_LCD_EN | intensity : 0,
+		[3] = 0,
+		[4] = 0,
+	};
+
+	return rave_sp_exec(sp, cmd, sizeof(cmd), NULL, 0);
+}
+
+static const struct backlight_ops rave_sp_backlight_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.update_status	= rave_sp_backlight_update_status,
+};
+
+static struct backlight_properties rave_sp_backlight_props = {
+	.type		= BACKLIGHT_PLATFORM,
+	.max_brightness = 100,
+	.brightness	= 50,
+};
+
+static int rave_sp_backlight_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct backlight_device *bd;
+
+	bd = devm_backlight_device_register(dev, pdev->name, dev->parent,
+					    dev_get_drvdata(dev->parent),
+					    &rave_sp_backlight_ops,
+					    &rave_sp_backlight_props);
+	if (IS_ERR(bd))
+		return PTR_ERR(bd);
+
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static const struct of_device_id rave_sp_backlight_of_match[] = {
+	{ .compatible = "zii,rave-sp-backlight" },
+	{}
+};
+
+static struct platform_driver rave_sp_backlight_driver = {
+	.probe = rave_sp_backlight_probe,
+	.driver	= {
+		.name = KBUILD_MODNAME,
+		.of_match_table = rave_sp_backlight_of_match,
+	},
+};
+module_platform_driver(rave_sp_backlight_driver);
+
+MODULE_DEVICE_TABLE(of, rave_sp_backlight_of_match);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>");
+MODULE_AUTHOR("Nikita Yushchenko <nikita.yoush@cogentembedded.com>");
+MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
+MODULE_DESCRIPTION("RAVE SP Backlight driver");
diff --git a/include/linux/mfd/rave-sp.h b/include/linux/mfd/rave-sp.h
index 796fb9794c9e..fe0ce7bc59cf 100644
--- a/include/linux/mfd/rave-sp.h
+++ b/include/linux/mfd/rave-sp.h
@@ -21,6 +21,7 @@ enum rave_sp_command {
 	RAVE_SP_CMD_STATUS			= 0xA0,
 	RAVE_SP_CMD_SW_WDT			= 0xA1,
 	RAVE_SP_CMD_PET_WDT			= 0xA2,
+	RAVE_SP_CMD_SET_BACKLIGHT		= 0xA6,
 	RAVE_SP_CMD_RESET			= 0xA7,
 	RAVE_SP_CMD_RESET_REASON		= 0xA8,
 
-- 
2.14.3
